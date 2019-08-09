Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EC5C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27226214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407223AbfHIS0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 14:26:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44803 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfHIS0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:26:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so99067673wrf.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 11:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=B4KFIxKNutpA7/ftPIbvPrjeT2ChHpkvwQOhvlsGhS0=;
        b=otWzwfJqy997hCxwwTJobzJgu8yI9xh/GdtBAeNmWRIHUfAtYvFNL+CaY80tE8po3o
         cQImKd6jPgHYEYE28bSEHxw50vn70TVynX1lSywgLQhpHEV3wxRLjyqcuTboxMlXsiYh
         i0sIuTTkJk43dYuevg5FD76dYmyPiRFsp9P2e8EpnEV7lsN0CX6yUMx3xlnL/jyhcDcx
         1Oai5gcXon2awoFhiU6nc+XDv9qG0tw8GfZLb655Te2IsO/879+PWYgnlPibq0EJmkeZ
         xASTW9vIZqtZpJa2CI4s43NpJmM+LgTY7/GHAbIpPyoALaExgv0viyvDF6T+sVw2nzna
         U9eg==
X-Gm-Message-State: APjAAAXT6m3P9XcH9GHtauqholG+S6qZqZ3hBHHTMuIsctAulMFdT/CM
        qPnikEF93w5Vkv++GcIonL8=
X-Google-Smtp-Source: APXvYqzDABIKO1iWibVTJYxknNES0RqfQYHlQQZNqCx7f0lvXtcgZJqIbqetoi4unazmQnRWCTWd0w==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr25459819wrq.340.1565375201482;
        Fri, 09 Aug 2019 11:26:41 -0700 (PDT)
Received: from Nover ([161.105.209.130])
        by smtp.gmail.com with ESMTPSA id e7sm4656455wmd.0.2019.08.09.11.26.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 11:26:41 -0700 (PDT)
Date:   Fri, 9 Aug 2019 20:26:22 +0200
From:   Paul Chaignon <paul.chaignon@orange.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] seccomp: allow BPF_MOD ALU instructions
Message-ID: <20190809182621.GA4074@Nover>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need BPF_MOD to match system calls against whitelists encoded as 32-bit
bit arrays.  The selection of the syscall's bit in the appropriate bit
array requires a modulo operation such that X = 1 << nr % 32.

Signed-off-by: Paul Chaignon <paul.chaignon@orange.com>
---
 kernel/seccomp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 811b4a86cdf6..87de6532ff6d 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -205,6 +205,8 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
 		case BPF_ALU | BPF_MUL | BPF_X:
 		case BPF_ALU | BPF_DIV | BPF_K:
 		case BPF_ALU | BPF_DIV | BPF_X:
+		case BPF_ALU | BPF_MOD | BPF_K:
+		case BPF_ALU | BPF_MOD | BPF_X:
 		case BPF_ALU | BPF_AND | BPF_K:
 		case BPF_ALU | BPF_AND | BPF_X:
 		case BPF_ALU | BPF_OR | BPF_K:
-- 
2.17.1

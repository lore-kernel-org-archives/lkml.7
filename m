Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D47CC7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 15:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732772085A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 15:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7ewl3Ac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbfG0P6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 11:58:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42064 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbfG0P6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 11:58:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so25900878plb.9;
        Sat, 27 Jul 2019 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=N73gVQg6a3C4HgsLaCOq7Hz45GAHNtEV1T91iTCqpnk=;
        b=L7ewl3AcLbeUFC7eCzjQRdIrUTWRMVKW5HX8M73hOwasMI5rZAP58D8VrsF+tivWmI
         jKUmxze/cTEXPonmRssoee50rJRKeu0WgX1eHy5njqPo5F/T+h0IZ4fTMUkra1grtNj2
         nqul8qI/U45GP6C7AbzTFP5q5uJcAqEXHIk7aew0MlXUs6zm/wlxJjsPHm18U7SrseAr
         Dqvv34ajcidNajkImd5iMk1u0S1JCUiUi+BnEKLtDXaoyPsMoXy2o2vC/2le4oDeCXWm
         5XojNkr/3rKxynBkSFPNw6jiMdl4mDr6jba494XaR75mVxY5+QnPc7zc6BX1NryrMvdk
         431Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=N73gVQg6a3C4HgsLaCOq7Hz45GAHNtEV1T91iTCqpnk=;
        b=W3/8huatS9JMmd9KCjG3FjbKZGzLbznU+MyYf7seTu1PhksX7diRtqSuxk/Sb87eVt
         CUCKatH6NXomBTy2dUHiTzZDPnc+Ob7nOI5H/R7x87xvoQYciqQnGRHjvN0dNjZfcBal
         l608/s5+EJC8f5EpBqaefhffus69Hw3ajg2k7kXvejrc0RriFO2daBmwiFk9j2Tx1p71
         8JXU+gUV8T1Cca79NC9xiZ0RSd9bayLF3vlfcdcy+KHOkV9AWFrw1Xknd/XMMdTskUxs
         j0SJVuZSNhtJH55MJy9f/SeDyiDVkPnRhjANhyGUWt4KFnlDGWxmTXnQtN0QaDvR1KmS
         F0LQ==
X-Gm-Message-State: APjAAAVJ8s4ePBcyejjT+RVREdcoluV5sI/ci/zZwhHM1VBRWq5JDjXA
        Cnh7lhHXpQLTf5rr+BZLogA=
X-Google-Smtp-Source: APXvYqw+ZQUom1oi/G4J7dHzt5RJ3zkCqb6hAenYN/wiGCdzeLJyS0z/7VcBbkoAHSYOj6QHYZY22w==
X-Received: by 2002:a17:902:b905:: with SMTP id bf5mr95127804plb.342.1564243126185;
        Sat, 27 Jul 2019 08:58:46 -0700 (PDT)
Received: from host ([183.101.165.196])
        by smtp.gmail.com with ESMTPSA id a25sm30550564pfo.60.2019.07.27.08.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jul 2019 08:58:45 -0700 (PDT)
Date:   Sun, 28 Jul 2019 00:58:41 +0900
From:   Joonwon Kang <kjw1627@gmail.com>
To:     keescook@chromium.org
Cc:     re.emese@gmail.com, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] randstruct: fix a bug in is_pure_ops_struct()
Message-ID: <20190727155841.GA13586@host>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this, there were false negatives in the case where a struct
contains other structs which contain only function pointers because
of unreachable code in is_pure_ops_struct().

Signed-off-by: Joonwon Kang <kjw1627@gmail.com>
---
 scripts/gcc-plugins/randomize_layout_plugin.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 6d5bbd31db7f..a123282a4fcd 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -443,13 +443,12 @@ static int is_pure_ops_struct(const_tree node)
 		if (node == fieldtype)
 			continue;
 
-		if (!is_fptr(fieldtype))
-			return 0;
-
-		if (code != RECORD_TYPE && code != UNION_TYPE)
-			continue;
+		if (code == RECORD_TYPE || code == UNION_TYPE) {
+			if (!is_pure_ops_struct(fieldtype))
+				return 0;
+		}
 
-		if (!is_pure_ops_struct(fieldtype))
+		if (!is_fptr(fieldtype))
 			return 0;
 	}
 
-- 
2.17.1


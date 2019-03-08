Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8A0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3DA20449
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxYztBBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfCHNDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:03:11 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38541 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbfCHM7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:59:21 -0500
Received: by mail-yw1-f66.google.com with SMTP id x20so1878619ywd.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 04:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=APFJ0w9evqtq931s8iT9Ht0PXXAjdlQ42zpctJfPXJc=;
        b=YxYztBBXJufCYKkuG/tsbDU8TkrppeG64koDvNKwzONQhg4EfZ4uZyGYYtAwD62tZk
         iypC4XdNkGJLAVQe5PpqrDQFYdqYDZ6ClgcRPAvkki5M7YoQ9eeINbXPyfpzUqTR8wvF
         spz9UYPzPUSVw2Pc+ip4uYOatSMX5A/OpChpkk+VB56PMb1wElLCB7osvrW6HtPCqhZc
         4fmwSL6Q4fdy+vfDQASYrG9HUMilcqPeWuuA8pbav8OMhUDfycMEs9i/CTW1ia1TTeVF
         Za0VTZAd2uB0cywuLYSoFdqk7yIaa0FXcFj3OT/bHT2fQAH4eCVFs9NRgjWfIT2UPtz4
         eDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=APFJ0w9evqtq931s8iT9Ht0PXXAjdlQ42zpctJfPXJc=;
        b=tbxsuGLtG4VqDClqibEG1tRugZD7B2XwmOn6h9LMDypauMLVEjVVTBuN+q6eV9+Vj8
         vtxqLp1gP6KpKuzo1fiCjK4IJn+4n2ER9xS3eVYSC7ycIMjHf1TF8yFOyuBNkEWU6Bwl
         dXwNmPvd5J8U5uPCsXo70nr9WA/1MYGh1rCD8OCSkPHnvwP8u1CyuEsKyPxG0e2LKWcR
         7bWIHYZ5AMHKxbWRFdiVSsCLZDggShfS8ixcSGHwUIUbay57Ml+ySuddKyDjRRCHsKBg
         ppKoCM/HKEfICrc7NfYHXdT/BKvl19EC7WOFXlVHvLMXsl87Uwq+64fDwKVhnfoz+6hZ
         gUeA==
X-Gm-Message-State: APjAAAWlg0YLqRNxVhjo839V8lO79AN7kErs5YNns+CkF7PC0xtNYXKV
        cS6IV8Rxg7piNzcV5zsXDS0=
X-Google-Smtp-Source: APXvYqxRlYFtviBGEseCMYwuZoKPJd/m5jwLtgH9azdZuXu+pxOZZp4EzHk+UmyDleYbteKsYCjAtA==
X-Received: by 2002:a25:3b92:: with SMTP id i140mr10930150yba.186.1552049960579;
        Fri, 08 Mar 2019 04:59:20 -0800 (PST)
Received: from laptop.localdomain ([185.175.33.171])
        by smtp.gmail.com with ESMTPSA id g82sm3057775ywg.60.2019.03.08.04.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 04:59:20 -0800 (PST)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] Fix the combination of CONFIG_RELOCATABLE=y and CONFIG_MIPS_ELF_APPENDED_DTB=y
Date:   Fri,  8 Mar 2019 14:58:50 +0200
Message-Id: <20190308125851.31806-1-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I sent this patch almost 5 months ago but received no response [1].
I'm sending it again now, on top of v5.0.

Full details are in the commit message.
Please review.

Thanks,
Yasha


[1] https://lkml.org/lkml/2018/10/20/175

Cc: linux-kernel@vger.kernel.org


Yasha Cherikovsky (1):
  MIPS: Ensure ELF appended dtb is relocated

 arch/mips/kernel/vmlinux.lds.S | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-- 
2.21.0


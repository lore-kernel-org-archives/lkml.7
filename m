Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC57C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152DE20449
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfCLLtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:49:12 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:36472 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726167AbfCLLtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:49:11 -0400
Received: from mr5.cc.vt.edu (mr5.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x2CBnAhB021847
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:49:10 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x2CBn5Qb021576
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:49:10 -0400
Received: by mail-qt1-f200.google.com with SMTP id e1so1906491qth.23
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=DoZMMxJhKwGpB9mqID3/wSsBHphCaCz0kS80Xyq7T+w=;
        b=ekLBwUOyAgUlRyO50Y8e3Y3BWWUut42cgcO1huFMSh0preqRMdHahTwjcr/vR6PrFE
         400ZrvbLZoIuD3XKAXwuLusTQzOMqoLGdzEnq1MPD25fVnf9wmitlnVXRXSE6fR7xDOs
         fTXuhsI9vYEjnUx3++BigVXotQ3nYNvWUhdZdSicgS0LIQYcshlsjgKeprbVWkpYCaP9
         IEp6ERnD3Re/GFYKXgM9vkKs0bMwDzY6CQa+XJo4qKNXfTTjTFf8jWhCGQa9UMM499Q1
         HOHlW8gf8XRGosA/vonJP0ksNf3tYApG/+p8RmYO2YurxK62dfMelpyI3RHFBtAZO8pf
         I3hQ==
X-Gm-Message-State: APjAAAVYMsMU0BRfoYLyFV3dXsZVd1szqh+7FYU908fPJyAqw1Kze3mf
        JuitVmTF23JPmrKzesj6JHERpMM+hWGKjGdh63lD6VN8icmg/ogpRCcZjwOKDCwatcGNvoCdRaW
        U/jN3PwYbQkw/dJ/2pb0TIrMmchARnWU9mEA=
X-Received: by 2002:ac8:88a:: with SMTP id v10mr12975240qth.136.1552391345287;
        Tue, 12 Mar 2019 04:49:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwfQWzlHfdxWoffKPzthfmi3MpO28fmjypykAniVzytoPvPHKaAYpZsMTcNT4efTKOCLO6k8Q==
X-Received: by 2002:ac8:88a:: with SMTP id v10mr12975232qth.136.1552391345130;
        Tue, 12 Mar 2019 04:49:05 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::3b7])
        by smtp.gmail.com with ESMTPSA id c10sm4468511qkk.91.2019.03.12.04.49.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 04:49:04 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/tty/tty_jobctrl.c - fix non-kerneldoc comment
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 12 Mar 2019 07:49:03 -0400
Message-ID: <20513.1552391343@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with W=1 reports (among other things):
  CC      drivers/tty/tty_jobctrl.o
drivers/tty/tty_jobctrl.c:317: warning: Cannot understand  *
 on line 317 - I thought it was a doc line

Fix up the non-kerneldoc comment. (other warnings to be cleaned up in separate patch)

Signed-off-by Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index c4ecd66fafef..1393f71bb170 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -313,7 +313,7 @@ void disassociate_ctty(int on_exit)
 	read_unlock(&tasklist_lock);
 }
 
-/**
+/*
  *
  *	no_tty	- Ensure the current process does not have a controlling tty
  */



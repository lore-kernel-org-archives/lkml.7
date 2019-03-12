Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3809BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1183F206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCLMJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:09:29 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:52712 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725873AbfCLMJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:09:29 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x2CC9S9W007526
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:09:28 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x2CC9NOK014247
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:09:28 -0400
Received: by mail-qk1-f200.google.com with SMTP id v67so1883412qkl.22
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 05:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=gwCmIPWQyJ32wTejhqj6D720XvgzY4pG6gf2m+Oo8pI=;
        b=FIOVW5Og7yZQpp9ysWBCiBviGVutGFXe/mIilqF3mw89XySo98Du1YQwfH/kBiVk9+
         Urv0qUJypEdRywbf3SrSg1bo6Sj2npnzGQvT4X1H//eCgaMfwbdlSGOkRtf60OB8ySEv
         /HNaook+RLKRePEVG9VAXGyUE46W7+rdQZabDqj/wGj5ULcIwYPKuGCAdGxGcxhF3/eP
         +4XvoOnF1BaUfV8bmD6f2POKlYbs3fjottTFAPQVeroK1W8ORDHKLhukzvKxjJe7cl/E
         lOYprGz61BCgbzfs2dDeVn9vYRqbY5Y46dK8aGN1Hn4Wt/agO4BDJizEA10TmRYCjZiE
         T92A==
X-Gm-Message-State: APjAAAXHN8THZp//lqHaHVMQ07MlBIqAHM/Ec/DstYIeZu4LTHisKWKG
        z0yDJOPc/FH3UMB+AKT4G2t1Us9UJd/L4LC/ZvPGjda7qgktFV+zFJlAgS95wZDrqXAcELFugzd
        XEsJcdO0b2dgwE5qWOPlSSh1o8RLGWokFmDY=
X-Received: by 2002:a0c:b485:: with SMTP id c5mr30286225qve.78.1552392562773;
        Tue, 12 Mar 2019 05:09:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwJcy1VtxnkZ1OSFcuiIZhAfN/YpuJdQLbnCN67ISqGcPXZcNQNwLfIuo+DUW/psw2AH2V6HA==
X-Received: by 2002:a0c:b485:: with SMTP id c5mr30286214qve.78.1552392562599;
        Tue, 12 Mar 2019 05:09:22 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::3b7])
        by smtp.gmail.com with ESMTPSA id f6sm652716qtf.66.2019.03.12.05.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 05:09:21 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/staging/rtl8712 - fix up non-kerneldoc comments
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 12 Mar 2019 08:09:20 -0400
Message-ID: <21795.1552392560@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with W=1 reports (among other things)

  CC [M]  drivers/staging/rtl8712/rtl871x_ioctl_linux.o
drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1106: warning: Cannot understand  *
 on line 1106 - I thought it was a doc line

  CC [M]  drivers/staging/rtl8712/os_intfs.o
drivers/staging/rtl8712/os_intfs.c:366: warning: Cannot understand  *
 on line 366 - I thought it was a doc line
drivers/staging/rtl8712/os_intfs.c:434: warning: Cannot understand  *
 on line 434 - I thought it was a doc line

Fix up the non-kerneldoc comments

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>


diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index 2d3f38007299..fc797c3fbaed 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -362,7 +362,7 @@ static void enable_video_mode(struct _adapter *padapter, int cbw40_value)
 	r8712_fw_cmd(padapter, intcmd);
 }
 
-/**
+/*
  *
  * This function intends to handle the activation of an interface
  * i.e. when it is brought Up/Active from a Down state.
@@ -430,7 +430,7 @@ static int netdev_open(struct net_device *pnetdev)
 	return -1;
 }
 
-/**
+/*
  *
  * This function intends to handle the shutdown of an interface
  * i.e. when it is brought Down from an Up/Active state.
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index e723357ac8c0..f49fed8cb0e7 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -1102,7 +1102,7 @@ static int r871x_wx_set_mlme(struct net_device *dev,
 	return ret;
 }
 
-/**
+/*
  *
  * This function intends to handle the Set Scan command.
  * Currently, the request comes via Wireless Extensions' SIOCSIWSCAN ioctl.


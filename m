Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A67CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23483206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfCLLGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:06:07 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:36384 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725811AbfCLLGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:06:06 -0400
Received: from mr4.cc.vt.edu (mr4.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x2CB653A004602
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:06:05 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x2CB60FO020167
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:06:05 -0400
Received: by mail-qk1-f200.google.com with SMTP id d8so1777025qkk.17
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=fHbH8xXrsdcVp7DgI6FhDseV5/05/lU0RAksNhHFrTE=;
        b=feDaoPYwFaCXUK4nCxt+bs0brJL3To0Ypq6ZsiTs6nKqqyf39i+yJptRFOMK6hh5He
         xVaG4e1sxvOEhdLdLrUrNqRLbwhZgc4I7cBNfHQPTl/mseoMDPJApHI/Z9CfipCrxLtq
         bpEV0Lrp788ljMbQACRZRnIsEr0H32U/uKc1EazThEiH9K8hlkp7u+fq5Ay2245CCNHT
         W6zxLxOLgQEckqMm7LXRqSNCbMhiNA+i0ParBeOTxrBD3Ci60eu7c3R3xlWggffywyka
         Rs4A10FIH9gCbpNjizhOrmgiSHzvH71Jsq1VBtz8a37HI9NtpOS/ttA6KhjB2kYkT84p
         U9Hw==
X-Gm-Message-State: APjAAAUEDw9CAIvXatvi7X/Gkeke5OzrNt+zB0jLpJbdLvHrkUoHnb1z
        5abG4yVZItnKnvaWYS7bmeoqOmk0Ph1rs0/EuGu3U6xQP3UUQjxxN6d+AxQ9gzFe0QNUpRx/ZZ7
        YjvLlFmTg43UE3LxAWgEyvXHueRHm69n7mJU=
X-Received: by 2002:a37:b704:: with SMTP id h4mr19373789qkf.39.1552388759875;
        Tue, 12 Mar 2019 04:05:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzc3WkjPFIew0rUJ4rvq+sC1ihUc28g1hckhy15AZ++tjWJ/KJPi6jAT6PWskJO+gQkvMlrZA==
X-Received: by 2002:a37:b704:: with SMTP id h4mr19373775qkf.39.1552388759653;
        Tue, 12 Mar 2019 04:05:59 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::3b7])
        by smtp.gmail.com with ESMTPSA id f13sm5575421qto.80.2019.03.12.04.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 04:05:58 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/net/wireless/realtek/rtlwifi/usb.c - fix some non-kerneldoc comments
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 12 Mar 2019 07:05:57 -0400
Message-ID: <15731.1552388757@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with W=1:
  CC [M]  drivers/net/wireless/realtek/rtlwifi/usb.o
drivers/net/wireless/realtek/rtlwifi/usb.c:243: warning: Cannot understand  *
 on line 243 - I thought it was a doc line
drivers/net/wireless/realtek/rtlwifi/usb.c:760: warning: Cannot understand  *
 on line 760 - I thought it was a doc line
drivers/net/wireless/realtek/rtlwifi/usb.c:790: warning: Cannot understand  *
 on line 790 - I thought it was a doc line

Fix comment blocks so they don't look like kerneldoc lines

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index e24fda5e9087..9478cc0d4f8b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -239,7 +239,7 @@ static void _rtl_usb_io_handler_release(struct ieee80211_hw *hw)
 	mutex_destroy(&rtlpriv->io.bb_mutex);
 }
 
-/**
+/*
  *
  *	Default aggregation handler. Do nothing and just return the oldest skb.
  */
@@ -756,7 +756,7 @@ static int rtl_usb_start(struct ieee80211_hw *hw)
 	return err;
 }
 
-/**
+/*
  *
  *
  */
@@ -786,7 +786,7 @@ static void rtl_usb_cleanup(struct ieee80211_hw *hw)
 	usb_kill_anchored_urbs(&rtlusb->tx_submitted);
 }
 
-/**
+/*
  *
  * We may add some struct into struct rtl_usb later. Do deinit here.
  *


Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91ACCC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 01:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FAA21872
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 01:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389729AbfHHBwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 21:52:11 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:49584 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389044AbfHHBwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 21:52:07 -0400
Received: from mr5.cc.vt.edu (mr5.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x781q5mn015321
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 21:52:05 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x781q0t2017136
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 21:52:05 -0400
Received: by mail-qk1-f198.google.com with SMTP id c79so81217401qkg.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 18:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=IVOB0NY2JGj/kstTGc6wLued6V3alD1RmAyhwYH10so=;
        b=UByGImlJEyAbeUPMX1aWaT9jJui7Q2cQroaPaeGnAakUZsdWfo/UJ3WLOTMBlRUec6
         gBcMa7XLQLw6+3FGUkkX2LlXWYgmjW7HwU/cYYsqq8xr91BpU66/ZgphuBMzByhJZ2sC
         iNo+AVO+INOZBjxQAxRtKN2z6TFW4lf8FcvfGy7NZ0a9RzE26nRCaedg14VuXMYtSfdC
         fX08SAXCQjwmb4aX4gKuj82+MjC0EF3nWJnasuJ38Ir7qFf9gFfmWKR708A+4DXgVNd4
         +VJwnUPSgW3lD6RZeM3VCyOvVT3gKWLrateOzlTH/uPlOX89jr+/obo5j4+UWb1/fDh+
         Aowg==
X-Gm-Message-State: APjAAAWIhg1uOYfTtf0IAyOAxxsCHBcydidEwWIw1x8487b16Bo5a4PO
        lRKnbSYaLl/YhOz+5nIW0hEu6j0hm2zqQeOaZLUeFxeNxtvbaR+PUS2HnVhQBVUu8SQ6j/q9Fak
        qxH9g38JPmcIj870XyPpCX48OtwxCnXfSuIk=
X-Received: by 2002:ac8:45d2:: with SMTP id e18mr10979189qto.258.1565229120431;
        Wed, 07 Aug 2019 18:52:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwsFTfPXmDA5/PiMsVC9GvHUAyCGr/895p2INC7GFhiSvFjcwVR2PUfzyinAlZa29Z3TikFcw==
X-Received: by 2002:ac8:45d2:: with SMTP id e18mr10979177qto.258.1565229120197;
        Wed, 07 Aug 2019 18:52:00 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id q29sm2965320qtf.74.2019.08.07.18.51.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 18:51:59 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Fix non-kerneldoc comment in realtek/rtlwifi/usb.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 07 Aug 2019 21:51:58 -0400
Message-ID: <34195.1565229118@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spurious warning message when building with W=1:

  CC [M]  drivers/net/wireless/realtek/rtlwifi/usb.o
drivers/net/wireless/realtek/rtlwifi/usb.c:243: warning: Cannot understand  * on line 243 - I thought it was a doc line
drivers/net/wireless/realtek/rtlwifi/usb.c:760: warning: Cannot understand  * on line 760 - I thought it was a doc line
drivers/net/wireless/realtek/rtlwifi/usb.c:790: warning: Cannot understand  * on line 790 - I thought it was a doc line

Clean up the comment format.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

---
Changes since v1:  Larry Finger pointed out the patch wasn't checkpatch-clean.

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 34d68dbf4b4c..4b59f3b46b28 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -239,10 +239,7 @@ static void _rtl_usb_io_handler_release(struct ieee80211_hw *hw)
 	mutex_destroy(&rtlpriv->io.bb_mutex);
 }
 
-/**
- *
- *	Default aggregation handler. Do nothing and just return the oldest skb.
- */
+/*	Default aggregation handler. Do nothing and just return the oldest skb.  */
 static struct sk_buff *_none_usb_tx_aggregate_hdl(struct ieee80211_hw *hw,
 						  struct sk_buff_head *list)
 {
@@ -756,11 +753,6 @@ static int rtl_usb_start(struct ieee80211_hw *hw)
 	return err;
 }
 
-/**
- *
- *
- */
-
 /*=======================  tx =========================================*/
 static void rtl_usb_cleanup(struct ieee80211_hw *hw)
 {
@@ -786,11 +778,7 @@ static void rtl_usb_cleanup(struct ieee80211_hw *hw)
 	usb_kill_anchored_urbs(&rtlusb->tx_submitted);
 }
 
-/**
- *
- * We may add some struct into struct rtl_usb later. Do deinit here.
- *
- */
+/* We may add some struct into struct rtl_usb later. Do deinit here.  */
 static void rtl_usb_deinit(struct ieee80211_hw *hw)
 {
 	rtl_usb_cleanup(hw);


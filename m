Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D8EC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 01:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6B22085A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 01:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaZDV+wO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbfFSB5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 21:57:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36916 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFSB5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 21:57:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id bh12so6486126plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 18:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DtzpsEMmA6y/VxThJKdgqPMw4atSdDvUpiSanqf0lPA=;
        b=BaZDV+wO6ImusZDj4cQOtLE/OFaK6teBN6YPViixSjyaqIfOfVDmWt4qSgmzzhO+4l
         rNjno/gyW56AzTXhsLEU2m80JQu5u3gt0iyt5S4gcCBEeJOPd73ZmQU9quFH24SI34JH
         7WoKEt/tJYcpT7wPqtAlho2FcVvDYTAWp35Ceug20SqujuXlyrPHvtcfWKKrvQmJ0tFM
         BzRDlhCHPWigZsI6exq4gGrgvxlaK5Oww/q5T9nIReszwzKWtRLtkhR3jyPmLz7FDJHN
         sQQn9lqef32jdMlxDCVKz/4FoBQfawT+KNALwX4w7UqNsCT2KwdIQli5YuPEMO424jF2
         3AVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DtzpsEMmA6y/VxThJKdgqPMw4atSdDvUpiSanqf0lPA=;
        b=gN3bzvt6BU8A3csStQCTl/tWGXd+AWsfobGLIa32j4VmKKuKMzOJ9e0ihtdnfg6Eix
         XqCwuISXl7ssntllhWR5hpbzv9s2WQPwiZDweJXV0Oal7vsf51KexofbDHEjfEsGf6HZ
         xLpA2pUKH/eicevC7KS/fq6fimfBbM4P0oBHz+1Y2dllHKvOuRfwmggHZJm8gKH5Yxs4
         ZCsZYfXZ3oAoERmQgKxB7vnT9dsQdJjNWGGkIfVN6/PQBkBL4oEV+1uKJZz8RfpoHgww
         oqjHLK9V3/xwJMfR5kjpseBRslgMV2wseLcqzjHp8fSXxYAHoVComqi+S4fqugf8Prd6
         m4sg==
X-Gm-Message-State: APjAAAUczosWCM1r0m6Od/IwJNjpmWsnZln+yMB5jtAVGi6aZh6INQXr
        lxHaghJsTl85629NojUBwvc=
X-Google-Smtp-Source: APXvYqzTSbLGX2f1sPruiEJLHqdG195QU1uWlsCYUFCHOYHVqgjZtiO1bcEion3Xsh87njq+2dMDlQ==
X-Received: by 2002:a17:902:a5c5:: with SMTP id t5mr118819238plq.288.1560909469154;
        Tue, 18 Jun 2019 18:57:49 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id x26sm14327540pfq.69.2019.06.18.18.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 18:57:48 -0700 (PDT)
Date:   Wed, 19 Jun 2019 07:27:43 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [Patch v3] staging: rtl8723bs: os_dep: ioctl_linux: make use of
 kzalloc
Message-ID: <20190619015742.GA19278@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a cleanup which replaces rtw_malloc(wep_total_len) with
kzalloc() and removes the memset().

The rtw_malloc() does GFP_ATOMIC allocations when in_atomic() is true.
But as the comments for in_atomic() describe, the in_atomic() check
should not be used in driver code.  The in_atomic() check is not
accurate when preempt is disabled.

In this code we are not in IRQ context and we are not holding any
spin_locks so GFP_KERNEL is safe.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
----
changes in v2: Replace rtw_zmalloc with kzalloc
changes in v3: Add proper changelog
---
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index ea50ec424..e050f20 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -477,14 +477,12 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
-			pwep = rtw_malloc(wep_total_len);
+			pwep = kzalloc(wep_total_len, GFP_KERNEL);
 			if (pwep == NULL) {
 				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, (" wpa_set_encryption: pwep allocate fail !!!\n"));
 				goto exit;
 			}
 
-			memset(pwep, 0, wep_total_len);
-
 			pwep->KeyLength = wep_key_len;
 			pwep->Length = wep_total_len;
 
@@ -2142,12 +2140,10 @@ static int rtw_wx_set_enc_ext(struct net_device *dev,
 	int ret = 0;
 
 	param_len = sizeof(struct ieee_param) + pext->key_len;
-	param = rtw_malloc(param_len);
+	param = kzalloc(param_len, GFP_KERNEL);
 	if (param == NULL)
 		return -1;
 
-	memset(param, 0, param_len);
-
 	param->cmd = IEEE_CMD_SET_ENCRYPTION;
 	memset(param->sta_addr, 0xff, ETH_ALEN);
 
@@ -3513,14 +3509,12 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
-			pwep = rtw_malloc(wep_total_len);
+			pwep = kzalloc(wep_total_len, GFP_KERNEL);
 			if (pwep == NULL) {
 				DBG_871X(" r871x_set_encryption: pwep allocate fail !!!\n");
 				goto exit;
 			}
 
-			memset(pwep, 0, wep_total_len);
-
 			pwep->KeyLength = wep_key_len;
 			pwep->Length = wep_total_len;
 
-- 
2.7.4


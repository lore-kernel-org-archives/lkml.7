Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84791C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530A82082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdyCCdCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfFRBoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 21:44:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46147 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFRBoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 21:44:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id e5so4960464pls.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 18:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+W3ejKKyHHMYN5ifOnPA7HkbvIIeiT8/4WeKGX5VrVk=;
        b=sdyCCdCmoVWWI/I903bEgV9QKK/O4tqrVHMSZ6JbJroGZx35q786WnQXv7/uusHrnL
         OlxsE5DE8h90le6csi3aTJtmYO4diogzRSs3oLkcAxoQGKPd4hgWrUnuteY0V/8uBCAs
         jZPTzYWc04IRW4nXohznGqv6wCn03+A+Y5RfmvI9xlTGS+lJ9uqX5GgqrKL32RMPCXb2
         6dcPxKEbAVmEKl7j8yj5VqO63R/Ls5MaDHgsn42XuynDw1q6qQHwZCpu8A1qLyOed7UO
         XcIHBLHeplFfH0s8eZy5TmmEjKXBOOCmzJy2ome/LYWTabdjS9pk7QSQhuXvmajlELzl
         C/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+W3ejKKyHHMYN5ifOnPA7HkbvIIeiT8/4WeKGX5VrVk=;
        b=kq+XsYUMGSDa9V9gDWQvi8FJBWMBb5YEh6S56A9dU7g7+OUEb6uNUYrEfMuvYxu7GR
         nPbtUDKQxpmJQ/AUHsDU1sVb74J2HcXyKFzmVwnQM4hgfGQXZ0OjquyTd1G5PI4Zg7ne
         rjJYC6E7vmkQlhl5/XdplgTMBYJ2kFxS2rh+rXflpRRzWjS7FynjN7oxy93J45FxUfwP
         cemwCyPGGia0fHdfmBXh1dzWTax9cGypYIHY/J/qWpvVg9V3pbkG/SNcYo1KQiRZxH7o
         KSYWAFVL/MKTzHSOX3qWQqMrMRjQqXOPYXQ01AhPzWoOv4pB3y/A07YSdYBOYdwPk0Qv
         zIqQ==
X-Gm-Message-State: APjAAAUpEJ9pTnfz1zIPjGr6RbNbA4mlNYnyb1Y5qaByFCOHl1UnFzvh
        i7ilcnKnUuS1U1ApNnkFzR0=
X-Google-Smtp-Source: APXvYqw75XAab/e7DAjrbX086W4UV6H2gu81Wu+qt0RcDKehBTOFbIVOxzsdRlvUQLbitVZmWCJ/QA==
X-Received: by 2002:a17:902:363:: with SMTP id 90mr25270995pld.340.1560822255986;
        Mon, 17 Jun 2019 18:44:15 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id p1sm14417631pff.74.2019.06.17.18.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 18:44:15 -0700 (PDT)
Date:   Tue, 18 Jun 2019 07:14:10 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [Patch v2] staging: rtl8723bs: os_dep: ioctl_linux: make use of
 kzalloc
Message-ID: <20190618014410.GA8505@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc with memset can be replaced with kzalloc.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
-----
changes in v2: Replace rtw_zmalloc with kzalloc
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


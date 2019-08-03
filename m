Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C2DC433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 17:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE6D2087C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 17:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRhuawTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfHCRkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 13:40:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45872 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfHCRkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 13:40:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so34867421plr.12
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 10:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=f5jHl+J1mvXUnH10CMkpOjLBtqZC1foXc9If20oTVtg=;
        b=mRhuawTPUIPR89SZbRUgtxNYHZbVDH6JC25i41nMw8z6/JVaoGB71Nl0nr4UUMrpuE
         1O+TQoV8Mb+DYOKYnkqVLFK1l9uZVB5p+DDQ04xBtocj7/Ug6Ca8p8YYAzBKpFUB5tna
         xa7D+l8b2CO6+vr2IaMng3G9e72eRvV7rkMjtnke01svp2D3TwiiGeztVwE40cYfswcT
         J36jkC62sMiguhNEs1Fs3ZmOdjSp3jgzmAiWydRcAZa5rjPeW+2QgW2+qyiRhGSp+QFr
         jdm1OkvWu9AfoAtRorhzkU8c2y1obDPKa6JmtS0GdrIv7RV5dxiSHWwrXn8eFnD4nVVw
         0a+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=f5jHl+J1mvXUnH10CMkpOjLBtqZC1foXc9If20oTVtg=;
        b=GRdqhN2O/b6CCDCeNxcJe+B1waAuq36/mwYhHZI2ztMMJhlH2E9yF/++TzygQNWSFo
         Qc3NCWonoGy2oNoXyJ2iClYhcgw0GmY/yaftcjjZUG5oDQTG9vElVVmfhxLxGL8beRnX
         CEWznm181L4H2XLSHDxczj6p5kY9zEEjhUjOF3Ap9WognGf5aGMwVTS/knffRfNxR/UG
         UUW8zVmbS7VEQ/LAlhzt0sLoYDKpvAQreMhDUt0FyaGknmORr3WSTEfLpf4DMN7Fp4H5
         PzSsAtDgOKzY4m96BK6P72pu3+UPr7oHPd8B6Zp6qaMY1qnV7Ja3ob5KqB5X1CGWmWmV
         ktGw==
X-Gm-Message-State: APjAAAUvvQq8WJXqKzUoeFxQhFtjjqXPMYYA1aOCthwjlEisnu2bDQGH
        FtEbPKclDBkh6lycpuP2zp8=
X-Google-Smtp-Source: APXvYqzq2R6gwb9NkEU2Ntm9Lg5/yUSnqsMI5FNrcMXh9a4raqwmWJv5phEyhCLIoTmjWxHXzu6mWA==
X-Received: by 2002:a17:902:1004:: with SMTP id b4mr139285953pla.325.1564854045051;
        Sat, 03 Aug 2019 10:40:45 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id r1sm88834898pfq.100.2019.08.03.10.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 10:40:44 -0700 (PDT)
Date:   Sat, 3 Aug 2019 23:10:38 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michiel Schuurmans <michielschuurmans@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Make use kmemdup
Message-ID: <20190803174038.GA10454@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As kmemdup API does kmalloc + memcpy . We can make use of it instead of
calling kmalloc and memcpy independetly.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index e29e8d6..9b8b301 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1382,10 +1382,8 @@ rtllib_association_req(struct rtllib_network *beacon,
 	ieee->assocreq_ies = NULL;
 	ies = &(hdr->info_element[0].id);
 	ieee->assocreq_ies_len = (skb->data + skb->len) - ies;
-	ieee->assocreq_ies = kmalloc(ieee->assocreq_ies_len, GFP_ATOMIC);
-	if (ieee->assocreq_ies)
-		memcpy(ieee->assocreq_ies, ies, ieee->assocreq_ies_len);
-	else {
+	ieee->assocreq_ies = kmemdup(ies, ieee->assocreq_ies_len, GFP_ATOMIC);
+	if (!ieee->assocreq_ies) {
 		netdev_info(ieee->dev,
 			    "%s()Warning: can't alloc memory for assocreq_ies\n",
 			    __func__);
@@ -2259,12 +2257,10 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
 			ieee->assocresp_ies = NULL;
 			ies = &(assoc_resp->info_element[0].id);
 			ieee->assocresp_ies_len = (skb->data + skb->len) - ies;
-			ieee->assocresp_ies = kmalloc(ieee->assocresp_ies_len,
+			ieee->assocresp_ies = kmemdup(ies,
+						      ieee->assocresp_ies_len,
 						      GFP_ATOMIC);
-			if (ieee->assocresp_ies)
-				memcpy(ieee->assocresp_ies, ies,
-				       ieee->assocresp_ies_len);
-			else {
+			if (!ieee->assocresp_ies) {
 				netdev_info(ieee->dev,
 					    "%s()Warning: can't alloc memory for assocresp_ies\n",
 					    __func__);
-- 
2.7.4


Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF876C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84083218C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdsznt0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfGCNRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:17:16 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43599 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfGCNRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:17:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id cl9so1232502plb.10;
        Wed, 03 Jul 2019 06:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=I+BQdeOmtZ7IKz7FF6jeB1KL5T/xBTm14TBegiYeXME=;
        b=hdsznt0KttbCFAXsabxfmtp6+t3geEt/8abokOpKd1ElP53l0GSKy0MBAUpFPJcOif
         JBioFRWlKeEeDIWHLfVe0qj0++/hrYP1LlmdK33cPh0rtqqMLkeD/7bRdTkH6MTU8IFK
         B0QreONXGKVnrs23PFCGqnt/RV08JDl5MPyywByMOOxwUXQHrjPT6igdxI5xMGotGMWQ
         6MOIGXNcFni2XFwHeeCWafZIH98vWVQTxA1XpVf9cvuIsNu7sP1WEHY4YC+ha0iMyy6R
         bzUrKde6mulNWxDiLBgmUsid/y30NEUGglrQP4nLYAZyrOZk6YZCiqpdXKOTuqO3busO
         79Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I+BQdeOmtZ7IKz7FF6jeB1KL5T/xBTm14TBegiYeXME=;
        b=DghvIRtT9PD7ec4VvERhNAqaALDL6SifqQluAUhxYO0DQ53E9iTfyknrZQrMp+5dcL
         Od7F+1uKDqIUSynGnhibi2s5vF2TRNA4QJtXi9iZoSjTVnA1puwXfgdGqUHkJrO2Jjyb
         NzHpKvc4AJ0CqrKyquZSH5lEW2Fyv/99MkKuKgknpXkS1k+LZgRJhPmpS+i6LLAtCDvM
         qMPNST9Kbvpc3xxZnEmPJTqsDwi6SmCwEcay4PyOo9GyxdIEjwkOkbCN2LmbcUnWUhhi
         PUrSw0fwCR62Y93ARfnMRZbOWvQ8ge5JEbze0QzojVXrG2CMFHPn2456pWQlMuomncLr
         pXkQ==
X-Gm-Message-State: APjAAAVUND+B6skd8CRrMG718icZHFJzandzxVKxaMVOhjIAs0WV28bD
        XTXvnJDflEDInrhjPKqRfuw=
X-Google-Smtp-Source: APXvYqz1JM4wam5zMtbtXbBfTaBciNfEsEphGiFSLqsyi9hSRtN44xP9VYYQ2792VhdXx9bcswss8Q==
X-Received: by 2002:a17:902:aa41:: with SMTP id c1mr41914634plr.201.1562159835315;
        Wed, 03 Jul 2019 06:17:15 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id u5sm2184456pgp.19.2019.07.03.06.17.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:17:14 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 21/30] usb: Use kmemdup rather than duplicating its implementation
Date:   Wed,  3 Jul 2019 21:17:05 +0800
Message-Id: <20190703131705.25643-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memset, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/usb/class/cdc-acm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 183b41753c98..cc4a96d59ffc 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1410,12 +1410,11 @@ static int acm_probe(struct usb_interface *intf,
 		struct usb_cdc_country_functional_desc * cfd =
 					h.usb_cdc_country_functional_desc;
 
-		acm->country_codes = kmalloc(cfd->bLength - 4, GFP_KERNEL);
+		acm->country_codes = kmemdup((u8 *)&cfd->wCountyCode0,
+					cfd->bLength - 4, GFP_KERNEL);
 		if (!acm->country_codes)
 			goto skip_countries;
 		acm->country_code_size = cfd->bLength - 4;
-		memcpy(acm->country_codes, (u8 *)&cfd->wCountyCode0,
-							cfd->bLength - 4);
 		acm->country_rel_date = cfd->iCountryCodeRelDate;
 
 		i = device_create_file(&intf->dev, &dev_attr_wCountryCodes);
-- 
2.11.0


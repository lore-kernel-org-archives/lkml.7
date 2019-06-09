Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ADAC468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 11:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E67720868
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 11:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUKhpdgJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfFILYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 07:24:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39276 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbfFILYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 07:24:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so3654621pfe.6;
        Sun, 09 Jun 2019 04:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GbNH/+SOJ/7ZiuH2uzFEjE1InUMnES6ChjAMNiqvkB8=;
        b=DUKhpdgJkLMIycp09Kyw7rQzFSM81WUbnpuVfAl/j+nUSjafYkWON4YuJsbwQV/5hJ
         tZcPrS2R2VVVZGvtYeF5uGDa2YeGeVzi+XgDN/gRGUC+Dq4kU4lPnuLjuw5yN1HeQOoV
         wNUMc6UyFM97Tnf7AB6Y4Ysdd7L/m/4uVKXyGM5YYwjYX1bPezL0CsIYNKv2JLcIt33L
         WNc6CGJLApFm2T4Q0tKM2Wzn0LC4u7gwNtDhfvDAgDbV/pcPjQuQ03Ez3zn65mRs4rh6
         r5hz+MTcFBx7dol/woagESqqpw7jHSmu4QeiS6gRilWKn8Ri+CP7GnhfgVfpJMyPteUe
         QwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GbNH/+SOJ/7ZiuH2uzFEjE1InUMnES6ChjAMNiqvkB8=;
        b=ftmXN8IbdqCPWHtrbiNifVUtlaLJy1NEFizK42/i3RxhITAeWj3YhwgUbOJebiGdtb
         2a8YUtWubg2wQkxT5apaDZz5JTdW9YVa2CCYZd3xtGzjkZBmjRRwPKIUWY7xAf9RaqTK
         Oea7MWCOKcbTCZ82BTJsOPbGU5Xkimy+6njRN1LdoY0CWPf8FSE7AKuyKrloJW088ajJ
         /9aU0bwjQWKMTrh0ezoKwEMJauHQDQLAnDyMMGYVqrUPtpbrghBWh1EzZPc8huvFDuye
         pLSNinWcethgOlB2Ckg2PONDuPbWbMbItayLhxBdhHS84wHobLGK0FTyd1xkz/B2SgFB
         TJjQ==
X-Gm-Message-State: APjAAAWyYOBOy3njyzBXRfBQGpzNQJIQdNFSX2jNCX0cW1Ks4CrxHH6u
        UYOyNPO6MdwFORurcRK09Go=
X-Google-Smtp-Source: APXvYqw+KgvfkLmIjJPP2eN1U77y5D1DRxM7+MdKmXZ9SN3RiF3kUTXc8q4Os7bNp4eUA1qt8553GQ==
X-Received: by 2002:a62:750c:: with SMTP id q12mr48335174pfc.59.1560079447047;
        Sun, 09 Jun 2019 04:24:07 -0700 (PDT)
Received: from saurav ([123.201.165.107])
        by smtp.gmail.com with ESMTPSA id y185sm11472716pfy.110.2019.06.09.04.24.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 09 Jun 2019 04:24:06 -0700 (PDT)
Date:   Sun, 9 Jun 2019 16:54:00 +0530
From:   Saurav-Girepunje <saurav.girepunje@gmail.com>
To:     b-liu@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] Updated the function description for musb_stage0_irq
 Signed-off-by: Saurav-Girepunje <saurav.girepunje@gmail.com>
Message-ID: <20190609112356.GA19055@saurav>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Description: Updated the function description for musb_stage0_irq
Content-Disposition: inline

---
 drivers/usb/musb/musb_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 9f5a4819a744..2451e0ee2d01 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -909,7 +909,6 @@ static void musb_handle_intr_reset(struct musb *musb)
  * @param musb instance pointer
  * @param int_usb register contents
  * @param devctl
- * @param power
  */
 
 static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
-- 
2.20.1

Regards,
Saurav Girepunje

--MGYHOYXEY6WxJCY8
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-Updated-the-function-description-for-musb_stage0_irq.patch"

From d861c19b28f6263f7c14c16e05398ddca06c56fb Mon Sep 17 00:00:00 2001
From: Saurav-Girepunje <saurav.girepunje@gmail.com>
Date: Sun, 9 Jun 2019 13:05:56 +0530
Subject: [PATCH] Updated the function description for musb_stage0_irq
 Signed-off-by: Saurav-Girepunje <saurav.girepunje@gmail.com>

---
 drivers/usb/musb/musb_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 9f5a4819a744..2451e0ee2d01 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -909,7 +909,6 @@ static void musb_handle_intr_reset(struct musb *musb)
  * @param musb instance pointer
  * @param int_usb register contents
  * @param devctl
- * @param power
  */
 
 static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
-- 
2.20.1


--MGYHOYXEY6WxJCY8--

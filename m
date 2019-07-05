Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55832C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E71B20828
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHzc0Kqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfGEKkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 06:40:43 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37368 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbfGEKkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:40:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id c9so4267483lfh.4;
        Fri, 05 Jul 2019 03:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=aBPGjCEIDcXv80ei9BJejEuJckIJCgoX974pF5ERpDA=;
        b=sHzc0KqoHbefGCAoERSUZUdOT6ybLPFuec47AfqKlicx8ZAKXztenXGfAuZgDx9yPo
         NqvSvplzH0q3VJNH1yW+GQ+N4gakhPnKOah1u686fzKahdYtNyrMHgslD7M3bdKIaRo5
         sNdH89pvFTA1nBF7E+hWMKS9cXlUousX3PMr8oSya127mG0bRIlmxOJXe5a6R6mMwRvp
         HjnS6yu2boDMCmlEBO+//Gkdj+idFbu7KF/TO20C5Pd3+jbKuYnx/Q200Ogj5Ztt7MZo
         BwahgF9s+NF4hfYK+mjT9Lt3DLd11upOfPIdnWr583NrqX9TG9TuPRO/H3FhJol6z5qQ
         qVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=aBPGjCEIDcXv80ei9BJejEuJckIJCgoX974pF5ERpDA=;
        b=qAToWdeh+unHspqlNHlIzuAbAlnePWFnQykiQJeTavUwG4Zz44X3JGzypXudaI2WD9
         1HtsQ1XtBF1eASKleyKsMP1j+buyOfhL78fliNmhOlDSjcX+p9W4CZr/3YmamlBJmbit
         sKCkPxTI45v9v1MG3kOtRdnHCitwzEiwA+OcjLO3QkEQxxgvbokEXwKnnmwXg/cWqv8p
         jPk7/V3yh1OreO0ywFfXjb4sPTB2aW3mtmiggJpkkvEMYidRk9TVGtPq5Qq+U4zzwErA
         +1u9PB1THP63FT9a4EW2dAUZHF87/sJ71GAsDDeWq1LECJ4GY73kyTiKOaewq0VhophI
         ecIw==
X-Gm-Message-State: APjAAAUwvqVRo2HkXPRZtofgfnh2bCgxP2Mt26fiq4rpzSWnADjzpifo
        h7ojUpS9zy5FmCT53JW1yNyxBMAN
X-Google-Smtp-Source: APXvYqz+G+tkWobfs0cQYZJnxdgkF9QQHZWFsbTdgE8oz84677of5rF3h98OerDgH8Sx6VO2p5K2BA==
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr1601429lfm.104.1562323240944;
        Fri, 05 Jul 2019 03:40:40 -0700 (PDT)
Received: from [192.168.0.94] (31-178-116-31.dynamic.chello.pl. [31.178.116.31])
        by smtp.googlemail.com with ESMTPSA id j11sm1342207lfm.29.2019.07.05.03.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 03:40:39 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        wadosm@gmail.com
From:   =?UTF-8?Q?Micha=c5=82_Wadowski?= <wadosm@gmail.com>
Subject: [PATCH] Fix for initialize drives not capable to handle maximum
 bandwidth
Message-ID: <461c653b-77e8-fa24-e8b5-56f210c23965@gmail.com>
Date:   Fri, 5 Jul 2019 12:40:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: pl-PL
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases if sata drive can't work with default controller
bandwidth, driver fails to initialize the device.

libata-core: sata_link_hardreset - if after reset the device is
offline, then driver should try again, with lower SPD.

sata_down_spd_limit - function should handle corner case values,
if device is not initialized yet.

Bugzilla: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1783906

Signed-off-by: Michał Wadowski <wadosm@gmail.com>
---
 drivers/ata/libata-core.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index adf28788cab5..a37249c4ebeb 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3061,6 +3061,7 @@ int sata_down_spd_limit(struct ata_link *link, u32 spd_limit)
 
 	/* If SCR can be read, use it to determine the current SPD.
 	 * If not, use cached value in link->sata_spd.
+	 * Value of link->sata_spd may be 0.
 	 */
 	rc = sata_scr_read(link, SCR_STATUS, &sstatus);
 	if (rc == 0 && ata_sstatus_online(sstatus))
@@ -3072,23 +3073,23 @@ int sata_down_spd_limit(struct ata_link *link, u32 spd_limit)
 	if (mask <= 1)
 		return -EINVAL;
 
+	/* sata_spd_limit may by initially INT_MAX, that is not correct
+	 * value to working with. Cut down mask to highest correct value.
+	 */
+	mask &= 0x7;
+
 	/* unconditionally mask off the highest bit */
 	bit = fls(mask) - 1;
 	mask &= ~(1 << bit);
 
 	/*
-	 * Mask off all speeds higher than or equal to the current one.  At
-	 * this point, if current SPD is not available and we previously
-	 * recorded the link speed from SStatus, the driver has already
-	 * masked off the highest bit so mask should already be 1 or 0.
-	 * Otherwise, we should not force 1.5Gbps on a link where we have
-	 * not previously recorded speed from SStatus.  Just return in this
-	 * case.
+	 * Mask off all speeds higher than or equal to the current one.
+	 * If device is not initialized yet, value of SPD is 0, so
+	 * we should ignore this. If spd is 1, then we can't speed down
+	 * any more.
 	 */
 	if (spd > 1)
 		mask &= (1 << (spd - 1)) - 1;
-	else
-		return -EINVAL;
 
 	/* were we already at the bottom? */
 	if (!mask)
@@ -4116,7 +4117,10 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 		goto out;
 	/* if link is offline nothing more to do */
 	if (ata_phys_link_offline(link))
+	{
+		rc = -EPIPE;
 		goto out;
+	}
 
 	/* Link is online.  From this point, -ENODEV too is an error. */
 	if (online)
-- 
2.7.4


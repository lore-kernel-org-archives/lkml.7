Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CFDC4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 07:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6235220873
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 07:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtivAAM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfIOHN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 03:13:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36634 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfIOHN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 03:13:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id f19so15105649plr.3;
        Sun, 15 Sep 2019 00:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9RsUkl6MEN71BO//b46KRM887milBSbG2u+IqiX1rgM=;
        b=NtivAAM77GDp12fbYDh716oc0G9uYsGGnDGcKfDhDvYThgJ/8sfdOvaqtV/croIwHr
         /r+TKQW6PvyWCNK+z6shvTcxM0BJnOIQ4+SadvG/jn9vBuN32skVTgsd6jQ2I6khu+/v
         U18L5eJ1pqnqYpimgRGOAA5L3ciY1GflwlaHE5Z2Mw/4qQ9tuZ4SlqQN58C6noEJwOy/
         zFhsPmpe0Inp3cZmeP9uN9BygF2Zw3hoLZq5PX1zSWfbX4JOCZg+ZNH8CakevgcHR71Q
         BLOd+BEk+Ok6pq6LHMckAc4r31AizMBvy65zk95uDwaFf01+PzFt0Rz9KoddNnRMSovt
         Hupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9RsUkl6MEN71BO//b46KRM887milBSbG2u+IqiX1rgM=;
        b=qWN34QmReFLiHBiCb8X0BfEiCxSw4o8CzlvWcJhh3NzolwYqJgUzkm6EEK4sBKhbPG
         LkiD03i29wBwe2bEiMSV5LgS9o/Jvf3ejZthsTwubI95MIHCybtkIdsP4gyQMurqy+mt
         wQbmQiu0u1LvrAIH58ubz/D/rG6DiLnMB94EgPwYQZWY040J63YANzczpknfXxvp5E9O
         7OlX8KO1TFo6Szewwj/+PKWYIFL1nqNGm20/o2qVR37dNT0irlM5O57XuNa10d6KRCYm
         4OEWhBtZAm0mubweM1tGdHNZwDnum33+mMW7H8BdHE2Q+JucmjTFx6GMo4MaPGsP+e25
         tteg==
X-Gm-Message-State: APjAAAW2FK3ub8ZGEDsxI+p2x8emzReUhcWJNSrgOixQUpSSbKCKoI9Y
        p7h3leliBdzhYG77KAOhs+k=
X-Google-Smtp-Source: APXvYqx75/bX6ZgLs/5GYKN91lU9aCoHIZOyWt9XH5ENUcWqcGQC61YP9nuIxCK/uDC1YZS4VL1NOA==
X-Received: by 2002:a17:902:7586:: with SMTP id j6mr57986217pll.8.1568531606466;
        Sun, 15 Sep 2019 00:13:26 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id k5sm28129193pgo.45.2019.09.15.00.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 00:13:26 -0700 (PDT)
Date:   Sun, 15 Sep 2019 00:13:23 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tegra: switch to using devm_gpiod_get_optional
Message-ID: <20190915071323.GA36596@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not really need to use API that fetches GPIO data from an
arbitrary device tree node, as we are dealing with device tree node
assigned to the device structure. We can easily switch to
devm_gpiod_get_optional() plus gpiod_set_consumer_name() and clean up
the code.

Note this is part of efforts to get rid of [devm_]gpiod_get_from_of_node
in drivers so that gpiolib can be cleaned up.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpu/drm/tegra/output.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
index bdcaa4c7168c..b4248125b844 100644
--- a/drivers/gpu/drm/tegra/output.c
+++ b/drivers/gpu/drm/tegra/output.c
@@ -121,19 +121,15 @@ int tegra_output_probe(struct tegra_output *output)
 		of_node_put(ddc);
 	}
 
-	output->hpd_gpio = devm_gpiod_get_from_of_node(output->dev,
-						       output->of_node,
-						       "nvidia,hpd-gpio", 0,
-						       GPIOD_IN,
-						       "HDMI hotplug detect");
-	if (IS_ERR(output->hpd_gpio)) {
-		if (PTR_ERR(output->hpd_gpio) != -ENOENT)
-			return PTR_ERR(output->hpd_gpio);
-
-		output->hpd_gpio = NULL;
-	}
+	output->hpd_gpio = devm_gpiod_get_optional(output->dev,
+						   "nvidia,hpd", GPIOD_IN);
+	if (IS_ERR(output->hpd_gpio))
+		return PTR_ERR(output->hpd_gpio);
 
 	if (output->hpd_gpio) {
+		gpiod_set_consumer_name(output->hpd_gpio,
+					"HDMI hotplug detect");
+
 		err = gpiod_to_irq(output->hpd_gpio);
 		if (err < 0) {
 			dev_err(output->dev, "gpiod_to_irq(): %d\n", err);
-- 
2.23.0.237.gc6a4ce50a0-goog


-- 
Dmitry

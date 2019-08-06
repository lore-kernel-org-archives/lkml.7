Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45AFC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B6B208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q4Fm42nZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfHFT1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 15:27:03 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:50390 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfHFT1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 15:27:02 -0400
Received: by mail-qk1-f201.google.com with SMTP id e18so76647017qkl.17
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 12:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iPCtVhelamfyNmHFH2EKFLaaUs7nprfge3H+YNAP5fc=;
        b=q4Fm42nZXSCJMyda/16R+zUSCptYRFIOQduf9C9prXzhSCNR19aofjCM0QXcsykY2X
         2HKqnLbG79HIix8cv2sfU5b80A0OSlzXo9CLrzoaJG7FH+fTDbVU7Ymd48rZdXxILzVP
         CacYAFOjUqwDsHfatUmMbSxcMnEz+qmVWXRFIoLilts8110jHqBaLSiNs+9XqIlF7/Xl
         BKaDDXqmY938i3Ia2NwlPAL1LANJePJ4o+5SctEALb+1RUP+/YeHFY0OHLy0qbd5JJdU
         oiADb5RW5SW7sIq0VnRaoLuQWxtSNXBWMmlejP1ksJZIig9EoJ2tZKcqnaFVTpWWVFDV
         9xAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iPCtVhelamfyNmHFH2EKFLaaUs7nprfge3H+YNAP5fc=;
        b=Lga9dlvrH3JcxylTwB5I10qTrs/Y3rSAGhlnNbGIj7rbDuUZ8G7K8aqWMV02nukrnP
         eaazuXVbxuCVYfW9ucBwRKBhtEcudx6uAX37dmh4QfMX2SZ5DQuxwn12ntfDapQsGNPt
         3BbWCMJ9EaIAQutcGZsdXotkwkxnx77Hfd/xy32/Vrhb1rj0H8SXWOI4if9ZfvfzPvAb
         6w7oY3ocalNd1+3UlcfrxdhXXOKvz7b7w2dkLgy15cmPvpCv7zjb88xK3Gm8hk2wZd0N
         kbH7pd/KlnikLXtp+9WqtGN1Qk49prWQ+NTrlaa+5Gp+sKEWifnx6GeghKMhFXjuffHt
         Bv4w==
X-Gm-Message-State: APjAAAW2UBsLm+aPZCORYImmivQ2CY+MsBq3CPhD4cfZaVEjJRR4t10W
        Z9ZgsBAGKIDHb26uyNAz/0McXunFSHAkZB8=
X-Google-Smtp-Source: APXvYqwvpDkuXUO1XDLIDxYen3s/Nv6gDoebrjDR5FqT9Q5FwKWsU6sSd2XJVBvKkXw1iiOO87nDjTgsTylqOQc=
X-Received: by 2002:ac8:24e3:: with SMTP id t32mr4733485qtt.104.1565119621558;
 Tue, 06 Aug 2019 12:27:01 -0700 (PDT)
Date:   Tue,  6 Aug 2019 12:26:54 -0700
In-Reply-To: <20190806192654.138605-1-saravanak@google.com>
Message-Id: <20190806192654.138605-2-saravanak@google.com>
Mime-Version: 1.0
References: <20190806192654.138605-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH 2/2] of/platform: Disable generic device linking code for PowerPC
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel-team@android.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PowerPC platforms don't use the generic of/platform code to populate the
devices from DT.  Therefore the generic device linking code is never used
in PowerPC.  Compile it out to avoid warning about unused functions.

If a specific PowerPC platform wants to use this code in the future,
bringing this back for PowerPC would be trivial. We'll just need to export
of_link_to_suppliers() and then let the machine specific files do the
linking as they populate the devices from DT.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index f68de5c4aeff..a2a4e4b79d43 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -506,6 +506,7 @@ int of_platform_default_populate(struct device_node *root,
 }
 EXPORT_SYMBOL_GPL(of_platform_default_populate);
 
+#ifndef CONFIG_PPC
 static bool of_link_is_valid(struct device_node *con, struct device_node *sup)
 {
 	of_node_get(sup);
@@ -683,7 +684,6 @@ static int of_link_to_suppliers(struct device *dev)
 	return __of_link_to_suppliers(dev, dev->of_node);
 }
 
-#ifndef CONFIG_PPC
 static const struct of_device_id reserved_mem_matches[] = {
 	{ .compatible = "qcom,rmtfs-mem" },
 	{ .compatible = "qcom,cmd-db" },
-- 
2.22.0.770.g0f2c4a37fd-goog


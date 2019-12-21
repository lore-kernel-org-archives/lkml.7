Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0B8C2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 18:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EEB2070C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 18:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWrwVgjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfLUSTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 13:19:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45381 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfLUSTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 13:19:01 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so6630705pgk.12;
        Sat, 21 Dec 2019 10:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XZWzStVGaglhqJ2FheU5GU3236NOGrsoSxq0qw1NNLs=;
        b=EWrwVgjB1N880JC615Xe0QmqiK1DQhoUA0Hp7hkEB5XECyH1lHU8eIJ9wt4aaLKkYj
         Ff4+IO2fv/ON7kJ69aMVwra2254836TqyJMOTFrekhxQCEbPBFLHeHdvMfMU8iJocJyZ
         WvWVm2fMO+YQ/fJGOxv7HoyS5i2o6aoj/cie/vHX46P5xzhWE2D7xIRvd9jOYx6XEITD
         vIeX9JdPd2cF/mSaFYkKatXdGhJsSLMd6ZlaipCKhcbvkNe2yKXyqCp7IjnxF2iVDQ2N
         HHzZOSLjweiYJZ3e42ryJ73Spizat9uCbHl7SR7lQ8gTnyYGBmDQNgbwitXgcdqVzGj5
         9TCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XZWzStVGaglhqJ2FheU5GU3236NOGrsoSxq0qw1NNLs=;
        b=tT49w6fDLX8lHBRmq5miyG00231RvVwZDypX3D8F5VSF0Wf8+wT683x8xjjEdUlmR2
         fbz51AHTMG1daWQVUmWunyMW8K9h7AWt8a6pDcUxhHNyLec1yXFPqjuMDlXwPmWolGlG
         Lk1mffs6X5NZv0gD/BI2pr81gw7UhPrpvBBVMiD2JBfZYT8yl400OVTCoKElqsBKDqiP
         CSOyFAk+jwPLcicW3gCgNenRaBmNrR9OiuvTJ8jYG0slzwlR/KkIh0pNtPfcF5jQitO7
         k1eW/qL6gTVC6v6/Xzvpambhv1SFyBsu2Lka8xAL4Gp4BiEoXCLXCe16Y6dOr6rN6RY5
         N4vg==
X-Gm-Message-State: APjAAAXFsXAg2U2fP8zzZYK/IjL6nf4xUvhNXGJ7E9tLYQ71nbIRC34e
        ZjPOoD+gLC/PaplymA3LrQOVo/Seds4=
X-Google-Smtp-Source: APXvYqyrZNXewNn1mnkCPEBTGU7duzlk3FmQh3qSjs79aeT79A47u+NvapGKMDjawXbiMXYzw/LRMQ==
X-Received: by 2002:a63:4287:: with SMTP id p129mr21803975pga.122.1576952340297;
        Sat, 21 Dec 2019 10:19:00 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id u1sm17467435pfn.133.2019.12.21.10.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Dec 2019 10:18:59 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/2] PM / devfreq: exynos-bus: add missing exynos_bus_disable_edev in exynos_bus_profile_init
Date:   Sat, 21 Dec 2019 18:18:55 +0000
Message-Id: <20191221181855.31380-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191221181855.31380-1-tiny.windzz@gmail.com>
References: <20191221181855.31380-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The exynos_bus_profile_init process may fail, but the devfreq event device
remains enabled. Call devfreq_event_disable_edev on the error return path.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/devfreq/exynos-bus.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 7f5917d59072..5e54eaf3cfc6 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -335,10 +335,14 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
 	ret = exynos_bus_set_event(bus);
 	if (ret < 0) {
 		dev_err(dev, "failed to set event to devfreq-event devices\n");
-		return ret;
+		goto err_disable_edev;
 	}
 
 	return 0;
+
+err_disable_edev:
+	exynos_bus_disable_edev(bus);
+	return ret;
 }
 
 static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
-- 
2.17.1


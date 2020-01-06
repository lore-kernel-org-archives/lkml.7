Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CAEC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7DB20707
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je+dzev+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgAFPRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:17:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36611 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgAFPRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:17:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so15643691wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 07:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zpVrjWu9aDwxR+gFK4Bj/HRMRoCvr4WMHyXpeXsUZuI=;
        b=je+dzev+ahIb+/gJsOqkpI4onXujW22u4BpaQj8FJ42M0yKtlAh4aB/uHjsf6xg9g1
         WgjJ6FnDFLBP+L3LsZtOUoZQTgJqM51uW75g63ZZkhfQ/yAjtFymmtSomQ0dS6y2QL3F
         BXs2Wgjs3J/MPyMuV1haP7jSbR2JFuXqLG1cjQ1en2Ogb86GqVYUdznYsHgiywzvu4JZ
         lDwpoqUMVmzKGy3uLnBtarRx8bn5S1/+noh89RAZ3nJIpw4yGNlsV51tE/SfbAvUjcIg
         IFnV7sAGiZMS5LAwLSXS96XhhQsbaVyxINeTZBBFxZ8SJ7XtTavmjN89IEX9eM5qrTmY
         QO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zpVrjWu9aDwxR+gFK4Bj/HRMRoCvr4WMHyXpeXsUZuI=;
        b=Wzsso+8KlcX4aed4zSUK5J4ckFA2guMzY9egqQ7GCG1c4p1SuFKvOsYFP707Fhifhp
         UwvkGo7z0hZEDeTo1C1f4aTfFQCQwLOZXnvEzxKGBoDWE386sh4zwVRaXHsSTSyzJgDD
         eBtlsaedHuUQpYaJ8tgxeb4X7SngTlG0NfvvQbl9gKv5M9vNh6IPCNfiCe0ApMgtSd0C
         KRU5kzkIqTGANtHeW/+5Qyn/fMS+FMNGqzsx9hAjeSJ0vhKnc2BSEwza1EnTTZ56Ec3Y
         gtyMBQF5X6fyBgQGX1OtoZ4BRQ9KxaVNDUVfH3+hVO+cluLViUtcp5imuDCpSTNQ7lFI
         tR1Q==
X-Gm-Message-State: APjAAAWlmE0hJyOS20HO0YzzBn8cJVpyesB2duuMhqZr/lKPu5Qn9DtI
        cInTWmMndE4SMNhthqyUGbLHCDUnfMIcJg==
X-Google-Smtp-Source: APXvYqx+bQmS7ysHaJStobb11d1QtmMIsCygBuoqMHOxm9t0UTckRame1IGMUlFK/+4C+9SKT3HLqg==
X-Received: by 2002:a1c:44d5:: with SMTP id r204mr36107168wma.122.1578323832989;
        Mon, 06 Jan 2020 07:17:12 -0800 (PST)
Received: from localhost.localdomain ([62.178.82.229])
        by smtp.gmail.com with ESMTPSA id l3sm72122463wrt.29.2020.01.06.07.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 07:17:12 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 4/6] drm/etnaviv: update gc7000 chip identity entry
Date:   Mon,  6 Jan 2020 16:16:49 +0100
Message-Id: <20200106151655.311413-5-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106151655.311413-1-christian.gmeiner@gmail.com>
References: <20200106151655.311413-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ~0U as marker for 'I do not care'. I am not sure what
GC7000 based devices are in the wild and I do not want to
break them. In the near future we should extend the hwdb.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
index 39b463db76c9..eb0f3eb87ced 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
@@ -9,6 +9,9 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 	{
 		.model = 0x7000,
 		.revision = 0x6214,
+		.product_id = ~0U,
+		.customer_id = ~0U,
+		.eco_id = ~0U,
 		.stream_count = 16,
 		.register_max = 64,
 		.thread_count = 1024,
-- 
2.24.1


Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A460BC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F73021479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HV3rCpJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389716AbfDRQnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:43:35 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:33442 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389016AbfDRQna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:43:30 -0400
Received: by mail-it1-f195.google.com with SMTP id v8so8424597itf.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V0DvXyW83Tyl1dIg7RoL/VcefLCuqNc5VVNBZR8eRII=;
        b=HV3rCpJrTVT6hdRU6RJdvCRZGQ2Fk1g+Sk8SnKM7WHdHry2vz5kqi4QJNGFPKxU+CB
         Q/K41eFnKV0Ow+F5J88tIXRoOkOFbsrELT3PulI7qabcNk5a92LNX+dUM+9XqilYWI3F
         KQeSkgob6eUEGsub+njapvLJyRBnZnH3s1YC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V0DvXyW83Tyl1dIg7RoL/VcefLCuqNc5VVNBZR8eRII=;
        b=b8Y9MEbUDnrsEBIZGLnYy9+nzqNMiuI0Nr9wnaaF3oiTp83cV/084YogU9TSY1ry6k
         i938gy3WTTiiaEQ4QxQKY5hjbxLYY7JSNb7bWf4V7oJYx3gy3L4gB490SZBlOvrwUZVz
         ANo3BlnxJ4wedSwv+hED0pO2b9o11TVzJznlWrapvNE9AdM8o+K35fo+gWgyLR7YpAKy
         hpzVvRSv+XB33kmHnCF6p5LYIzsceoXKAnwOVVB45YHxol7MUNG3MFbthOOyHu22zu1X
         KL2Lsp24Qd4fcaxmkWPKyaX7voUXULB2SqjuFQoelGOHgjp0Zy1EQ3Vw6EEj++V1G6Le
         DDRA==
X-Gm-Message-State: APjAAAU4wh+k2dqRWp0LdmaHh52FSTBfyBG+NMAHANK1nrVfdk0MnUpU
        XZnfSycGiAyCmEJqOohg+AUJhQ==
X-Google-Smtp-Source: APXvYqzQpRUPm+raVvlIN8EON3EH87VVwkxn1YgDwTHhcOjWIg2kelfED367Q6EXh5o+Xwcd7qSV0g==
X-Received: by 2002:a02:6a28:: with SMTP id l40mr41437731jac.25.1555605809480;
        Thu, 18 Apr 2019 09:43:29 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id g70sm1180905itg.40.2019.04.18.09.43.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Apr 2019 09:43:29 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org, sre@kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        lamzin@google.com, bartfab@google.com, derat@google.com,
        dtor@google.com, sjg@chromium.org, jchwong@chromium.org,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH v5 3/3] power_supply: Add missing documentation for CHARGE_CONTROL_* properties
Date:   Thu, 18 Apr 2019 10:43:14 -0600
Message-Id: <20190418164314.161065-3-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190418164314.161065-1-ncrews@chromium.org>
References: <20190417214022.7jk3usygcpnls3pr@earth.universe>
 <20190418164314.161065-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT and
POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX properties
don't have documentation. I add that documentation here.

v5 changes:
- Split this commit out from the previous two commits.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 Documentation/ABI/testing/sysfs-class-power | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index a5b144f61de8..b77e30b9014e 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -114,6 +114,25 @@ Description:
 		Access: Read
 		Valid values: Represented in microamps
 
+What:		/sys/class/power_supply/<supply_name>/charge_control_limit
+Date:		Oct 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Maximum allowable charging current. Used for charge rate
+		throttling for thermal cooling or improving battery health.
+
+		Access: Read, Write
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/charge_control_limit_max
+Date:		Oct 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Maximum legal value for the charge_control_limit property.
+
+		Access: Read
+		Valid values: Represented in microamps
+
 What:		/sys/class/power_supply/<supply_name>/charge_control_start_threshold
 Date:		April 2019
 Contact:	linux-pm@vger.kernel.org
-- 
2.20.1


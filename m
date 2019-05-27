Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F422C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF4F2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="0r29VISI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfE0IXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:23:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36956 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfE0IXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:23:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id h1so1843844wro.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 01:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1P0YZo/wN9Hi4i3wVVtvZOC+PYc4GxlayMQxrDs2oJw=;
        b=0r29VISI/sleJKF6HyZxAFrh2kh/YfBUsyXfqB+Uq7gencb0DLdj6ynAmT6lnnhfVI
         u6b7Hdtwm11DUvMNlrTyiwVtmth2RmBJFfPktxKMqE1Ya8OFbJhTxzCzwAePG714BE6G
         L8Er0ZafhWTDV+ungMYqXp40+4C7//Ipfn7Yorcz4A8bSwgJKW/u3yOPpvVsPD/05cyd
         PXn/nY7SdkDO6B75GJFJUXr5iGEfv5muqWOXlz8BiztUeqCTDZ1lMJyMsuBx71jDnpi4
         fRTAiFKEXtmJL267zY7ArQNWxUBTrqnjTgrmuHCeGY6x5SqsGsj9so5k7Roqwt8vfT6U
         vCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1P0YZo/wN9Hi4i3wVVtvZOC+PYc4GxlayMQxrDs2oJw=;
        b=NRFNaD5+K+sHmzpPUk7h9nzCkGIoTobqwANj/18tv6xstQRLcJlx0/faNUL/7Hw3OZ
         y8LKl22tJtTLnRO1AJ4SeldAWhc38PfdOyiuJAC7J5exT7M/ZF7Fu11mk49ke3deg5ky
         oGEX+Wr46nF218m+M3n/g16AqMKWOqZUBZnissfg5d8UqLELlcLopK/CZeNjCDlAQA0O
         97H1y2X73itAMAnRm9Ze5+3igHJzCJNYNDCalTVGeoXfoV/YsIaZobPk4t6fhw4B5AvL
         QXZYb6Lr0KG0aGyLRNPc6Dv4ZLshvSWjzImWd437fR/VKXiioMicfm9OWrYnCDjc0LpT
         ukiw==
X-Gm-Message-State: APjAAAW5JrmEmtIBr1QZxizarx7YxS2MyVHMs2NbMnQ9XV5IFPNKkq+G
        4ap6csztxXOKjXJ36ai+KAFSwQ==
X-Google-Smtp-Source: APXvYqyNwI/ePsL+r12MfFxLaq+cmuaSjCI/uIy3GarP8rEJKG3oAJbqaBtNW6Dt2CCfrWekKVz07g==
X-Received: by 2002:adf:ea90:: with SMTP id s16mr7059760wrm.221.1558945389541;
        Mon, 27 May 2019 01:23:09 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id n5sm14482754wrj.27.2019.05.27.01.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 01:23:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v5 5/5] ARM: davinci_all_defconfig: Enable CPUFREQ_DT
Date:   Mon, 27 May 2019 10:22:59 +0200
Message-Id: <20190527082259.29237-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527082259.29237-1-brgl@bgdev.pl>
References: <20190527082259.29237-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

This sets CONFIG_CPUFREQ_DT=m in davinci_all_defconfig. This is used for
frequency scaling on device tree boards.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 4a8cad4d3707..9a32a8c0f873 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -45,6 +45,7 @@ CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_PERFORMANCE=m
 CONFIG_CPU_FREQ_GOV_POWERSAVE=m
 CONFIG_CPU_FREQ_GOV_ONDEMAND=m
+CONFIG_CPUFREQ_DT=m
 CONFIG_CPU_IDLE=y
 CONFIG_NET=y
 CONFIG_PACKET=y
-- 
2.21.0


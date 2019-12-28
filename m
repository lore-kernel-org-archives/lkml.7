Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8378EC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD4420838
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0TDwlSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfL1UgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 15:36:03 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44613 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfL1UgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:36:02 -0500
Received: by mail-lj1-f193.google.com with SMTP id u71so29862943lje.11;
        Sat, 28 Dec 2019 12:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bvf4OSFNQcVF0tHhO08aQEMZiSb+xUsqvddNKBq6qy4=;
        b=F0TDwlSY87vh6jALSmqg7UkSMm5ISdJeaa13aKEDsrvT040sx5AC7qCYS+MpJIT33X
         tEYA3ffk6sOkFRI0jkRFFBACTEs/gdtdBbtB5ywo9XFiBOtsOVhjgsvFX+fD78Jicgde
         m2LuNzmVq7zZahJv/eQhPuwXp1cskTuGpKN5+4aWOvTpmnfRsZ3Yb+gWhUgU5KGHuoFx
         yhnMSawRXlF2wyiPyddbKEK6ckTHCXt2/08Zw1SQEyB09FpQlahikIGT2M5m7gHjqxLW
         I0HdvleFXyNFahbVTFO21kXS39evWRmYq9kml5+SupUd+huytdDKgNdE6oIL+QEDjc8b
         7LeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bvf4OSFNQcVF0tHhO08aQEMZiSb+xUsqvddNKBq6qy4=;
        b=mkALFVkMNbNLO2dkwUEv/FmSmPJtHPZ9qteh2f9EaKi8ytb1/OrnhqCA32nfZ7k7aP
         B9Yw4EqgSWmzU/fWM6bHZm6yO76qB8dx/7+p1NT5esaUoyOT0TixDSYFzueNIIUd+bvd
         Jvhj7OGcx8rhJOFUpIBRcfy3jukyA21tLRMEmNDh1IIypSDvVs83ws8upR2xZJ02Apsm
         5B3lTlE7oWYIQnuvQF6Jq11jVgkrCh+RoN4yaIuK7FdIjAqCdVwAdddykxyzss1VbbsP
         0XOSCHY55yQaZ4HG1IKgrCblcPBQWYn5J5Ktd/SnflIxs3dALT0JEh7sacfDCG4ObT9Z
         uHSA==
X-Gm-Message-State: APjAAAV8N1KSavEfc1NyiyV3xIanJ7KKEY+LwRV+fhVQXJkJYqcOraej
        F3XsMrvOeDtJUD8hAeR/inY=
X-Google-Smtp-Source: APXvYqzwpxlNCNUwrML48Eq/oKgKa2QCbM5bfx5ahFqrKmJfokZr8VMZFchSLwVwScLx/tTZmlqFPg==
X-Received: by 2002:a2e:9c0b:: with SMTP id s11mr15255011lji.11.1577565360121;
        Sat, 28 Dec 2019 12:36:00 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d9sm15162614lja.73.2019.12.28.12.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:35:59 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/16] dt-binding: usb: ci-hdrc-usb2: Document NVIDIA Tegra support
Date:   Sat, 28 Dec 2019 23:33:43 +0300
Message-Id: <20191228203358.23490-2-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191228203358.23490-1-digetx@gmail.com>
References: <20191228203358.23490-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVIDIA Tegra SoCs use ChipIdea silicon IP for the USB controllers.

Acked-by: Peter Chen <peter.chen@nxp.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
index cfc9f40ab641..51376cbe5f3d 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
@@ -15,6 +15,10 @@ Required properties:
 	"qcom,ci-hdrc"
 	"chipidea,usb2"
 	"xlnx,zynq-usb-2.20a"
+	"nvidia,tegra20-udc"
+	"nvidia,tegra30-udc"
+	"nvidia,tegra114-udc"
+	"nvidia,tegra124-udc"
 - reg: base address and length of the registers
 - interrupts: interrupt for the USB controller
 
-- 
2.24.0


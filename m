Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37536C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086602183E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FGcvKTgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfCUOAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:00:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39632 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfCUOAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:00:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id i17so4357497pfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GYwTgmlWSVYWvxP/h7yMFr7idR5LGv6A4BU5Fkgg4q0=;
        b=FGcvKTgl6NB2UtnMF9kQzr0BiQLKgvxBEUshDKOfS4i4ssA1TTayyj+4JD8iqNYThq
         oSRuuh6tw9ZjChLgSVpJPEL5bLESpc/V6bjWUCXuoOOWQpHZOlk6u4jES5Yziu4iofwP
         y3eyDMkRNrmUyf6uiocrVBRHPRODFXB5vzNpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GYwTgmlWSVYWvxP/h7yMFr7idR5LGv6A4BU5Fkgg4q0=;
        b=naaNJII/qq+oicj9ekNXUUJplxFpFB0bUGzmhUMXyEBbX6Z9TimEyLARYkOQGs8weP
         CadNSf7n5RXKkJ41bAa2Ft7L0B3McDUyDNJbRPAo7O0813YDHvCR8QCwh8urGrl0Mvba
         zUiboP9KeI4ng/7tRW4ISzWcPO9FvstVFBBuYJBYkoZSiUCoCnBwtVpO9qw4IAYxnvwo
         E9JjhlTWVA8FKvyFMfujP1qD9OQHey/soZ6zR/l6XAHntsLeUODg06BKx7dZqzD932DO
         Q5fAA8WgAsF5hy35+sjGeFNOJKt6WfBSH626/rHeOtSqaAE8VUsJBZk55vIg0SYG3Vba
         +S0w==
X-Gm-Message-State: APjAAAUSV77Q3R1rsD4KJqps7cPqBLU48CFZe3NOhWmYfJM0se8po0P7
        nDCwVaKkRE8ssr9ka/5Nv9YAxA==
X-Google-Smtp-Source: APXvYqyjFIp7Xi8pOR7tFDkI9n1bs5q6JelbKXfA4DE8HfZvWcN0kT+1jNHmBfLsTJlUT8o0T4pFkg==
X-Received: by 2002:a17:902:20eb:: with SMTP id v40mr3749970plg.20.1553176815414;
        Thu, 21 Mar 2019 07:00:15 -0700 (PDT)
Received: from localhost.localdomain ([49.206.202.234])
        by smtp.gmail.com with ESMTPSA id i126sm7985158pfc.101.2019.03.21.07.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 07:00:13 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Ryan Pannell <ryan@osukl.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        devicetree@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 0/4] drm/panel: Add Novatek NT35596 panel
Date:   Thu, 21 Mar 2019 19:29:51 +0530
Message-Id: <20190321135955.25661-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v2 series for Novatek NT35596 panel driver. here is previous
series set[2]

Since there is no proper programming guide for NT35596 IC, the driver 
init sequence is referenced from [1] but analyzed based on datasheet.

NT35596 support several regulators on the chip, among those ony 4
regulators like VCI, VDDI/DVDD, AVDD, AVEE are used during power-on
sequence. Right now driver added code for 3-regulator based power-on
sequence since MTF050FHDI-03 panel support. This power-on sequence may
be moved to panel_desc in future, if there is any new panel would come
up with other type of sequence.

Changes for v2:
- control enable/disable calls using enable, prepare flags
- comment on delays
- move 120ms delay on power-on since it is part of power-on sequence
- fix driver name as novatek-nt35596

[2] https://patchwork.freedesktop.org/series/57490/#rev1
[1] https://android.googlesource.com/kernel/msm/+/android-msm-shamu-3.10-lollipop-mr1/arch/arm/boot/dts/qcom/dsi-panel-nt35596-1080p-video.dtsi

Any inputs?
Jagan.

Jagan Teki (4):
  dt-bindings: Add vendor prefix for novatek
  dt-bindings: Add vendor prefix for microtech
  dt-bindings: display: Add Novatek NT35596 panel documentation
  drm/panel: Add Novatek NT35596 panel driver

 .../display/panel/novatek,nt35596.txt         |  32 +
 .../devicetree/bindings/vendor-prefixes.txt   |   2 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/panel/Kconfig                 |  13 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt35596.c | 895 ++++++++++++++++++
 6 files changed, 949 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt35596.txt
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt35596.c

-- 
2.18.0.321.gffc6fa0e3


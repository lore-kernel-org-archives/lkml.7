Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFE6FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00BB62085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6qI6CoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfKHNKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:10:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35852 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfKHNKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:10:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id v19so4557577pfm.3;
        Fri, 08 Nov 2019 05:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XBz1Jc3/FiwJIp4RboH8VljgUQ6jRhtm1XzbxHXczBI=;
        b=a6qI6CoPQOIV7/MjWLHdMwLEEOsLElkRa+bh/kFYUUDZhpO10RT3wZy9SwZT8GgF7H
         OiMkj6uihW0+/a5mxow+4Q/Lyd5pWHtKrvHSaNa+oQ7nAajMp+nNGrFLL8ActfNNnT6Y
         q6MoQc/Aop4wwwOjWKb8EH2w8OwHvHyfLSbL/QS3AfU1Nntx7lN+FrirQ5rYnS91TQ+e
         agHArMGlnXYf8/tZa7uCdyxljSSppplS6M0Em4Q9dG1yas8ShFFq+9ePF7p+kI8G8gDV
         1yY2WnCNG15wIDMYfbBbcfT7szvaVzCzAt4azod2PCjJQaur2MHFTNS+LjfnKI2IivIM
         uMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XBz1Jc3/FiwJIp4RboH8VljgUQ6jRhtm1XzbxHXczBI=;
        b=Xu+KFalfilVT2afJ2i1XoKHL3XzamyzQW/Qco0ql5/zBzBHGV+j/20AakFfnqWGxBT
         7fOQ4m3YfnvGuoLWr7MIyeXatyIApb/iOiVw4/lT7Mfvlat+uHv1pQ8g09fU9nRtdB52
         6XSjRpbabcSTdulAiQkBegZXxah/zi/O6P6jN8a2H4cNNnlP7ip9wirvMFZLTjZNfevh
         ecwtfNCWC4KKWL1EYUcI+Y8A70gs55av18rxckSnVD64DQmY4NPz1LHRh6yQxN4QLu8E
         Ai0wwhIxR6ohovn+d7G+KWdDmWe89zO65HHvNlYCSKH0o3I5stb7PL71mPTJCLyiRbMQ
         54/A==
X-Gm-Message-State: APjAAAU/6ebKzd7IDd1csBmlQjwV3pBjoxNwV/W2LGXKZkWf+xeqsTp0
        OREZYy/UP9Uc+xSZyZO+GKo=
X-Google-Smtp-Source: APXvYqzciQpQ70/OMBDo8jUhaVkvkwXj9G7b/PcEjqu9pt+ztWVa3y/7I7nwrrrScoSE/7G9eokeFA==
X-Received: by 2002:a63:ae02:: with SMTP id q2mr12144703pgf.210.1573218609219;
        Fri, 08 Nov 2019 05:10:09 -0800 (PST)
Received: from localhost (97.64.17.87.16clouds.com. [97.64.17.87])
        by smtp.gmail.com with ESMTPSA id x20sm6749679pfa.186.2019.11.08.05.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Nov 2019 05:10:08 -0800 (PST)
From:   Song Qiang <songqiang1304521@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH 3/3] MAINTAINERS: add maintainer for AD5940
Date:   Fri,  8 Nov 2019 21:09:46 +0800
Message-Id: <20191108130946.14740-3-songqiang1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191108130946.14740-1-songqiang1304521@gmail.com>
References: <20191108130946.14740-1-songqiang1304521@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as the maintainer of the driver of AD5940 and it's
docs.

Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a427d1e9f01..c3d29dcc50ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -431,6 +431,16 @@ W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/regulator/ad5398.c
 
+AD5940 ANALOG FRONT END DRIVER
+M:	Song Qiang <songqiang1304521@gmail.com>
+W:	https://wiki.analog.com/resources/eval/user-guides/ad5940
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/adc/ad5940.c
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad5940.yaml
+F:	arch/arm/boot/dts/overlays/rpi-ad5940-overlay.dts
+F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad594
+
 AD714X CAPACITANCE TOUCH SENSOR DRIVER (AD7142/3/7/8/7A)
 M:	Michael Hennerich <michael.hennerich@analog.com>
 W:	http://wiki.analog.com/AD7142
-- 
2.17.1


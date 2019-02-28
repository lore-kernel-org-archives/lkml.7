Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B0CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8138D218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnCHEB/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387865AbfB1USY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:18:24 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51542 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387801AbfB1USU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:18:20 -0500
Received: by mail-it1-f193.google.com with SMTP id e24so16715231itl.1;
        Thu, 28 Feb 2019 12:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=40fGOBZ2WRp7c5AXY118hJm2tF8m6I1wVRQbUkrZ3wk=;
        b=FnCHEB/wPnS9VhlFtjX69Ou6SXpcGei8/PMPsCD3wFBRqW4c5DBO7vOp3qrhKtKgvb
         fOKO2Imx4dAwtWYMILpNYeP015ukTtGPX+0kKEGfmuXufck9yHa7zS8xDeY7rXr2pQjN
         IOFgpoKnikxAwwpuNMYBY3vKWpIR6Tk82lBZHBEoK/W/cNgqrJeuiNWL1MBu6mhJ9iLX
         HuDNclcML/kVHwrDG3gtweoyItZruD2wUDPfGHKPpfc1dhLvxJIp5wRHEw3TNqnoO8Ui
         wkA1Skemr/xPlp1nzQuDt32y65mrdwFhbLdw9Jee62c0m8HnBGl33/4LzpxEVBcl2+ge
         JzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=40fGOBZ2WRp7c5AXY118hJm2tF8m6I1wVRQbUkrZ3wk=;
        b=ocYgqX8V8o/sp8Q41qneI4lhfjpUlFZpWmwNyJcXWAQlrOVW5JstVDb0WvfLqY9fqA
         y3TRFJXadF6BJWP/JeSkW7XDdmnv2uWOySz1FktQgmj3M39JJc45xPae+39MTt2yCiXh
         a1qHvH3PrbiG2V2gEbZfH0eF+ZTWh5DaAJWH0tVp0HceOX1X9ZeKHAEMZ6WLeaY9tGIT
         IXyUJwN3yzo1mflajGC0cVG4zSvWGoTu3qnFDZIeXzqUzihGGIisIulz0LiBcsfNEKy+
         PR/Qxzm9Jy6+S9lSRU5OXks+gRMTTM5+ZGTcWskwNnr4VhuGrIKLHrcYqgw0w3H1zVZy
         TC0w==
X-Gm-Message-State: APjAAAUNqS7zgZ9WLw2Y2p6GkEQIeCVmyX22XiBbTOjYW/USxfnvYd+x
        B6mMss/ZuHGYjKVMLPi1gA==
X-Google-Smtp-Source: APXvYqwakrTGQyhvOp40sHGQXKJ1kgObg/tqcaAkdYeMEzOjzevWRQxR9AGDcamXkN+aEoAtQKqIBA==
X-Received: by 2002:a02:117:: with SMTP id c23mr551878jad.71.1551385100083;
        Thu, 28 Feb 2019 12:18:20 -0800 (PST)
Received: from localhost.localdomain (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id l131sm3388808itc.17.2019.02.28.12.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 12:18:19 -0800 (PST)
From:   Robert Yang <decatf@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Yang <decatf@gmail.com>
Subject: [PATCH 1/3] dt-bindings: Add vendor prefix for Kionix, Inc.
Date:   Thu, 28 Feb 2019 15:18:09 -0500
Message-Id: <20190228201811.7582-2-decatf@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228201811.7582-1-decatf@gmail.com>
References: <20190228201811.7582-1-decatf@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kionix manufactured MEMs sensors. There are Kionix acceleromoter sensor
drivers which can be used with device tree.

Signed-off-by: Robert Yang <decatf@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 01732c887521..e28583ebe5e8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -208,6 +208,7 @@ kiebackpeter    Kieback & Peter GmbH
 kinetic Kinetic Technologies
 kingdisplay	King & Display Technology Co., Ltd.
 kingnovel	Kingnovel Technology Co., Ltd.
+kionix	Kionix, Inc.
 koe	Kaohsiung Opto-Electronics Inc.
 kosagi	Sutajio Ko-Usagi PTE Ltd.
 kyo	Kyocera Corporation
-- 
2.17.1


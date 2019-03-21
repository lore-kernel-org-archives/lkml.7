Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9D4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A2A218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WzUQJvKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfCUIVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:21:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35979 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbfCUIVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:21:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id p10so3833735pff.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 01:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JHR4URZIW7IuMIK7c59NYIYWSg7ZlWSVaAjtcwyfIJ0=;
        b=WzUQJvKPl79/7o0FSclrCsgoRVYxCRoAkgOAPVBLh0ACdJRDgTr24XRkbSXxw+zMqk
         Q6/FboI49UBoyGizUkRU59eUYsuJfQx/AmCWn3GaYKC3ExeB+VIMyOnDKUDvuvGv3QlZ
         aXREbLKeKlOst5s/h/LaUvbsju9RvrHTz3rA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JHR4URZIW7IuMIK7c59NYIYWSg7ZlWSVaAjtcwyfIJ0=;
        b=Z2TLMs8kj8AIoNdhY9HtS11LL92CCQZBVRQpkSWr6Qgit3KCGTIlE4mQ79iNNKtwWn
         gk0Wn7++4rKe/MDCe0EOh3Z1uUT6oOsKJmFAscjHo4q+KFK3REZ6W+6CEQDNVBi19oXx
         aZHWH3gyNmtCoJf4LtSchCEy85mdNeYPYPc53FQmjvXIp/i6jw96lr1lrs5BI65SWTo1
         Me+k6xj+SE46jGW7j3RJ6EPiEbcDDt5bwEdkqbN76L4eVLFp+L1mMctrSyAazQiVaI41
         VWf7gFL62gokQq2h6XLjMNmkCkwcw2vY03wnHbjCi55paFuSZQP9CFgZX1Hi42Y1uG/z
         B/xw==
X-Gm-Message-State: APjAAAWi3jfxtWFpm2TbtM5prUIAjVlPg3HmdJd3P6shyyB8tqD19VsE
        fBpJXrJsVMqXJVXBbtso58M0uw==
X-Google-Smtp-Source: APXvYqy2B31ROp3oDkFeGxOL+UKJN7lVGkY+cfTNpymD/B891rTzLISg2HmucXgBUzFDhaS+tWtuFQ==
X-Received: by 2002:a63:c511:: with SMTP id f17mr2207375pgd.202.1553156492116;
        Thu, 21 Mar 2019 01:21:32 -0700 (PDT)
Received: from localhost.localdomain ([49.206.202.234])
        by smtp.gmail.com with ESMTPSA id b138sm6288681pfb.48.2019.03.21.01.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 01:21:31 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v7 4/4] Input: goodix - Add GT5663 CTP support
Date:   Thu, 21 Mar 2019 13:51:04 +0530
Message-Id: <20190321082104.2874-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190321082104.2874-1-jagan@amarulasolutions.com>
References: <20190321082104.2874-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GT5663 is capacitive touch controller with customized smart
wakeup gestures.

Add support for it by adding compatible and supported chip data.

The chip data on GT5663 is similar to GT1151, like
- config data register has 0x8050 address
- config data register max len is 240
- config data checksum has 16-bit

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/input/touchscreen/goodix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index de5b80a08f41..c558b091749c 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -219,6 +219,7 @@ static const struct goodix_chip_data *goodix_get_chip_data(u16 id)
 {
 	switch (id) {
 	case 1151:
+	case 5663:
 	case 5688:
 		return &gt1x_chip_data;
 
@@ -1003,6 +1004,7 @@ MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
 #ifdef CONFIG_OF
 static const struct of_device_id goodix_of_match[] = {
 	{ .compatible = "goodix,gt1151" },
+	{ .compatible = "goodix,gt5663" },
 	{ .compatible = "goodix,gt5688" },
 	{ .compatible = "goodix,gt911" },
 	{ .compatible = "goodix,gt9110" },
-- 
2.18.0.321.gffc6fa0e3


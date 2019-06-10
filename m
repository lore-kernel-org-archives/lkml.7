Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65120C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B56120859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fdh+cJir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbfFJIm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:42:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37794 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388540AbfFJImY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:42:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id 22so7288235wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D1YI3KbYi08Gt53137zQUvYaTjAlj5pAkcVwiE+DyoM=;
        b=Fdh+cJirOeCPwca26GEwwWvQ3uzK3nNcYIOCYE8binAxIF/9nbOyMkwaed+EfuvQJy
         VqLf/0N0B9UWZzM3uwCXTlBxBRaoBDkNkBtGw3eXyQIiwzWCxJTeuq45QjmkejDndaV1
         LWduK1uypyuWZFT5a5FsEAgypHaOkHW6tLNHRGr+NmxAkJq2qKanIs8glRWS71UfhM9K
         LSkKBodguJ08qiQbcXIpbJw/ruLp8OSwuEIBXpd4Ux3Dz+qh0qLOOfskjggq/Oe7aqpn
         YFYA+qd7cTUnb474P8X/pSeXinKIyv1TCgXRw0/BnhwXM7fP47h3BtLQ8YmHeChyhPGZ
         mIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D1YI3KbYi08Gt53137zQUvYaTjAlj5pAkcVwiE+DyoM=;
        b=tvXyOBQGls+mlvSv579uayOtpnm6lzieEvLOUsEyyqTJVjptIylm7lHHW4hsTo3h+U
         4ESY25LqcotoxspUdC5tMQ0znrBdgDQqWYbeTwbLoHC1wW7IvxWlrsISmfVn3fhuP1D2
         CYRFysXnzJLZ6vwfeEIlrM/TQevc7Ju2d8tsmG381gK3B6GtgWOh7TaNIlUyO0zacJbz
         h+FOqlLphEtSMNqQHQKOk/l0ecZ0sCcfmTbE3lDb2JFNKlhZgtPfYuWLETf/FUMroZB7
         q26dfikwV52ek9wIRoZgnCNaSOefQl+X9/4p2bUnnh9WYKbuCOLXmPjDGJuCcaOro0bZ
         2MkQ==
X-Gm-Message-State: APjAAAVsfmHbkGxLcwCVQIVGR39OAtG1eigoTujdZuV7AUZjmp77qqFH
        lmOFVnm1R8Jub7GnbMREQqkBZg==
X-Google-Smtp-Source: APXvYqyHnsHDEi1fkEAIyNUAvCi58JRFoTK1I10cExECKSGoyLaT6+gdnSZIt3mwKxzj0hkM9/ajgw==
X-Received: by 2002:a1c:3942:: with SMTP id g63mr11315348wma.61.1560156142556;
        Mon, 10 Jun 2019 01:42:22 -0700 (PDT)
Received: from localhost.localdomain ([2.31.167.229])
        by smtp.gmail.com with ESMTPSA id a125sm9929670wmf.42.2019.06.10.01.42.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 01:42:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     alokc@codeaurora.org, andy.gross@linaro.org,
        david.brown@linaro.org, wsa+renesas@sang-engineering.com,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        ard.biesheuvel@linaro.org, jlhugo@gmail.com,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 7/8] usb: dwc3: qcom: Start USB in 'host mode' on the SDM845
Date:   Mon, 10 Jun 2019 09:42:12 +0100
Message-Id: <20190610084213.1052-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610084213.1052-1-lee.jones@linaro.org>
References: <20190610084213.1052-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting with Device Tree, the current default boot configuration
table option, the request to boot via 'host mode' comes from the
'dr_mode' property.  A property of the same name can be used inside
ACPI tables too.  However it is missing from the SDM845's ACPI tables
so we have to supply this information using Platform Device Properties
instead.

This does not change the behaviour of any currently supported devices.
The property is only set on ACPI enabled platforms, thus for H/W
booting DT, unless a 'dr_mode' property is present, the default is
still OTG (On-The-Go) as per [0].  Any new ACPI devices added will
also be able to over-ride this implementation by providing a 'dr_mode'
property in their ACPI tables.  In cases where 'dr_mode' is omitted
from the tables AND 'host mode' should not be the default (very
unlikely), then we will have to add some way of choosing between them
at run time - most likely by ACPI HID.

[0] Documentation/devicetree/bindings/usb/generic.txt

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 1e1f12b7991d..55ba04254e38 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -444,6 +444,11 @@ static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)
 	return 0;
 }
 
+static const struct property_entry dwc3_qcom_acpi_properties[] = {
+	PROPERTY_ENTRY_STRING("dr_mode", "host"),
+	{}
+};
+
 static int dwc3_qcom_acpi_register_core(struct platform_device *pdev)
 {
 	struct dwc3_qcom 	*qcom = platform_get_drvdata(pdev);
@@ -488,6 +493,13 @@ static int dwc3_qcom_acpi_register_core(struct platform_device *pdev)
 		goto out;
 	}
 
+	ret = platform_device_add_properties(qcom->dwc3,
+					     dwc3_qcom_acpi_properties);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to add properties\n");
+		goto out;
+	}
+
 	ret = platform_device_add(qcom->dwc3);
 	if (ret)
 		dev_err(&pdev->dev, "failed to add device\n");
-- 
2.17.1


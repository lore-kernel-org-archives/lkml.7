Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B58C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B536215EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yUio+wwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfJBXQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 19:16:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46615 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbfJBXQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 19:16:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id q24so544864plr.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 16:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rU3ZIe1wEyPAlyBuDaaRw79vpye8Qn/RpKU+olhtNWc=;
        b=yUio+wwG5BWebxxhvpw7haRUyEyivo6OPVbEi3XIn0sz8A+fsfgZW/IZSGk9ec0w4f
         k4ZlnzlypckTUxWu2hXxCWjxs8vw7UXlr95Mwpk0gklCavpWrE2yLme/muin40Hf1x9J
         ZtzTL/CsWMQoKLjUj4m/nIAlZgEjN2F9K2zALdSWKf4ca4eIshDHFjyScWISkS9ezCL6
         xakFfbbDqt6ZTYKTEyt6iPYey0xWjdaWccEK8xBkX2tPDAq9m0/MdlVA+9kVeTC+Vabd
         9hM4hLA32mrfL5Y1epXeavibzLHX300cNBtFli9v8J5PuuZWcPHBHLt/wi68gP7/DDEz
         DmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rU3ZIe1wEyPAlyBuDaaRw79vpye8Qn/RpKU+olhtNWc=;
        b=jhqDm/p5feIi17+2XnfC0un8khY5NmYmTBdzHguEQPEnkZW8E/fazk2kRE7wR3w5t8
         Q2OMZtCPQuX/SPEbvImeY60xYys324sSYmk/S4XvhsiOP6fnhZaysfila8PaXeSjXl1f
         OuIf/fM/vN5jEmGVS5lPQR3grlBKAgt40m6hq/H23lxoozIUt0ax6x3/k1qJQ7LTLEj0
         lSxFZ43imnEkbu40nMTL4airB57fbo9KdK7vYm647mLSOZ/yR10BUXbHjSGYq3bI5aAy
         HOvpL4k/g9n0U+Ug0vHB/Mxt6ZAFmH8XlI+UiO/7sq+e5Sg262oFCWuumBKR+XTQLCjB
         fQiQ==
X-Gm-Message-State: APjAAAWlmU+4SdeENHyZR1E8H7OeCU6u7lee/cU3I06L3o+zphCgrmSo
        Dueyac5v0FNkgB2NgSdBVwHPq/+CZm8=
X-Google-Smtp-Source: APXvYqwcoB4Ky8kF2Dkr6DmmT3lpgIWscDqSSRfTpsmolukj/DFBnWE3VjYEeGe1NHexI2kCdvgjsw==
X-Received: by 2002:a17:902:ff08:: with SMTP id f8mr6340368plj.309.1570058183692;
        Wed, 02 Oct 2019 16:16:23 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id l7sm288791pjy.12.2019.10.02.16.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 16:16:22 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>, Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC][PATCH 1/3] dt-bindings: usb: generic: Add role-switch-default-host binding
Date:   Wed,  2 Oct 2019 23:16:15 +0000
Message-Id: <20191002231617.3670-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002231617.3670-1-john.stultz@linaro.org>
References: <20191002231617.3670-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding to configure the default role the controller
assumes is host mode when the usb role is USB_ROLE_NONE.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Yu Chen <chenyu56@huawei.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jun Li <lijun.kernel@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 Documentation/devicetree/bindings/usb/generic.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
index cf5a1ad456e6..013782fde293 100644
--- a/Documentation/devicetree/bindings/usb/generic.txt
+++ b/Documentation/devicetree/bindings/usb/generic.txt
@@ -34,6 +34,11 @@ Optional properties:
 			the USB data role (USB host or USB device) for a given
 			USB connector, such as Type-C, Type-B(micro).
 			see connector/usb-connector.txt.
+ - role-switch-default-host: boolean, indicating if usb-role-switch is enabled
+			the device default operation mode of controller while
+			usb role is USB_ROLE_NONE is host mode. If this is not
+			set or false, it will be assumed the default is device
+			mode.
 
 This is an attribute to a USB controller such as:
 
-- 
2.17.1


Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A24C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD79D222C4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0PrWbfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfLLBnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:43:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35500 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfLLBmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:42:39 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so287170pgk.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 17:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X9Kc7R9+KeUY27tDEV+sMDYPQg0vMU8CdEEpsw9B7eY=;
        b=V0PrWbfKF6yh5jnUesdINqEzgHzMsX3X/h8mQRQt7abSsm8BD1zIM3mTyuJAm4y3kP
         fjCqZ+MT657YUqC5fFq+USYJQkg/nwLbiZzbLc1ZZ/+AH1ZY2o/P7I/ogmVWFT2eoKVD
         VvmvB8Nw8+/gE6DnMtNB+4sghteYtNdFYbeM6Q+B1VJiUIlyNXEbJbs1yHD/dUMged95
         pH+vBbrBuz/G5kKvVuB1H/0Z3wWaXELPX8OJC9XBveAInCMPrFPLT1Ygauyjsf5HBtMl
         4jvvIt4F9HQcgkLnmCLBWh5/bnO15j/5DUAR1SOnmrY3lzfgR/SF7SyOLeNBzoM7XasI
         kbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X9Kc7R9+KeUY27tDEV+sMDYPQg0vMU8CdEEpsw9B7eY=;
        b=rUppLhwn38nG60Sio70A1tjo41yUSyRItqYkCZclAYu3gaFZMjs+wn8b096wXuCpLE
         u4mlz4j+nKOza3L6mKmZyrPKr03Mo9BvaHIlEc8ltAbAenPZ7Oj2bKxgb2MpBeod3qFv
         0KI6cesJWKoK7w4I+HmImxi64WXmNpqdPEr1uUJF8gNEdeRITgzTEv7l3gr1ViHX/24N
         48j0s76dIIkyyRK3Fk1hsas5MNJqQBW9GSfexdCZe5qLY9XUCJRNpUEqc8qSk43wwv67
         ZUH23HfOw7RVbZAEadnYwbMgVXrBblTGbO1lPoxeldxOfHJm0GNUeuzWgPElXLETe6Pt
         K/LA==
X-Gm-Message-State: APjAAAX/UzfhBFlejrgZciANVKoWg85QXPoDSbNBVJbkxdlYm+53Jqxr
        GOXaxmPq8pWW46xCV0lkoYl8SSzZTjk=
X-Google-Smtp-Source: APXvYqy0BVmYHRBfzJOVdXEzf35ykOhMUK6HJkBTVjdR49V2P5zoAJ4NwvOkopcghcK3+EabZw/nPQ==
X-Received: by 2002:a62:f842:: with SMTP id c2mr7196663pfm.104.1576114958243;
        Wed, 11 Dec 2019 17:42:38 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id p16sm4217996pgi.50.2019.12.11.17.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 17:42:37 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>, Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Guillaume Gardet <Guillaume.Gardet@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 2/8] dt-bindings: usb: generic: Add role-switch-default-mode binding
Date:   Thu, 12 Dec 2019 01:42:27 +0000
Message-Id: <20191212014233.32799-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212014233.32799-1-john.stultz@linaro.org>
References: <20191212014233.32799-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding to configure the default role the controller
assumes is host mode when the usb role is USB_ROLE_NONE.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
CC: ShuFan Lee <shufan_lee@richtek.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Yu Chen <chenyu56@huawei.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jun Li <lijun.kernel@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Guillaume Gardet <Guillaume.Gardet@arm.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v5: Switch to string rather then a bool
---
 Documentation/devicetree/bindings/usb/generic.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
index cf5a1ad456e6..dd733fa81fad 100644
--- a/Documentation/devicetree/bindings/usb/generic.txt
+++ b/Documentation/devicetree/bindings/usb/generic.txt
@@ -34,6 +34,12 @@ Optional properties:
 			the USB data role (USB host or USB device) for a given
 			USB connector, such as Type-C, Type-B(micro).
 			see connector/usb-connector.txt.
+ - role-switch-default-mode: indicating if usb-role-switch is enabled, the
+			device default operation mode of controller while usb
+			role is USB_ROLE_NONE. Valid arguments are "host" and
+			"peripheral". Defaults to "peripheral" if not
+			specified.
+
 
 This is an attribute to a USB controller such as:
 
-- 
2.17.1


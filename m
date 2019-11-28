Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ED4C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 05:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B857C206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 05:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BDxr5QZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfK1FKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 00:10:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43455 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfK1FKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 00:10:07 -0500
Received: by mail-pg1-f196.google.com with SMTP id b1so12273878pgq.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 21:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bijPVAEzb+PpbucEzBhezT3J7OXGruht9k9XHqbXPdY=;
        b=BDxr5QZdUNok23k8lyxS3y1ZlKHNNc4ELZ+mU2Dn/bzWGvj8AhvFqwxsu93p12BDGR
         4IVjdr4gFJQGP1v3zum4XslwjezFAshgm31mNb+w17TCL8R3mrfq/tY8L6AngoTqu+MC
         ZbBqb7ADtZQpf7DCp+khMqANrkf+mHWNuHe2TGyUKk6rblxP8qyIUQj9Ns4e+Oq7L7EN
         J3UDzm5ai43a5A0OBKuPqN3Vr8/gk0UtvyJAjNXweZSwjwaxEqIYZt5Bwln4pSm17O2j
         XXlTKYnsDaoDxjxVS13JBlKb/pMJS6yFyYu/8nvmPlAYzhPyPdr6Vhtej/pYUtOcbUM8
         p37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bijPVAEzb+PpbucEzBhezT3J7OXGruht9k9XHqbXPdY=;
        b=YnI1GPSCnPWqRpXWchs6E9ioEZYQc85m33hT32KhBOskwcDzGSaAXRuauXw8JNJjCQ
         opJb6CDm45k4mVVrMJ2eZh7WJdRbvdR0EjqDnD7YMFkns1n8bJ53AMhe5E8g2/iD9MY/
         wgPJ6EKAT3eX5vF0zgNRVUbWNOirQ3WtymwGwrPQverL1DzVPIWT2IiEPRn0D9VjH/OI
         zRZ+tCpEtmSfG5zNQb1sD5S8cT9DuFsP7xf9r8R/A0byFl45qodikP2JvfSSE+RBwo4z
         mPyu2o0P8ypjYTQStP2Xg8x3qAFNyNkprpzwnQX0u9v6spTbpHa1QZC1gJXdB7K1jPsP
         afWQ==
X-Gm-Message-State: APjAAAUggbgzsH48Pdd3Hc9ECWw9yK227O1VFzOJrgMczKFET2sZZDLT
        ttDwuryO4dyLqyWHIAdsqPpT6KELutY=
X-Google-Smtp-Source: APXvYqyHageaOcP7ZOVXe/q37hqFPzxHmvwOcCaNRfIR6tgS60hDSdNJ+Eg+GXENKnFhjHUG5+LJBQ==
X-Received: by 2002:a63:f207:: with SMTP id v7mr9384553pgh.246.1574917806305;
        Wed, 27 Nov 2019 21:10:06 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j20sm17799838pff.182.2019.11.27.21.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 21:10:05 -0800 (PST)
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
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 2/8] dt-bindings: usb: generic: Add role-switch-default-mode binding
Date:   Thu, 28 Nov 2019 05:09:55 +0000
Message-Id: <20191128051001.18995-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128051001.18995-1-john.stultz@linaro.org>
References: <20191128051001.18995-1-john.stultz@linaro.org>
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
Cc: Jack Pham <jackp@codeaurora.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Change-Id: I6ac1d9c56039d76d924148e29a5e4b0bb304ed0f
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


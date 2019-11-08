Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50294C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 01:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF9A214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 01:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKxk19Vd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfKHBR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 20:17:28 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33041 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbfKHBR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 20:17:28 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay6so2896150plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 17:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kZcD6GKA7XbCzd3zg1eCgX8HZHAD6+MLe8xQYM7PmDE=;
        b=jKxk19VdnovnbeBuwPQoZftMD3I3oHzDoPitrIzZx8fcjOoT8jMhScOyC5c0iVp7cT
         WD+e9SPcrFuUxCDI1jIGQGJbkOLpxhvr2J+MI4rW/Qyx9JWb3tfJW9iifr/XHEqwUIlG
         P5FpxncR5UUH9ZbW274W8pwlZ45Y46ua8nM7jrHal0jfGsmTsU8mYnpFzTtyrzlVSKgb
         GrEci+r/HGDFmdHP0zvlNfHFCMRYxShpCqTg03pQoWRiOqDNYzlDLpgUHZkXnm5651Zu
         Qcp4kM1EWv2uZm2I13rKP0dfth8Rx4/TiIYyZXieqU6Ow3N1Uo2OqKQz2TokvTR2hMfN
         ixgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kZcD6GKA7XbCzd3zg1eCgX8HZHAD6+MLe8xQYM7PmDE=;
        b=iIY06onnlrCWWxESbSrLxSlkJyGkGfiZ6eRolgf5Rzbky6dM5qc8DBiGBdvakd1mq0
         HsGd3uCjwsB9DecFI7JjIZNenKqQjOJWFxw8rLP+kH2qqIH+z2gX98zPm4zhRKYxyFhH
         b/Vw81mo3okjg0iXqmi6p+w6usAu39/5kOKBPMb29tnV9U2g6c3G9WUNOoxG9nRZavxr
         1zPwZ8yh8s4TJ8OFHRniYKnM5HxOYAifHOr6kvVuhxvyYtjqXkhkAkugz0r+l0v4Qh/j
         mRXSigbdv6FBGb+ixRJ4NMCsoY2SXTH4YhaeAmxazkooYAM0Qnw2jAJfMdH0KH/xFFaO
         awVw==
X-Gm-Message-State: APjAAAXcS3ZrCgxswEpEsn4ioZxoTdCXhHosReibiOsNUWUgZd7aN8mc
        k23VAS70SLRVIAzwkom/3E2Bos/Ll4g=
X-Google-Smtp-Source: APXvYqyB6Q21widSmq8YSXUuNBlkXc+2TtWS9jvD0cuWjYjPPfDOAWNebW12rxcoc0nCFsHsptmgXA==
X-Received: by 2002:a17:90a:268c:: with SMTP id m12mr9306601pje.69.1573175847075;
        Thu, 07 Nov 2019 17:17:27 -0800 (PST)
Received: from localhost.localdomain (c-67-170-172-113.hsd1.or.comcast.net. [67.170.172.113])
        by smtp.gmail.com with ESMTPSA id s23sm3801627pgh.21.2019.11.07.17.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 17:17:26 -0800 (PST)
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
Subject: [PATCH v5 0/3] dwc3 prereqs for HiKey960 USB support
Date:   Fri,  8 Nov 2019 01:17:20 +0000
Message-Id: <20191108011723.32390-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just another round here trying to push forward a patch series
submitted previously by Yu Chen to get HiKey960 dev-board's USB
functionality working.

This set is even more narrowly focused on just the role-switch
support and adding the role-switch-default-mode option (as the
core extension/glue bindings bits are still in discussion).

While Felipe had quite a bit of feedback on the last round, and
I'm not completely sure how to address all of it yet, I wanted
to send out this set which tries to address *some* of his
concerns, so I could get further feedback and make sure I'm on
the right track.

The current version of the full patchset to enable USB on
HiKey960 can be found here:
  https://git.linaro.org/people/john.stultz/android-dev.git/log/?id=d40d8c803c5a79b70e2a6b363fe03442480df7d9

I'd greatly appreciate any feedback or thoughts!

thanks
-john

New in v5:
* Just sending out role-switch and role-swith-default-mode
  changes
* Reworked role-switch code to not select CONFIG_USB_ROLE_SWITCH
  and to ifdef out the dependent code if its not enabled, as
  suggested by Felipe
* Changed to a string based role-switch-default-mode binding
  as suggested by Felipe


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

John Stultz (2):
  dt-bindings: usb: generic: Add role-switch-default-mode binding
  usb: dwc3: Add support for role-switch-default-mode binding

Yu Chen (1):
  usb: dwc3: Registering a role switch in the DRD code.

 .../devicetree/bindings/usb/generic.txt       |  6 ++
 drivers/usb/dwc3/core.h                       |  6 ++
 drivers/usb/dwc3/drd.c                        | 96 ++++++++++++++++++-
 3 files changed, 107 insertions(+), 1 deletion(-)

-- 
2.17.1


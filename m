Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782BFC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C07E222BE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XuU6hHtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfJBXQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 19:16:23 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40492 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbfJBXQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 19:16:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id d22so561339pll.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 16:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ze/XvAAk8GBZMksPYjyDCpmqV8AGCwQH61JmBZ7VYXE=;
        b=XuU6hHtCbzgnLgj5xFdd29USBSRIe9zpmWPOLYUJB/YMxHldDaP1t3RdXqKU7+9qST
         CHAm4YD7iyFga95zzDWl2BjqU7MUMTB3jy4xz1GdTiRkdD5XgK9GOF16bc+n1vXBwFTs
         cMRj5LW+ej1CyJRz6V9q57XBmn+T6zAnJz5PabxfyCmUJVXoe9vngSvvZmpQ/kbUIbMa
         +htweaej41pOqioUGALldV5jmpQexr9STl2LcRl08StyUthb17t34BXsB6Y8avXbOWPG
         50XyAz92YjpfMHOFwtvoST77qm5oxCyFltxTEA2eGtbBN1yVvp8nGP7eMXXN+zGAZAp8
         6SEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ze/XvAAk8GBZMksPYjyDCpmqV8AGCwQH61JmBZ7VYXE=;
        b=U1ITPeJ+qr3PfZ9qhM6+mVkeUlD5s0KcOi9ohSBlcvqpAxWjyJ9vECCJLlwD+JgfEc
         fcI/Oe8RFL79bwTMJ8RBsMQEqcyZDTEKqjBvZ02GUkemsfJaM9iwvGx8o8f/C9bbVZZm
         K7LIHWJOO9ddPSzIFQe0d2o85RFMzOl0MpsiBfZDZPGkXTFamFTTrmjT+1iwFE9oXI/E
         Gfb+m1UUBFFeBT/QObnfuK3DaQo2P1W0d5ZgHU9HSKEzpLqBn12Y0g37l0pAW5vtfyiQ
         RE4f9KHA3FFz6hBP+uAcaF+FcvRpFGtHa/aHda/fHrbMhZvdSGJubc+OvcqBax/+wMhj
         SToQ==
X-Gm-Message-State: APjAAAVzkGKIxqCnxc3MzqhLLp/vfEjKj2IdG4mCz+wGpF9NHQrxfwE1
        fJpsnRpGAitXGYZMZg362D/7TT2ccKY=
X-Google-Smtp-Source: APXvYqwKK+QsXsOrigPf5Vzcddlm1GWn4ouIdnrb8vXeJ7P0jW3FJ31myUBhJrIC1NEdFL3iiaRbbg==
X-Received: by 2002:a17:902:a40a:: with SMTP id p10mr6399376plq.149.1570058181824;
        Wed, 02 Oct 2019 16:16:21 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id l7sm288791pjy.12.2019.10.02.16.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 16:16:21 -0700 (PDT)
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
Subject: [RFC][PATCH 0/3] dwc3 role-switch handling for HiKey960
Date:   Wed,  2 Oct 2019 23:16:14 +0000
Message-Id: <20191002231617.3670-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm just trying to pick up parts of a patch previously by
Yu Chen to get HiKey960 dev-board's USB functionality working. 

The current full patchset can be found here:
 https://git.linaro.org/people/john.stultz/android-dev.git/log/?id=12289c95c89e0e3173f8da1ebd3a29e52fd50a44

I don't have any real knowledge of the hardware other then the
code, and what I can intuit from testing, but I tried to
document the previously undocumented bindings as best I could
and fixed up a few minor checkpatch issues.

I'd greatly appreciate feedback or thoughts!

thanks
-john

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

John Stultz (1):
  dt-bindings: usb: generic: Add role-switch-default-host binding

Yu Chen (2):
  usb: roles: Add usb role switch notifier.
  usb: dwc3: Registering a role switch in the DRD code.

 .../devicetree/bindings/usb/generic.txt       |  5 ++
 drivers/usb/dwc3/Kconfig                      |  1 +
 drivers/usb/dwc3/core.h                       |  6 ++
 drivers/usb/dwc3/drd.c                        | 78 ++++++++++++++++++-
 drivers/usb/roles/class.c                     | 35 ++++++++-
 include/linux/usb/role.h                      | 16 ++++
 6 files changed, 139 insertions(+), 2 deletions(-)

-- 
2.17.1


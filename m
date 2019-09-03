Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FDAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1A422D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f5zi/b69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbfICO7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:59:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38759 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbfICO7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:59:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id o184so18631892wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CqMvdMuRx1qQHVU6PsmLAtqbm2AbeFoogKgqN4O+tSA=;
        b=f5zi/b698/9ce0EI/0V5aE6hF/KZbZrznmm772xUFPscWQ5AbEAsN04/9GLV4caC6C
         OU3jz7W+RqTX4V2EjDf//x+SAmuaXx/xoqARkHje20dPb6HeUlkBmuKNug4qdILB+w2w
         fKu7QYfe1O7EGsARq8M2/eZzbkcECKULQOllc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CqMvdMuRx1qQHVU6PsmLAtqbm2AbeFoogKgqN4O+tSA=;
        b=AL2a/MjNnVNLe5nD1zEfeKGkGB6kc0U/n/fqC1po82Ih0yjNe1X74GMhL1Qz1KFYNz
         UQRomenzfSxaosRMq+Mr9nSMiwl9HFRNswNZ8it2g2hhSBID1/n0yqWChFzutiQJ75oE
         thjs11IZpUGNnYGNiDl0sTBl8+ZKne8RoTnkuketi1GTWDTTIlYqb1c5ynipixIX7sXi
         VOPvm1TF/kE1OX+ZesDJmFREd6I2Kt6p/5c4uBof+fjfEkMcS6veTK//wHeIGAe6OlHz
         k5PlFO6sN9n0wkm7TBh6hwwKa7hY/VRG5fl1v1UFvrhm2crbW+qBizmgKQD1kB4l5XJj
         xjbg==
X-Gm-Message-State: APjAAAWS/NyR24w8lgEeqiQecQh1iYRZjmW50Nh7W9Ns99je32fEa2I3
        6sghrqYappRrGPVU5FBuEhl85K4OP9YDZhBARKmK0A==
X-Google-Smtp-Source: APXvYqyMDrC72Rn8SGS9zV3V1JTPQD8z+XJgk2vmjSjqKrUk9al9ywXNHTlnAeCv+NEEzalejtMsFou6QtPU8/C8cNY=
X-Received: by 2002:a1c:eb0c:: with SMTP id j12mr565277wmh.132.1567522786724;
 Tue, 03 Sep 2019 07:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <1564568395-9980-1-git-send-email-srinath.mannam@broadcom.com>
In-Reply-To: <1564568395-9980-1-git-send-email-srinath.mannam@broadcom.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Tue, 3 Sep 2019 20:29:35 +0530
Message-ID: <CABe79T7=Kat6DjUDmOvfA79Ex0tzuU7ov4aoZodbeB=UO8DOZg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Reset xHCI port PHY on disconnect
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

Could you please help to review this patch series?

Regards,
Srinath.

On Wed, Jul 31, 2019 at 3:50 PM Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
>
> This patch set adds a quirk in xHCI driver to reset PHY of xHCI port on
> its disconnect event.
>
> This patch set is based on Linux-5.2-rc4.
>
> Changes from v1:
>   - Addressed Mathias's comments
>     - Modified mapping of HC ports and their corresponding PHYs
>   - Addressed Rob's comments
>     - Removed usb-phy-port-reset DT property.
>     - Added quirk in platform data using HCI compatible string.
>   - Add phy ports in phy attr structure to have enabled ports bitmask.
>   - Modified #phy-cells of sr-phy to pass phy ports bitmask.
>
> Srinath Mannam (4):
>   phy: Add phy ports in attrs
>   dt-bindings: phy: Modify Stingray USB PHY #phy-cells
>   phy: sr-usb: Set phy ports
>   dt-bindings: usb-xhci: Add platform specific compatible for Stingray
>     xHCI
>   drivers: xhci: Add quirk to reset xHCI port PHY
>
>  .../devicetree/bindings/phy/brcm,stingray-usb-phy.txt | 14 ++++++++------
>  Documentation/devicetree/bindings/usb/usb-xhci.txt    |  1 +
>  drivers/phy/broadcom/phy-bcm-sr-usb.c                 |  9 ++++++++-
>  drivers/usb/core/hcd.c                                |  6 ++++++
>  drivers/usb/core/phy.c                                | 19 +++++++++++++++++++
>  drivers/usb/core/phy.h                                |  1 +
>  drivers/usb/host/xhci-plat.c                          | 10 ++++++++++
>  drivers/usb/host/xhci-plat.h                          |  1 +
>  drivers/usb/host/xhci-ring.c                          |  9 ++++++---
>  drivers/usb/host/xhci.h                               |  1 +
>  include/linux/phy/phy.h                               | 10 ++++++++++
>  include/linux/usb/hcd.h                               |  1 +
>  12 files changed, 72 insertions(+), 10 deletions(-)
>
> --
> 2.7.4
>

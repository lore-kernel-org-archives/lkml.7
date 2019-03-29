Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DD1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121D621773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DK5NTXZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfC2RD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:03:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38129 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbfC2RD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:03:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so3623779wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 10:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4h7VtKuChw0e0QSGqGDCThC9qDFXbr94ocjisp/vP48=;
        b=DK5NTXZpVNhSYwXY6uVXLvL2a9EGSCpHjj2zbXUZ62yDuMlBg9mflXQZg0kAG2MrZs
         9nmAmxFEmymZEgawOa5rWnJuOllBVJuuWZ7l9zLN2LV+2jx+/HABsGInQ3bAxHZcJZzh
         t4zMoNXo+xKuLihVE+WQSdDOP0jqcgNvrSsFu/lIE1ZuV2UNFtp76AWFqoTIlsRXmoyO
         GKkZ+PkS40YHjaG/9+BFvy31XwL7kY92eaY3xkBAPDgFciM6lmMz84fPCItFoHEc89J7
         PYLHijgNub+HRTAKqz94pLzJM27mDR9DJdN7h2PFTuwomANJrn/96QgUD0XHIgfXE3AP
         wBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4h7VtKuChw0e0QSGqGDCThC9qDFXbr94ocjisp/vP48=;
        b=oNX+8OLu/UJD5Y6rvpOINg1oTnjd5bvIRKmAOQkyRmeVlcG8hLsfXKXOMsf4heJIoM
         tgYmxKP+Gejb6cMDDdaECf+dC8UoRChmIKDindBY8cUVvGzGxIyG3S5OMsCQnnNZyp5z
         cZ/JoAuUMF+SMOpgoe88zEAc+qfGUM+lvP2b8MVn7hTMIFh11c8Bbm9PVlfUJBFZU8Z+
         nX+V+Dhi5k5lM1tHY2Z41KEquCJi6ZhIFMzrza7JmMldnFeoTViWSsGwP8Pn6ruclU1K
         Fcp7RUwGnDo3aLG58uacdQda48x3gjMby/RN6p2y8eiZVlQDltF+wLZikNzJAU/50ADi
         brZA==
X-Gm-Message-State: APjAAAVwtyr0vOjBkZdsgqjcdsm3Pu9q3DfqGJ2sCK/QSKQZ9Fnbw6yc
        Kv16agCIODHAMkGPNxZN9f4rpiPz2txXH1rh3M7L
X-Google-Smtp-Source: APXvYqwhptPso1F/rhg8GsB+eunOKCtPDDa2WtV6+AwxGkIBfBS16VSbxziC16Ge8bCY0GmXhyWmWl6TtpmMz9YuZKM=
X-Received: by 2002:a7b:c3d7:: with SMTP id t23mr4151441wmj.62.1553879004012;
 Fri, 29 Mar 2019 10:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190325194220.5873-1-helgaas@kernel.org> <4faf234df19c1b54b70cbe82c0dacacc58568b87.camel@perches.com>
In-Reply-To: <4faf234df19c1b54b70cbe82c0dacacc58568b87.camel@perches.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 29 Mar 2019 12:03:11 -0500
Message-ID: <CAErSpo7bGn8JP9n6UaPUdTJ1ZFonnZX+C+bCFgfN4HH2Hu6OpA@mail.gmail.com>
Subject: Re: [PATCH] vfio: Use dev_printk() when possible
To:     Joe Perches <joe@perches.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 3:49 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2019-03-25 at 14:42 -0500, Bjorn Helgaas wrote:
> > Use dev_printk() when possible to make messages consistent with other
> > device-related messages.
>
> trivial note:
>
> > diff --git a/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c b/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
> []
> > @@ -89,7 +89,8 @@ static int vfio_platform_amdxgbe_reset(struct vfio_platform_device *vdev)
> >       } while ((pcs_value & MDIO_CTRL1_RESET) && --count);
> >
> >       if (pcs_value & MDIO_CTRL1_RESET)
> > -             pr_warn("%s XGBE PHY reset timeout\n", __func__);
> > +             dev_warn(&vdev->device, "%s XGBE PHY reset timeout\n",
> > +                      __func__);
>
> Many of these could use a colon after the %s used with __func__
> to make the output more consistent with other modules.

Thanks, Joe.  I added a colon to the two in
vfio_platform_amdxgbe_reset().  Those were the only ones I saw, except
for a couple "%s failed" messages in
drivers/vfio/vfio_iommu_spapr_tce.c, which I didn't change because (1)
they can't use dev_err() so slightly out of scope for this patch, and
(2) it arguably reads more naturally without the colon.

In vfio_pci.c, I converted some pr_info() to dev_info() without adding
a dev_fmt definition, so that removed the KBUILD_MODNAME prefix, which
I didn't intend.  I'll add "#define dev_fmt pr_fmt" to restore the
prefix.

Messages from drivers/vfio use a variety of prefixes (none, "VFIO: ",
KBUILD_MODNAME, __func__).  That could potentially be rationalized but
I would want Alex's guidance first.

Bjorn

Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB39C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB97520811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CjJnIqVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfC1UkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:40:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52889 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfC1UkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:40:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id a184so232790wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 13:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=imkfeqEcWIzu+E8VFBHue+K4STWxZWqfwAo8zkxA/bE=;
        b=CjJnIqVgfP2Wk0EuZ9JY/vYzkI/UYHEq0Rwq3d4TuwgeTjKlgMoniVfAQOChP/TW1+
         hWK9FlyaNjv4Ak+MgjeQKnWfmK1HuMwSuI5JCkKSZxH6AZjPzRxvV5WeMYw1TmbJX4oJ
         qsfmuz+/DKAawzI6CQssXc+5wcM5rM0bk0vvvQGgeWqkz8Ku8xBX7oZo/N+cL5kbsLXe
         4Rt4ZVP5a/ujrwsdS5ypxLstiBaRONMv7PdTgj5Co5fZT+Evf+8LeKNj09KnusvXdlNA
         uEo4YmRLvnFAPQZQlyZexJaLe92wilSgCAGSL5WoO1+6oCvVx8Y3pxijh+paoaMbzWws
         49QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=imkfeqEcWIzu+E8VFBHue+K4STWxZWqfwAo8zkxA/bE=;
        b=opfXTTHDooZ22JpWr/6XNM9iyo+sdwR+ZXLeprMdBoXAohBkDTnrixyx8kH7rkrXGY
         tdPgD8qEEuOjNYva8SXajFy+ZfRZszU2+QZV3EcIVI1URdMSXlgwV13HK9l6TPf8MBV7
         CADKbhCcdsVkZ3PqqFF0VI+zUOS2YzhiVADXTDn2jDayEPr6dWVbnVKwKjsE2EWb3x8g
         ztfelV5qIfvLZ2QP7j+q1mUb17Jv4LgT+nXceS415iXxd338khUJ4Ebx3sXLeTg8XnEI
         YXLh7NHQQytELVUjV7oOjOiCNvmXYuXQ7n5/18PMyQoq71uFlMJIDX2ZOmZvVB1WA3+b
         1bFQ==
X-Gm-Message-State: APjAAAULJAvig+RMCyrtGA6YtL0sGPuhMa7WzrX/RZv1lojKDQCgx3Zy
        TkNoZocGV4PPu+B/bDh3TE5k4VyCpbIXcKxxKObt
X-Google-Smtp-Source: APXvYqyWatYP6mFcBYOBefCSI2iYkGQBjOQCrnqkf4qZH1Ko/DfHUXaCsj0LAob7EgfohuX1joCdZYneVTj2Hjwx7yk=
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr1217913wmc.76.1553805617929;
 Thu, 28 Mar 2019 13:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190325194220.5873-1-helgaas@kernel.org> <9f4e9d19-8d82-bff0-a627-f82757d1da59@redhat.com>
In-Reply-To: <9f4e9d19-8d82-bff0-a627-f82757d1da59@redhat.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 28 Mar 2019 15:40:05 -0500
Message-ID: <CAErSpo4dzRbVVN40x-1PFmCDMAB81=75r+kAuoDgDGXZHtQRQw@mail.gmail.com>
Subject: Re: [PATCH] vfio: Use dev_printk() when possible
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 5:00 PM Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Bjorn,
> On 3/25/19 8:42 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>

> > --- a/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
> > +++ b/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
> > @@ -89,7 +89,8 @@ static int vfio_platform_amdxgbe_reset(struct vfio_platform_device *vdev)
> >       } while ((pcs_value & MDIO_CTRL1_RESET) && --count);
> >
> >       if (pcs_value & MDIO_CTRL1_RESET)
> > -             pr_warn("%s XGBE PHY reset timeout\n", __func__);
> > +             dev_warn(&vdev->device, "%s XGBE PHY reset timeout\n",
> vdev->device

Indeed, thank you!

> > @@ -63,7 +63,7 @@ static int vfio_platform_acpi_probe(struct vfio_platform_device *vdev,
> >
> >       adev = ACPI_COMPANION(dev);
> >       if (!adev) {
> > -             pr_err("VFIO: ACPI companion device not found for %s\n",
> > +             dev_err(dev, "VFIO: ACPI companion device not found for %s\n",
> >                       vdev->name);
> nit: for VFIO platform devices vdev->name and dev_name(dev) are the
> same. But for amba devices they are different I think so it looks
> sensible to keep both names at the moment.

OK, I'll keep this hunk as-is.

Bjorn

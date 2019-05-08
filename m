Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955E6C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD11214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVTDq0Vg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfEHP4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:56:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44991 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfEHP4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:56:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id z16so10297508pgv.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 08:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iBHtYpRsc712Jhf8r1jzS0KUOogBgaASzE45fG6Wcrk=;
        b=oVTDq0VgZYvgpI1y9y4+DccGKoeBrl6DvatY0dzm2NiYUXphf/oYmeygPHZCSY2QvA
         pmz0UOwGi93pZPyP7X4Gy2XPKYYVjHQVuG37fccJvZbAdlGUzB9c75qKridESGgLPD4M
         lse3wmXa1uCUzlwmoichBtUOV9S86GKIE0562diLN8zZlzmZA2Z7/d9zqCVsmqrq7yxm
         v4LFcVsRg1TgtMoXaM2aem82JBVmNWyeu5PXsWjILO1lbGo/WIFjjSj/pTIcSBb0JFhQ
         3e/xomKGMP+8lUxxl/1eIR/OXH8kqXqg35zZcR9uE+KKG+Gf22knKmo7VnWYP9hKNvnQ
         F3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iBHtYpRsc712Jhf8r1jzS0KUOogBgaASzE45fG6Wcrk=;
        b=BUHDmzkBB2snzX55fu54miHmn5i3NUkkvig3Ove6AXJa1/97SwpO5IKCtFKr12p+Fb
         p0ZzjA775XSzqT2CzLCUYsgoumb9UGtd9fORiK5vjodLOVmzrFDFBOP5b4RNglnXIHYS
         G49zO+1u7uTc4s+1Q7eQF4BDcNCbtBkInaVuPFl/SE26aisLrWE6plPwFgjbB9cCZt8D
         2YcV1Mfy1vyyhRpl1HQia1zYht0uoodUxudcHsbHxCv+iICl1RixP9nzDqOHObjy8qXO
         u/u8cvkwIi7BK0Hchh5LAzI7+QKeNqxfszvufPE8QcgOdWi7MB7ZPj9P8Ow1RF3JSbiO
         zghQ==
X-Gm-Message-State: APjAAAXnkUgi6/Q/Tlx7nZSn9fqj/N5xPDuS5pCRI8NmZRTtxtzzHcwT
        QclaDvQSnlNxnY1givt2B8isotTNw8ZoLWmfoyUk6lWS
X-Google-Smtp-Source: APXvYqyqfPaJ8sWq2tO5xRtoUCLKX/06gKK05XCIY4tOxB0M86pv/YGaMfPEDT0DgIx+zQ+kSmjz8JdAoJq8HUjzSWc=
X-Received: by 2002:a65:480c:: with SMTP id h12mr46853626pgs.266.1557330995251;
 Wed, 08 May 2019 08:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
 <1557248314-4238-7-git-send-email-akinobu.mita@gmail.com> <a4ec2c1a-1ff7-52fe-07bd-179613411536@intel.com>
 <20190507212241.GA7113@localhost.localdomain>
In-Reply-To: <20190507212241.GA7113@localhost.localdomain>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Thu, 9 May 2019 00:56:24 +0900
Message-ID: <CAC5umyhkeqD6ndh0OXauibZfz+BTd_EU9X81uebttp9gmxEYhg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] nvme-pci: add device coredump support
To:     Keith Busch <kbusch@kernel.org>
Cc:     "Heitke, Kenneth" <kenneth.heitke@intel.com>,
        linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=E5=B9=B45=E6=9C=888=E6=97=A5(=E6=B0=B4) 6:28 Keith Busch <kbusch@kerne=
l.org>:
>
> On Tue, May 07, 2019 at 02:31:41PM -0600, Heitke, Kenneth wrote:
> > On 5/7/2019 10:58 AM, Akinobu Mita wrote:
> > > +
> > > +static int nvme_get_telemetry_log_blocks(struct nvme_ctrl *ctrl, voi=
d *buf,
> > > +                                    size_t bytes, loff_t offset)
> > > +{
> > > +   const size_t chunk_size =3D ctrl->max_hw_sectors * ctrl->page_siz=
e;
> >
> > Just curious if chunk_size is correct since page size and block size ca=
n
> > be different.
>
> They're always different. ctrl->page_size is hard-coded to 4k, while
> sectors are always 512b.

Oops.  I misunderstood how ctrl->max_hw_sectors is initialized from MDTS.
Also overflow check was required here for the architectures that use
"unsigned int" size_t.

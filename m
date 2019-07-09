Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D599C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F341321537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbdDK6vQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfGIGJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:09:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35351 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfGIGJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:09:08 -0400
Received: by mail-lj1-f196.google.com with SMTP id x25so11579300ljh.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 23:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aO4HsjFSXTmCyv7N8t49daOR6Or7RO788/EOiK8lz64=;
        b=UbdDK6vQ2kC6sVmZpD7PU531pyGPupgTWwYb73MMIhH5aTIVDt3D1CBjUmAjigkft3
         +HvfCQIzLHJNPkTxesTMRvGuj9yR9DMBJfwgnVfhi4KSOtHzYxqOVEQW0kjSVm0YdfRV
         nWbnehOZ9bsjTtPwN1U8qZxXrdxOa8sDiRaq8u4Iy4wtvXRvIvEnucetfrICi1e9DzLO
         EmRj0248n15phzyvL9kPFVghxYoPf/znxIy7ATAIX2M9RwpZ0mlPTECKMAfCbnaz8syw
         NjLa9IuLxTAPFlqtF+Y/1HxgchCfi1KH6f3GEADrpbawBBTg8rI55roW5VvQ5tlsSmNI
         Cs8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aO4HsjFSXTmCyv7N8t49daOR6Or7RO788/EOiK8lz64=;
        b=L9zXC2s4LDVhH6HhZ4NahvbjITuphHYbk/nbG5sPJ+iRLd2EVHDmTu4nD3mwqvdKnO
         R0cxJJI+KGNgW4cmukr1D+F5YKyUNgdZDbyLRVLqZS1cWbdkmYqAe7wPrTuVyB+hwmgV
         6vl89jldRORwbOjp4y8rSM+DhHWZnZtC40m+B0xa3dgzXCnUCH938/tz6YzNDqnCNT/W
         QkchbxTK3OyDag0BXeN/tcRr6QXI8AYN13nVb4hZhOXrUJHhax5YyPycmx1acOWLCgF/
         r9kJ/DnCyH2oEPNudd4Xn+SKEjOFxXUo1ybn3iK46WHwvrfTw+TDNicpe28cCHEijec0
         wtvg==
X-Gm-Message-State: APjAAAUPIsLD5NYeATPNrVPnoBsr+KeHyqX0Ui2IpeCvNuyWdssb1PIJ
        w1+4jOcoIuF03zpKyZQWmMYJLtxH9i1sbMKi58Q=
X-Google-Smtp-Source: APXvYqw54brV8xQ4Cah6//8rXfeFeNgl0IpPxsUJxv+YIWbskJC9ifWxdjTb++TkFKWGw9GCvFmy/kMcdkKmphP2PCk=
X-Received: by 2002:a2e:781a:: with SMTP id t26mr9275235ljc.28.1562652546187;
 Mon, 08 Jul 2019 23:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190708123952.3341920-1-arnd@arndb.de> <CAFCwf12rQ8Rgr37qPOrN7k0Ru+_jJk-XnXEOGi4Vhp0S8iZB+Q@mail.gmail.com>
In-Reply-To: <CAFCwf12rQ8Rgr37qPOrN7k0Ru+_jJk-XnXEOGi4Vhp0S8iZB+Q@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 9 Jul 2019 09:08:39 +0300
Message-ID: <CAFCwf10-Q5g23A-SV+ccwyO=Yn11J9U04G7KvNC5jHAJj0mbNg@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: use %pad for printing a dma_addr_t
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tomer Tayar <ttayar@habana.ai>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 9:07 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> On Mon, Jul 8, 2019 at 3:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > dma_addr_t might be different sizes depending on the configuration,
> > so we cannot print it as %llx:
> >
> > drivers/misc/habanalabs/goya/goya.c: In function 'goya_sw_init':
> > drivers/misc/habanalabs/goya/goya.c:698:21: error: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'dma_addr_t' {aka 'unsigned int'} [-Werror=format=]
> >
> > Use the special %pad format string. This requires passing the
> > argument by reference.
> >
> > Fixes: 2a51558c8c7f ("habanalabs: remove DMA mask hack for Goya")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/misc/habanalabs/goya/goya.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> > index 75294ec65257..60e509f64051 100644
> > --- a/drivers/misc/habanalabs/goya/goya.c
> > +++ b/drivers/misc/habanalabs/goya/goya.c
> > @@ -695,8 +695,8 @@ static int goya_sw_init(struct hl_device *hdev)
> >                 goto free_dma_pool;
> >         }
> >
> > -       dev_dbg(hdev->dev, "cpu accessible memory at bus address 0x%llx\n",
> > -               hdev->cpu_accessible_dma_address);
> > +       dev_dbg(hdev->dev, "cpu accessible memory at bus address %pad\n",
> > +               &hdev->cpu_accessible_dma_address);
> >
> >         hdev->cpu_accessible_dma_pool = gen_pool_create(ilog2(32), -1);
> >         if (!hdev->cpu_accessible_dma_pool) {
> > --
> > 2.20.0
> >
>
> This patch is:
> Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
>
> Thanks! applied to -next
Sorry, meant -fixes of course.

Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141A3C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 00:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3B5222F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 00:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="OwqIclI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKSAEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 19:04:20 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33572 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfKSAET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 19:04:19 -0500
Received: by mail-oi1-f193.google.com with SMTP id m193so17185893oig.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 16:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZtbvKjjnscKy4A6MuNeD3a3NFthr68OtKoL8RB+WxNo=;
        b=OwqIclI3keeY7VHTJMp42XcFMnSTpvkqGJgi1VHbv9P05zsqk7I4qEew1vlPCtyxE6
         NtIAzveBsEu4kp70hWM+c+0r8DFE2JfAuqsFbN0yMpKcYrac8GPNaBuUxFR2EypImxtG
         TbR3Gp8qoV/FATMkEKzlAggAnAqeHJJgJMZccBlQX3YSC1H5g1ptRg934gVSvL4odkQm
         wN0l/Z3VtNzyskVviilqa+8hpfN1DGw5KiJZiWyXEP/sX3mSW9PujfWr8BAiH/OJoUMU
         BEXRq1HBY8xK18/ZQAcIxHS4HLunPih16a070i5KPwuvbR2SMnxCy8MdUDiXvgBRovMR
         2nUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZtbvKjjnscKy4A6MuNeD3a3NFthr68OtKoL8RB+WxNo=;
        b=NdUJkSZFqZyACpOVKWfriYrTw3r1uJxA5sDAFxQ98BQXoGnAujgY85VCCAHpHhaiJO
         msTPGOtCcP6xCDtdyA+2kDF9L1pzZbKPfYIUsPrvryIWs58ru51fuFA/sSOiPxMGnVxL
         UJf7lpnOlVahv/z0uO5W76mwl6Uzgrk6iLvGJz/tvnjUDdOqIyovOqy0zwUM5ddRMgvA
         RKltlTEThmxv9JheOnNzAlJsBRnw09A8GPWYvGmSUxjjVJxwyz7wgrxdvAqwwM164Nhs
         /KOi9jwh3dSLBMax5+yt4UzjG0S38yl/YQEYztDpwZuEaSPAvXyAUzUqPuXJ+8suz/3U
         w53w==
X-Gm-Message-State: APjAAAUn+rOYEse4jkMmpGezuE10dvSa9ufXuqjASJGiLAR8whbx8Ysn
        C5VL3ft1oXQMxIRVGeeY6Tg6LEGqyH9OKxnG+v8uaA==
X-Google-Smtp-Source: APXvYqyHTRHOCdWxsyyF+07+0YV81ecwmO5E2eDEN7/DauYrZtLt+iJnkG3Op6xVtOT1jIhYYt8wSLdsK2pfoAPRMRw=
X-Received: by 2002:aca:ea57:: with SMTP id i84mr1382576oih.73.1574121858711;
 Mon, 18 Nov 2019 16:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20191025044721.16617-1-alastair@au1.ibm.com> <20191025044721.16617-9-alastair@au1.ibm.com>
 <8232c1a6-d52a-6c32-6178-de082174a92a@linux.ibm.com> <CAPcyv4g9b6PyREurH9NcQf4BO2YcRGJPBZDqGKy-Vz91mBKjew@mail.gmail.com>
 <02374c9a-39fb-5693-3d9c-aa7e7674a6c1@linux.ibm.com>
In-Reply-To: <02374c9a-39fb-5693-3d9c-aa7e7674a6c1@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 Nov 2019 16:04:07 -0800
Message-ID: <CAPcyv4hDxeJo-i9FG=JBhaK3awjm3cN_MNvdO_7Z=9bJT9wsGw@mail.gmail.com>
Subject: Re: [PATCH 08/10] nvdimm: Add driver for OpenCAPI Storage Class Memory
To:     Andrew Donnellan <ajd@linux.ibm.com>
Cc:     Frederic Barrat <fbarrat@linux.ibm.com>,
        "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org,
        Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Mackerras <paulus@samba.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>, Qian Cai <cai@lca.pw>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Linux MM <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 3:48 PM Andrew Donnellan <ajd@linux.ibm.com> wrote:
>
> On 15/11/19 3:35 am, Dan Williams wrote:
> >> Have you discussed with the directory owner if it's ok to split the
> >> driver over several files?
> >
> > My thought is to establish drivers/opencapi/ and move this and the
> > existing drivers/misc/ocxl/ bits there.
>
> Is there any other justification for this we can think of apart from not
> wanting to put this driver in the nvdimm directory? OpenCAPI drivers
> aren't really a category of driver unto themselves.

The concern is less about adding to drivers/nvdimm/ and more about the
proper location to house opencapi specific transport and enumeration
details. The organization I'm looking for is to group platform
transport and enumeration code together similar to how drivers/pci/
exists independent of all pci drivers that use that common core. For
libnvdimm the enumeration is platform specific and calls into the
nvdimm core. This is why the x86 platform persistent memory bus driver
lives under drivers/acpi/nfit/ instead of drivers/nvdimm/. The nfit
driver is an ACPI extension that translates ACPI details into
libnvdimm core objects.

The usage of "ocxl" in the source leads me to think part of this
driver belongs in a directory that has other opencapi specific
considerations.

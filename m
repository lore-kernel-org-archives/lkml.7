Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CA6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 04:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668FE22318
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 04:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="05QWaL6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKSElu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 23:41:50 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43568 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfKSElu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 23:41:50 -0500
Received: by mail-oi1-f193.google.com with SMTP id l20so17637987oie.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 20:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m3MHq1VeKFp127FUICx04ubISK/Dg9APGUYHbc8GCeE=;
        b=05QWaL6gVTbgGCnZuO1yjSnjhWRi3w56l7hdlFSvvB8HiMDjBUO8yQ0RvJvlVo0qrc
         LDTYINUM5Yz7PgMGOy/bFHjxL6KJLqarZnNaOW355ivIXYFifzzcwVSAotpWlAb448cg
         cGiHNiToS3o3BeltrXgUR8vT8b73Tsz627J+9LPszqNyQyTUj33nxl3KHG3AHLooI3Gd
         yVTaO6OHo0EuDIIK5dpNL5RXxotYXkd8Hp4zLWlaTagZrtXbh5DsQV4EK9s/xTexTKeu
         pm4BC3RVxJ3UeExcy4v3Sr3p2qNqBENFM83bjAQnXRlcbCyQKBclbh76qG9xPSZT8Gty
         L9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3MHq1VeKFp127FUICx04ubISK/Dg9APGUYHbc8GCeE=;
        b=ZMNQEO6JDibuq1sk6RcUZGGpal/ON3WBfRLbTrJUbET7LdGU4Vw6T4IKhTot8w/MIz
         Gbu7qdoUIMP2nerCzZtqKSeJM/kgZeF5djylVkiiTu9L7Z0tTbjmm4F+zKXXUPhqZgRJ
         AzwcvNA42CmsCi46Aleh2kDOA3ZkhCAVyvXRfS6hz78bbVLJ2emxC6xfm0blidjh4XU+
         C76C+jTp7NyBasyAMUFpcji2jFdFeEl2xSGnAqkrE/xA27ZUrhSAVy2gXiV7WJJYy208
         Jky5gRST7cJYPxH4ZiwGy2RlfDaeFS0qPwfuiu5N3wlkiRVnznkXpXLRtnAa5aBPh76w
         UXRg==
X-Gm-Message-State: APjAAAVJ8gdPwpREFrA/SP99L9q470/xCiVQkMNSW1pg24TuONw6fUgS
        gkPKPY1nwbl7cz8yJRs5vPzHaCRNCqVQhptdhvwAWg==
X-Google-Smtp-Source: APXvYqwaHXiniUcSPs62JothmUuDkzT/zx/0SnTg3vefxzqbvzTfYsTVt7fj8ADLqJF7B6/l1DhnNw4N/Z8KxZnRhnU=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr2403758oib.105.1574138509410;
 Mon, 18 Nov 2019 20:41:49 -0800 (PST)
MIME-Version: 1.0
References: <20191025044721.16617-1-alastair@au1.ibm.com> <20191025044721.16617-9-alastair@au1.ibm.com>
 <8232c1a6-d52a-6c32-6178-de082174a92a@linux.ibm.com> <CAPcyv4g9b6PyREurH9NcQf4BO2YcRGJPBZDqGKy-Vz91mBKjew@mail.gmail.com>
 <02374c9a-39fb-5693-3d9c-aa7e7674a6c1@linux.ibm.com> <7fd5a4571062a06da8f09f18300794b48ead5dc1.camel@au1.ibm.com>
 <33b6f6b2-5ca1-7c08-01db-6aad73f9a0ec@linux.ibm.com>
In-Reply-To: <33b6f6b2-5ca1-7c08-01db-6aad73f9a0ec@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 Nov 2019 20:41:37 -0800
Message-ID: <CAPcyv4gOB3=U_0NU81qr1v8w4rd8i3AMHZuT1hs05sx287YgcA@mail.gmail.com>
Subject: Re: [PATCH 08/10] nvdimm: Add driver for OpenCAPI Storage Class Memory
To:     Andrew Donnellan <ajd@linux.ibm.com>
Cc:     "Alastair D'Silva" <alastair@au1.ibm.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Wei Yang <richard.weiyang@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
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

On Mon, Nov 18, 2019 at 7:29 PM Andrew Donnellan <ajd@linux.ibm.com> wrote:
>
> On 19/11/19 1:48 pm, Alastair D'Silva wrote:
> > On Tue, 2019-11-19 at 10:47 +1100, Andrew Donnellan wrote:
> >> On 15/11/19 3:35 am, Dan Williams wrote:
> >>>> Have you discussed with the directory owner if it's ok to split
> >>>> the
> >>>> driver over several files?
> >>>
> >>> My thought is to establish drivers/opencapi/ and move this and the
> >>> existing drivers/misc/ocxl/ bits there.
> >>
> >> Is there any other justification for this we can think of apart from
> >> not
> >> wanting to put this driver in the nvdimm directory? OpenCAPI drivers
> >> aren't really a category of driver unto themselves.
> >>
> >
> > There is a precedent for bus-based dirs, eg. drivers/(ide|w1|spi) all
> > contain drivers for both controllers & connected devices.
> >
> > Fred, how do you feel about moving the generic OpenCAPI driver out of
> > drivers/misc?
>
> Instinctively I don't like the idea of creating a whole opencapi
> directory, as OpenCAPI is a generic bus which is not tightly coupled to
> any particular application area, and drivers for other OpenCAPI devices
> are already spread throughout the tree (e.g. cxlflash in drivers/scsi).

I'm not suggesting all opencapi drivers go there, nor the entirety of
this driver, just common infrastructure. That said, it's hard to talk
about specifics given the current state of the patch set. I have not
even taken a deeper look past the changelog as this 3K lines-of-code
submission needs to be broken up into smaller pieces before we settle
on what pieces belong where.

Just looking at the diffstat, at a minimum it's not appropriate for
them to live in drivers/nvdimm/ directly, drivers/nvdimm/oxcl/ would
be an acceptable starting point.

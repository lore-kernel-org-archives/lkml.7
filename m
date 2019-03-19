Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E476C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9112083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="aZpreJfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfCSPgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:36:53 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42460 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSPgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:36:51 -0400
Received: by mail-ot1-f65.google.com with SMTP id 103so2746354otd.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 08:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1unbtIvY5Ht57/xExEoU7Ql118n/fJ7lA1QdHqj8Odk=;
        b=aZpreJfZigo3FKFLPUZju3pojwCEccRahWR3gpAo6ZfCqnm80KEjECkjhF+s7IRotx
         5hw8tXb+CaJesSAIWhgcGCpQA7hZzzrZ+9f9SO7gvkUW5tGowDM/3iommlzv6U6burYI
         BNmd+EJvqFeLxFn81SfbhyntCt4bNsllLQoFNgz1f2lITd61wl+htoOGhnjBl014kN16
         IUmyQXlvPOSXPDY++j0eWwbcpoyyqtUpOsmNnsshnqRnsUDfJiLYo9EeHXeyyaz763AC
         q8MEBln0Af2RbQ8eLac+I5cLVBSiQ1cCA2cpKMnBa4WuGFMYa31AV8rxXkUOkAyb1YHe
         A1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1unbtIvY5Ht57/xExEoU7Ql118n/fJ7lA1QdHqj8Odk=;
        b=DDbPWbW9hYIEL5QX/CO2gj64Rj2JtfUDu93UrHOvIuc/M1x87exmUi/Je9n3tosGDt
         nq7kLwZFSsEk29dOkE2yOtyuOlayMNRj4Oem7iscHga81Jrfs9I0tK5THsDIMUUxKokK
         zr5Du3XGcWXqdJiSZzr28LZhbhy3LPiMuZ/3vu0nexjPM9IJLf70wV8gfpWwmNu1CkVt
         dyrjbApjdVeRnZRqvHxK8zbowSw4h2gif3WMpP9t1/oXvXSdYzj+ndekDPTOwiKZBotp
         nwxGYnruAIUj/xHZ/434JDcXG1US+C/zUVD9hnIdmLtJ7lmVsKVnJpTMhU9rura/sBMv
         Ld1g==
X-Gm-Message-State: APjAAAVUIzQTxwwZAb1HwXZ8SYHzI4I2+frNtdBgHTbFOENMU5Irn3tO
        K6EvPbshn38Gv4pT//Neb7h2ocO7Ohb+EPijOGt58O85Zlo=
X-Google-Smtp-Source: APXvYqxPZKAs3Uy3oIgghMayYyNVrb3KfDYOGyNEqIq7hCNaT+fTAAGNpB3SAeibiLTtMxkc/Xc9qQ6zh78W8KexrOw=
X-Received: by 2002:a9d:2c23:: with SMTP id f32mr1985166otb.353.1553009810711;
 Tue, 19 Mar 2019 08:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
 <20190228083522.8189-2-aneesh.kumar@linux.ibm.com> <CAOSf1CHjkyX2NTex7dc1AEHXSDcWA_UGYX8NoSyHpb5s_RkwXQ@mail.gmail.com>
 <CAPcyv4jhEvijybSVsy+wmvgqfvyxfePQ3PUqy1hhmVmPtJTyqQ@mail.gmail.com>
 <87k1hc8iqa.fsf@linux.ibm.com> <20190306124453.126d36d8@naga.suse.cz>
 <df01bf6e-84a1-53fb-bf0c-0957af2f79e1@linux.ibm.com> <CAPcyv4iLm09DSiF3niFprP3PTFrgB5pZPp9AysBpRa-m725tmw@mail.gmail.com>
 <20190319084439.eya2pisiirattuil@kshutemo-mobl1>
In-Reply-To: <20190319084439.eya2pisiirattuil@kshutemo-mobl1>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Mar 2019 08:36:38 -0700
Message-ID: <CAPcyv4jAMAenu-WJ1P9E-q728OVpvcajPxqPrW0+gQg_Jk1+0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/dax: Don't enable huge dax mapping by default
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Oliver <oohall@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 1:45 AM Kirill A. Shutemov <kirill@shutemov.name> w=
rote:
>
> On Wed, Mar 13, 2019 at 09:07:13AM -0700, Dan Williams wrote:
> > On Wed, Mar 6, 2019 at 4:46 AM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> > >
> > > On 3/6/19 5:14 PM, Michal Such=C3=A1nek wrote:
> > > > On Wed, 06 Mar 2019 14:47:33 +0530
> > > > "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> > > >
> > > >> Dan Williams <dan.j.williams@intel.com> writes:
> > > >>
> > > >>> On Thu, Feb 28, 2019 at 1:40 AM Oliver <oohall@gmail.com> wrote:
> > > >>>>
> > > >>>> On Thu, Feb 28, 2019 at 7:35 PM Aneesh Kumar K.V
> > > >>>> <aneesh.kumar@linux.ibm.com> wrote:
> > > >
> > > >> Also even if the user decided to not use THP, by
> > > >> echo "never" > transparent_hugepage/enabled , we should continue t=
o map
> > > >> dax fault using huge page on platforms that can support huge pages=
.
> > > >
> > > > Is this a good idea?
> > > >
> > > > This knob is there for a reason. In some situations having huge pag=
es
> > > > can severely impact performance of the system (due to host-guest
> > > > interaction or whatever) and the ability to really turn off all THP
> > > > would be important in those cases, right?
> > > >
> > >
> > > My understanding was that is not true for dax pages? These are not
> > > regular memory that got allocated. They are allocated out of /dev/dax=
/
> > > or /dev/pmem*. Do we have a reason not to use hugepages for mapping
> > > pages in that case?
> >
> > The problem with the transparent_hugepage/enabled interface is that it
> > conflates performing compaction work to produce THP-pages with the
> > ability to map huge pages at all.
>
> That's not [entirely] true. transparent_hugepage/defrag gates heavy-duty
> compaction. We do only very limited compaction if it's not advised by
> transparent_hugepage/defrag.
>
> I believe DAX has to respect transparent_hugepage/enabled. Or not
> advertise its huge pages as THP. It's confusing for user.

What does "advertise its huge pages as THP" mean in practice? I think
it's confusing that DAX, a facility that bypasses System RAM, is
affected by a transparent_hugepage flag which is a feature for
combining System RAM pages into larger pages. For the same reason that
transparent_hugepage does not gate / control hugetlb operation is the
same reason that transparent_hugepage should not gate / control DAX. A
global setting to disable opportunistic large page mappings of
System-RAM makes sense, but I don't see why that should read on DAX?

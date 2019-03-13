Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D70C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C71C20643
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Ev3mjXd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfCMQH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:07:26 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34631 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfCMQHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:07:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id r19so2259497otn.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 09:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/XfqRx4tzKzsjCcb8QbRLqX/uBHxzCtpu1uDPCItsOs=;
        b=Ev3mjXd6En91xODIUX56pYwhJLO9DdmQ95Gif+qABOQYxSXLSsL3HdkZ996LpFM0Ok
         BNFXboh0vkQcZET1UNi2xWbfJOgLi7YJOBlDe07HQIOTkXhyuZZtxYx1Jr323nQBINw1
         bCIVmxF4JR2efLcgr/ZOkQzDj5SYAbGOQud/xj7awoc+6yVUoor9qC0PAVErRf0dlx+t
         qM1zGEHB4PSIuwMXtFmThJuVWsfXkY8L4/6g612b2JAC90VycrbkkPGVtxjK+QjLV1tp
         zV3E3pIxFXDm4fJ1q4lhu5iiryNlMnlw3ajMFHOD83PMclLscUSXLEmMdZOnDZ62lqrK
         YZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/XfqRx4tzKzsjCcb8QbRLqX/uBHxzCtpu1uDPCItsOs=;
        b=Q4GrEd7BzY1WLQI4HuS7N3qpH1hXet4zyoBihZOe9/p4nkKFIjr8zkyj95a6cMIqQe
         VAPGjfAQU7MAZQ5pFy94VK3WMObcSzeH0T9S6lvoFgr/gVISCSqF1gdfkFT5nrorR+v3
         jJzImuwvUderxZL+GCJ22lYAVrHNHxuMz5m+dBKOjjuIjFLONo/qePOW9orHR1cnhEKv
         P9NghoACOC8QC6ONb8i8RC+qJYlTyKLTZKGNqSylsHV8Sc+AoFt6Cj0HCT1iVBOwhU9G
         fxL4ChlXxJMf5Eg/CI7QhqgG7htpD6HydnbSwM+nnbDaTSEa0V6XUN/ed03a09+jkys0
         nutQ==
X-Gm-Message-State: APjAAAVj0C8GWjjYO00Iij1yhN/ECmZjnmSqIfuSkz12tF369ofL9ZKo
        /tzyodkqFCoCN23toe5yOIEIbZnxQ8oMcuc2SMn5QQ==
X-Google-Smtp-Source: APXvYqzH9OHk6fwYw9vNd25aIvBEiA2sVSv1vjB2i+lT3GwQjeRBJM8aOKz1bJJDYo3s88am/imNu4byiUR9Jvcm8nc=
X-Received: by 2002:a9d:224a:: with SMTP id o68mr16122221ota.214.1552493244500;
 Wed, 13 Mar 2019 09:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
 <20190228083522.8189-2-aneesh.kumar@linux.ibm.com> <CAOSf1CHjkyX2NTex7dc1AEHXSDcWA_UGYX8NoSyHpb5s_RkwXQ@mail.gmail.com>
 <CAPcyv4jhEvijybSVsy+wmvgqfvyxfePQ3PUqy1hhmVmPtJTyqQ@mail.gmail.com>
 <87k1hc8iqa.fsf@linux.ibm.com> <20190306124453.126d36d8@naga.suse.cz> <df01bf6e-84a1-53fb-bf0c-0957af2f79e1@linux.ibm.com>
In-Reply-To: <df01bf6e-84a1-53fb-bf0c-0957af2f79e1@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Mar 2019 09:07:13 -0700
Message-ID: <CAPcyv4iLm09DSiF3niFprP3PTFrgB5pZPp9AysBpRa-m725tmw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/dax: Don't enable huge dax mapping by default
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
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

On Wed, Mar 6, 2019 at 4:46 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 3/6/19 5:14 PM, Michal Such=C3=A1nek wrote:
> > On Wed, 06 Mar 2019 14:47:33 +0530
> > "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> >
> >> Dan Williams <dan.j.williams@intel.com> writes:
> >>
> >>> On Thu, Feb 28, 2019 at 1:40 AM Oliver <oohall@gmail.com> wrote:
> >>>>
> >>>> On Thu, Feb 28, 2019 at 7:35 PM Aneesh Kumar K.V
> >>>> <aneesh.kumar@linux.ibm.com> wrote:
> >
> >> Also even if the user decided to not use THP, by
> >> echo "never" > transparent_hugepage/enabled , we should continue to ma=
p
> >> dax fault using huge page on platforms that can support huge pages.
> >
> > Is this a good idea?
> >
> > This knob is there for a reason. In some situations having huge pages
> > can severely impact performance of the system (due to host-guest
> > interaction or whatever) and the ability to really turn off all THP
> > would be important in those cases, right?
> >
>
> My understanding was that is not true for dax pages? These are not
> regular memory that got allocated. They are allocated out of /dev/dax/
> or /dev/pmem*. Do we have a reason not to use hugepages for mapping
> pages in that case?

The problem with the transparent_hugepage/enabled interface is that it
conflates performing compaction work to produce THP-pages with the
ability to map huge pages at all. The compaction is a nop for dax
because the memory is already statically allocated. If the
administrator does not want dax to consume huge TLB entries then don't
configure huge-page dax. If a hypervisor wants to force disable
huge-page-configured device-dax instances after the fact it seems we
need an explicit interface for that and not overload
transparent_hugepage/enabled.

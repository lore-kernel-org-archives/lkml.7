Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49497C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E60F2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ZBLFEadu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbfDQW77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:59:59 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34766 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730037AbfDQW76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:59:58 -0400
Received: by mail-ot1-f65.google.com with SMTP id k21so129807otf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 15:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y5Q86gAOv8MWLH9laJ1IXocaow5yfnrBeR8EoiIfWbU=;
        b=ZBLFEadujMfdBVNXmJrbI4zR196fsIe5mO0VxN2DENpJoVBadqYu0gk0x8BFoQgGPq
         OK03oOc+QwJXFHRhGDlI7HCGUn2FEDGxayOCXFrte0xS6Eixyn+gIt/g4OryYh6KKycR
         AtX1Bh19zGnaHnWO2gBlfJUTikry4l1+4Qk11EAhA94VzavMVUGVX203v5zHLieBR6zh
         iTobtE2slojYN1Tb2AHac5rvm5VvsUU57qEovxYyIrZFhvH/Prks6Ak+9axoPXJErs1g
         9Loy/hrOeN5wKsxb70LZ4bKOMK6ISrFa8Gw6DMu0Aw8V6ImUhRDqecnSs5U2wRmEqV76
         IzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5Q86gAOv8MWLH9laJ1IXocaow5yfnrBeR8EoiIfWbU=;
        b=gcgcQOUK1tzMqv1k271asqs78TP1j/TB0h+Ho+nZDoDIgc1O3jWxVCDUzzRV9iEayz
         mV/96AzZuvWOC9JTsFHaCjBOmSl6iWJf47Edw6SO5vXm8U0m/zVcqrsaOequ0yeFW/bR
         C233VCMKj47xnm5Gm/CP0sT/eHfVqo6nErOwoSOaeq2/Zls6LlujtNuCkWCaTYSVMEI0
         qlaAqnr7kKVuLjwZ6uuSEq+MbGKUzEBpUGMNOn5yDDOTS9lnPPJ19K+d/2zHj37saI/X
         tLHJg7/iqGQM0s+7aGPd9ACbpTaUxlCKe+d/3BWoObwCsv+OF4Y07C7eXONlEdLwN/9s
         0S8g==
X-Gm-Message-State: APjAAAUXWcmfkdSKnqielWK4kcK3MsI5LWqllDqWMC0u/0d747T6D63T
        DUgajcPnxBvJXYn8G5bEB14Qg39BaKkGbZUxFWM2po76
X-Google-Smtp-Source: APXvYqx0PiTtBkyrLfmk/jOmFbuQMwTA591NJRQvMCXkPXCoY+luPtiOJZPaujG8DsNnN9FucBhbxzpzdgGKAJXtWxA=
X-Received: by 2002:a9d:27e3:: with SMTP id c90mr57351203otb.214.1555541997937;
 Wed, 17 Apr 2019 15:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190417150331.90219ca42a1c0db8632d0fd5@linux-foundation.org>
In-Reply-To: <20190417150331.90219ca42a1c0db8632d0fd5@linux-foundation.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 17 Apr 2019 15:59:46 -0700
Message-ID: <CAPcyv4hB47NJrVi1sm+7msL+6dJNhBD10BJbtLPZRcK2JK6+pg@mail.gmail.com>
Subject: Re: [PATCH v6 00/12] mm: Sub-section memory hotplug support
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Jeff Moyer <jmoyer@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        stable <stable@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 3:04 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 17 Apr 2019 11:38:55 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
>
> > The memory hotplug section is an arbitrary / convenient unit for memory
> > hotplug. 'Section-size' units have bled into the user interface
> > ('memblock' sysfs) and can not be changed without breaking existing
> > userspace. The section-size constraint, while mostly benign for typical
> > memory hotplug, has and continues to wreak havoc with 'device-memory'
> > use cases, persistent memory (pmem) in particular. Recall that pmem uses
> > devm_memremap_pages(), and subsequently arch_add_memory(), to allocate a
> > 'struct page' memmap for pmem. However, it does not use the 'bottom
> > half' of memory hotplug, i.e. never marks pmem pages online and never
> > exposes the userspace memblock interface for pmem. This leaves an
> > opening to redress the section-size constraint.
>
> v6 and we're not showing any review activity.  Who would be suitable
> people to help out here?

There was quite a bit of review of the cover letter from Michal and
David, but you're right the details not so much as of yet. I'd like to
call out other people where I can reciprocate with some review of my
own. Oscar's altmap work looks like a good candidate for that.

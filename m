Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B01C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6AC208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="DDH2tF8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfEMVMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 17:12:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38326 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfEMVMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 17:12:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id s19so13181254otq.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 14:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ehW85Lrv2Q48sCjGFVYU8EiJvcqJ/cEoN0rsLhKwFn4=;
        b=DDH2tF8rRfIjsd+6p3tNZ6N0FrylBCHLkuudu7uIV1T1yuGKEfmS5nhaufD2LxCH0n
         G845ptMmk8uLtcFNrOm9RJ/y5yUNcE06KAhjuzSEvjcwqluLZzThkkFoVLMzDS/GRFiQ
         E3YJqmPgTJDanm2yChPEe9Htk6yEnKKy74gZ1xdIUD/wHzbHnBDGzYiaAisiKcyMiL43
         a7ia7WeecOqq9//fSUFEgti9KcdEQBl+Yf08zwAb8MthphEbW8tsStK9BfeWjBslJy9P
         /aU3hHSwS4cAoxn925mw+G8S7Zm+GNjhEPotnhkBeJGxfQcKkGFVGwhIkvS82qmcTcOv
         6R5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehW85Lrv2Q48sCjGFVYU8EiJvcqJ/cEoN0rsLhKwFn4=;
        b=f/ArhlmWJVrjSyDEZ0uEZhTmaZPh7Jwh3AHgGLlf8GSzSMpRcGsEpvbKFbZhtT14pQ
         A46LX+60YkyWT0DwlXT0zABWzZw2yUoD3QX8bbv0SKI4/bwV2HKWNfh7fBoIvnc7p5MN
         PzRLkNGR3WjId3pynS28H2OI5R1CgxyY7ZO8IgaBBv+j/28PGYuzLsIlVLMG6dvm5J4L
         1walGEhjKsxlsjMkR62mSIvELWrNCNfDryNzbL75sTfC/Rl8z1+ebGzn8Y05DdvHweMP
         pTEvNrC07qLQ7YAOBcNxYeJktOBQclcfwrGki01MB1PAcyYtET91aGOEO0slj8FoO7KA
         ni7g==
X-Gm-Message-State: APjAAAXHvOj41SAJqjUQMislPofsWLRuoTiYzZ00rjIxklAcQR2+bSUt
        qofULmLFhjU4YXtgQVNBZbTEeOlj/yDYa7lN5inPgg==
X-Google-Smtp-Source: APXvYqwIGJ0PBLErnWxuRYnfK8Gzj1P5cw9UmR9BtnvGHQjAVMKGB06nxi/SpfU6EmNEkLZmuWLghYQYRcySk2jRhMk=
X-Received: by 2002:a9d:6f19:: with SMTP id n25mr12997789otq.367.1557781926319;
 Mon, 13 May 2019 14:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <155718596657.130019.17139634728875079809.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190513210148.GA21574@rapoport-lnx>
In-Reply-To: <20190513210148.GA21574@rapoport-lnx>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 13 May 2019 14:11:54 -0700
Message-ID: <CAPcyv4he64-d=govm4+OEt75gxeuLZcrwrhow5dT=rA3KwQ4JA@mail.gmail.com>
Subject: Re: [PATCH v8 00/12] mm: Sub-section memory hotplug support
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Jane Chu <jane.chu@oracle.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Paul Mackerras <paulus@samba.org>,
        Toshi Kani <toshi.kani@hpe.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jeff Moyer <jmoyer@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        stable <stable@vger.kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 2:02 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Hi Dan,
>
> On Mon, May 06, 2019 at 04:39:26PM -0700, Dan Williams wrote:
> > Changes since v7 [1]:
>
> Sorry for jumping late

No worries, it needs to be rebased on David's "mm/memory_hotplug:
Factor out memory block device handling" series which puts it firmly
in v5.3 territory.

> but presuming there will be v9, it'd be great if it
> would also include include updates to
> Documentation/admin-guide/mm/memory-hotplug.rst and

If I've done my job right this series should be irrelevant to
Documentation/admin-guide/mm/memory-hotplug.rst. The subsection
capability is strictly limited to arch_add_memory() users that never
online the memory, i.e. only ZONE_DEVICE / devm_memremap_pages()
users. So this isn't "memory-hotplug" as much as it is "support for
subsection vmemmap management".

> Documentation/vm/memory-model.rst

This looks more fitting and should probably include a paragraph on the
general ZONE_DEVICE / devm_memremap_pages() use case.

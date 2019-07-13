Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2561EC31E40
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 16:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA8120830
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 16:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vm2O5Q/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfGMQw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 12:52:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42264 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbfGMQw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 12:52:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id v15so11786774eds.9
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QJtleFy0W5wG+kdjcQeK55r7BWM3778hGqddVx/0MZo=;
        b=Vm2O5Q/c3MGDUmRqEb79GmywtMNQUwpvrKPNIkqSH760cGhr+7PbMBMWs0uNtd/66a
         xp51fGxqAZdeBd6IMqm9Z/46AAtWtCTRtNhrdcD0EHcK0dXYJcMkBNjQOwLXGmUuJ/k/
         3lYxq2jv1c2pz8TzeUK6BoAUhQ8oxACHVO4iFqHOL7toO2CQ1xyPjABeTVlPF916bWeY
         GZj17ofIBcVfR2W6n9YhRPIzujPGVGvuO4zuyN+4ztTMte49OULTEE5wTHfi0BtL8Qdd
         4THAi7172kWjg6H3wGaNhJd9kgA5FqHNYuEsTCLaNB+KH9HW5z6Mf0VNPfP2C02N0uRC
         ASSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QJtleFy0W5wG+kdjcQeK55r7BWM3778hGqddVx/0MZo=;
        b=dG5LsHW1itJ0FcQAMBz3RceZgVRdIJJ8o5JOfHFVGXBz8JUsKb8LmIWbZ3Mn5EuA0p
         FrBnUjvf/uzz5KpPfcuOgmPkNiI2XrnjsGbrYwz0s6sZLF7Hdv84GW9SBsIMqnnvXxAF
         ztGvEEid0Ag774vHrdRi/JgN2Y4Ngft+atrBrKW/6+5/rK9xIH29Y1e6aOZEZob+KxLO
         Wn2olpww8u55HlWOL0OR/w1LWGtjv/+lnVfzd12ePh+oaMLY44RxwlqnrPYz4DdN/FUN
         Jaopa314Sbksq3yvBmQfQDF4RcSyVjeOeOfOyRHR/YClCTPCaH8yD2o94ewbg8HEz0NE
         LxBw==
X-Gm-Message-State: APjAAAVTDnPPtdUYYZH13ImPLV75y2AZvZxrSUq30cZDAm/sum7oZIhv
        CJr1Hll6qRnWVxawx9iQuQCANIS8
X-Google-Smtp-Source: APXvYqw3SV43FYERQz/LFl2ft4u4C9PlOgnoiwlyz8ZxyhiAHA7EmSDB/qtYar8gidDGLBb/bJi6dw==
X-Received: by 2002:a05:6402:14c4:: with SMTP id f4mr14931366edx.170.1563036745777;
        Sat, 13 Jul 2019 09:52:25 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id by12sm2559899ejb.37.2019.07.13.09.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Jul 2019 09:52:19 -0700 (PDT)
Date:   Sat, 13 Jul 2019 16:52:19 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Raslan, KarimAllah" <karahmed@amazon.de>
Cc:     "richard.weiyang@gmail.com" <richard.weiyang@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cai@lca.pw" <cai@lca.pw>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>
Subject: Re: [PATCH] mm: sparse: Skip no-map regions in memblocks_present
Message-ID: <20190713165219.n3ro7peyyml6swrk@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <1562921491-23899-1-git-send-email-karahmed@amazon.de>
 <20190712230913.l35zpdiqcqa4o32f@master>
 <1563026005.19043.12.camel@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563026005.19043.12.camel@amazon.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2019 at 01:53:25PM +0000, Raslan, KarimAllah wrote:
>On Fri, 2019-07-12 at 23:09 +0000, Wei Yang wrote:
>> On Fri, Jul 12, 2019 at 10:51:31AM +0200, KarimAllah Ahmed wrote:
>> > 
>> > Do not mark regions that are marked with nomap to be present, otherwise
>> > these memblock cause unnecessarily allocation of metadata.
>> > 
>> > Cc: Andrew Morton <akpm@linux-foundation.org>
>> > Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
>> > Cc: Oscar Salvador <osalvador@suse.de>
>> > Cc: Michal Hocko <mhocko@suse.com>
>> > Cc: Mike Rapoport <rppt@linux.ibm.com>
>> > Cc: Baoquan He <bhe@redhat.com>
>> > Cc: Qian Cai <cai@lca.pw>
>> > Cc: Wei Yang <richard.weiyang@gmail.com>
>> > Cc: Logan Gunthorpe <logang@deltatee.com>
>> > Cc: linux-mm@kvack.org
>> > Cc: linux-kernel@vger.kernel.org
>> > Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
>> > ---
>> > mm/sparse.c | 4 ++++
>> > 1 file changed, 4 insertions(+)
>> > 
>> > diff --git a/mm/sparse.c b/mm/sparse.c
>> > index fd13166..33810b6 100644
>> > --- a/mm/sparse.c
>> > +++ b/mm/sparse.c
>> > @@ -256,6 +256,10 @@ void __init memblocks_present(void)
>> > 	struct memblock_region *reg;
>> > 
>> > 	for_each_memblock(memory, reg) {
>> > +
>> > +		if (memblock_is_nomap(reg))
>> > +			continue;
>> > +
>> > 		memory_present(memblock_get_region_node(reg),
>> > 			       memblock_region_memory_base_pfn(reg),
>> > 			       memblock_region_memory_end_pfn(reg));
>> 
>> 
>> The logic looks good, while I am not sure this would take effect. Since the
>> metadata is SECTION size aligned while memblock is not.
>> 
>> If I am correct, on arm64, we mark nomap memblock in map_mem()
>> 
>>     memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
>
>The nomap is also done by EFI code in ${src}/drivers/firmware/efi/arm-init.c
>
>.. and hopefully in the future by this:
>https://lkml.org/lkml/2019/7/12/126
>
>So it is not really striclty associated with the map_mem().
>
>So it is extremely dependent on the platform how much memory will end up mapped??
>as nomap.
>
>> 
>> And kernel text area is less than 40M, if I am right. This means
>> memblocks_present would still mark the section present. 
>> 
>> Would you mind showing how much memory range it is marked nomap?
>
>We actually have some downstream patches that are using this nomap flag for
>more than the use-cases I described above which would enflate the nomap regions??
>a bit :)
>

Thanks for your explanation.

If my understanding is correct, the range you mark nomap could not be used by
the system, it looks those ranges are useless for the system. Just curious
about how linux could use these memory after marking nomap?

>> 
>> > 
>> > -- 
>> > 2.7.4
>> 
>
>
>
>Amazon Development Center Germany GmbH
>Krausenstr. 38
>10117 Berlin
>Geschaeftsfuehrung: Christian Schlaeger, Ralf Herbrich
>Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
>Sitz: Berlin
>Ust-ID: DE 289 237 879
>
>

-- 
Wei Yang
Help you, Help me

Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD92C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 03:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02B8214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 03:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czJnR5SP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfLNDeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 22:34:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51378 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726046AbfLNDeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 22:34:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576294438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tML/8OZB0+z+ReKLp0+fit2Y41cAd6W2Z1tBQGsHHkI=;
        b=czJnR5SPZWUqNlOeyEz+XGGjYTiJlbqkBJNWzgY6M3IZey5GcDtxQ7xWAt+LhKmuW/Se4n
        j0/3PzxXsGGwlSCISl/VPe0FmTOE2usw/AZyhGmSYq63K9KWRDbN7W5oTwiV96/QZSSg7Q
        1AinQSLQQ+2o6MLm09uajc2sxS2QA3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-48t0-X0NP7OZmFt3J36Txg-1; Fri, 13 Dec 2019 22:33:54 -0500
X-MC-Unique: 48t0-X0NP7OZmFt3J36Txg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80ABE1852E26;
        Sat, 14 Dec 2019 03:33:52 +0000 (UTC)
Received: from localhost (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4FCF60BCE;
        Sat, 14 Dec 2019 03:33:51 +0000 (UTC)
Date:   Sat, 14 Dec 2019 11:33:48 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] x86/mm/KASLR: Adjust the padding size for the
 direct mapping.
Message-ID: <20191214033348.GJ28917@MiWiFi-R3L-srv>
References: <20191115144917.28469-1-msys.mizuma@gmail.com>
 <20191115144917.28469-5-msys.mizuma@gmail.com>
 <20191212201916.GL4991@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212201916.GL4991@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/19 at 09:19pm, Borislav Petkov wrote:
> On Fri, Nov 15, 2019 at 09:49:17AM -0500, Masayoshi Mizuma wrote:
> > +/*
> > + * Even though a huge virtual address space is reserved for the direct
> > + * mapping of physical memory, e.g in 4-level paging mode, it's 64TB,
> > + * rare system can own enough physical memory to use it up, most are
> > + * even less than 1TB.
> 
> This sentence is unparseable.
> 
> > So with KASLR enabled, we adapt the size of
> 
> Who's "we"?
> 
> > + * direct mapping area to the size of actual physical memory plus the
> > + * configured padding CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING.
> > + * The left part will be taken out to join memory randomization.
> > + */
> > +static inline unsigned long calc_direct_mapping_size(void)
> 
> What direct mapping?!
> 
> The code is computing the physical memory regions base address and
> sizes.
> 
> > +{
> > +	unsigned long size_tb, memory_tb;
> > +
> > +	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
> > +		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
> > +
> > +#ifdef CONFIG_MEMORY_HOTPLUG
> > +	if (boot_params.max_addr) {
> > +		unsigned long maximum_tb;
> > +
> > +		maximum_tb = DIV_ROUND_UP(boot_params.max_addr,
> > +				1UL << TB_SHIFT);
> 
> All that jumping through hoops and adding a member to boot_params which
> is useless on !hot-add systems - basically the majority out there - just

Read this again, one system owns ACPI SRAT tables, doesn't mean it's
a hot-adding system. Currently, most of systems have ACPI and the
affiliated SRAT tables. But to support memory hotplug, it need specific
firmware setting and web management to remotely power on/off the DIMM.
At least, systems which is delived to us for testing is very few.

So in kernel there's no way to check if memory hotplug is supported in
system. Memory hotplug is the sufficient and unnecessary condition of
the SRAT existence, I would say.

Thanks
Baoquan


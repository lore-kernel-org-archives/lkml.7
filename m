Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC207C33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F216C24715
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjPktfS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfLMN3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:29:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38599 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726674AbfLMN3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 08:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576243739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7n8SWaJivUQ/2/eU9591KEOF2V8zoo8DFt7lnv7IRQc=;
        b=HjPktfS4jU/q9zkbzxqbho8tJcnEdbxTa9AE5Z/hhRpB2IRgiNv7ydRpfW2LuMAMUU/oHt
        r0MmiiiWg1CfVq7mgv3U8lH5R9R+J0SnFPKjrmwFRckQZ7ZaJSFMCZ/eURSuIKrAEkAUEi
        BT3nnAb9fVBPY0bp9tekdJZUtcX0Zx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-Z8aowBMIOpSGuo1ww6FrxA-1; Fri, 13 Dec 2019 08:28:55 -0500
X-MC-Unique: Z8aowBMIOpSGuo1ww6FrxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 447C71883521;
        Fri, 13 Dec 2019 13:28:54 +0000 (UTC)
Received: from localhost (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 52A051CB;
        Fri, 13 Dec 2019 13:28:52 +0000 (UTC)
Date:   Fri, 13 Dec 2019 21:28:50 +0800
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
Message-ID: <20191213132850.GG28917@MiWiFi-R3L-srv>
References: <20191115144917.28469-1-msys.mizuma@gmail.com>
 <20191115144917.28469-5-msys.mizuma@gmail.com>
 <20191212201916.GL4991@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212201916.GL4991@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/19 at 09:19pm, Borislav Petkov wrote:
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

In Documentation/x86/x86_64/mm.rst, the physical memory regions mapping
with page_offset is called as the direct mapping of physical memory.
Seems both is used in kernel and document. 

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
> so that you can use that max address here?!
> 
> Did you not find acpi_table_parse_srat()?

kernel_randomize_memory() is invoked much earlier than
acpi_table_parse_srat(). KASLR need know the max address to reserve
space for the direct mapping region (or the physical memory region)
so that it can cover later possible hotplugged memory.

Thanks
Baoquan


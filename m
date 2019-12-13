Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A1AC3400C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75A324776
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ciqbZ/Ru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfLMOzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 09:55:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46653 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727673AbfLMOzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 09:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576248899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gntSwDNDnzHe3/thZbUD4KWSDrrpcmgp8bqbLa8CMa0=;
        b=ciqbZ/Ru+IADPhb+B4Jkhk0zMVadryQZlVHzrRP6JTgwnJC7NXmuk3HpjCLdff7K13R07g
        o+XhvEHOrTgm6mUya6fHTx3bKEMEJBaANDqNmqYSe2d4v4L89jznmZsgZkVMM/RwjEOat1
        Du8XsJSJD2nUjV8POy+ezirCAgzQhW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-n5LdeNYkMJyouqVkjHcDAA-1; Fri, 13 Dec 2019 09:54:56 -0500
X-MC-Unique: n5LdeNYkMJyouqVkjHcDAA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7B998017DF;
        Fri, 13 Dec 2019 14:54:53 +0000 (UTC)
Received: from localhost (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5132C5C219;
        Fri, 13 Dec 2019 14:54:53 +0000 (UTC)
Date:   Fri, 13 Dec 2019 22:54:48 +0800
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
Message-ID: <20191213145448.GH28917@MiWiFi-R3L-srv>
References: <20191115144917.28469-1-msys.mizuma@gmail.com>
 <20191115144917.28469-5-msys.mizuma@gmail.com>
 <20191212201916.GL4991@zn.tnic>
 <20191213132850.GG28917@MiWiFi-R3L-srv>
 <20191213141543.GA25899@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213141543.GA25899@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/19 at 03:15pm, Borislav Petkov wrote:
> On Fri, Dec 13, 2019 at 09:28:50PM +0800, Baoquan He wrote:
> > In Documentation/x86/x86_64/mm.rst, the physical memory regions mapping
> > with page_offset is called as the direct mapping of physical memory.
> 
> The fact that it happens to compute the *first* region's size, which
> *happens* to be the direct mapping of all physical memory is immaterial
> here.
> 
> It is actually causing more confusion in an already complex piece of
> code. You can call this function just as well
> 
>   calc_region_size()
> 
> which won't confuse readers. Because all you care about here is the
> region's size - not which region it is.

Won't calc_region_size be too generic? We also have vmalloc and vmemmap,
and here we are specifically calculating the direct mapping of physical
memory. 

> 
> > kernel_randomize_memory() is invoked much earlier than
> > acpi_table_parse_srat().
> 
> And? What are we going to do about that?


void __init setup_arch(char **cmdline_p)
{
...
	kernel_randomize_memory();
...
	init_mem_mapping();
...
	initmem_init();
...
}

In kernel_randomize_memory(), KASLR builds the layout of these regions,
including their starting address and the gap between them. Once
finished, __PAGE_OFFSET, VMALLOC_START, VMEMMAP_START are settled. 
If not knowing the max address to cover all the possible hotplugged
memory, later memory hotplug will fail.

Thanks
Baoquan


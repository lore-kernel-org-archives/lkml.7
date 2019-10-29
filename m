Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF319CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5134208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olxdYvHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390257AbfJ2Pxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 11:53:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40126 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389960AbfJ2Pxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 11:53:40 -0400
Received: by mail-qt1-f195.google.com with SMTP id o49so20902005qta.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 08:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+O32B4WO5xsVzYjwCARGC2wmDrcO5IMKYkCtwpSW9S4=;
        b=olxdYvHtQ+lAzgIO9gCunN5ZtpEo6noFKPjq6MSM14x/aZ47VUyw1DJ1Z8zGBRvDcz
         YlJRAASqoY/mkJwbch7DoFud/9AtxnOduknjZKBCRVmXkxhkRPE+mghCq4K6W3vHLxl+
         JI3TGYZt07BVM2ps4YjK0poUnHXY1XtmBUZPiGJ8QexaILBPySH+vVUc7hKQlhZ8jD35
         D2fRnQmDafFz16IfKZ5gZRdbyykVSd9ZXNQEaXkjl1jWAJMqolUS3xk/9mTMeqcBNbac
         RShAVpGcGhDU5+kc6qikF/730RuUhWbhGTvs9m2ORlia0j2XnIPBZ8WVI5NtfoJ0F4hs
         WE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+O32B4WO5xsVzYjwCARGC2wmDrcO5IMKYkCtwpSW9S4=;
        b=hQXCjobw178rwxqQsziv8f/pFU0ZG1e4clkQ3n2b4jdsYIYMriqEP+3yGyszkDMlQK
         sHviY0B6MBvPbcXC0K1Q4P4UdrviR8XKezVFpJS69ctTs2tXUsgD8E5sNuug/yg2H8rk
         fzbuchdgqifnbkeb7sdBlLPCdf3KgyH84NhCJeE/sEg0EQJBxE7an4H8t5R+SdnRJvgi
         IrHLxyblYbvOS+nknpyMye61qXWNS0TscHgWcOll3mho9LX5gKDYtkldE6dXy4dsnXlS
         hdhS0NFBHzerx1IVeH3mhBVNjBYsynDQxE8htoFbj0kCvz4y9PDpIU30Me97cNASw+sX
         XTeQ==
X-Gm-Message-State: APjAAAVxeTiBl0fdrqv+z0cF7BKBGyCuSGEQ6CY0ATz87NLFS6m/2EF8
        v2+siHzS+Y/C75mA3kHurQ==
X-Google-Smtp-Source: APXvYqwxtAUs+WfWN5IXmrtdDq4IkbfvkPXCT6SsKAFjQqJCDAPLgv0I/ofeU3hdcXXxy9XzoWeSig==
X-Received: by 2002:a0c:eb90:: with SMTP id x16mr23871176qvo.140.1572364419427;
        Tue, 29 Oct 2019 08:53:39 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t127sm8632867qkf.43.2019.10.29.08.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 08:53:39 -0700 (PDT)
Date:   Tue, 29 Oct 2019 11:53:32 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] x86/boot: Get the max address from SRAT
Message-ID: <20191029155331.7o3pewdafrbua5hd@gabell>
References: <20190830214707.1201-1-msys.mizuma@gmail.com>
 <20190830214707.1201-4-msys.mizuma@gmail.com>
 <20190905135134.GC20805@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905135134.GC20805@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 09:51:34PM +0800, Baoquan He wrote:
> On 08/30/19 at 05:47pm, Masayoshi Mizuma wrote:
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > 
> > Get the max address from SRAT and write it into boot_params->max_addr.
> > 
> > Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > ---
> >  arch/x86/boot/compressed/acpi.c | 24 ++++++++++++++++++------
> >  1 file changed, 18 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> > index 908a1bfab..ba2bc5ab9 100644
> > --- a/arch/x86/boot/compressed/acpi.c
> > +++ b/arch/x86/boot/compressed/acpi.c
> > @@ -362,16 +362,24 @@ static unsigned long get_acpi_srat_table(void)
> >  	return 0;
> >  }
> >  
> > -static void subtable_parse(struct acpi_subtable_header *sub_table, int *num)
> > +static void subtable_parse(struct acpi_subtable_header *sub_table, int *num,
> > +		unsigned long *max_addr)
> >  {
> >  	struct acpi_srat_mem_affinity *ma;
> > +	unsigned long addr;
> >  
> >  	ma = (struct acpi_srat_mem_affinity *)sub_table;
> >  
> > -	if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && ma->length) {
> > -		immovable_mem[*num].start = ma->base_address;
> > -		immovable_mem[*num].size = ma->length;
> > -		(*num)++;
> > +	if (ma->length) {
> > +		if (ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) {
> > +			addr = ma->base_address + ma->length;
> > +			if (addr > *max_addr)
> > +				*max_addr = addr;
> 
> Can we return max_addr or only pass out the max_addr, then let the
> max_addr compared and got outside of subtable_parse()? This can keep
> subtable_parse() really only doing parsing work.

Sounds great! I'll change subtable_parse() to return max_addr.

Thanks,
Masa

> 
> Personal opinion, see what maintainers and other reviewers will say.
> 
> Thanks
> Baoquan
> 
> > +		} else {
> > +			immovable_mem[*num].start = ma->base_address;
> > +			immovable_mem[*num].size = ma->length;
> > +			(*num)++;
> > +		}
> >  	}
> >  }
> >  
> > @@ -391,6 +399,7 @@ int count_immovable_mem_regions(void)
> >  	struct acpi_subtable_header *sub_table;
> >  	struct acpi_table_header *table_header;
> >  	char arg[MAX_ACPI_ARG_LENGTH];
> > +	unsigned long max_addr = 0;
> >  	int num = 0;
> >  
> >  	if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
> > @@ -409,7 +418,7 @@ int count_immovable_mem_regions(void)
> >  		sub_table = (struct acpi_subtable_header *)table;
> >  		if (sub_table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
> >  
> > -			subtable_parse(sub_table, &num);
> > +			subtable_parse(sub_table, &num, &max_addr);
> >  
> >  			if (num >= MAX_NUMNODES*2) {
> >  				debug_putstr("Too many immovable memory regions, aborting.\n");
> > @@ -418,6 +427,9 @@ int count_immovable_mem_regions(void)
> >  		}
> >  		table += sub_table->length;
> >  	}
> > +
> > +	boot_params->max_addr = max_addr;
> > +
> >  	return num;
> >  }
> >  #endif /* CONFIG_RANDOMIZE_BASE && CONFIG_MEMORY_HOTREMOVE */
> > -- 
> > 2.18.1
> > 

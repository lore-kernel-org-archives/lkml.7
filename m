Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98491C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6076E20881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="oaK55DJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfEOG6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 02:58:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36042 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfEOG6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:58:51 -0400
Received: from zn.tnic (p200300EC2F0A7C00C5AEE5FDCF635866.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:7c00:c5ae:e5fd:cf63:5866])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5171B1EC050B;
        Wed, 15 May 2019 08:58:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557903529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tKlVEadOu2TMf51BsYgCfI6Pqrx82HYiWRU6sDgtFtI=;
        b=oaK55DJzFSRq+I1iCez9wqIFzE4gA5TNxkKjeGqP20qYi3fvdf6FeMLR9348OC+m+j1iYt
        3kQvKWVxW3z1RsKYHhsZsCUG74AUPyG0IuOdDh8VPCwsDIdtshoBD5pX4OdpijpJeu4d/y
        M8HOSvs/wCu1igXAfwS12rKZ3Plix/A=
Date:   Wed, 15 May 2019 08:58:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Baoquan He <bhe@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190515065843.GA24212@zn.tnic>
References: <20190424092944.30481-1-bhe@redhat.com>
 <20190424092944.30481-2-bhe@redhat.com>
 <20190429002318.GA25400@MiWiFi-R3L-srv>
 <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic>
 <20190513080210.GC16774@MiWiFi-R3L-srv>
 <20190515051717.GA13703@jeru.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190515051717.GA13703@jeru.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 05:17:19AM +0000, Junichi Nomura wrote:
> Hi Kairui,
> 
> On 5/13/19 5:02 PM, Baoquan He wrote:
> > On 05/13/19 at 09:50am, Borislav Petkov wrote:
> >> On Mon, May 13, 2019 at 03:32:54PM +0800, Baoquan He wrote:
> >> So we're going to try it again this cycle and if there's no fallout, it
> >> will go upstream. If not, it will have to be fixed. The usual thing.
> >>
> >> And I don't care if Kairui's patch fixes this one problem - judging by
> >> the fragility of this whole thing, it should be hammered on one more
> >> cycle on as many boxes as possible to make sure there's no other SNAFUs.
> >>
> >> So go test it on more machines instead. I've pushed it here:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=next-merge-window
> > 
> > Pingfan has got a machine to reproduce the kexec breakage issue, and
> > applying these two patches fix it. He planned to paste the test result.
> > I will ask him to try this branch if he has time, or I can get his
> > machine to test.
> > 
> > Junichi, also have a try on Boris's branch in NEC's test environment?
> 
> while the patch set works on most of the machines I'm testing around,
> I found kexec(1) fails to load kernel on a few machines if this patch
> is applied.  Those machines don't have IORES_DESC_ACPI_TABLES region
> and have ACPI tables in IORES_DESC_ACPI_NV_STORAGE region instead.

Why? What kind of machines are those?

Why are the ACPI tables in NV storage?

Looking at crash_setup_memmap_entries(), it already maps that type so I
guess this is needed.

+ Rafael and leaving in the rest for reference.

 
> So I think map_acpi_tables() should try to map both regions.  I tried
> following change in addition and it worked.
> 
> -- 
> Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
> 
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 3c77bdf..3837c4a 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -56,12 +56,22 @@ static int mem_region_callback(struct resource *res, void *arg)
>  {
>  	unsigned long flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>  	struct init_pgtable_data data;
> +	int ret;
>  
>  	data.info = info;
>  	data.level4p = level4p;
>  	flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> -	return walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1,
> -				   &data, mem_region_callback);
> +	ret = walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1,
> +				  &data, mem_region_callback);
> +	if (ret && ret != -EINVAL)
> +		return ret;
> +
> +	ret = walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1,
> +				  &data, mem_region_callback);
> +	if (ret && ret != -EINVAL)
> +		return ret;
> +
> +	return 0;
>  }
>  #else
>  static int map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p) { return 0; }

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

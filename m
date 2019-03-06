Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8D7C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D405920661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfCFRDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:03:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:49008 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726226AbfCFRDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:03:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9382BC2B;
        Wed,  6 Mar 2019 17:03:46 +0000 (UTC)
Date:   Wed, 6 Mar 2019 18:03:46 +0100
From:   Jiri Bohac <jbohac@suse.cz>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Omar Sandoval <osandov@fb.com>, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4] x86/gart/kcore: Exclude GART aperture from kcore
Message-ID: <20190306170346.zs6orsyu327c6m2p@dwarf.suse.cz>
References: <20190306113859.19263-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306113859.19263-1-kasong@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 06, 2019 at 07:38:59PM +0800, Kairui Song wrote:
> +int register_mem_pfn_is_ram(int (*fn)(unsigned long pfn))
> +{
> +	if (mem_pfn_is_ram)
> +		return -EBUSY;
> +	mem_pfn_is_ram = fn;
> +	return 0;
> +}
> +
> +void unregister_mem_pfn_is_ram(void)
> +{
> +	mem_pfn_is_ram = NULL;
> +}
> +
> +static int pfn_is_ram(unsigned long pfn)
> +{
> +	if (mem_pfn_is_ram)
> +		return mem_pfn_is_ram(pfn);
> +	else
> +		return 1;
> +}
> +

If anyone were ever to use unregister_mem_pfn_is_ram(),
pfn_is_ram() would become racy.

In V2 you had this:
	+       fn = mem_pfn_is_ram;
	+       if (fn)
	+               ret = fn(pfn);

I agree it's unnecessary since nothing uses
unregister_mem_pfn_is_ram(). But then I think it would be best to
just drop the unregister function.

Otherwise the patch looks good to me.

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


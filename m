Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CED5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB662082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfC1JD0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:03:26 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:39311 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfC1JD0 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:5:1>);
        Thu, 28 Mar 2019 05:03:26 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Thu, 28 Mar 2019 03:03:25 -0600
Message-Id: <5C9C8DDC0200007800222606@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Thu, 28 Mar 2019 03:03:24 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Cc:     "Stefano Stabellini" <sstabellini@kernel.org>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/Xen: streamline (and fix) PV CPU enumeration
References: <5C9B92EA020000780022227B@prv1-mh.provo.novell.com>
 <2f027b4b-dce2-3e90-dc1b-c824bc8eb355@oracle.com>
In-Reply-To: <2f027b4b-dce2-3e90-dc1b-c824bc8eb355@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 27.03.19 at 18:07, <boris.ostrovsky@oracle.com> wrote:
> On 3/27/19 11:12 AM, Jan Beulich wrote:
>> -
>> -static void __init xen_filter_cpu_maps(void)
>> +static void __init _get_smp_config(unsigned int early)
>>  {
>>  	int i, rc;
>>  	unsigned int subtract = 0;
>>  
>> -	if (!xen_initial_domain())
>> +	if (early)
>>  		return;
>>  
>>  	num_processors = 0;
> 
> 
> Is there a reason to set_cpu_possible() here (not in the diff, but in
> this routine)? This will be called from setup_arch() before
> prefill_possible_map(), which will clear and then re-initialize
> __cpu_possible_mask.

I don't think it's needed before my change either, so I'd call
removing this an orthogonal change. As said in the commit
message, the goal was to leave this function alone as far as
possible.

Before my patch, xen_filter_cpu_maps() gets called long after
prefill_possible_map(), and by the purpose of the latter function
the possible map shouldn't be altered anymore once that has
run. Adding bits to it is surely not going to have the intended
effect (setup_per_cpu_areas() has already run), while removing
bits may have some effect, but comes too late at least for
setup_per_cpu_areas().

And if we were to remove this, I think the CONFIG_HOTPLUG_CPU
section should go away as well. After all prefill_possible_map()
also sets nr_cpu_ids. To be honest, it was largely this code
fragment which made me want not touch the function more than
necessary: The comment there makes not clear to me at all why
all of this needs to be in an #ifdef in the first place.

Let me know whether you really want me to fold this extra
cleanup into this patch. If so, I'd then wonder whether the
set_cpu_present() from xen_pv_smp_prepare_cpus() shouldn't
be moved here, too. And the fiddling with the possible map
there looks bogus as well: Bring-up of CPUs past the command
line option should be avoided at boot time, but they shouldn't
be excluded from getting brought up later on. Note how
native_smp_prepare_cpus() ignores its parameter altogether.

Jan



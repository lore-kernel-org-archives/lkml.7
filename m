Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25940C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CCD20842
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q6Vkdnnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfCAV17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 16:27:59 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32911 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCAV17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 16:27:59 -0500
Received: by mail-pg1-f195.google.com with SMTP id h11so12041765pgl.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 13:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=enNvwB0scpSS/1buCvD824SgQhmWeVv3YrCaXdZ6YVw=;
        b=Q6Vkdnnx86eUXJrEJx1rydKAQ5FH051EmCl1IxQ+tQNZlQNqEGW4mnx67xL5ibrVO+
         3IpeFIzZPpKWXUcxtxIZIdlRpB2ims2L0vk3OSObc1gQfAKucPLAm6nZZzn/wGYWjPRd
         9nEOJ9n3tTBcojAaL/ptKfeOpTd/WqOlJdLIkL74Ww+E/MXFpfNgywlM/SxYX6lYXToa
         f67Pz1EuHEvtPzTQEegZa1ZAXLjNEsz/+/9TE1aIYQmOF4PNCv8XwTsqNOx8ZZsACl2w
         qpesLXPn31Ce60woDs1KlkIuxriraeA8MGAl5o3VQAHQBdiKWgD2CThu1pvadSGL3wns
         dZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=enNvwB0scpSS/1buCvD824SgQhmWeVv3YrCaXdZ6YVw=;
        b=nNUirWXDpagkagSsXbzQEn9TZO/9f6Uqi8kSIXer0bob+x1welDinAECLQNjH87WGv
         fvXriz9+XHAxvWaAT1tqwsbeS/y3EaA69OE6KKjzVvjDgaY2MSq6rW+u5UVcR/stZjXu
         Jz10GC1u8WP9D1d1g2S6KZiyy3UlbO5yyHOoMggZPybSoHEToe7N908wv5LJ3Cblq32u
         V6f2JlObh3tIoWzh2GGCGu+vyxzFOHt84N5GmhGBQUI2hjiJ7dQtFnGZeOrvRqCY5Xpb
         LJ3/U077WNC27FZ6wZZDxem0lKfkhxvDMsQtJ1nrzKK6tyVfHKb9GQFefhbn4G7xIk87
         17Kw==
X-Gm-Message-State: APjAAAU11Ru1WO5VaF1HCVaN5Sodg+jvjm+kaMKTN1cn850EGLqGie1V
        wQx+urfTz2KCI4d52PoVd8UZbw==
X-Google-Smtp-Source: APXvYqyM04vXcfJZbXTzhdNpTFPnK2VJte139ICpkFnpX+5TO0q3B1qaVAqgnnhTLTuJsSQZrJn1Ug==
X-Received: by 2002:a65:6548:: with SMTP id a8mr6928475pgw.103.1551475677687;
        Fri, 01 Mar 2019 13:27:57 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id k27sm21334752pgb.70.2019.03.01.13.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 13:27:56 -0800 (PST)
Subject: Re: [PATCH] percpu/module resevation: change resevation size iff
 X86_VSMP is set
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Eial Czerwacki <eial@scalemp.com>, tj@kernel.org, cl@linux.com,
        linux-kernel@vger.kernel.org, Shai Fultheim <shai@scalemp.com>,
        Oren Twaig <oren@scalemp.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
References: <1548071251-1849-1-git-send-email-eial@scalemp.com>
 <a7eff2ed-0e80-edae-2a97-a3fdab2d05f5@google.com>
 <20190301203455.GA97188@dennisz-mbp.dhcp.thefacebook.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <c72402f2-967e-cd56-99d8-9139c9e7f267@google.com>
Date:   Fri, 1 Mar 2019 16:27:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190301203455.GA97188@dennisz-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

On 03/01/2019 03:34 PM, Dennis Zhou wrote:
> Hi Barret,
> 
> On Fri, Mar 01, 2019 at 01:30:15PM -0500, Barret Rhoden wrote:
>> Hi -
>>
>> On 01/21/2019 06:47 AM, Eial Czerwacki wrote:
>>>
>>
>> Your main issue was that you only sent this patch to LKML, but not the
>> maintainers of the file.  If you don't, your patch might get lost.  To get
>> the appropriate people and lists, run:
>>
>> 	scripts/get_maintainer.pl YOUR_PATCH.patch.
>>
>> For this patch, you'll get this:
>>
>> Dennis Zhou <dennis@kernel.org> (maintainer:PER-CPU MEMORY ALLOCATOR)
>> Tejun Heo <tj@kernel.org> (maintainer:PER-CPU MEMORY ALLOCATOR)
>> Christoph Lameter <cl@linux.com> (maintainer:PER-CPU MEMORY ALLOCATOR)
>> linux-kernel@vger.kernel.org (open list)
>>
>> I added the three maintainers to this email.
>>
>> I have a few minor comments below.
>>
>>> [PATCH] percpu/module resevation: change resevation size iff X86_VSMP is
>> set
>>
>> You misspelled 'reservation'.  Also, I'd just say: "percpu: increase module
>> reservation size if X86_VSMP is set".  ('change' -> 'increase'), only says
>> 'reservation' once.)
>>
>>> as reported in bug #201339 (https://bugzilla.kernel.org/show_bug.cgi?id=201339)
>>
>> I think you can add a tag for this right above your Signed-off-by tags.
>> e.g.:
>>
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201339
>>
>>> by enabling X86_VSMP, INTERNODE_CACHE_BYTES's definition differs from the default one
>>> causing the struct size to exceed the size ok 8KB.
>>                                              ^of
>>
>> Which struct are you talking about?  I have one in mind, but others might
>> not know from reading the commit message.
>>
>> I ran into this on https://bugzilla.kernel.org/show_bug.cgi?id=202511. In
>> that case, it was because modules (drm and amdkfd) were using DEFINE_SRCU,
>> which does a DEFINE_PER_CPU on struct srcu_data, and that used
>> ____cacheline_internodealigned_in_smp.
>>
>>>
>>> in order to avoid such issue, increse PERCPU_MODULE_RESERVE to 64KB if CONFIG_X86_VSMP is set.
>>                                 ^increase
>>
>>>
>>> the value was caculated on linux 4.20.3, make allmodconfig all and the following oneliner:
>>                 ^calculated
>>
>>> for f in `find -name *.ko`; do echo $f; readelf -S $f  |grep perc; done |grep data..percpu -B 1 |grep ko |while read r; do echo -n "$r: "; objdump --syms --section=.data..percpu $r|grep data |sort -n  |awk '{c++; d=strtonum("0x" $1) + strtonum("0x" $5); if (m < d) m = d;} END {printf("%d vars-> last addr 0x%x ( %d )\n", c, m, m)}' ; done |column -t |sort -k 8 -n | awk '{print $8}'| paste -sd+ | bc
>>
>> Not sure how useful the one-liner is, versus a description of what you're
>> doing.  i.e. "the size of all module percpu data sections, or something."
>>
>> Also, how close was that calculated value to 64K?  If more modules start
>> using DEFINE_SRCU, each of which uses 8K, then that 64K might run out.
>>
>> Thanks,
>> Barret
>>
>>> Signed-off-by: Eial Czerwacki <eial@scalemp.com>
>>> Signed-off-by: Shai Fultheim <shai@scalemp.com>
>>> Signed-off-by: Oren Twaig <oren@scalemp.com>
>>> ---
>>>    include/linux/percpu.h | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
>>> index 70b7123..6b79693 100644
>>> --- a/include/linux/percpu.h
>>> +++ b/include/linux/percpu.h
>>> @@ -14,7 +14,11 @@
>>>    /* enough to cover all DEFINE_PER_CPUs in modules */
>>>    #ifdef CONFIG_MODULES
>>> +#ifdef X86_VSMP
>>> +#define PERCPU_MODULE_RESERVE		(1 << 16)
>>> +#else
>>>    #define PERCPU_MODULE_RESERVE		(8 << 10)
>>> +#endif
>>>    #else
>>>    #define PERCPU_MODULE_RESERVE		0
>>>    #endif
>>>
>>
> 
> Thanks for sending this to me.
> 
> I must say, I really do not want to expand the reserved region. In most
> cases, it can easily end up unused and thus wasted memory as it is hard
> allocated on boot. This is done because code gen assumes static
> variables are close to the program counter. This would not be true with
> dynamic allocations which being at the end of the vmalloc area
> (Summarized from Tejun's account in [1]).
> 
> Another note on the reserved region. It starts at the end of the static
> region which means it generally isn't page aligned. So while an 8kb
> allocation would fit, a 4kb alignment more than likely would fail.
> Something as large as 8kb should probably be dynamically allocated as
> well.
 >
> I read through the bugzilla report and it seems that the culprits are:
>    drivers/gpu/drm/amd/amdkfd/kfd_process.c:DEFINE_SRCU(kfd_processes_srcu);
>    drivers/gpu/drm/drm_drv.c:DEFINE_STATIC_SRCU(drm_unplug_srcu);
> 
> Is there a reason we cannot dynamically initialize these structs? I've
> cced Paul McKenney because we saw an issue with ipmi in December [1].

I looked at the AMD driver, and it looks like they could dynamically 
initialize it.  It would require a little extra plumbing.  I imagine the 
DRM one is the same way.

To catch this in the future, should we disallow DEFINE_SRCU in modules 
or something?  Otherwise, this will pop up again the next time someone 
uses DEFINE_SRCU in a module and builds with CONFIG_X86_VSMP.

That might be a little much, and it still won't be sufficient to catch 
all cases.  This will also come up any time a module has a static 
per-cpu data structure that uses __cacheline_aligned_in_smp, so it's not 
limited to SRCU either.

I'm not familiar with VSMP - how bad is it to use L1 cache alignment 
instead of 4K page alignment?  Maybe some structures can use the smaller 
alignment?  Or maybe have VSMP require SRCU-using modules to be built-in?

Thanks,

Barret


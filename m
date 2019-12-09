Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C17C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CAB207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5VavvoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfLILLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:11:24 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35369 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727836AbfLILLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:11:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575889881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=czJgCCCl4yh/GkLiX85Au9Aj8Z8lAON4H5pQx5W/t8o=;
        b=X5VavvoACN/Y3arm08pXizDvNVJ9hiYP2Bqw8PN78Ga7KawTzxaOzLMv8ZBb+V/3qqLlbU
        KgFYKNy5XHxWRG9ZLAaLTk8mYsfL5HtqPy9OAhNjF0GhcoKV7OjZzrlRr7/bUwiEOUULJl
        R+n6OsK5yTmrWN9wMh8jQBJlmGSVpBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-mxayHfizP-yZlVUgZXwMiw-1; Mon, 09 Dec 2019 06:11:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEAE9107ACC4;
        Mon,  9 Dec 2019 11:11:16 +0000 (UTC)
Received: from [10.36.117.245] (ovpn-117-245.ams2.redhat.com [10.36.117.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04E0546;
        Mon,  9 Dec 2019 11:11:14 +0000 (UTC)
Subject: Re: [PATCH] mm/hotplug: Only respect mem= parameter during boot stage
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        william.kucharski@oracle.com, mingo@kernel.org,
        akpm@linux-foundation.org
References: <20191206150524.14687-1-bhe@redhat.com>
 <20191209100717.GC6156@dhcp22.suse.cz>
 <7fc610be-df56-c5ae-33fb-53b471aa76d1@suse.com>
 <94aead35-1541-6c1a-d172-70dc613410c2@redhat.com>
 <1089517e-4454-be5e-1320-7f246c4efefe@suse.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <43dbabf0-08c4-9780-af56-20b19b1a5866@redhat.com>
Date:   Mon, 9 Dec 2019 12:11:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1089517e-4454-be5e-1320-7f246c4efefe@suse.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: mxayHfizP-yZlVUgZXwMiw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.12.19 12:08, J=C3=BCrgen Gro=C3=9F wrote:
> On 09.12.19 12:01, David Hildenbrand wrote:
>> On 09.12.19 11:24, J=C3=BCrgen Gro=C3=9F wrote:
>>> On 09.12.19 11:07, Michal Hocko wrote:
>>>> On Fri 06-12-19 23:05:24, Baoquan He wrote:
>>>>> In commit 357b4da50a62 ("x86: respect memory size limiting via mem=3D
>>>>> parameter") a global varialbe global max_mem_size is added to store
>>>>> the value which is parsed from 'mem=3D '. This truly stops those
>>>>> DIMM from being added into system memory during boot.
>>>>>
>>>>> However, it also limits the later memory hotplug functionality. Any
>>>>> memory board can't be hot added any more if its region is beyond the
>>>>> max_mem_size. System will print error like below:
>>>>>
>>>>> [  216.387164] acpi PNP0C80:02: add_memory failed
>>>>> [  216.389301] acpi PNP0C80:02: acpi_memory_enable_device() error
>>>>> [  216.392187] acpi PNP0C80:02: Enumeration failure
>>>>>
>>>>> >From document of 'mem =3D' parameter, it should be a restriction dur=
ing
>>>>> boot, but not impact the system memory adding/removing after booting.
>>>>>
>>>>>     mem=3Dnn[KMG]     [KNL,BOOT] Force usage of a specific amount of =
memory
>>>>>
>>>>> So fix it by also checking if it's during SYSTEM_BOOTING stage when
>>>>> restrict memory adding. Otherwise, skip the restriction.
>>>>
>>>> Could you be more specific about why the boot vs. later hotplug makes
>>>> any difference? The documentation is explicit about the boot time but
>>>> considering this seems to be like that since ever I strongly suspect
>>>> that this is just an omission.
>>>>
>>>> Btw. how have you tested the situation fixed by 357b4da50a62?
>>>
>>> I guess he hasn't.
>>>
>>> The backtrace of the problem at that time was:
>>>
>>> [ 8321.876844]  [<ffffffff81019ab9>] dump_trace+0x59/0x340
>>> [ 8321.882683]  [<ffffffff81019e8a>] show_stack_log_lvl+0xea/0x170
>>> [ 8321.889298]  [<ffffffff8101ac31>] show_stack+0x21/0x40
>>> [ 8321.895043]  [<ffffffff81319530>] dump_stack+0x5c/0x7c
>>> [ 8321.900779]  [<ffffffff8107fbf1>] warn_slowpath_common+0x81/0xb0
>>> [ 8321.907482]  [<ffffffff81009f54>] xen_alloc_pte+0x1d4/0x390
>>> [ 8321.913718]  [<ffffffff81064950>]
>>> pmd_populate_kernel.constprop.6+0x40/0x80
>>> [ 8321.921498]  [<ffffffff815ef0a8>] phys_pmd_init+0x210/0x255
>>> [ 8321.927724]  [<ffffffff815ef2c7>] phys_pud_init+0x1da/0x247
>>> [ 8321.933951]  [<ffffffff815efb81>] kernel_physical_mapping_init+0xf5/=
0x1d4
>>> [ 8321.941533]  [<ffffffff815ebc7d>] init_memory_mapping+0x18d/0x380
>>> [ 8321.948341]  [<ffffffff810647f9>] arch_add_memory+0x59/0xf0
>>> [ 8321.954570]  [<ffffffff815eceed>] add_memory_resource+0x8d/0x160
>>> [ 8321.961283]  [<ffffffff815ecff2>] add_memory+0x32/0xf0
>>> [ 8321.967025]  [<ffffffff813e1c91>] acpi_memory_device_add+0x131/0x2e0
>>> [ 8321.974128]  [<ffffffff8139f752>] acpi_bus_attach+0xe2/0x190
>>> [ 8321.980453]  [<ffffffff8139f6ce>] acpi_bus_attach+0x5e/0x190
>>> [ 8321.986778]  [<ffffffff8139f6ce>] acpi_bus_attach+0x5e/0x190
>>> [ 8321.993103]  [<ffffffff8139f6ce>] acpi_bus_attach+0x5e/0x190
>>> [ 8321.999428]  [<ffffffff813a1157>] acpi_bus_scan+0x37/0x70
>>> [ 8322.005461]  [<ffffffff81fba955>] acpi_scan_init+0x77/0x1b4
>>> [ 8322.011690]  [<ffffffff81fba70c>] acpi_init+0x297/0x2b3
>>> [ 8322.017530]  [<ffffffff8100213a>] do_one_initcall+0xca/0x1f0
>>> [ 8322.023855]  [<ffffffff81f74266>] kernel_init_freeable+0x194/0x226
>>> [ 8322.030760]  [<ffffffff815eb1ba>] kernel_init+0xa/0xe0
>>> [ 8322.036503]  [<ffffffff815f7bc5>] ret_from_fork+0x55/0x80
>>>
>>> So this patch would break it again.
>>>
>>> I'd recommend ...
>>>
>>>>
>>>>> Fixes: 357b4da50a62 ("x86: respect memory size limiting via mem=3D pa=
rameter")
>>>>> Signed-off-by: Baoquan He <bhe@redhat.com>
>>>>> ---
>>>>>    mm/memory_hotplug.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>>>> index 55ac23ef11c1..5466a0a00901 100644
>>>>> --- a/mm/memory_hotplug.c
>>>>> +++ b/mm/memory_hotplug.c
>>>>> @@ -105,7 +105,7 @@ static struct resource *register_memory_resource(=
u64 start, u64 size)
>>>>>    =09unsigned long flags =3D  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUS=
Y;
>>>>>    =09char *resource_name =3D "System RAM";
>>>>>   =20
>>>>> -=09if (start + size > max_mem_size)
>>>>> +=09if (start + size > max_mem_size && system_state =3D=3D SYSTEM_BOO=
TING)
>>>
>>> ... changing this to: ... && system_state !=3D SYSTEM_RUNNING
>>
>> I think we usually use system_state < SYSTEM_RUNNING
>>
>=20
> Works for me as well. :-)
>=20

As this patch has to be resent, I'd also enjoy a comment explaining why
this special check is in place

/* Make sure memory hotplug works although mem=3D was specified */

or sth. like that :)

>=20
> Juergen
>=20


--=20
Thanks,

David / dhildenb


Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11691C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D122920726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlDiT0UL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfLJIEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:04:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45934 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726071AbfLJIEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:04:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575965061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dEcFPUgnLfk0OgFFb+OrSZaIOT1djGc+rDDJSgVmBvk=;
        b=FlDiT0UL8HRkDjnaM9oJ1XB+rdlI1+EwOyu1H6EuYBbVIEUeK+sct9/KxXLVaHMuZCKfGZ
        PJxOVvA5tU5lOruzPRCtaEeo+wYGpJZizj5Ty+EZgtYNI3Grp78SrGI36+jVI7jF1eb+F1
        kKsl4u1+clbDXQ50UxGpRgP3f2mNVIs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-PKuz4irqPaK1MMNCgcN8iw-1; Tue, 10 Dec 2019 03:04:18 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5EF9183B700;
        Tue, 10 Dec 2019 08:04:16 +0000 (UTC)
Received: from localhost (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08A60600D3;
        Tue, 10 Dec 2019 08:04:13 +0000 (UTC)
Date:   Tue, 10 Dec 2019 16:04:11 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>,
        =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        william.kucharski@oracle.com, mingo@kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/hotplug: Only respect mem= parameter during boot stage
Message-ID: <20191210080411.GJ2984@MiWiFi-R3L-srv>
References: <20191206150524.14687-1-bhe@redhat.com>
 <20191209100717.GC6156@dhcp22.suse.cz>
 <7fc610be-df56-c5ae-33fb-53b471aa76d1@suse.com>
 <94aead35-1541-6c1a-d172-70dc613410c2@redhat.com>
 <1089517e-4454-be5e-1320-7f246c4efefe@suse.com>
 <43dbabf0-08c4-9780-af56-20b19b1a5866@redhat.com>
MIME-Version: 1.0
In-Reply-To: <43dbabf0-08c4-9780-af56-20b19b1a5866@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: PKuz4irqPaK1MMNCgcN8iw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/19 at 12:11pm, David Hildenbrand wrote:
> On 09.12.19 12:08, J=FCrgen Gro=DF wrote:
> > On 09.12.19 12:01, David Hildenbrand wrote:
> >> On 09.12.19 11:24, J=FCrgen Gro=DF wrote:
> >>> On 09.12.19 11:07, Michal Hocko wrote:
> >>>> On Fri 06-12-19 23:05:24, Baoquan He wrote:
> >>>>> In commit 357b4da50a62 ("x86: respect memory size limiting via mem=
=3D
> >>>>> parameter") a global varialbe global max_mem_size is added to store
> >>>>> the value which is parsed from 'mem=3D '. This truly stops those
> >>>>> DIMM from being added into system memory during boot.
> >>>>>
> >>>>> However, it also limits the later memory hotplug functionality. Any
> >>>>> memory board can't be hot added any more if its region is beyond th=
e
> >>>>> max_mem_size. System will print error like below:
> >>>>>
> >>>>> [  216.387164] acpi PNP0C80:02: add_memory failed
> >>>>> [  216.389301] acpi PNP0C80:02: acpi_memory_enable_device() error
> >>>>> [  216.392187] acpi PNP0C80:02: Enumeration failure
> >>>>>
> >>>>> >From document of 'mem =3D' parameter, it should be a restriction d=
uring
> >>>>> boot, but not impact the system memory adding/removing after bootin=
g.
> >>>>>
> >>>>>     mem=3Dnn[KMG]     [KNL,BOOT] Force usage of a specific amount o=
f memory
> >>>>>
> >>>>> So fix it by also checking if it's during SYSTEM_BOOTING stage when
> >>>>> restrict memory adding. Otherwise, skip the restriction.
> >>>>
> >>>> Could you be more specific about why the boot vs. later hotplug make=
s
> >>>> any difference? The documentation is explicit about the boot time bu=
t
> >>>> considering this seems to be like that since ever I strongly suspect
> >>>> that this is just an omission.
> >>>>
> >>>> Btw. how have you tested the situation fixed by 357b4da50a62?
> >>>
> >>> I guess he hasn't.
> >>>
> >>> The backtrace of the problem at that time was:
> >>>
> >>> [ 8321.876844]  [<ffffffff81019ab9>] dump_trace+0x59/0x340
> >>> [ 8321.882683]  [<ffffffff81019e8a>] show_stack_log_lvl+0xea/0x170
> >>> [ 8321.889298]  [<ffffffff8101ac31>] show_stack+0x21/0x40
> >>> [ 8321.895043]  [<ffffffff81319530>] dump_stack+0x5c/0x7c
> >>> [ 8321.900779]  [<ffffffff8107fbf1>] warn_slowpath_common+0x81/0xb0
> >>> [ 8321.907482]  [<ffffffff81009f54>] xen_alloc_pte+0x1d4/0x390
> >>> [ 8321.913718]  [<ffffffff81064950>]
> >>> pmd_populate_kernel.constprop.6+0x40/0x80
> >>> [ 8321.921498]  [<ffffffff815ef0a8>] phys_pmd_init+0x210/0x255
> >>> [ 8321.927724]  [<ffffffff815ef2c7>] phys_pud_init+0x1da/0x247
> >>> [ 8321.933951]  [<ffffffff815efb81>] kernel_physical_mapping_init+0xf=
5/0x1d4
> >>> [ 8321.941533]  [<ffffffff815ebc7d>] init_memory_mapping+0x18d/0x380
> >>> [ 8321.948341]  [<ffffffff810647f9>] arch_add_memory+0x59/0xf0
> >>> [ 8321.954570]  [<ffffffff815eceed>] add_memory_resource+0x8d/0x160
> >>> [ 8321.961283]  [<ffffffff815ecff2>] add_memory+0x32/0xf0
> >>> [ 8321.967025]  [<ffffffff813e1c91>] acpi_memory_device_add+0x131/0x2=
e0
> >>> [ 8321.974128]  [<ffffffff8139f752>] acpi_bus_attach+0xe2/0x190
> >>> [ 8321.980453]  [<ffffffff8139f6ce>] acpi_bus_attach+0x5e/0x190
> >>> [ 8321.986778]  [<ffffffff8139f6ce>] acpi_bus_attach+0x5e/0x190
> >>> [ 8321.993103]  [<ffffffff8139f6ce>] acpi_bus_attach+0x5e/0x190
> >>> [ 8321.999428]  [<ffffffff813a1157>] acpi_bus_scan+0x37/0x70
> >>> [ 8322.005461]  [<ffffffff81fba955>] acpi_scan_init+0x77/0x1b4
> >>> [ 8322.011690]  [<ffffffff81fba70c>] acpi_init+0x297/0x2b3
> >>> [ 8322.017530]  [<ffffffff8100213a>] do_one_initcall+0xca/0x1f0
> >>> [ 8322.023855]  [<ffffffff81f74266>] kernel_init_freeable+0x194/0x226
> >>> [ 8322.030760]  [<ffffffff815eb1ba>] kernel_init+0xa/0xe0
> >>> [ 8322.036503]  [<ffffffff815f7bc5>] ret_from_fork+0x55/0x80
> >>>
> >>> So this patch would break it again.
> >>>
> >>> I'd recommend ...
> >>>
> >>>>
> >>>>> Fixes: 357b4da50a62 ("x86: respect memory size limiting via mem=3D =
parameter")
> >>>>> Signed-off-by: Baoquan He <bhe@redhat.com>
> >>>>> ---
> >>>>>    mm/memory_hotplug.c | 2 +-
> >>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> >>>>> index 55ac23ef11c1..5466a0a00901 100644
> >>>>> --- a/mm/memory_hotplug.c
> >>>>> +++ b/mm/memory_hotplug.c
> >>>>> @@ -105,7 +105,7 @@ static struct resource *register_memory_resourc=
e(u64 start, u64 size)
> >>>>>    =09unsigned long flags =3D  IORESOURCE_SYSTEM_RAM | IORESOURCE_B=
USY;
> >>>>>    =09char *resource_name =3D "System RAM";
> >>>>>   =20
> >>>>> -=09if (start + size > max_mem_size)
> >>>>> +=09if (start + size > max_mem_size && system_state =3D=3D SYSTEM_B=
OOTING)
> >>>
> >>> ... changing this to: ... && system_state !=3D SYSTEM_RUNNING
> >>
> >> I think we usually use system_state < SYSTEM_RUNNING
> >>
> >=20
> > Works for me as well. :-)
> >=20

Thanks for reviewing and suggestions, will correct it as
'system_state < SYSTEM_RUNNING'.=20

>=20
> As this patch has to be resent, I'd also enjoy a comment explaining why
> this special check is in place
>=20
> /* Make sure memory hotplug works although mem=3D was specified */
>=20
> or sth. like that :)

OK, will consider what is better to be placed here. Thanks.


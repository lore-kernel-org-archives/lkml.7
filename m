Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836C9C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DD420663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+R7jGIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfLJKnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:43:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35756 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726574AbfLJKnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575974593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p0+JwFDMZsyAdIm5iZQOsypIJdHkBPYWVLOBLKiChvk=;
        b=g+R7jGIZ2x4ztGC/+8sFaDP6TjPt0UcOIQiHZA4Id/zuwNZ/eJ5CnRvCA3KQYmdF1jY5x8
        wCjnhvjFa/dLpTQoD+hjCMDjE2nAYA5lgCcsUBU9vtCz18i9vq4ZfUUDXafFMFzPUj25/z
        hPqXtisGaxfy0OieKVW0n5W34g3VhSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-vQGtSDQ5Nn-OyTGmwJgrKA-1; Tue, 10 Dec 2019 05:43:08 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A75528024DD;
        Tue, 10 Dec 2019 10:43:06 +0000 (UTC)
Received: from localhost (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F39B75C1B0;
        Tue, 10 Dec 2019 10:43:05 +0000 (UTC)
Date:   Tue, 10 Dec 2019 18:43:03 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, jgross@suse.com,
        william.kucharski@oracle.com, mingo@kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/hotplug: Only respect mem= parameter during boot stage
Message-ID: <20191210104303.GN2984@MiWiFi-R3L-srv>
References: <20191206150524.14687-1-bhe@redhat.com>
 <20191209100717.GC6156@dhcp22.suse.cz>
 <20191210072453.GI2984@MiWiFi-R3L-srv>
 <20191210102834.GE10404@dhcp22.suse.cz>
MIME-Version: 1.0
In-Reply-To: <20191210102834.GE10404@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: vQGtSDQ5Nn-OyTGmwJgrKA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/19 at 11:28am, Michal Hocko wrote:
> On Tue 10-12-19 15:24:53, Baoquan He wrote:
> > On 12/09/19 at 11:07am, Michal Hocko wrote:
> > > On Fri 06-12-19 23:05:24, Baoquan He wrote:
> > > > In commit 357b4da50a62 ("x86: respect memory size limiting via mem=
=3D
> > > > parameter") a global varialbe global max_mem_size is added to store
> > > > the value which is parsed from 'mem=3D '. This truly stops those
> > > > DIMM from being added into system memory during boot.
> > > >=20
> > > > However, it also limits the later memory hotplug functionality. Any
> > > > memory board can't be hot added any more if its region is beyond th=
e
> > > > max_mem_size. System will print error like below:
> > > >=20
> > > > [  216.387164] acpi PNP0C80:02: add_memory failed
> > > > [  216.389301] acpi PNP0C80:02: acpi_memory_enable_device() error
> > > > [  216.392187] acpi PNP0C80:02: Enumeration failure
> > > >=20
> > > > >From document of 'mem =3D' parameter, it should be a restriction d=
uring
> > > > boot, but not impact the system memory adding/removing after bootin=
g.
> > > >=20
> > > >   mem=3Dnn[KMG]     [KNL,BOOT] Force usage of a specific amount of =
memory
> > > >=20
> > > > So fix it by also checking if it's during SYSTEM_BOOTING stage when
> > > > restrict memory adding. Otherwise, skip the restriction.
> > >=20
> > > Could you be more specific about why the boot vs. later hotplug makes
> > > any difference? The documentation is explicit about the boot time but
> > > considering this seems to be like that since ever I strongly suspect
> > > that this is just an omission.
> >=20
> > I think the 'mem=3D' updating in commit 357b4da50a62 will only affect
> > those hotplugable memory regions. When I tested it, there are three
> > memmory boards, one is the normal memory region with 4G memory, and the
> > other two are hotpluggable memory boards and recorded in ACPI tables,
> > each is 1GB. When put all them three onsite before boot, they will be
> > recognized by firmware and written into e820 table and/or EFI table, th=
en
> > kernel can read them from e820 and them as system memory, we get 6G
> > memory.=20
> >=20
> > However, if add 'mem=3D', like 'mme=3D3G', w/o commit 357b4da50a62, in =
e820,
> > we will only get 3G memory. Later in acpi_init(), acpi scanning will
> > search those two memory regions, and try to add them into system call
> > because the two hotpluggable memory boards are power on and ready.
> > Then we will get 3G + 1G + 1G, 5G memory. the 1st 3G is from the normal
> > memory board, its last 1G is trimmed. Jurgen's patch is trying to fix t=
his
> > because the adding happens during boot time, and conflicts with 'mem=3D=
'.=20
>=20
> Unless I misunderstand what you are saying this all is just expected.
> You have restricted the memory explicitly and the result is that not all
> the memory is visible.

Yes.

>=20
> > But after system bootup, we should be able to hot add/remove any memory
> > board. This should not be restricted by a boot-time kernel parameter
> > 'mme=3D'. This is what I am trying to fix.
>=20
> This is a simple statement without any actual explanation on why. Why is
> hotplug memory special? What is the usecase? Who would want to use mem
> parameter and later expect a memory above the restrected area to be
> hotplugable?

The why is 'mem=3D' is used to restrict the amount of system ram during
boot. We have two ways to add system memory, one is installing DIMMs
before boot, the other is hot adding memory after boot. Without David's=20
use case, we may need redefine 'mem=3D' and change its documentation in
kernel-parameters.txt, if we don't want to fix it like this. Otherwise,
'mem=3D' will limit the system's upper system ram always, that is not
expected.

>=20
> David has provided an actual usecase [1] but this needs to be documented
> somewhere so that we do not break that accidentally in the future.
> Ideally both in code which adds the boot restriction and the kernel
> command line documentation to be explicit about BOOT restriction.
>=20
> [1] http://lkml.kernel.org/r/429622cf-f0f4-5d80-d39d-b0d8a6c6605f@redhat.=
com

Yes, agree. As I replied in the v2 thread, I will add that into log, and
also will change text of 'mem=3D' in kernel-parameters.txt.

Thanks
Baoquan


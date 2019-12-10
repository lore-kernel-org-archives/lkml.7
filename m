Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F86C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7117206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZetcH8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfLJHZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 02:25:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35077 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726819AbfLJHZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 02:25:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575962701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bTEqvCuRO5f0LeaSsAdHDKQ/6wgoQTfNdU+DfN0Dg3g=;
        b=hZetcH8+lkTakU56ILvruf9IvqjV6ZsfF6e36oF+g+3NFTRTXibj+9v3/uJV5Q/JDewbAS
        VldybIVfFzCGG+8hp78V7DpchkvF7sa7oPg3IfmknZVSuJpNCEqbkLHpJIU0yB/p3IlwRa
        jn02nkWT94tMRB+aTYQxJ1z4IUTcysM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-Xzp9NbVqPCSP8E0P-v5vuA-1; Tue, 10 Dec 2019 02:24:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0108107ACE3;
        Tue, 10 Dec 2019 07:24:56 +0000 (UTC)
Received: from localhost (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DDC460562;
        Tue, 10 Dec 2019 07:24:55 +0000 (UTC)
Date:   Tue, 10 Dec 2019 15:24:53 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, jgross@suse.com,
        william.kucharski@oracle.com, mingo@kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/hotplug: Only respect mem= parameter during boot stage
Message-ID: <20191210072453.GI2984@MiWiFi-R3L-srv>
References: <20191206150524.14687-1-bhe@redhat.com>
 <20191209100717.GC6156@dhcp22.suse.cz>
MIME-Version: 1.0
In-Reply-To: <20191209100717.GC6156@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Xzp9NbVqPCSP8E0P-v5vuA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/19 at 11:07am, Michal Hocko wrote:
> On Fri 06-12-19 23:05:24, Baoquan He wrote:
> > In commit 357b4da50a62 ("x86: respect memory size limiting via mem=3D
> > parameter") a global varialbe global max_mem_size is added to store
> > the value which is parsed from 'mem=3D '. This truly stops those
> > DIMM from being added into system memory during boot.
> >=20
> > However, it also limits the later memory hotplug functionality. Any
> > memory board can't be hot added any more if its region is beyond the
> > max_mem_size. System will print error like below:
> >=20
> > [  216.387164] acpi PNP0C80:02: add_memory failed
> > [  216.389301] acpi PNP0C80:02: acpi_memory_enable_device() error
> > [  216.392187] acpi PNP0C80:02: Enumeration failure
> >=20
> > >From document of 'mem =3D' parameter, it should be a restriction durin=
g
> > boot, but not impact the system memory adding/removing after booting.
> >=20
> >   mem=3Dnn[KMG]     [KNL,BOOT] Force usage of a specific amount of memo=
ry
> >=20
> > So fix it by also checking if it's during SYSTEM_BOOTING stage when
> > restrict memory adding. Otherwise, skip the restriction.
>=20
> Could you be more specific about why the boot vs. later hotplug makes
> any difference? The documentation is explicit about the boot time but
> considering this seems to be like that since ever I strongly suspect
> that this is just an omission.

I think the 'mem=3D' updating in commit 357b4da50a62 will only affect
those hotplugable memory regions. When I tested it, there are three
memmory boards, one is the normal memory region with 4G memory, and the
other two are hotpluggable memory boards and recorded in ACPI tables,
each is 1GB. When put all them three onsite before boot, they will be
recognized by firmware and written into e820 table and/or EFI table, then
kernel can read them from e820 and them as system memory, we get 6G
memory.=20

However, if add 'mem=3D', like 'mme=3D3G', w/o commit 357b4da50a62, in e820=
,
we will only get 3G memory. Later in acpi_init(), acpi scanning will
search those two memory regions, and try to add them into system call
because the two hotpluggable memory boards are power on and ready.
Then we will get 3G + 1G + 1G, 5G memory. the 1st 3G is from the normal
memory board, its last 1G is trimmed. Jurgen's patch is trying to fix this
because the adding happens during boot time, and conflicts with 'mem=3D'.=
=20

But after system bootup, we should be able to hot add/remove any memory
board. This should not be restricted by a boot-time kernel parameter
'mme=3D'. This is what I am trying to fix.

>=20
> Btw. how have you tested the situation fixed by 357b4da50a62?

I just focused on the testing of the hotplug after booting, missed this
one. Sorry for the confusion.

Thanks
Baoquan


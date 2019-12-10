Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BAAC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3591208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f09E4U11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfLJKLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:11:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60237 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727083AbfLJKLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575972670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7uDmVcUZEiwaQGzEN8078B6vVZy0xcpZ3vyIXP24O5w=;
        b=f09E4U11NY0lAJxvEv4pSfFdAuoppMvXbpufO76bnUFakiPitn7knlGoHPcUnXO3OnFtHa
        J3ZwhTaTCNs9gOx+zCHLAkI2paVwalb9R+lM8R6VUSjJY+Uh9eEb5zQjau/5xySyul4xBz
        hz0ntyPbKcySH1SWqXHaN+8Nby+q3Zs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-l9AOL3DMMBiiuOZVNtLWUw-1; Tue, 10 Dec 2019 05:11:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75B2B18AAFA1;
        Tue, 10 Dec 2019 10:11:06 +0000 (UTC)
Received: from localhost (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42ED360561;
        Tue, 10 Dec 2019 10:11:03 +0000 (UTC)
Date:   Tue, 10 Dec 2019 18:11:00 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jgross@suse.com,
        akpm@linux-foundation.org
Subject: Re: [Patch v2] mm/hotplug: Only respect mem= parameter during boot
 stage
Message-ID: <20191210101100.GM2984@MiWiFi-R3L-srv>
References: <20191210084413.21957-1-bhe@redhat.com>
 <75188d0f-c609-5417-aa2e-354e76b7ba6e@gmail.com>
 <429622cf-f0f4-5d80-d39d-b0d8a6c6605f@redhat.com>
 <20191210095002.GA10404@dhcp22.suse.cz>
MIME-Version: 1.0
In-Reply-To: <20191210095002.GA10404@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: l9AOL3DMMBiiuOZVNtLWUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/19 at 10:50am, Michal Hocko wrote:
> On Tue 10-12-19 10:36:19, David Hildenbrand wrote:
> > On 10.12.19 10:24, Balbir Singh wrote:
> > >=20
> > >=20
> > > On 10/12/19 7:44 pm, Baoquan He wrote:
> > >> In commit 357b4da50a62 ("x86: respect memory size limiting via mem=
=3D
> > >> parameter") a global varialbe global max_mem_size is added to store
> > >                   typo ^^^
> > >> the value parsed from 'mem=3D ', then checked when memory region is
> > >> added. This truly stops those DIMM from being added into system memo=
ry
> > >> during boot-time.
> > >>
> > >> However, it also limits the later memory hotplug functionality. Any
> > >> memory board can't be hot added any more if its region is beyond the
> > >> max_mem_size. System will print error like below:
> > >>
> > >> [  216.387164] acpi PNP0C80:02: add_memory failed
> > >> [  216.389301] acpi PNP0C80:02: acpi_memory_enable_device() error
> > >> [  216.392187] acpi PNP0C80:02: Enumeration failure
> > >>
> > >> From document of 'mem=3D ' parameter, it should be a restriction dur=
ing
> > >> boot, but not impact the system memory adding/removing after booting=
.
> > >>
> > >>   mem=3Dnn[KMG]     [KNL,BOOT] Force usage of a specific amount of m=
emory
> > >> =09          ...
> > >>
> > >> So fix it by also checking if it's during boot-time when restrict me=
mory
> > >> adding. Otherwise, skip the restriction.
> > >>
> > >=20
> > > The fix looks reasonable, but I don't get the use case. Booting with =
mem=3D is
> > > generally a debug option, is this for debugging memory hotplug + limi=
ted memory?
> >=20
> > Some people/companies use "mem=3D" along with KVM e.g., to avoid
> > allocating memmaps for guest backing memory and to not expose it to the
> > buddy across kexec's. The excluded physical memory is then memmap into
> > the hypervisor process and KVM can deal with that. I can imagine that
> > hotplug might be desirable as well for such use cases.
>=20
> If this is really the usecase (it makes some sense to me) then it should
> be folded into the changelog. Because the real semantic is not really
> clear as I've pointed out in the previous version of this patch [1].
> The restriction to BOOT is documented since ever long before the memory
> hotplug was a thing.

I will hold a while and post v3 to take this into log.

>=20
> [1] Btw. it would have been much better if you posted the version 2 only
> after all the feedback got discussed properly.

You could have replied to wrong person.=20

I don't know the use case David told. My motivation was to make memory hotp=
lug
not impacted after boot. I thought I have got your question and answered
it. I will wait a little longer when post next time.

Thanks
Baoquan


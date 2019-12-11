Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0405C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FCF2464B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfMpm+5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfLKNU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:20:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54267 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728976AbfLKNUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576070425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=61Sm77wHsqBMMFdZKARKxx8aSpgfgeBKIFR7CjGK+3w=;
        b=BfMpm+5AzaDindQjQk1W1JJYvKOK5EznNoF7YF1386QuZdiXBAcf1Xao2AvN8FhAZuLGGJ
        LfMkunTEwMjXifNxjYF6iqZMlY460l9LyH75v450gwNvtWMwbaKLQ5CpmQdZi7GGCGtspe
        8JcSiOy8NEDWsxLT1S6kPoaPYSqpKTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-NGbFWe4PN1mC_x--I1LrmQ-1; Wed, 11 Dec 2019 08:20:22 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EE68DB21;
        Wed, 11 Dec 2019 13:20:20 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A9A6B1001902;
        Wed, 11 Dec 2019 13:20:19 +0000 (UTC)
Date:   Wed, 11 Dec 2019 21:20:17 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, jgross@suse.com,
        william.kucharski@oracle.com, mingo@kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/hotplug: Only respect mem= parameter during boot stage
Message-ID: <20191211132017.GC28917@MiWiFi-R3L-srv>
References: <20191206150524.14687-1-bhe@redhat.com>
 <20191209100717.GC6156@dhcp22.suse.cz>
 <20191210072453.GI2984@MiWiFi-R3L-srv>
 <20191210102834.GE10404@dhcp22.suse.cz>
 <20191210104303.GN2984@MiWiFi-R3L-srv>
 <20191210113341.GG10404@dhcp22.suse.cz>
 <20191210125557.GA28917@MiWiFi-R3L-srv>
 <20191210133202.GJ10404@dhcp22.suse.cz>
 <20191210140534.GB28917@MiWiFi-R3L-srv>
 <20191210141934.GL10404@dhcp22.suse.cz>
MIME-Version: 1.0
In-Reply-To: <20191210141934.GL10404@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: NGbFWe4PN1mC_x--I1LrmQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/19 at 03:19pm, Michal Hocko wrote:
> On Tue 10-12-19 22:05:34, Baoquan He wrote:
> > On 12/10/19 at 02:32pm, Michal Hocko wrote:
> > > On Tue 10-12-19 20:55:57, Baoquan He wrote:
> > > [...]
> > > > Btw, as you said at above, I am confused by the '[KNL,BOOT]', what =
does
> > > > the 'BOOT' mean in the documentation of 'mem=3D'? I checked all par=
ameters
> > > > with 'BOOT', still don't get it clearly.
> > >=20
> > > This is a good question indeed. I have checked closer and this is wha=
t
> > > documentation says
> > > Documentation/admin-guide/kernel-parameters.rst
> > > "
> > >         BOOT    Is a boot loader parameter.
> > >=20
> > > Parameters denoted with BOOT are actually interpreted by the boot
> > > loader, and have no meaning to the kernel directly.
> > > "
> > >=20
> > > and that really doesn't fit, right? So I went to check the full histo=
ry
> > > git tree just to get to 2.4.0-test5 and no explanation whatsoever.
> > > Fun, isn't it? ;)
> >=20
> > Yeah, very interesting. Finally I got their original purpose from
> > Documentation/x86/boot.rst.
> >=20
> >=20
> > Special Command Line Options
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >=20
> > If the command line provided by the boot loader is entered by the
> > user, the user may expect the following command line options to work.
> > They should normally not be deleted from the kernel command line even
> > though not all of them are actually meaningful to the kernel.  Boot
> > loader authors who need additional command line options for the boot
> > loader itself should get them registered in
> > Documentation/admin-guide/kernel-parameters.rst to make sure they will =
not
> > conflict with actual kernel options now or in the future.
> >=20
> > ...
> >=20
> > So here, [KNL,BOOT], KNL means it's used for kernel, BOOT means it's
> > needed by boot loader.
>=20
> OK, that clarifies this a bit. Thanks for referencing to it!
> That should explain how the behavior is not boot time restricted at all
> and the current implementation is actually correct. So a change to it
> should clearly state the new usecase as we have already discussed. In
> case there are bootloaders which really rely on the original strict
> meaning then we should be able to compare cost/benfits of those two
> usecases.

Sounds reasonable to me. From the current parameters for x86, it only
impact the bootloader during boot-time, e.g 'mem=3D ' says bootloader need
this to place initrd. It might not give the trouble, anyway, we will
say.

Just a little more, we have test case for memory hotplug which only test
the DIMM added after boot. And the old 'mem=3D ' implementation in x86
only erazes memory regions above 'mem=3D ' in e820 table. That is why the
behaviour change immediately gave me a surprise when I noticed people
back ported Jurgen's patch to our distros.=20

So glad to see all is clear, thanks.


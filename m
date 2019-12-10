Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B35C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBDC20838
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Olq65x8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfLJM4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:56:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54297 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727131AbfLJM4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575982565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=voBFuLhBnq3shzi9hcSX1u7zwHkQUZ0Y0JRPiC6qMKE=;
        b=Olq65x8TGmYDknPKM1BN0jTLNWJuO6Gy5yIL9EPahEu98zoB17g/iMVTqHl/lBSX6PgT4M
        u/G1aawr/LRP03p/klcN9Z0KSf+s6eyIaUkg5aoNZouz6QmtO8pOa5Bms1Gt4f3c3ZSH4T
        X16Zvmnfcgipz8nFi0LWJ73MhSwu1k0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-nFjQcfFPPB6VN-5yM26yVQ-1; Tue, 10 Dec 2019 07:56:02 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40C92593DF;
        Tue, 10 Dec 2019 12:56:01 +0000 (UTC)
Received: from localhost (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7351E5EE0F;
        Tue, 10 Dec 2019 12:56:00 +0000 (UTC)
Date:   Tue, 10 Dec 2019 20:55:57 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, jgross@suse.com,
        william.kucharski@oracle.com, mingo@kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/hotplug: Only respect mem= parameter during boot stage
Message-ID: <20191210125557.GA28917@MiWiFi-R3L-srv>
References: <20191206150524.14687-1-bhe@redhat.com>
 <20191209100717.GC6156@dhcp22.suse.cz>
 <20191210072453.GI2984@MiWiFi-R3L-srv>
 <20191210102834.GE10404@dhcp22.suse.cz>
 <20191210104303.GN2984@MiWiFi-R3L-srv>
 <20191210113341.GG10404@dhcp22.suse.cz>
MIME-Version: 1.0
In-Reply-To: <20191210113341.GG10404@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: nFjQcfFPPB6VN-5yM26yVQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/19 at 12:33pm, Michal Hocko wrote:
> On Tue 10-12-19 18:43:03, Baoquan He wrote:
> > On 12/10/19 at 11:28am, Michal Hocko wrote:
> > > On Tue 10-12-19 15:24:53, Baoquan He wrote:
> [...]
> > > > But after system bootup, we should be able to hot add/remove any me=
mory
> > > > board. This should not be restricted by a boot-time kernel paramete=
r
> > > > 'mme=3D'. This is what I am trying to fix.
> > >=20
> > > This is a simple statement without any actual explanation on why. Why=
 is
> > > hotplug memory special? What is the usecase? Who would want to use me=
m
> > > parameter and later expect a memory above the restrected area to be
> > > hotplugable?
> >=20
> > The why is 'mem=3D' is used to restrict the amount of system ram during
> > boot. We have two ways to add system memory, one is installing DIMMs
> > before boot, the other is hot adding memory after boot. Without David's=
=20
> > use case, we may need redefine 'mem=3D' and change its documentation in
> > kernel-parameters.txt, if we don't want to fix it like this. Otherwise,
> > 'mem=3D' will limit the system's upper system ram always, that is not
> > expected.
>=20
> I really do not see why. It seems a pretty consistent behavior to me.
> Because it essentially cut any memory above the given size. If a new
> hotplugable memory fits into that cap then it just shows up. Quite
> contrary I would consider it unexpected that a memory higher than the
> given mem=3DXYZ is really there. But I do recognize a real usecase
> mentioned elsewhere which beats the consistency argument here because
> all setups where such a restriction would be really important are
> debugging/workaround AFAICS.

All right. There could be me who have this misunderstanding.=20

Anyway, I think now we all agree it's only a boot-time restriction on
the system RAM.

Btw, as you said at above, I am confused by the '[KNL,BOOT]', what does
the 'BOOT' mean in the documentation of 'mem=3D'? I checked all parameters
with 'BOOT', still don't get it clearly.

Thanks
Baoquan


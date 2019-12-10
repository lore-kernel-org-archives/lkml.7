Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C65C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16B820652
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLjkWXF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfLJOFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:05:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43312 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727131AbfLJOFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575986743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SOYnZuCbc+qSbe4PVmdcAeY7lsD1liv9hGkxVuOBR+k=;
        b=iLjkWXF2tkSUuTegqgPuvaIsHgJI9qYuoPoRv5i0tBXbe8upa8IreRscCcLzRj85oCSiwm
        S/0OzqHFfs/Urpw9McIsprRxUA1mCZRe7DLyRE2pXFkEPP2bhes6/UFzExfsuMn0rFqo6N
        exaeHRu412IQP5hP+y+LcnbKXCRBZtA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-BlQbeN4EOXuXUKazet-nYw-1; Tue, 10 Dec 2019 09:05:39 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13ACC1800D45;
        Tue, 10 Dec 2019 14:05:38 +0000 (UTC)
Received: from localhost (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F2D3605C9;
        Tue, 10 Dec 2019 14:05:37 +0000 (UTC)
Date:   Tue, 10 Dec 2019 22:05:34 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, jgross@suse.com,
        william.kucharski@oracle.com, mingo@kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/hotplug: Only respect mem= parameter during boot stage
Message-ID: <20191210140534.GB28917@MiWiFi-R3L-srv>
References: <20191206150524.14687-1-bhe@redhat.com>
 <20191209100717.GC6156@dhcp22.suse.cz>
 <20191210072453.GI2984@MiWiFi-R3L-srv>
 <20191210102834.GE10404@dhcp22.suse.cz>
 <20191210104303.GN2984@MiWiFi-R3L-srv>
 <20191210113341.GG10404@dhcp22.suse.cz>
 <20191210125557.GA28917@MiWiFi-R3L-srv>
 <20191210133202.GJ10404@dhcp22.suse.cz>
MIME-Version: 1.0
In-Reply-To: <20191210133202.GJ10404@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: BlQbeN4EOXuXUKazet-nYw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/19 at 02:32pm, Michal Hocko wrote:
> On Tue 10-12-19 20:55:57, Baoquan He wrote:
> [...]
> > Btw, as you said at above, I am confused by the '[KNL,BOOT]', what does
> > the 'BOOT' mean in the documentation of 'mem=3D'? I checked all paramet=
ers
> > with 'BOOT', still don't get it clearly.
>=20
> This is a good question indeed. I have checked closer and this is what
> documentation says
> Documentation/admin-guide/kernel-parameters.rst
> "
>         BOOT    Is a boot loader parameter.
>=20
> Parameters denoted with BOOT are actually interpreted by the boot
> loader, and have no meaning to the kernel directly.
> "
>=20
> and that really doesn't fit, right? So I went to check the full history
> git tree just to get to 2.4.0-test5 and no explanation whatsoever.
> Fun, isn't it? ;)

Yeah, very interesting. Finally I got their original purpose from
Documentation/x86/boot.rst.


Special Command Line Options
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

If the command line provided by the boot loader is entered by the
user, the user may expect the following command line options to work.
They should normally not be deleted from the kernel command line even
though not all of them are actually meaningful to the kernel.  Boot
loader authors who need additional command line options for the boot
loader itself should get them registered in
Documentation/admin-guide/kernel-parameters.rst to make sure they will not
conflict with actual kernel options now or in the future.

...

So here, [KNL,BOOT], KNL means it's used for kernel, BOOT means it's
needed by boot loader.

I think we should at least add a note in kernel-parameters.txt to
explain this. Will add it.

Thanks
Baoquan


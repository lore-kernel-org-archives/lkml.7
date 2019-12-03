Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C85C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A1C20661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYc5/Chk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfLCPYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:24:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38090 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726024AbfLCPYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 10:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575386663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A0z0yQVPqG29ag0+Ol/YyJZXC41RYLDBg10RcYmTD30=;
        b=SYc5/Chkz0Ja0RY67M0/PQA6fSb/4CMX1D7lrlaeq2sD3vU/+/oAox+TcCNzJaf6vj7Twt
        Lvw5fA2ZL3ckI8Pv1ipfYZH7BhZ/DPSsxji56SjhCc/2s+oPovQWlQEOaVqGi9eNRqzBa/
        Tp2vcajCxpFuKS1R8A3wzm/knCs//q8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-VViTfyV5NWy7UWI2A6Fhtw-1; Tue, 03 Dec 2019 10:17:12 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D51612A7E21;
        Tue,  3 Dec 2019 15:17:10 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA8D060C18;
        Tue,  3 Dec 2019 15:17:09 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id xB3FH9uX006546;
        Tue, 3 Dec 2019 10:17:09 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id xB3FH8mW006536;
        Tue, 3 Dec 2019 10:17:08 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 3 Dec 2019 10:17:08 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Daniel Axtens <dja@axtens.net>,
        Michael Neuling <mikey@neuling.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tty crash in Linux 4.6
In-Reply-To: <20191116093614.GB408484@kroah.com>
Message-ID: <alpine.LRH.2.02.1912031016030.6365@file01.intranet.prod.int.rdu2.redhat.com>
References: <573A5996.3080305@hurleysoftware.com> <573B3F84.5050201@hurleysoftware.com> <573B5E4C.8030808@hurleysoftware.com> <alpine.LRH.2.02.1607071855150.19053@file01.intranet.prod.int.rdu2.redhat.com> <CAEjGV6zRghiCCMC1+-n+YPeA0Lrq=-vcvdoYpbwE4G=TXWzY3Q@mail.gmail.com>
 <87po3wusq1.fsf@linkitivity.dja.id.au> <20180322140554.GA3273@kroah.com> <alpine.LRH.2.02.1803270818150.30055@file01.intranet.prod.int.rdu2.redhat.com> <87k1td913u.fsf@linkitivity.dja.id.au> <d8ba132f-e174-2acc-e74c-4e9aed945c30@oracle.com>
 <20191116093614.GB408484@kroah.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: VViTfyV5NWy7UWI2A6Fhtw-1
X-Mimecast-Spam-Score: 0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Nov 2019, Greg Kroah-Hartman wrote:

> On Fri, Nov 15, 2019 at 11:21:08AM -0800, Mike Kravetz wrote:
> > On 4/11/18 9:09 AM, Daniel Axtens wrote:
> > > Mikulas Patocka <mpatocka@redhat.com> writes:
> > >=20
> > >> On Thu, 22 Mar 2018, Greg Kroah-Hartman wrote:
> > >>
> > >>> On Fri, Mar 23, 2018 at 12:48:06AM +1100, Daniel Axtens wrote:
> > >>>> Hi,
> > >>>>
> > >>>>>> This patch works, I've had no tty crashes since applying it.
> > >>>>>>
> > >>>>>> I've seen that you haven't sent this patch yet to Linux-4.7-rc a=
nd
> > >>>>>> Linux-4.6-stable. Will you? Or did you create a different patch?
> > >>>>>
> > >>>>> We are hitting this now on powerpc.  This patch never seemed to m=
ake
> > >>>>> it upstream (drivers/tty/tty_ldisc.c hasn't been touched in 1 yea=
r).
> > >>>>
> > >>>> I seem to be hitting this too on a kernel that has the 4.6 changes
> > >>>> backported to 4.4.
> > >>>>
> > >>>> Has there been any further progress on getting this accepted?
> > >>>
> > >>> Can you try applying 28b0f8a6962a ("tty: make n_tty_read() always a=
bort
> > >>> if hangup is in progress") to see if that helps out or not?
> > >=20
> > > Sorry for the delay in getting the test results; as with Mikulas,
> > > 28b0f8a6962a does not help.
> > >=20
> > > Regards,
> > > Daniel
> > >=20
> > >>>
> > >>> thanks,
> > >>>
> > >>> greg k-h
> > >>
> > >> It doesn't help. I get the same crash as before.
> > >>
> > >> Mikulas
> >=20
> > Reviving a really old thread.
> >=20
> > It looks like this patch never got merged.
>=20
> I do not see a patch in this email, so I have no idea what you are
> referring to, sorry.
>=20
> > Did it get resolved in some other way?  I ask because we have a
> > customer who seems to have hit this issue.
>=20
> Can you try with the latest kernel to see if it is resolved or not?

I tested it on the kernel 5.4 and I couldn't reproduce the crash anymore.

Mikulas

> thanks,
>=20
> greg k-h
>=20


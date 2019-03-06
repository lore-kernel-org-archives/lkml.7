Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755B3C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421DC20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfCFPbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:31:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47390 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbfCFPbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:31:33 -0500
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1h1YW2-0003Jm-Df
        for linux-kernel@vger.kernel.org; Wed, 06 Mar 2019 15:31:30 +0000
Received: by mail-ed1-f69.google.com with SMTP id y26so6556961edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 07:31:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version;
        bh=7ToVMIeJrVpQWSTL3UBmYh9PQUW1FXYHUOWi8xqD3Rs=;
        b=KiGecVZwA+e4ORobU16RWuLh0VOSf99fye+AkYbYeK3WySKpZGF4IzwFDW10J+3U5v
         8XBj0bjzCQZxl/ZYiNvrpnggerX5YoGSbQb6Ns9GLOyod5Qu7Dgxb5s83Cpw43TpQNID
         qGWqug04dWJdnwQxHSKEHpugr+h0ZU6JoXl214y4ZsUehfdnpTRpp7is1zzs2v+nB0EE
         B1Oi4F+Sg4BCqh1CZqMRIAP1mSuTZI0vPsBwgKziVC3XSwAoxRmKGMzJ7/GDFHbgBJP0
         2j8hLAiFeHx77PAioK2+dQFTCiRtXHdE8YX5GvC8wXAoHEchGGTeyTohXHwc+tDHl9wM
         lWvg==
X-Gm-Message-State: APjAAAUIE/O3sZIHEEiPT+jSaVkFLCC7upcDTbhEv6yusj+XpUIC7dnb
        X7cBqmybtlwgT6WQRR4Ob7A0ZiJ8nrcLWidlFKzpaWC+EqduRvv2x9AOyIrhM4Njn8jF8P7YWNl
        z5oij8+tho0s++PJysMDxuszgTg9OgJNZU+LUdS6VuA==
X-Received: by 2002:a17:906:3c3:: with SMTP id c3mr4212806eja.181.1551886289751;
        Wed, 06 Mar 2019 07:31:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqyG4+MUXTtBjZQYu5aTTuR2Wd46qHejyQrdojzRE2PlAJdGfbMfjipNnjt5/oQG7z4uFslDPA==
X-Received: by 2002:a17:906:3c3:: with SMTP id c3mr4212782eja.181.1551886289395;
        Wed, 06 Mar 2019 07:31:29 -0800 (PST)
Received: from gollum ([81.221.192.120])
        by smtp.gmail.com with ESMTPSA id gq12sm390299ejb.21.2019.03.06.07.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 07:31:28 -0800 (PST)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
Date:   Wed, 6 Mar 2019 16:31:26 +0100
To:     Joe Stringer <joe@ovn.org>
Cc:     Christian Ehrhardt <christian.ehrhardt@canonical.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        James Page <james.page@canonical.com>,
        Pravin Shelar <pshelar@ovn.org>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        "<dev@openvswitch.org>" <dev@openvswitch.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jarno Rajahalme <jarno@ovn.org>
Subject: Re: [ovs-dev] openvswitch crash on i386
Message-ID: <20190306163126.00483bdf@gollum>
In-Reply-To: <CAOftzPjJnBdHWgArGRhkSnQrqmUKvhxkO_eLth61-HEfZiAHUw@mail.gmail.com>
References: <20190305104010.6342e9b9@gollum>
        <CAATJJ0KgvC-j2egtq6G5M0jK5O04-xATEu_yDLvr53tJdFEzrQ@mail.gmail.com>
        <CAOftzPjJnBdHWgArGRhkSnQrqmUKvhxkO_eLth61-HEfZiAHUw@mail.gmail.com>
Organization: Canonical Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_//KcPt1lZ=Bv+qqUyJH+aIQm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//KcPt1lZ=Bv+qqUyJH+aIQm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Mar 2019 11:58:42 -0800
Joe Stringer <joe@ovn.org> wrote:

> On Tue, Mar 5, 2019 at 2:12 AM Christian Ehrhardt
> <christian.ehrhardt@canonical.com> wrote:
> >
> > On Tue, Mar 5, 2019 at 10:58 AM Juerg Haefliger
> > <juerg.haefliger@canonical.com> wrote: =20
> > >
> > > Hi,
> > >
> > > Running the following commands in a loop will crash an i386 5.0 kernel
> > > typically within a few iterations:
> > >
> > > ovs-vsctl add-br test
> > > ovs-vsctl del-br test
> > >
> > > [  106.215748] BUG: unable to handle kernel paging request at e8a35f3b
> > > [  106.216733] #PF error: [normal kernel read fault]
> > > [  106.217464] *pdpt =3D 0000000019a76001 *pde =3D 0000000000000000
> > > [  106.218346] Oops: 0000 [#1] SMP PTI
> > > [  106.218911] CPU: 0 PID: 2050 Comm: systemd-udevd Tainted: G       =
     E     5.0.0 #25
> > > [  106.220103] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS 1.11.1-1ubuntu1 04/01/2014
> > > [  106.221447] EIP: kmem_cache_alloc_trace+0x7a/0x1b0
> > > [  106.222178] Code: 01 00 00 8b 07 64 8b 50 04 64 03 05 28 61 e8 d2 =
8b 08 89 4d ec 85 c9 0f 84 03 01 00 00 8b 45 ec 8b 5f 14 8d 4a 01 8b 37 01 =
c3 <33> 1b 33 9f b4 00 00 00 64 0f c7 0e 75 cb 8b 75 ec 8b 47 14 0f 18
> > > [  106.224752] EAX: e8a35f3b EBX: e8a35f3b ECX: 0000869f EDX: 0000869e
> > > [  106.225683] ESI: d2e96ef0 EDI: da401a00 EBP: d9b85dd0 ESP: d9b85db0
> > > [  106.226662] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 0=
0010282
> > > [  106.227710] CR0: 80050033 CR2: e8a35f3b CR3: 185b8000 CR4: 000006f0
> > > [  106.228703] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > > [  106.229604] DR6: fffe0ff0 DR7: 00000400
> > > [  106.230114] Call Trace:
> > > [  106.230525]  ? kernfs_fop_open+0xb4/0x390
> > > [  106.231176]  kernfs_fop_open+0xb4/0x390
> > > [  106.231856]  ? security_file_open+0x7c/0xc0
> > > [  106.232562]  do_dentry_open+0x131/0x370
> > > [  106.233229]  ? kernfs_fop_write+0x180/0x180
> > > [  106.233905]  vfs_open+0x25/0x30
> > > [  106.234432]  path_openat+0x2fd/0x1450
> > > [  106.235084]  ? cp_new_stat64+0x115/0x140
> > > [  106.235754]  ? cp_new_stat64+0x115/0x140
> > > [  106.236427]  do_filp_open+0x6a/0xd0
> > > [  106.237026]  ? cp_new_stat64+0x115/0x140
> > > [  106.237748]  ? strncpy_from_user+0x3d/0x180
> > > [  106.238539]  ? __alloc_fd+0x36/0x120
> > > [  106.239256]  do_sys_open+0x175/0x210
> > > [  106.239955]  sys_openat+0x1b/0x20
> > > [  106.240596]  do_fast_syscall_32+0x7f/0x1e0
> > > [  106.241313]  entry_SYSENTER_32+0x6b/0xbe
> > > [  106.242017] EIP: 0xb7fae871
> > > [  106.242559] Code: 8b 98 58 cd ff ff 89 c8 85 d2 74 02 89 0a 5b 5d =
c3 8b 04 24 c3 8b 14 24 c3 8b 34 24 c3 8b 3c 24 c3 51 52 55 89 e5 0f 34 cd =
80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
> > > [  106.245551] EAX: ffffffda EBX: ffffff9c ECX: bffdcb60 EDX: 00088000
> > > [  106.246651] ESI: 00000000 EDI: b7f9e000 EBP: 00088000 ESP: bffdc970
> > > [  106.247706] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 0=
0000246
> > > [  106.248851] Modules linked in: openvswitch(E)
> > > [  106.249621] CR2: 00000000e8a35f3b
> > > [  106.250218] ---[ end trace 6a8d05679a59cda7 ]---
> > >
> > > I've bisected this down to the following commit that seems to have in=
troduced
> > > the issue:
> > >
> > > commit 120645513f55a4ac5543120d9e79925d30a0156f (refs/bisect/bad)
> > > Author: Jarno Rajahalme <jarno@ovn.org>
> > > Date:   Fri Apr 21 16:48:06 2017 -0700
> > >
> > >     openvswitch: Add eventmask support to CT action.
> > >
> > >     Add a new optional conntrack action attribute OVS_CT_ATTR_EVENTMA=
SK,
> > >     which can be used in conjunction with the commit flag
> > >     (OVS_CT_ATTR_COMMIT) to set the mask of bits specifying which
> > >     conntrack events (IPCT_*) should be delivered via the Netfilter
> > >     netlink multicast groups.  Default behavior depends on the system
> > >     configuration, but typically a lot of events are delivered.  This=
 can be
> > >     very chatty for the NFNLGRP_CONNTRACK_UPDATE group, even if only =
some
> > >     types of events are of interest.
> > >
> > >     Netfilter core init_conntrack() adds the event cache extension, s=
o we
> > >     only need to set the ctmask value.  However, if the system is
> > >     configured without support for events, the setting will be skippe=
d due
> > >     to extension not being found.
> > >
> > >     Signed-off-by: Jarno Rajahalme <jarno@ovn.org>
> > >     Reviewed-by: Greg Rose <gvrose8192@gmail.com>
> > >     Acked-by: Joe Stringer <joe@ovn.org>
> > >     Signed-off-by: David S. Miller <davem@davemloft.net> =20
> >
> > Hi Juerg,
> > the symptom, the identified breaking commit and actually all of it
> > seems to be [1] which James, Joseph and I worked on already.
> > I wanted to make you aware of the past context that already exists.
> >
> > Back then we already reverted the change, found it to be working then.
> > Afterwards Joseph brought it up with Jarno [2] and got some patch it
> > seems, but that (whatever change it was - I have never seen it) wasn't
> > enough and still crashing.
> > Then we lost traction on the case and now you had to re-debug it I'm af=
raid :-/
> >
> > [1]: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1736390
> > [2]: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1736390/comme=
nts/55
> > =20
> > > Reverting that commit from 5.0 makes the problem go away. I'm not abl=
e to
> > > reproduce the crash on x86_64.
> > >
> > > ...Juerg
> > > _______________________________________________
> > > dev mailing list
> > > dev@openvswitch.org
> > > https://mail.openvswitch.org/mailman/listinfo/ovs-dev =20
> >
> >
> >
> > --
> > Christian Ehrhardt
> > Software Engineer, Ubuntu Server
> > Canonical Ltd =20
>=20
> Somehow the patch was shared on three different open source lists (the
> bug, linux-kernel, and ovs-dev), yet only one of the three actually
> retained the message:
>=20
> https://mail.openvswitch.org/pipermail/ovs-dev/2018-September/352395.html

Thanks for the link, Jarno, but that patch doesn't help at all.

FWIW, removing the following case statement makes the test pass:

		case OVS_CT_ATTR_EVENTMASK:
			info->have_eventmask =3D true;
			info->eventmask =3D nla_get_u32(a);
			break;

But changing it to something like the below also blows up the machine:

		case OVS_CT_ATTR_EVENTMASK:
			info->have_eventmask =3D false;
			info->eventmask =3D nla_get_u32(a);
			break;

Also bad:

		case OVS_CT_ATTR_EVENTMASK:
			break;

I'm not saying these tests make any sense, just saying :-)

...Juerg


--Sig_//KcPt1lZ=Bv+qqUyJH+aIQm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAlx/584ACgkQD9OLCQum
Qrdeyg//eRL6YlM7OopBna2ex6dyC5w2uz01M6KL2WQJmqjToNjqE7UhmoezAkta
p7K9tZhL6LQFozr9HoN55H7E8T3ydq13B6u2y9AW9zqkoNYKjzl+7EvlY5InFbn/
7apsvQ4hj+wVba9wzBKo8hM3Ik+pARq2HDfwBenz0M775MASx9QdTs81GBibihF8
ktCL9krQ+7RJOGpXPLnGRJSLKu0eqfjEpOQ2hL2E7lVVgwsMMQWlu7EN1A9QdfZd
1iNo8PNLTHiwtZe0EfKJfVM1HYPhz5ThThBITREdo64sQqL4VkRa+iNtm0mpL5IM
4OvUGUXDlgfPBvp83miqplMacvnK74HBGdbpUHv8Q+2JDqrGdWDUtsOVrgL6X0bh
MapBBLIbQSU7k7zcXSdf+hqzPAFa3v2MADaMlcyi/lGXto+eSHhMDa8GS3ktDu0V
UQnTQUXn4RmcEYGpbGslw0WOCV6Gc5XiPLDekcU7IkeWNrRcnYmWc/id5xUdB954
k8adpGW4Dq/84w/Dtt83eWNMigBDSm+II1//4q8NSapuMcQ4TOoQrsF2lGdU0uj5
4A1JjUOzNSy3VsyJ3p+9IG1CdB8kw/s3zWG/0W/2c5SiTDvUJVX23kDpphokchpz
WS0l0YcS8j26pDVHBk1qBX6uCMkUBQvqlgxBcn8J9FLUkXxNbO0=
=SPTU
-----END PGP SIGNATURE-----

--Sig_//KcPt1lZ=Bv+qqUyJH+aIQm--

Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABD9C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684392077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kDyiSAth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfLIQ0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:26:21 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:52250 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfLIQ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575908780; x=1607444780;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FACCC9TphTRL0+cXsVrKulsVHqGEFX7ZWN1UiNvGdJ4=;
  b=kDyiSAth4ADec8XczuxKpXKMb6Pscj3U/EjgXlX2RtKo9nop6FxEbVTl
   F+3lXa30JEo4JjfGvorCIpE5rJDdRAAqF+T/3u83DN7IfnIE38uLaBF2d
   TZGvhjMIACttvaFWcQbZAjcyiflyewfDLc4FezmqiflcU/J/262qVCxEf
   Q=;
IronPort-SDR: yzqPwSyPBH0xLx/HAs8JGd+ttMLiiLLtO6zf8BPU2Mtjhu8V9WEV+W54648FzQtaeVusjRInio
 y40n5xzP9pZA==
X-IronPort-AV: E=Sophos;i="5.69,296,1571702400"; 
   d="scan'208";a="7764489"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 09 Dec 2019 16:26:18 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id 3C99CA20E8;
        Mon,  9 Dec 2019 16:26:17 +0000 (UTC)
Received: from EX13D32EUC004.ant.amazon.com (10.43.164.121) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 16:26:16 +0000
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13D32EUC004.ant.amazon.com (10.43.164.121) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 16:26:16 +0000
Received: from EX13D32EUC003.ant.amazon.com ([10.43.164.24]) by
 EX13D32EUC003.ant.amazon.com ([10.43.164.24]) with mapi id 15.00.1367.000;
 Mon, 9 Dec 2019 16:26:15 +0000
From:   "Durrant, Paul" <pdurrant@amazon.com>
To:     =?iso-8859-1?Q?Roger_Pau_Monn=E9?= <roger.pau@citrix.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Subject: RE: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced to
 closed
Thread-Topic: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced to
 closed
Thread-Index: AQHVq3SCoU35oX1INEGjFwMD1PQM5aexs7UAgAAEsBCAAAg3gIAAAevggAAghQCAAAFgMIAACyOAgAAHopA=
Date:   Mon, 9 Dec 2019 16:26:15 +0000
Message-ID: <b9271df6222a4fba86ec54c81b09eace@EX13D32EUC003.ant.amazon.com>
References: <20191205140123.3817-1-pdurrant@amazon.com>
 <20191205140123.3817-3-pdurrant@amazon.com>
 <20191209113926.GS980@Air-de-Roger>
 <19b5c2fa36b842e58bbdddd602c4e672@EX13D32EUC003.ant.amazon.com>
 <20191209122537.GV980@Air-de-Roger>
 <54e3cd3a42d8418d9a36388315deab13@EX13D32EUC003.ant.amazon.com>
 <20191209142852.GW980@Air-de-Roger>
 <e026926b9aea4ffe868d41828c1f4721@EX13D32EUC003.ant.amazon.com>
 <20191209151339.GZ980@Air-de-Roger>
In-Reply-To: <20191209151339.GZ980@Air-de-Roger>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.211]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
[snip]
> >
> > Well unbind is pretty useless now IMO since bind doesn't work, and a
> transition straight to closed is just plain wrong anyway.
>=20
> Why do you claim that a straight transition into the closed state is
> wrong?

It's badly documented, I agree, but have a look at https://git.kernel.org/p=
ub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/xen-netback/xen=
bus.c#n480. Connected -> Closed is not a valid transition, and I don't thin=
k it was ever intended to be.

>=20
> I don't see any such mention in blkif.h, which also doesn't contain
> any guidelines regarding closing state transitions, so unless
> otherwise stated somewhere else transitions into closed can happen
> from any state IMO.
>=20

They can, but it is even more poorly documented what should be done in this=
 case.

> > But, we could have a flag that the backend driver sets to say that it
> supports transparent re-bind that gates this code. Would that make you
> feel more comfortable?
>=20
> Having an option to leave state untouched when unbinding would be fine
> for me, otherwise state should be set to closed when unbinding. I
> don't think there's anything else that needs to be done in this
> regard, the cleanup should be exactly the same the only difference
> being the setting of all the active backends to closed state.
>=20

Ok, I'll add such a flag and define it for blkback only, in patch #4 i.e. w=
hen it actually gains the ability to rebind.

> > If you want unbind to actually do a proper unplug then that's extra wor=
k
> and not really something I want to tackle (and re-bind would still need t=
o
> be toolstack initiated as something would have to re-create the xenstore
> area).
>=20
> Why do you say the xenstore area would need to be recreated?
>=20
> Setting state to closed shouldn't cause any cleanup of the xenstore
> area, as that should already happen for example when using pvgrub
> since in that case grub itself disconnects and already causes a
> transition to closed and a re-attachment afterwards by the guest
> kernel.
>=20

For some reason, when I originally tested, the xenstore area disappeared. I=
 checked again and it did not this time. I just ended up with a frontend st=
uck in state 5 (because it is the system disk and won't go offline) trying =
to talk to a non-existent backend. Upon re-bind the backend goes into state=
 5 (because it sees the 5 in the frontend) and leaves the guest wedged.

  Paul


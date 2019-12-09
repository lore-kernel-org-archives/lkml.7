Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94365C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653C52073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZtJwfcJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfLIRXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:23:50 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:63542 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfLIRXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575912229; x=1607448229;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/o/DIuVt0siT0/xDHQSqGb+p+hsUxtlaap2ta8gFs3c=;
  b=ZtJwfcJ6q9uQaK7W3CuLy9rooxW6Lj2cG5JwBehMS74EoCelKy14v8cV
   WCrrclUrTOjHX+WCeydmnEcdZaSlxMyWaXL8RybjQpgeunI3BTnJZV8M+
   gBy6WzOGI8zJhJhTpKkB4/8LVcc7qX5t0LfAosTg5ndmQrUJ5ivpwb1PP
   g=;
IronPort-SDR: hUDG+2m+V51DMKrCpX/G/TdEZw/vlZOyeUKcewJhYdAI+7Eurg8b2SUBXrdD1VZAEKboO9MI7O
 f64BC+pBLA6w==
X-IronPort-AV: E=Sophos;i="5.69,296,1571702400"; 
   d="scan'208";a="7775052"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 09 Dec 2019 17:23:43 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS id 67D19A1DB8;
        Mon,  9 Dec 2019 17:23:41 +0000 (UTC)
Received: from EX13D32EUC002.ant.amazon.com (10.43.164.94) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 17:23:40 +0000
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13D32EUC002.ant.amazon.com (10.43.164.94) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 17:23:40 +0000
Received: from EX13D32EUC003.ant.amazon.com ([10.43.164.24]) by
 EX13D32EUC003.ant.amazon.com ([10.43.164.24]) with mapi id 15.00.1367.000;
 Mon, 9 Dec 2019 17:23:39 +0000
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
Thread-Index: AQHVq3SCoU35oX1INEGjFwMD1PQM5aexs7UAgAAEsBCAAAg3gIAAAevggAAghQCAAAFgMIAACyOAgAAHopCAABsYgIAAAH5A
Date:   Mon, 9 Dec 2019 17:23:39 +0000
Message-ID: <5851d5c9424d4df088af96b24dca1906@EX13D32EUC003.ant.amazon.com>
References: <20191205140123.3817-1-pdurrant@amazon.com>
 <20191205140123.3817-3-pdurrant@amazon.com>
 <20191209113926.GS980@Air-de-Roger>
 <19b5c2fa36b842e58bbdddd602c4e672@EX13D32EUC003.ant.amazon.com>
 <20191209122537.GV980@Air-de-Roger>
 <54e3cd3a42d8418d9a36388315deab13@EX13D32EUC003.ant.amazon.com>
 <20191209142852.GW980@Air-de-Roger>
 <e026926b9aea4ffe868d41828c1f4721@EX13D32EUC003.ant.amazon.com>
 <20191209151339.GZ980@Air-de-Roger>
 <b9271df6222a4fba86ec54c81b09eace@EX13D32EUC003.ant.amazon.com>
 <20191209171757.GC980@Air-de-Roger>
In-Reply-To: <20191209171757.GC980@Air-de-Roger>
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
> From: Roger Pau Monn=E9 <roger.pau@citrix.com>
> Sent: 09 December 2019 17:18
> To: Durrant, Paul <pdurrant@amazon.com>
> Cc: linux-kernel@vger.kernel.org; xen-devel@lists.xenproject.org; Juergen
> Gross <jgross@suse.com>; Stefano Stabellini <sstabellini@kernel.org>;
> Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Subject: Re: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced t=
o
> closed
>=20
> On Mon, Dec 09, 2019 at 04:26:15PM +0000, Durrant, Paul wrote:
> > > > If you want unbind to actually do a proper unplug then that's extra
> work
> > > and not really something I want to tackle (and re-bind would still
> need to
> > > be toolstack initiated as something would have to re-create the
> xenstore
> > > area).
> > >
> > > Why do you say the xenstore area would need to be recreated?
> > >
> > > Setting state to closed shouldn't cause any cleanup of the xenstore
> > > area, as that should already happen for example when using pvgrub
> > > since in that case grub itself disconnects and already causes a
> > > transition to closed and a re-attachment afterwards by the guest
> > > kernel.
> > >
> >
> > For some reason, when I originally tested, the xenstore area
> disappeared. I checked again and it did not this time. I just ended up
> with a frontend stuck in state 5 (because it is the system disk and won't
> go offline) trying to talk to a non-existent backend. Upon re-bind the
> backend goes into state 5 (because it sees the 5 in the frontend) and
> leaves the guest wedged.
>=20
> Likely blkfront should go back to init state, but anyway, that's not
> something that needs fixing as part of this series.
>=20

Ok, cool.

I am wondering though whether we ought to suppress bind/unbind for drivers =
that don't whitelist themselves (through the new xenbus_driver flag that I'=
ll add). It's somewhat misleading that the nodes are there but don't necess=
arily work.

  Paul


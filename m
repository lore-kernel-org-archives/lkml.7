Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE22C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258E52077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HtRe015B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfLIMk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:40:56 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:63260 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfLIMkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 07:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575895256; x=1607431256;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VIw1kTmJqxJMg02zZJc8KS3XN2nB5nqChmZFv+am6xY=;
  b=HtRe015B3axKCfoMQdYZj3iyXnvXXgzG/UCWutSGwqFRsfnFjPb6uajJ
   oQCaWkqIDK7EYSnorr/tK6ciq6hZdQnyREz/9PIbhqtJqW5iSOz0QpP6v
   raTwtzEH+gFU7UVbO8eG9UjPl2nZedsP4b2GaWNy15Q5Ndz4F+gN96ENo
   w=;
IronPort-SDR: pYN9wEgJstjwwx4RrBwZlcZJHg2lwO2vtyZQW3KXZ/582Ohf6K1LdXg4XY5gCPamdbbbgtuqWY
 NUhPsOaSxPUw==
X-IronPort-AV: E=Sophos;i="5.69,294,1571702400"; 
   d="scan'208";a="7667714"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 09 Dec 2019 12:40:54 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id A4C26A209C;
        Mon,  9 Dec 2019 12:40:52 +0000 (UTC)
Received: from EX13D32EUC004.ant.amazon.com (10.43.164.121) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 12:40:51 +0000
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13D32EUC004.ant.amazon.com (10.43.164.121) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 12:40:47 +0000
Received: from EX13D32EUC003.ant.amazon.com ([10.43.164.24]) by
 EX13D32EUC003.ant.amazon.com ([10.43.164.24]) with mapi id 15.00.1367.000;
 Mon, 9 Dec 2019 12:40:47 +0000
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
Thread-Index: AQHVq3SCoU35oX1INEGjFwMD1PQM5aexs7UAgAAEsBCAAAg3gIAAAevg
Date:   Mon, 9 Dec 2019 12:40:47 +0000
Message-ID: <54e3cd3a42d8418d9a36388315deab13@EX13D32EUC003.ant.amazon.com>
References: <20191205140123.3817-1-pdurrant@amazon.com>
 <20191205140123.3817-3-pdurrant@amazon.com>
 <20191209113926.GS980@Air-de-Roger>
 <19b5c2fa36b842e58bbdddd602c4e672@EX13D32EUC003.ant.amazon.com>
 <20191209122537.GV980@Air-de-Roger>
In-Reply-To: <20191209122537.GV980@Air-de-Roger>
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
> Sent: 09 December 2019 12:26
> To: Durrant, Paul <pdurrant@amazon.com>
> Cc: linux-kernel@vger.kernel.org; xen-devel@lists.xenproject.org; Juergen
> Gross <jgross@suse.com>; Stefano Stabellini <sstabellini@kernel.org>;
> Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Subject: Re: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced t=
o
> closed
>=20
> On Mon, Dec 09, 2019 at 12:01:38PM +0000, Durrant, Paul wrote:
> > > -----Original Message-----
> > > From: Roger Pau Monn=E9 <roger.pau@citrix.com>
> > > Sent: 09 December 2019 11:39
> > > To: Durrant, Paul <pdurrant@amazon.com>
> > > Cc: linux-kernel@vger.kernel.org; xen-devel@lists.xenproject.org;
> Juergen
> > > Gross <jgross@suse.com>; Stefano Stabellini <sstabellini@kernel.org>;
> > > Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > > Subject: Re: [Xen-devel] [PATCH 2/4] xenbus: limit when state is
> forced to
> > > closed
> > >
> > > On Thu, Dec 05, 2019 at 02:01:21PM +0000, Paul Durrant wrote:
> > > > Only force state to closed in the case when the toolstack may need
> to
> > > > clean up. This can be detected by checking whether the state in
> xenstore
> > > > has been set to closing prior to device removal.
> > >
> > > I'm not sure I see the point of this, I would expect that a failure t=
o
> > > probe or the removal of the device would leave the xenbus state as
> > > closed, which is consistent with the actual driver state.
> > >
> > > Can you explain what's the benefit of leaving a device without a
> > > driver in such unknown state?
> > >
> >
> > If probe fails then I think it should leave the state alone. If the
> > state is moved to closed then basically you just killed that
> > connection to the guest (as the frontend will normally close down
> > when it sees this change) so, if the probe failure was due to a bug
> > in blkback or, e.g., a transient resource issue then it's game over
> > as far as that guest goes.
>=20
> But the connection can be restarted by switching the backend to the
> init state again.

Too late. The frontend saw closed and you already lost.

>=20
> > The ultimate goal here is PV backend re-load that is completely
> transparent to the guest. Modifying anything in xenstore compromises that
> so we need to be careful.
>=20
> That's a fine goal, but not switching to closed state in
> xenbus_dev_remove seems wrong, as you have actually left the frontend
> without a matching backend and with the state not set to closed.
>=20

Why is this a problem? With this series fully applied a (block) backend can=
 come and go without needing to change the state. Relying on guests to DTRT=
 is not a sustainable option for a cloud deployment.

> Ie: that would be fine if you explicitly state this is some kind of
> internal blkback reload, but not for the general case where blkback
> has been unbound. I think we need someway to difference a blkback
> reload vs a unbound.
>=20

Why do we need that though? Why is it advantageous for a backend to go to c=
losed. No PV backends cope with an unbind as-is, and a toolstack initiated =
unplug will always set state to 5 anyway. So TBH any state transition done =
directly in the xenbus code looks wrong to me anyway (but appears to be a n=
ecessary evil to keep the toolstack working in the event it spawns a backen=
d where there is actually to driver present, or it doesn't come online).

  Paul


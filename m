Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100A2C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF02320726
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PL0SdY+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfLIMY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:24:59 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:55139 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbfLIMY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 07:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575894297; x=1607430297;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QtCj/9K/AIAe1MY4j6H683/S6PECk5x09PNGWvLJxjo=;
  b=PL0SdY+OHxQ8Ytnyo/1c99uW9+Mk0UzY0A7xGUMbV0vMz9ZlcJx/2lsu
   2ag5jde6Sj2oIoDxEcDqp5VoldzkUePVTZiqDPoDtNs3Vo99QtC4qvjcZ
   UcDtm5/f2uTOZOYqN4/sN0JePwT66DYZzA5EiBqWwvgSjrAiLwzdc3DaV
   w=;
IronPort-SDR: NrS8ksYiTcwjYGii7UpFE4VAW7by8aX/VuTQ+PhuPvZE6KtQRtp0I0buCLSe9A3LTZUgdY5CuJ
 mu5bs2s59l0w==
X-IronPort-AV: E=Sophos;i="5.69,294,1571702400"; 
   d="scan'208";a="6802387"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 09 Dec 2019 12:24:56 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 45F7EA21B5;
        Mon,  9 Dec 2019 12:24:53 +0000 (UTC)
Received: from EX13D32EUC004.ant.amazon.com (10.43.164.121) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 12:24:53 +0000
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13D32EUC004.ant.amazon.com (10.43.164.121) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 12:24:50 +0000
Received: from EX13D32EUC003.ant.amazon.com ([10.43.164.24]) by
 EX13D32EUC003.ant.amazon.com ([10.43.164.24]) with mapi id 15.00.1367.000;
 Mon, 9 Dec 2019 12:24:49 +0000
From:   "Durrant, Paul" <pdurrant@amazon.com>
To:     =?iso-8859-1?Q?Roger_Pau_Monn=E9?= <roger.pau@citrix.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: RE: [PATCH 4/4] xen-blkback: support dynamic unbind/bind
Thread-Topic: [PATCH 4/4] xen-blkback: support dynamic unbind/bind
Thread-Index: AQHVq3SGozEa3lNeXkCoixgttFczb6exvlMAgAABmYA=
Date:   Mon, 9 Dec 2019 12:24:49 +0000
Message-ID: <215c57c1096548769aeaaeaa76e7c73b@EX13D32EUC003.ant.amazon.com>
References: <20191205140123.3817-1-pdurrant@amazon.com>
 <20191205140123.3817-5-pdurrant@amazon.com>
 <20191209121726.GU980@Air-de-Roger>
In-Reply-To: <20191209121726.GU980@Air-de-Roger>
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
> Sent: 09 December 2019 12:17
> To: Durrant, Paul <pdurrant@amazon.com>
> Cc: linux-kernel@vger.kernel.org; xen-devel@lists.xenproject.org; Konrad
> Rzeszutek Wilk <konrad.wilk@oracle.com>; Jens Axboe <axboe@kernel.dk>;
> Boris Ostrovsky <boris.ostrovsky@oracle.com>; Juergen Gross
> <jgross@suse.com>; Stefano Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH 4/4] xen-blkback: support dynamic unbind/bind
>=20
> On Thu, Dec 05, 2019 at 02:01:23PM +0000, Paul Durrant wrote:
> > By simply re-attaching to shared rings during connect_ring() rather tha=
n
> > assuming they are freshly allocated (i.e assuming the counters are zero=
)
> > it is possible for vbd instances to be unbound and re-bound from and to
> > (respectively) a running guest.
> >
> > This has been tested by running:
> >
> > while true; do dd if=3D/dev/urandom of=3Dtest.img bs=3D1M count=3D1024;=
 done
> >
> > in a PV guest whilst running:
> >
> > while true;
> >   do echo vbd-$DOMID-$VBD >unbind;
> >   echo unbound;
> >   sleep 5;
> >   echo vbd-$DOMID-$VBD >bind;
> >   echo bound;
> >   sleep 3;
> >   done
>=20
> So this does unbind blkback while leaving the PV interface as
> connected?
>=20

Yes, everything is left in place in the frontend. The backend detaches from=
 the ring, closes its end of the event channels, etc. but the guest can sti=
ll send requests which will get serviced when the new backend attaches.

  Paul

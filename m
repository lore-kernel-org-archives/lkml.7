Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16AFC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A272D214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="r4k5bDE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfLKKPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 05:15:05 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:23253 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfLKKPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 05:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576059304; x=1607595304;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QAxEg8wAMpeQpGJaY0emkukCqNQsOl8+HnDT4r3pg28=;
  b=r4k5bDE+O6EnMs0orPfb0e4hrclInphNptcIF9f+mHDUTxfAb8YfTOF5
   7N/F99pZjPYNIRxcN0ul26xg/rZtuMqkeUCORz39zSfNOEBI5uuFvh7fX
   rfWYOYp9SYBndo5Ege/ehN3zvx0ejmz5jqNIujhYlu/8muyySCfx9cT/x
   g=;
IronPort-SDR: TlUAzD03+db+XnCJ5SOx7jg8iAfAJAsCWzYeaF5UYwd4Ir/j6CHWtxsj3vujq21Oo9aEwN3lFc
 ATTxI2ku0eEg==
X-IronPort-AV: E=Sophos;i="5.69,301,1571702400"; 
   d="scan'208";a="8587630"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 11 Dec 2019 10:15:03 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id 27B06A29F7;
        Wed, 11 Dec 2019 10:15:01 +0000 (UTC)
Received: from EX13D32EUC004.ant.amazon.com (10.43.164.121) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Dec 2019 10:15:00 +0000
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13D32EUC004.ant.amazon.com (10.43.164.121) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Dec 2019 10:15:00 +0000
Received: from EX13D32EUC003.ant.amazon.com ([10.43.164.24]) by
 EX13D32EUC003.ant.amazon.com ([10.43.164.24]) with mapi id 15.00.1367.000;
 Wed, 11 Dec 2019 10:14:59 +0000
From:   "Durrant, Paul" <pdurrant@amazon.com>
To:     =?iso-8859-1?Q?Roger_Pau_Monn=E9?= <roger.pau@citrix.com>
CC:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Subject: RE: [Xen-devel] [PATCH v2 2/4] xenbus: limit when state is forced to
 closed
Thread-Topic: [Xen-devel] [PATCH v2 2/4] xenbus: limit when state is forced to
 closed
Thread-Index: AQHVr029Jnf5zy5/UEOnUavFsd58GKe0trGAgAABW5A=
Date:   Wed, 11 Dec 2019 10:14:59 +0000
Message-ID: <86a7d140501047028c49736c43fe547c@EX13D32EUC003.ant.amazon.com>
References: <20191210113347.3404-1-pdurrant@amazon.com>
 <20191210113347.3404-3-pdurrant@amazon.com>
 <20191211100627.GI980@Air-de-Roger>
In-Reply-To: <20191211100627.GI980@Air-de-Roger>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.120]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Roger Pau Monn=E9 <roger.pau@citrix.com>
> Sent: 11 December 2019 10:06
> To: Durrant, Paul <pdurrant@amazon.com>
> Cc: xen-devel@lists.xenproject.org; linux-kernel@vger.kernel.org; Juergen
> Gross <jgross@suse.com>; Stefano Stabellini <sstabellini@kernel.org>;
> Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Subject: Re: [Xen-devel] [PATCH v2 2/4] xenbus: limit when state is force=
d
> to closed
>=20
> On Tue, Dec 10, 2019 at 11:33:45AM +0000, Paul Durrant wrote:
> > If a driver probe() fails then leave the xenstore state alone. There is
> no
> > reason to modify it as the failure may be due to transient resource
> > allocation issues and hence a subsequent probe() may succeed.
> >
> > If the driver supports re-binding then only force state to closed durin=
g
> > remove() only in the case when the toolstack may need to clean up. This
> can
> > be detected by checking whether the state in xenstore has been set to
> > closing prior to device removal.
> >
> > NOTE: Re-bind support is indicated by new boolean in struct
> xenbus_driver,
> >       which defaults to false. Subsequent patches will add support to
> >       some backend drivers.
>=20
> My intention was to specify whether you want to close the
> backends on unbind in sysfs, so that an user can decide at runtime,
> rather than having a hardcoded value in the driver.
>=20
> Anyway, I'm less sure whether such runtime tunable is useful at all,
> so let's leave it out and can always be added afterwards. At the end
> of day a user wrongly doing a rmmod blkback can always recover
> gracefully by loading blkback again with your proposed approach to
> leave connections open on module removal.
>=20
> Sorry for the extra work.
>=20

Does this mean you don't think the extra driver flag is necessary any more?=
 NB: now that xenbus actually takes module references you can't accidentall=
y rmmod any more :-)

  Paul

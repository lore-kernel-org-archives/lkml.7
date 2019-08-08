Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9D7C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2842173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404761AbfHHWqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 18:46:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:35776 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbfHHWqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:46:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 15:46:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,363,1559545200"; 
   d="p7s'?scan'208";a="374314813"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga005.fm.intel.com with ESMTP; 08 Aug 2019 15:46:07 -0700
Received: from orsmsx126.amr.corp.intel.com (10.22.240.126) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 8 Aug 2019 15:46:07 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.157]) by
 ORSMSX126.amr.corp.intel.com ([169.254.4.77]) with mapi id 14.03.0439.000;
 Thu, 8 Aug 2019 15:46:07 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH] genirq/affinity: report extra vectors on uneven nodes
Thread-Topic: [PATCH] genirq/affinity: report extra vectors on uneven nodes
Thread-Index: AQHVTVw64ep/2nQTn0mnIrRj8XvgYKbxSakAgACergCAAGhlAA==
Date:   Thu, 8 Aug 2019 22:46:06 +0000
Message-ID: <1a6ab898b8800c3e660054f77ac81bfc3921d45a.camel@intel.com>
References: <20190807201051.32662-1-jonathan.derrick@intel.com>
         <alpine.DEB.2.21.1908080903360.2882@nanos.tec.linutronix.de>
         <20190808163224.GB27077@localhost.localdomain>
In-Reply-To: <20190808163224.GB27077@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.152]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-JtYa6nr8PKObgbLFPdew"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-JtYa6nr8PKObgbLFPdew
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-08 at 10:32 -0600, Keith Busch wrote:
> On Thu, Aug 08, 2019 at 09:04:28AM +0200, Thomas Gleixner wrote:
> > On Wed, 7 Aug 2019, Jon Derrick wrote:
> > > The current irq spreading algorithm spreads vectors amongst cpus even=
ly
> > > per node. If a node has more cpus than another node, the extra vector=
s
> > > being spread may not be reported back to the caller.
> > >=20
> > > This is most apparent with the NVMe driver and nr_cpus < vectors, whe=
re
> > > the underreporting results in the caller's WARN being triggered:
> > >=20
> > > irq_build_affinity_masks()
> > > ...
> > > 	if (nr_present < numvecs)
> > > 		WARN_ON(nr_present + nr_others < numvecs);
> > >=20
> > > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > > ---
> > >  kernel/irq/affinity.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> > > index 4352b08ae48d..9beafb8c7e92 100644
> > > --- a/kernel/irq/affinity.c
> > > +++ b/kernel/irq/affinity.c
> > > @@ -127,7 +127,8 @@ static int __irq_build_affinity_masks(unsigned in=
t startvec,
> > >  	}
> > > =20
> > >  	for_each_node_mask(n, nodemsk) {
> > > -		unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
> > > +		unsigned int ncpus, v, vecs_to_assign, total_vecs_to_assign,
> > > +			vecs_per_node;
> > > =20
> > >  		/* Spread the vectors per node */
> > >  		vecs_per_node =3D (numvecs - (curvec - firstvec)) / nodes;
> > > @@ -141,14 +142,16 @@ static int __irq_build_affinity_masks(unsigned =
int startvec,
> > > =20
> > >  		/* Account for rounding errors */
> > >  		extra_vecs =3D ncpus - vecs_to_assign * (ncpus / vecs_to_assign);
> > > +		total_vecs_to_assign =3D vecs_to_assign + extra_vecs;
> > > =20
> > > -		for (v =3D 0; curvec < last_affv && v < vecs_to_assign;
> > > +		for (v =3D 0; curvec < last_affv && v < total_vecs_to_assign;
> > >  		     curvec++, v++) {
> > >  			cpus_per_vec =3D ncpus / vecs_to_assign;
> > > =20
> > >  			/* Account for extra vectors to compensate rounding errors */
> > >  			if (extra_vecs) {
> > >  				cpus_per_vec++;
> > > +				v++;
> > >  				--extra_vecs;
> > >  			}
> > >  			irq_spread_init_one(&masks[curvec].mask, nmsk,
> > > --=20
>=20
> This looks like it will break the spread to non-present CPUs since
> it's not accurately reporting how many vectors were assigned for the
> present spread.
>=20
> I think the real problem is the spread's vecs_per_node doesn't account
> which nodes contribute more CPUs than others. For example:
>=20
>   Node 0 has 32 CPUs
>   Node 1 has 8 CPUs
>   Assign 32 vectors
>=20
> The current algorithm assigns 16 vectors to node 0 because vecs_per_node
> is calculated as 32 vectors / 2 nodes on the first iteration. The
> subsequent iteration for node 1 gets 8 vectors because it has only 8
> CPUs, leaving 8 vectors unassigned.
>=20
> A more fair spread would give node 0 the remaining 8 vectors. This
> optimization, however, is a bit more complex than the current algorithm,
> which is probably why it wasn't done, so I think the warning should just
> be removed.

It does get a bit complex for the rare scenario in this case
Maybe just an informational warning rather than a stackdumping warning

--=-JtYa6nr8PKObgbLFPdew
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
PNauajAtxgRKfqfSMb+IcL/VXiPtVZOxVq+CTZeDJkaEmn/79vg8OYxpR+YhFF+tGlKf/Zc4id1P
AgMBAAGjggI3MIICMzAdBgNVHQ4EFgQU4oawcWXM1cPGdwGcIszDfjORVZAwHwYDVR0jBBgwFoAU
HmkqtNwo/kcYTiELP7ysES/wmPUwZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5pbnRlbC5j
b20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENB
JTIwNEEuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzBpBggrBgEFBQcwAoZdaHR0cDovL3d3dy5pbnRl
bC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIw
SXNzdWluZyUyMENBJTIwNEEuY3J0MCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5pbnRlbC5jb20v
MAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9gSiFjp9T
gpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMMMCkGCSsG
AQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBRBgNVHREESjBIoCoGCisGAQQB
gjcUAgOgHAwaam9uYXRoYW4uZGVycmlja0BpbnRlbC5jb22BGmpvbmF0aGFuLmRlcnJpY2tAaW50
ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQBxGkHe05DNpYel4b9WbbyQqD1G6y6YA6C93TjKULZi
p8+gO1LL096ixD44+frVm3jtXMikoadRHQJmBJdzsCywNE1KgtrYF0k4zRWr7a28nyfGgQe4UHHD
7ARyZFeGd7AKSQ1y4/LU57I2Aw2HKx9/PXavv1JXjjO2/bqTfnZDJTQmOQ0nvlO3/gvbbABxZHqz
NtfHZsQWS7s+Elk2xGUQ0Po2pMCQoaPo9R96mm+84UP9q3OvSqMoaZwfzoUeAx2wGJYl0h3S+ABr
CPVfCgq9qnmVCn5DyHWE3V/BRjJCoILLBLxAxnmSdH4pF6wJ6pYRLEw9qoyNhpzGUIJU/Lk1MYIC
FzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBD
bGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFs
IEJhc2ljIElzc3VpbmcgQ0EgNEECEzMAAMamAkocC+WQNPgAAAAAxqYwCQYFKw4DAhoFAKBdMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDgwODIyNDYwMlowIwYJ
KoZIhvcNAQkEMRYEFIdhuGHtjoshQS0vL/vWWJlPjlQhMA0GCSqGSIb3DQEBAQUABIIBAGMjGx2U
pGgZsWlGdHfmyniyDX0Rh2V5EHl0HQjjV/2e/HyCLgtbcWG5wUyM14gPLTvs9HRhOCLF9yrPgbMu
A++tLoIUEmI4yGxMJl1HvrdIfeWDr9M+38afPucOeqlq7lelrDrVHQLheWrEvsz3ddpmvCehctOz
gdl6iO0p8ixJ03P4047TBNkO7uZODWRCwEuNCiCTu9YjYgbExt7gf90zUeGkWuc0M0xzHAVGMkzt
65zbH7B0bDBgWy1xAErqrJFoqUvDC7I+z/EgIFStXcIH0GnDdqGIVbdj2QR5V3k0VC/nPJth+10A
l41s8eowu2m0WbjkZxECxlN1BmiqhCwAAAAAAAA=


--=-JtYa6nr8PKObgbLFPdew--

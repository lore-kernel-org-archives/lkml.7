Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E03C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAAC206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="uxl6k1ve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDKM3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:29:49 -0400
Received: from mail-eopbgr150054.outbound.protection.outlook.com ([40.107.15.54]:64534
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbfDKM3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4R10yTz74VnhHVclVB9zHntmO+xfP6Yk0f3p3eTtfFM=;
 b=uxl6k1ve10DmL6ePy/Bp1WvDuaIVOOaczt/vnuFbvUI2G9GX5OfDwbCSAc/hkgXByhf42DwFdnciooELEspEwG63eB2HPB+9cl0scIn0tDiI2vWAGZjin40qBEDQ2TXFFf0HmMtdLUw6EWkNGcggpCbeD0iKkqwEika6l6vIpuU=
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com (10.172.226.9) by
 DB6PR0501MB2551.eurprd05.prod.outlook.com (10.168.74.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Thu, 11 Apr 2019 12:29:43 +0000
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::6ca8:55cc:a7c3:e214]) by DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::6ca8:55cc:a7c3:e214%11]) with mapi id 15.20.1771.021; Thu, 11 Apr
 2019 12:29:43 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     "jglisse@redhat.com" <jglisse@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v3 0/1] Use HMM for ODP v3
Thread-Topic: [PATCH v3 0/1] Use HMM for ODP v3
Thread-Index: AQHU77Pkgxx6AZujQ0e6VPT2yK8P1qY25Q8A
Date:   Thu, 11 Apr 2019 12:29:43 +0000
Message-ID: <20190411122940.GZ3201@mtr-leonro.mtl.com>
References: <20190410154125.21350-1-jglisse@redhat.com>
In-Reply-To: <20190410154125.21350-1-jglisse@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0020.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::33) To DB6PR0501MB2694.eurprd05.prod.outlook.com
 (2603:10a6:4:82::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bd9f3f6-1db9-49e5-62a7-08d6be796005
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(49563074)(7193020);SRVR:DB6PR0501MB2551;
x-ms-traffictypediagnostic: DB6PR0501MB2551:
x-microsoft-antispam-prvs: <DB6PR0501MB2551478D92076CF4C35E7784B02F0@DB6PR0501MB2551.eurprd05.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(366004)(396003)(346002)(189003)(199004)(3846002)(6246003)(476003)(14454004)(6436002)(5640700003)(99936001)(1076003)(33656002)(11346002)(8676002)(8936002)(26005)(97736004)(14444005)(6916009)(256004)(68736007)(186003)(4326008)(81156014)(1730700003)(81166006)(6512007)(99286004)(66574012)(7736002)(2501003)(478600001)(66066001)(446003)(966005)(5660300002)(6306002)(6506007)(25786009)(386003)(486006)(52116002)(53936002)(102836004)(9686003)(6116002)(76176011)(6486002)(229853002)(2351001)(54906003)(71190400001)(2906002)(86362001)(105586002)(316002)(71200400001)(106356001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2551;H:DB6PR0501MB2694.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ku/6j4Lj3CRJpqzjWwz6NCr5IAeL6T10kPp5DvBU0mvi2s6zEanncprkBhFnxhW0uQX7JUjT0STUu6EUa2S+H6R46p0U7qrjF89gS/hbB80+/6B2wCFHZB4iC9fmSViKb3fl2m8aAgeRyi3ZNg/8DjagrztgSqUrxMlNkJ3nY4MuarnJ/66/7qpFl5pKLfejbzwxoQhXDuqfdmXUfm6AvbT2wAqga1Np0B1nsUj0n+EkIJoeVaPg1+2HeEa0c3choUomMz8LhFeRgDhpaXRUqw/ThU4zRSFzZAgXkr1k2pffzmuBQSQo3VqI7VWWuPNTOAl+UpeyMwx9e597rh9R9np5lEdabF9LvHb0DyiSwSrepbR9j+DoFXHF5DsZeZt81tUlL2gHhBFztCZ5/d0dWyejnXKOip2qhH6pyw4Y0HI=
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Tdr039sUWCyRuLRO"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd9f3f6-1db9-49e5-62a7-08d6be796005
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 12:29:43.7775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Tdr039sUWCyRuLRO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2019 at 11:41:24AM -0400, jglisse@redhat.com wrote:
> From: J=E9r=F4me Glisse <jglisse@redhat.com>
>
> Changes since v1/v2 are about rebase and better comments in the code.
> Previous cover letter slightly updated.
>
>
> This patchset convert RDMA ODP to use HMM underneath this is motivated
> by stronger code sharing for same feature (share virtual memory SVM or
> Share Virtual Address SVA) and also stronger integration with mm code to
> achieve that. It depends on HMM patchset posted for inclusion in 5.2 [2]
> and [3].
>
> It has been tested with pingpong test with -o and others flags to test
> different size/features associated with ODP.
>
> Moreover they are some features of HMM in the works like peer to peer
> support, fast CPU page table snapshot, fast IOMMU mapping update ...
> It will be easier for RDMA devices with ODP to leverage those if they
> use HMM underneath.
>
> Quick summary of what HMM is:
>     HMM is a toolbox for device driver to implement software support for
>     Share Virtual Memory (SVM). Not only it provides helpers to mirror a
>     process address space on a device (hmm_mirror). It also provides
>     helper to allow to use device memory to back regular valid virtual
>     address of a process (any valid mmap that is not an mmap of a device
>     or a DAX mapping). They are two kinds of device memory. Private memory
>     that is not accessible to CPU because it does not have all the expect=
ed
>     properties (this is for all PCIE devices) or public memory which can
>     also be access by CPU without restriction (with OpenCAPI or CCIX or
>     similar cache-coherent and atomic inter-connect).
>
>     Device driver can use each of HMM tools separatly. You do not have to
>     use all the tools it provides.
>
> For RDMA device i do not expect a need to use the device memory support
> of HMM. This device memory support is geared toward accelerator like GPU.
>
>
> You can find a branch [1] with all the prerequisite in. This patch is on
> top of rdma-next with the HMM patchset [2] and mmu notifier patchset [3]
> applied on top of it.
>
> [1] https://cgit.freedesktop.org/~glisse/linux/log/?h=3Drdma-5.2

Hi Jerome,

I took this branch and merged with our latest rdma-next, but it doesn't
compile.

In file included from drivers/infiniband/hw/mlx5/mem.c:35:
=2E/include/rdma/ib_umem_odp.h:110:20: error: field _mirror_ has
incomplete type
  struct hmm_mirror mirror;
                      ^~~~~~
=2E/include/rdma/ib_umem_odp.h:132:18: warning: _struct hmm_range_ declared=
 inside parameter list will not be visible outside of this definition or de=
claration
struct hmm_range *range);
	^~~~~~~~~
make[4]: *** [scripts/Makefile.build:276: drivers/infiniband/hw/mlx5/mem.o]=
 Error 1

The reason to it that in my .config, ZONE_DEVICE, MEMORY_HOTPLUG and HMM op=
tions were disabled.

Thanks

--Tdr039sUWCyRuLRO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcrzM0AAoJEORje4g2clinEt4P/3wiD/ydhWQnQz/BSONuyzO9
TpkWmDo9g8kUY53myMIlmzDSdoAS4SaJmTBCE/gwotsqQ3WUpCovy7p4oY+W6oK7
kwgHSTKqTT76oSNM609j4fYn45TK2kvZ+n4XXW9gvdmXnbVsQV8NvpCKU01JuTuf
mfqL5HVk5QMwnAHDW/7+E8hBEt28DF2nSizD66qs4pZUhv8cLFcPrL0HcqdtRew1
m4YZEPvnqkDfyBou4Elje+g2UipqIiF/fLE3p9kBp0uxPP5MVbjxGG+tQ/8AA/WA
dbHIU+sNevjfeM0rblA83wsX5kWYOE1e3umk2IZYVvB5xzrfgbnRbPzHH7OqyM/r
YVQUvZpglLd7dX6Ciwny3qICEphvH9375i9WkKlGRLXbvUATqdDwghfHbjxNSfwe
dnRpjY6H+7ARPtxonoLPVIDPgVt2BJ07YRyDApY6yu3H/TKwVXu9tTgVmYuUslmE
bk2hAfxRX8fnYHUVKVyx3cRdvn1pt3uSUAimtBe23xYfuEQ4CioNBjtKRiV8Glg3
Q1yJadrdcNBwB8MWP24V46K30edgGi5pEa8A1K2jjt3zSb5Fe33q4Jdjq2S9B3/O
4RFeNtsdkfqCuLbB3f3gG7StuNlKfjb/5h3UuRFFDMFMk49hzleBYGUJhirWgylJ
EB1NHvWV1nG5yhJTCnFN
=3csj
-----END PGP SIGNATURE-----

--Tdr039sUWCyRuLRO--

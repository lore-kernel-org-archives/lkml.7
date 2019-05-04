Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEBFC004C9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 01:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8382075E
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 01:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="lEgevMdZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfEDBZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 21:25:36 -0400
Received: from mail-eopbgr800053.outbound.protection.outlook.com ([40.107.80.53]:44805
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726042AbfEDBZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 21:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdKWZNWsC2QDZPr7BKiJhEirVBVPb9zk96COLc9DNXU=;
 b=lEgevMdZZX+zU54N6kgdk2i69yRAMZ1RjdI734MtLBF+Afc95EpzNxORO0FD2WfvJutDMZ0kn2ymdhvZRhsQkp5e9pvW+q33KQiq9UCAA6F83BbIoHEfg7hRKOR+5pje7Z7uJ0sprgYZuotYI3k+6PTIAHzEnBZ+pkpsbZXj0rc=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6213.namprd05.prod.outlook.com (20.178.55.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Sat, 4 May 2019 01:25:25 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::b057:917a:f098:6098]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::b057:917a:f098:6098%7]) with mapi id 15.20.1878.012; Sat, 4 May 2019
 01:25:24 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Julien Freche <jfreche@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Jason Wang <jasowang@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 0/4] vmw_balloon: Compaction and shrinker support
Thread-Topic: [PATCH v4 0/4] vmw_balloon: Compaction and shrinker support
Thread-Index: AQHU+5sfw4lXp6MJj0Ov0LaKSU1Rk6ZaOUgA
Date:   Sat, 4 May 2019 01:25:24 +0000
Message-ID: <8A2D1D43-759A-4B09-B781-31E9002AE3DA@vmware.com>
References: <20190425115445.20815-1-namit@vmware.com>
In-Reply-To: <20190425115445.20815-1-namit@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4bafb9c-9199-422e-8764-08d6d02f623f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB6213;
x-ms-traffictypediagnostic: BYAPR05MB6213:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <BYAPR05MB6213679830B52A78D4C2C711D0360@BYAPR05MB6213.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0027ED21E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(2616005)(486006)(33656002)(68736007)(36756003)(6486002)(102836004)(186003)(6506007)(26005)(53546011)(8936002)(76176011)(73956011)(3846002)(6116002)(66946007)(66556008)(66446008)(446003)(54906003)(2906002)(7736002)(478600001)(66476007)(64756008)(11346002)(99286004)(14444005)(256004)(25786009)(229853002)(476003)(71200400001)(6916009)(66066001)(305945005)(316002)(76116006)(14454004)(82746002)(8676002)(5660300002)(83716004)(6512007)(4326008)(6246003)(53936002)(71190400001)(86362001)(81166006)(6436002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6213;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qPo5D/F9hGET3k6Gq/zZ44ji2YXV45Kc7MgTWcwETlnHn+o1eeWnGSiDvUs5kAjzytfoSv+ws1n+fZs1J4v58hq39BFQ1JHzm2kUQJXg1M9q8oiJ4n9pAbEX2X1WCdbZabGpVu1hGH34rfhSC/y/UB3k7N0j2JSj0KikbzqDLe6yc5UrhqPy6u2uZ7VxIZc0Kk9H7IuA6CbB3+uARirVRAFFIlsjZnexzDMA/Qfi5Nq+n9FBc+rfZd54lDbYww6ErRqiudTH5yOS5CRgok602/Papr26lfeYFykWyOj5Ra6wEtA9l+IDEE7LjMlYvajvrZoAS7xGyCpSFfc1AIKZjxuzWV+Ek3NOZb+h7ntzVJkUAtm6KeYfzbz2x5NeWNFMVrj9iNJZsNex8ArbaRvy1gwGO/MK1vcnk0aVZFLa/ns=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <88829AE5ABEA6941919308A6A9557F98@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bafb9c-9199-422e-8764-08d6d02f623f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2019 01:25:24.8825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Apr 25, 2019, at 4:54 AM, Nadav Amit <namit@vmware.com> wrote:
>=20
> VMware balloon enhancements: adding support for memory compaction,
> memory shrinker (to prevent OOM) and splitting of refused pages to
> prevent recurring inflations.
>=20
> Patches 1-2: Support for compaction
> Patch 3: Support for memory shrinker - disabled by default
> Patch 4: Split refused pages to improve performance
>=20
> v3->v4:
> * "get around to" comment [Michael]
> * Put list_add under page lock [Michael]
>=20
> v2->v3:
> * Fixing wrong argument type (int->size_t) [Michael]
> * Fixing a comment (it) [Michael]
> * Reinstating the BUG_ON() when page is locked [Michael]=20
>=20
> v1->v2:
> * Return number of pages in list enqueue/dequeue interfaces [Michael]
> * Removed first two patches which were already merged
>=20
> Nadav Amit (4):
>  mm/balloon_compaction: List interfaces
>  vmw_balloon: Compaction support
>  vmw_balloon: Add memory shrinker
>  vmw_balloon: Split refused pages
>=20
> drivers/misc/Kconfig               |   1 +
> drivers/misc/vmw_balloon.c         | 489 ++++++++++++++++++++++++++---
> include/linux/balloon_compaction.h |   4 +
> mm/balloon_compaction.c            | 144 ++++++---
> 4 files changed, 553 insertions(+), 85 deletions(-)
>=20
> --=20
> 2.19.1

Ping.

Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69009C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343162070D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nkK3gtoO";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="n9VmEX5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbfEVREG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 13:04:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59928 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729269AbfEVREF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 13:04:05 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4MH3sIY027947;
        Wed, 22 May 2019 10:03:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WgCGtBQOvcWvqhCP4BvVezpXhGfHNgoGFhAqyvMtHLY=;
 b=nkK3gtoOi6vwAW5msMF9SKxD1B/0BEI8qfPkcMlYx/ccJArqND7QOozRpt5rNxUtnm43
 LP5DK9cnrjSEygS9Q8bwUUitngaDFB1jIlEZ2nNdJVEC6Y1V6Ym4YfUFbdxBUJAYvS45
 Vfkpxm7JCOwiyfoJcgz9I3MAuAkVefVkc3g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2snabk01cy-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 May 2019 10:03:55 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 22 May 2019 10:03:51 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 22 May 2019 10:03:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgCGtBQOvcWvqhCP4BvVezpXhGfHNgoGFhAqyvMtHLY=;
 b=n9VmEX5CJ1tUiunRMmjLdw49CqMRQl+7KYycA8e3huw7bX/1neemEaT1RZ3OojdaOhwuy42cPdSKsWUyucAZRk8Wa9xW5Acai0iXbFehWrhkroorRrhYB/74ucO6row2yde2S2222ADzcxby/0zJRjHz9+1x7yQKDV/ccN/JdK0=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2342.namprd15.prod.outlook.com (52.135.197.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 17:03:48 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 17:03:48 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
CC:     Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] proc/meminfo: add MemKernel counter
Thread-Topic: [PATCH] proc/meminfo: add MemKernel counter
Thread-Index: AQHVEKxMijk76PIMmkOK94/In9VVJqZ3S1QAgAAEwgCAAA8xAA==
Date:   Wed, 22 May 2019 17:03:48 +0000
Message-ID: <20190522170342.GA11077@tower.DHCP.thefacebook.com>
References: <155853600919.381.8172097084053782598.stgit@buzz>
 <20190522155220.GB4374@dhcp22.suse.cz>
 <177f56cd-6e10-4d2e-7a3e-23276222ba19@yandex-team.ru>
In-Reply-To: <177f56cd-6e10-4d2e-7a3e-23276222ba19@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:301:1::23) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:b434]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69b3b830-ba92-4b9c-66b6-08d6ded7750b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2342;
x-ms-traffictypediagnostic: BYAPR15MB2342:
x-microsoft-antispam-prvs: <BYAPR15MB234221F12D2BEDBD57E5A8F3BE000@BYAPR15MB2342.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(366004)(376002)(346002)(189003)(199004)(476003)(64756008)(99286004)(66446008)(66556008)(66476007)(486006)(11346002)(54906003)(9686003)(68736007)(86362001)(5660300002)(6512007)(14454004)(8676002)(186003)(66946007)(76176011)(102836004)(52116002)(446003)(386003)(6916009)(25786009)(6436002)(73956011)(6116002)(6506007)(53546011)(81166006)(81156014)(46003)(478600001)(4326008)(7736002)(6486002)(305945005)(8936002)(1076003)(256004)(2906002)(6246003)(316002)(229853002)(33656002)(53936002)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2342;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J0zDvcUSItJHCsRmFsZQ6kXrOXe3JuZ+VZ2pzsenzrCK6bVkyg2ufgncaBqDNj4VI23JZUn0ke9lNaiH/a5Dwj7PUawUbjSgP+qhcrzQhjFrI2H0VgkIbI9Nvs/pkCiFl0tE9/DvgsfSkpv3LEvK8KRZZ0wzbIJ7GCZqGYVC5THiiszSvwlAhel4XwP9R94TKaTd5u7dLTeC+YCxdLFzXnGoMpyiVHEIV5geoIvgxNkjMbbfBum5eO/aZeQKkMrcpXLSnbIEve3ivNtt/oqwoicx+2k1TQ3N4GMYgR6jsPKlvvO2m6hqtxJcfcHTfkap4a1TkY4uGbE4poWIK7La67EmPirJlSBnJF/lEiZ0bbf9h3OTAqzSe3nuO8d53/rH5zC97lVRIRljM5jaZc4+DL1U73pg3YAsDXjSaKhFzao=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <60F765A80C84264D94E551496AAD5BB6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b3b830-ba92-4b9c-66b6-08d6ded7750b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 17:03:48.5478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2342
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-22_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=883 adultscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220120
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 07:09:22PM +0300, Konstantin Khlebnikov wrote:
> On 22.05.2019 18:52, Michal Hocko wrote:
> > On Wed 22-05-19 17:40:09, Konstantin Khlebnikov wrote:
> > > Some kinds of kernel allocations are not accounted or not show in mem=
info.
> > > For example vmalloc allocations are tracked but overall size is not s=
hown
> > > for performance reasons. There is no information about network buffer=
s.
> > >=20
> > > In most cases detailed statistics is not required. At first place we =
need
> > > information about overall kernel memory usage regardless of its struc=
ture.
> > >=20
> > > This patch estimates kernel memory usage by subtracting known sizes o=
f
> > > free, anonymous, hugetlb and caches from total memory size: MemKernel=
 =3D
> > > MemTotal - MemFree - Buffers - Cached - SwapCached - AnonPages - Huge=
tlb.
> >=20
> > Why do we need to export something that can be calculated in the
> > userspace trivially? Also is this really something the number really
> > meaningful? Say you have a driver that exports memory to the userspace
> > via mmap but that memory is not accounted. Is this really a kernel
> > memory?
> >=20
>=20
> It may be trivial right now but not fixed.
> Adding new kinds of memory may change this definition.

Right, and it's what causes me to agree with Michal here, and leave it
to the userspace calculation.

The real meaning of the counter is the size of the "gray zone",
basically the memory which we have no clue about.

If we'll add accounting of some new type of memory, which now in this
gray zone (say, xfs buffers), we probably should exclude it too.
And this means that definition of this counter will change.

So IMO the definition is way too implementation-defined to be a part
of procfs API.

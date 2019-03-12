Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170C8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD108206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="XmEYDB+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbfCLRZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:25:51 -0400
Received: from mail-eopbgr820045.outbound.protection.outlook.com ([40.107.82.45]:31440
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729759AbfCLRZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuL6L6UHqB0jogE14X4LVrkJxK5RVwdS5RmNSCDnbHg=;
 b=XmEYDB+USxW26zzkeRUVN79lUx+UEtuBtPtrW4RuLAnYLNk+ZVwNsHp9TqKUCzqEgHNnF0X8xIU8PwMeOo9H5Ob53cCWaKnUOQP+PoER2YcHynkL3QFVzBS/I0TN1UzMMVNRF2uAKyv8HZ5boQKsJlg1b7/sVJgLcc85F8cODAs=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5704.namprd05.prod.outlook.com (20.178.48.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.11; Tue, 12 Mar 2019 17:25:28 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::6cf6:1336:9f92:b1b5]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::6cf6:1336:9f92:b1b5%4]) with mapi id 15.20.1709.011; Tue, 12 Mar 2019
 17:25:28 +0000
From:   Nadav Amit <namit@vmware.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Julien Grall <julien.grall@arm.com>,
        osstest service owner <osstest-admin@xenproject.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "k.khlebnikov@samsung.com" <k.khlebnikov@samsung.com>,
        Julien Freche <jfreche@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: xen: Can't insert balloon page into VM userspace (WAS Re:
 [Xen-devel] [linux-linus bisection] complete test-arm64-arm64-xl-xsm)
Thread-Topic: xen: Can't insert balloon page into VM userspace (WAS Re:
 [Xen-devel] [linux-linus bisection] complete test-arm64-arm64-xl-xsm)
Thread-Index: AQHU2PcQ+2WuG1OSZEK1UAN5w8teIKYIPsCAgAAAfIA=
Date:   Tue, 12 Mar 2019 17:25:28 +0000
Message-ID: <A3443EC8-2A35-47C5-9EB3-78763AF641B0@vmware.com>
References: <E1h3Uiq-0002L6-Ij@osstest.test-lab.xenproject.org>
 <80211e70-5f54-9421-8e8f-2a4fc758ce39@arm.com>
 <46118631-61d4-adb6-6ffc-4e7c62ea3da9@arm.com>
 <20190312171421.GJ19508@bombadil.infradead.org>
 <28a72642-d0db-214c-2bf2-d1a6c6e03d92@redhat.com>
In-Reply-To: <28a72642-d0db-214c-2bf2-d1a6c6e03d92@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0787024-0a84-4317-c63a-08d6a70fb8ff
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5704;
x-ms-traffictypediagnostic: BYAPR05MB5704:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <BYAPR05MB5704E53882FD3EC214D21FBBD0490@BYAPR05MB5704.namprd05.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(346002)(376002)(136003)(189003)(199004)(106356001)(71200400001)(6436002)(11346002)(105586002)(86362001)(7416002)(6486002)(186003)(5660300002)(71190400001)(478600001)(76176011)(6506007)(83716004)(446003)(68736007)(476003)(229853002)(53546011)(36756003)(14454004)(26005)(82746002)(53936002)(99286004)(81166006)(2616005)(81156014)(6116002)(33656002)(486006)(102836004)(3846002)(54906003)(66066001)(4326008)(93886005)(256004)(6916009)(25786009)(6512007)(8676002)(97736004)(8936002)(2906002)(305945005)(316002)(7736002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5704;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BG9N2f8C+dlo3mBMwuqnPoQzRUmb/nEAM7EVvFo7FSYuYmjPf/rwSEWKGt1rSEYoJEM+9/TjXzYpf6xO4E4LgQAOfJmW3Z2ym7oNYir6Zl+PY1txlEUPTb4Fj1bukSx/5zKWMj7X/3Fq7o/S0hpJj1dU+H7obCquEwS5mSpscKrzqrkUWQL5s0BhE/T8BeePu4SPM2QNlwIGRFbGOyddi1wkvX0bI1OrZzXJORVGjE/AgqijTWuy8dL/8OdsgEGF32TeRnyHbj7QL1Fpg8N0WAzZT/uCCQawzQJlXUmsekv9GtRxxIbCyNsPEwRZrq7POqBHoSgHUawvrzZKSopoNMxQlt0WdcskYBTUUMn8FG6JhP9Ni3SSHTkS1pkqCDuP/c365wKSuWXgHtwc3fIfb1RLljJJ9wur36L7thPqa+Y=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <50EB2B33C821234E9E7264AB3F0F5A4C@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0787024-0a84-4317-c63a-08d6a70fb8ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 17:25:28.8020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5704
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mar 12, 2019, at 10:23 AM, David Hildenbrand <david@redhat.com> wrote:
>=20
> On 12.03.19 18:14, Matthew Wilcox wrote:
>> On Tue, Mar 12, 2019 at 05:05:39PM +0000, Julien Grall wrote:
>>> On 3/12/19 3:59 PM, Julien Grall wrote:
>>>> It looks like all the arm test for linus [1] and next [2] tree
>>>> are now failing. x86 seems to be mostly ok.
>>>>=20
>>>> The bisector fingered the following commit:
>>>>=20
>>>> commit 0ee930e6cafa048c1925893d0ca89918b2814f2c
>>>> Author: Matthew Wilcox <willy@infradead.org>
>>>> Date:   Tue Mar 5 15:46:06 2019 -0800
>>>>=20
>>>>     mm/memory.c: prevent mapping typed pages to userspace
>>>>     Pages which use page_type must never be mapped to userspace as it =
would
>>>>     destroy their page type.  Add an explicit check for this instead o=
f
>>>>     assuming that kernel drivers always get this right.
>>=20
>> Oh good, it found a real problem.
>>=20
>>> It turns out the problem is because the balloon driver will call
>>> __SetPageOffline() on allocated page. Therefore the page has a type and
>>> vm_insert_pages will deny the insertion.
>>>=20
>>> My knowledge is quite limited in this area. So I am not sure how we can
>>> solve the problem.
>>>=20
>>> I would appreciate if someone could provide input of to fix the mapping=
.
>>=20
>> I don't know the balloon driver, so I don't know why it was doing this,
>> but what it was doing was Wrong and has been since 2014 with:
>=20
> Just to clarify on that point, XEN balloon does not use balloon
> compaction as far as I know (only virtio-balloon and as far as I know
> now also vmware balloon). Both of them don't map any such pages to user
> space, so it never was and isn't a problem.

I still need to submit the next version of the patches, but yes, we are not
about to map them to userspace (dah).


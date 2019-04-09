Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987C5C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6CB20820
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="G4nRo/EO";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="g9ahn0aL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfDITZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:25:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36308 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726415AbfDITZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 15:25:50 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x39JJHsN005063;
        Tue, 9 Apr 2019 12:25:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=pbyCNr9SzKR3rMO1KePwhKv+GlIK1gijJfr94zUstvg=;
 b=G4nRo/EOOw1obuWdlO55f3u+sIlTgE1cmtw4Awbe/mCdFPpedEWNxEk9iQGs5aW86u6O
 N7iC/ZDwuhC2OBYF9RwPIcYUn0dGr0jmdxB6DshUTuo8dWQiNjBJ+TrDHAgncJgRrBj4
 6e5+JJqAZXrHTwM7RRSJtlUaj37pHMz0QmI= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rs0nb88ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 09 Apr 2019 12:25:44 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 9 Apr 2019 12:25:43 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 9 Apr 2019 12:25:43 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 9 Apr 2019 12:25:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbyCNr9SzKR3rMO1KePwhKv+GlIK1gijJfr94zUstvg=;
 b=g9ahn0aLRnMDszNSwi5jBck/uxshf+6c//9CNERePfGG7gjOBZRUYm210/nQCPA39dv+bvZf1Y6YTqoHt7F2Ce+wvmAucBR9gbPMOA1XVsC89XhCpIQbYW0wHxEFLJbuibsD0ofrN+8hXizLmher82aLCPw44hkWNdV9Sd/2AX0=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2294.namprd15.prod.outlook.com (52.135.197.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Tue, 9 Apr 2019 19:25:40 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%3]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 19:25:40 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] mm/vmstat: fix /proc/vmstat format for
 CONFIG_DEBUG_TLBFLUSH=y CONFIG_SMP=n
Thread-Topic: [PATCH] mm/vmstat: fix /proc/vmstat format for
 CONFIG_DEBUG_TLBFLUSH=y CONFIG_SMP=n
Thread-Index: AQHU7tRd8udGiTW/AEmGR64qjpN4YqYzz0sAgAADOwCAABT8AIAATtgA
Date:   Tue, 9 Apr 2019 19:25:40 +0000
Message-ID: <20190409192534.GA29340@tower.DHCP.thefacebook.com>
References: <155481488468.467.4295519102880913454.stgit@buzz>
 <a606145d-b2e6-a55d-5e62-52492309e7dc@suse.cz>
 <bfcc286e-48dd-8069-3287-a923e4b5ab65@yandex-team.ru>
 <81880eb3-ab26-e968-1820-5d5e46f82836@suse.cz>
In-Reply-To: <81880eb3-ab26-e968-1820-5d5e46f82836@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:102:2::20) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:3465]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b54d1d1-2988-4cc1-3cfe-08d6bd2126a0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2294;
x-ms-traffictypediagnostic: BYAPR15MB2294:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR15MB229403E6D16A6BAF8D92869DBE2D0@BYAPR15MB2294.namprd15.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(53936002)(6436002)(966005)(25786009)(1076003)(93886005)(6246003)(33656002)(68736007)(99286004)(4326008)(256004)(14444005)(229853002)(6916009)(106356001)(76176011)(53546011)(6506007)(46003)(386003)(316002)(102836004)(486006)(476003)(186003)(478600001)(11346002)(6512007)(9686003)(7736002)(446003)(14454004)(105586002)(305945005)(6306002)(2906002)(52116002)(6486002)(6116002)(54906003)(71190400001)(71200400001)(81166006)(97736004)(81156014)(8676002)(5660300002)(86362001)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2294;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R/Fg10njT1dqrMQT0D2dRMpKC78ZRw0E9VrOU3iaIcfMmhLqXlQrW1DFbV5UegVMErtS0upwwa9sY68cSvJ1GNWH2C9vOC5kfo1KGOJ8MwkT6pVAN00gU6QA/lUZEPvnfo+Z10p0pD929LhodvouRbE/tU8MIQNdC7bVwzBbZhgRTcpUjTDO8rBiYTe2iyXuCJO4raozg4uEXt2p/zlXkdH+IfZvRfZiKWHuA8+DvZU+PQSUJhnkA/4Y/kvvpsU4MmQnx0hWkTNKs6ANeUzJ8buqkXEhvf/v8IGgifUB8SJtDaOIMWtbVuD9AV7nHbMYvcVAza9+3CCXhkseqCSnPUvFIm7fWCgU13EVq40u1XNYO1uRhtl8AEm4E7WY6NmMITbcq9pHVFFuX/8t3QkwNacjOPDTEX8OGz08moS7H68=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <510B44D47C8B6E42875A6531E67CD72B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b54d1d1-2988-4cc1-3cfe-08d6bd2126a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 19:25:40.2952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2294
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 04:43:24PM +0200, Vlastimil Babka wrote:
> On 4/9/19 3:28 PM, Konstantin Khlebnikov wrote:
> > On 09.04.2019 16:16, Vlastimil Babka wrote:
> >> On 4/9/19 3:01 PM, Konstantin Khlebnikov wrote:
> >>> Commit 58bc4c34d249 ("mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly=
")
> >>> depends on skipping vmstat entries with empty name introduced in comm=
it
> >>> 7aaf77272358 ("mm: don't show nr_indirectly_reclaimable in /proc/vmst=
at")
> >>> but reverted in commit b29940c1abd7 ("mm: rename and change semantics=
 of
> >>> nr_indirectly_reclaimable_bytes").
> >>=20
> >> Oops, good catch.
> >=20
> > Also 4.19.y has broken format in /sys/devices/system/node/node*/vmstat =
and /proc/zoneinfo.
> > Do you have any plans on pushing related slab changes into that stable =
branch?
>=20
> Hmm do you mean this?
> https://lore.kernel.org/linux-mm/20181030174649.16778-1-guro@fb.com/
>=20
> Looks like Roman marked it wrongly for # 4.14.x-4.18.x and I didn't notic=
e, my
> slab changes are indeed 4.20, so we should resend for 4.19.

Oops, my bad. I believe 4.19 hasn't been released at that time, so I missed=
 it.
Thanks for noticing!

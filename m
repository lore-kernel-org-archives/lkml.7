Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F7FC04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594D0214AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="D5hpyzfe";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZE65bTfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfLISEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:04:39 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6456 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbfLISEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:04:38 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9HuxAl000382;
        Mon, 9 Dec 2019 10:04:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5GFSeL1NVoDFgAC+vRaIBksqNHZ/hDT8bk7uDk6pivU=;
 b=D5hpyzfe6vf0cahf8xvWKFZFTqS6iemyXGubJBqYHmS6gmFADrY/XEiRbVV8ltxztrYW
 AzTk9HCHWwODV5l0DSLLYPXk7bPS3BhgfJ0+1HMKT20Nd9xIFDltq8Opg5W94zdrDQTH
 iqs6KfnAaJb+sVNoJcNd0yVbHi/s6vpgfUQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wrvp0pacb-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Dec 2019 10:04:28 -0800
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 9 Dec 2019 10:04:24 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 9 Dec 2019 10:04:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dm0e15yU5anmOfwr85X9mIsgE1QPyA8elm9Zxfe/6h3dpqLbb27/2nWEFPFyNKIA9Fe6N5SHyKCmEueJZ/VhmeAMNU0i7kycMHFWn8dUJNZAO1tLs9IXKKT3UhRHzUQFkxQB3bhnZWeOghfFl8ZkwIzIHmGDDUaJ0WbqHRwVsEe82U0H0trfzUwDCEPrBCMYeTIq4sQGuxAZtlAugSY1s/gbKe7OVHdXXruiRZcOu0LZoGnYTxObHjfhURQjz7ClmG2s7HyupODqUn39jKG0OqHzldjLD+cI/zsXASeSK9sPtlBUdsK8NuIZkNovQGcz6xvsEacG7DWz030puwIP2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GFSeL1NVoDFgAC+vRaIBksqNHZ/hDT8bk7uDk6pivU=;
 b=MU6dFNQm3wxjGDbJSOp66H7eWdHhzGFfHqs8q6Sr+bQhkFIctg8QxwYDKHvNMPHWVgp9pFXAAUd8ncsdCaz01zu0Ecc4GBTXfzoBgjSYunfN65+HZm23gtNAepXmjwcpMdiOij1LMS37nGkP6oZCSTNYty3kdTG4OQBv9kYpYbkaX3+loiHWyJoFs0zzLCnGWIG38Qs1FslCJL4J/8pa3UcgXxM3qhMP9SqRiabusWj94ak96fsYfUnNp5uajGYNdLi06DqWCy9jZ83HayMUmFR06oJaTYYHPP+SsatPBABudB360pYTtw6k1ABwvaRUYzVygm2aHy43V3foNFO1lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GFSeL1NVoDFgAC+vRaIBksqNHZ/hDT8bk7uDk6pivU=;
 b=ZE65bTfkT+8/VZPxKRs7LhfDTJ278JKJ0+HGx6dx7Ldxjjm1BifUc4602kwX33c8OLB2Ulq7T4j7i5OndU/xY8myo8j4uOhnTrelONsa5Q/n6PsEkkBY7Ip2qGDs8Gmg8yDc1pl0meEaFJrqkCWd7aTxk6/wnXGBa/t3ivwsyaQ=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2519.namprd15.prod.outlook.com (20.179.155.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Mon, 9 Dec 2019 18:04:23 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60%3]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 18:04:23 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Bharata B Rao <bharata@linux.ibm.com>
CC:     "mhocko@kernel.org" <mhocko@kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "longman@redhat.com" <longman@redhat.com>
Subject: Re: [PATCH 00/16] The new slab memory controller
Thread-Topic: [PATCH 00/16] The new slab memory controller
Thread-Index: AQHVrnGR5S0BeZVm/Uu7NV5uFsOBDKexspaAgABmrQA=
Date:   Mon, 9 Dec 2019 18:04:22 +0000
Message-ID: <20191209180418.GA15797@localhost.localdomain>
References: <20190905214553.1643060-1-guro@fb.com>
 <20191209091746.GA16989@in.ibm.com> <20191209115649.GA17552@in.ibm.com>
In-Reply-To: <20191209115649.GA17552@in.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0184.namprd04.prod.outlook.com
 (2603:10b6:104:5::14) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::aa34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 892165df-91be-440b-3257-08d77cd23840
x-ms-traffictypediagnostic: BYAPR15MB2519:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2519E82D1F8BC24245757EC4BE580@BYAPR15MB2519.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(366004)(346002)(396003)(199004)(189003)(6512007)(52116002)(9686003)(33656002)(8676002)(229853002)(6506007)(186003)(4326008)(71190400001)(81166006)(81156014)(71200400001)(66946007)(8936002)(6916009)(66476007)(66556008)(305945005)(45080400002)(478600001)(86362001)(316002)(2906002)(54906003)(5660300002)(66446008)(64756008)(1076003)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2519;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oh1HCKFbWGbScDTY9bXNU2dhcSOFG+vtNVahiAmXKu8+vOFNSHMejOmVSQdGe1rFjYQQdUCefIzX5RcGi3BfvqO6ow6yANgVN7vu7bfsABKcpmonLne9E2WjeIWJXTNqOjZFmi3WSb7Xziy7XMg6zH2fMEfsvmReoeQOECXHr6xXbseQFWyQn/y0J8Ce8Dn2YqpGr8MpN79lEi6Q/15jwKCbo3IGAe0vV1V6CUCaT6POb/8TsCAZt5E4s/xK5tN7LlkRSIDaJ8rILUf/eSDqM/tgC3BBiwL5FEzVlVS3W9H3/3bvXz0EfdphwDJyZxWbsumz4pUoU4pXDh3IFmerKipG4WMpCd5gKFJQ4qQKbh0KqJ5lXjbdsqPOb66Kn79cpMlFcerxm/LPIKxpV/+s7cf5Hirnw8Vsgde5sa1N+st7RltidzBji7QfQoQvoXQJ
Content-Type: text/plain; charset="us-ascii"
Content-ID: <95AC369EF77A324EBDFFB3274B615CE9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 892165df-91be-440b-3257-08d77cd23840
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 18:04:22.8540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yPDMrQod+7wzeTXrABXlNCJ3oKz9cPipyxVfo+1HawI4o2TYJWGV26zaeMmlKuwg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2519
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_04:2019-12-09,2019-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 clxscore=1011
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912090144
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 05:26:49PM +0530, Bharata B Rao wrote:
> On Mon, Dec 09, 2019 at 02:47:52PM +0530, Bharata B Rao wrote:
> > Hi,
> >=20
> > I see the below crash during early boot when I try this patchset on
> > PowerPC host. I am on new_slab.rfc.v5.3 branch.
> >=20
> > BUG: Unable to handle kernel data access at 0x81030236d1814578
> > Faulting instruction address: 0xc0000000002cc314
> > Oops: Kernel access of bad area, sig: 11 [#1]
> > LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA PowerNV
> > Modules linked in: ip_tables x_tables autofs4 sr_mod cdrom usbhid bnx2x=
 crct10dif_vpmsum crct10dif_common mdio libcrc32c crc32c_vpmsum
> > CPU: 31 PID: 1752 Comm: keyboard-setup. Not tainted 5.3.0-g9bd85fd72a0c=
 #155
> > NIP:  c0000000002cc314 LR: c0000000002cc2e8 CTR: 0000000000000000
> > REGS: c000001e40f378b0 TRAP: 0380   Not tainted  (5.3.0-g9bd85fd72a0c)
> > MSR:  900000010280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: =
44022224  XER: 00000000
> > CFAR: c0000000002c6ad4 IRQMASK: 1=20
> > GPR00: c0000000000b8a40 c000001e40f37b40 c000000000ed9600 0000000000000=
000=20
> > GPR04: 0000000000000023 0000000000000010 c000001e40f37b24 c000001e3cba3=
400=20
> > GPR08: 0000000000000020 81030218815f4578 0000001e50220000 0000000000000=
030=20
> > GPR12: 0000000000002200 c000001fff774d80 0000000000000000 0000000107260=
0d8=20
> > GPR16: 0000000000000000 c0000000000bbaac 0000000000000000 0000000000000=
000=20
> > GPR20: c000001e40f37c48 0000000000000001 0000000000000000 c000001e3cba3=
400=20
> > GPR24: c000001e40f37dd8 0000000000000000 c000000000fa0d58 0000000000000=
000=20
> > GPR28: c000001e3a080080 c000001e32da0100 0000000000000118 0000000000000=
010=20
> > NIP [c0000000002cc314] __mod_memcg_state+0x58/0xd0
> > LR [c0000000002cc2e8] __mod_memcg_state+0x2c/0xd0
> > Call Trace:
> > [c000001e40f37b90] [c0000000000b8a40] account_kernel_stack+0xa4/0xe4
> > [c000001e40f37bd0] [c0000000000ba4a4] copy_process+0x2b4/0x16f0
> > [c000001e40f37cf0] [c0000000000bbaac] _do_fork+0x9c/0x3e4
> > [c000001e40f37db0] [c0000000000bc030] sys_clone+0x74/0xa8
> > [c000001e40f37e20] [c00000000000bb34] ppc_clone+0x8/0xc
> > Instruction dump:
> > 4bffa7e9 2fa30000 409e007c 395efffb 3d000020 2b8a0001 409d0008 39000020=
=20
> > e93d0718 e94d0028 7bde1f24 7d29f214 <7ca9502a> 7fff2a14 7fe9fe76 7d27fa=
78=20
> >=20
> > Looks like page->mem_cgroup_vec is allocated but not yet initialized
> > with memcg pointers when we try to access them.
> >=20
> > I did get past the crash by initializing the pointers like this
> > in account_kernel_stack(),
>=20
> The above is not an accurate description of the hack I showed below.
> Essentially I am making sure that I get to the memcg corresponding
> to task_struct_cachep object in the page.

Hello, Bharata!

Thank you very much for the report and the patch, it's a good catch,
and the code looks good to me. I'll include the fix into the next
version of the patchset (I can't keep it as a separate fix due to massive
renamings/rewrites).

>=20
> But that still doesn't explain why we don't hit this problem on x86.

On x86 (and arm64) we're using vmap-based stacks, so the underlying memory =
is
allocated directly by the page allocator, bypassing the slab allocator.
It depends on CONFIG_VMAP_STACK.

Btw, thank you for looking into the patchset and trying it on powerpc.
Would you mind to share some results?

Thank you!

Roman

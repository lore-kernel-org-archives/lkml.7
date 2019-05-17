Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38837C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FBA2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kZIxusP5";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="AIQLFJNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfEQQdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 12:33:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43052 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725932AbfEQQdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 12:33:06 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4HGROD8010662;
        Fri, 17 May 2019 09:32:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=NJ3hso/WmOgSS+6n1y+qSQvU0a0Ih98TNQn/HvLliMM=;
 b=kZIxusP5Z1aZReXpNgEOfnqjFmhl+nj+1MqOUMRN5XoY5rnpwrdah+zQxgSjFM7Ydxoj
 Kj7+KREBmEKuOuJtuiPjxQOfhxdeIB96xvmNIeGw+VOUwiTpd3XD8mpVTts3dR7uXHFG
 2llkY+Z6USiFN8VPHxev2qaw7q4xjuCUls4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0b-00082601.pphosted.com with ESMTP id 2sht77987t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 May 2019 09:32:50 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 17 May 2019 09:32:49 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 17 May 2019 09:32:49 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 17 May 2019 09:32:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ3hso/WmOgSS+6n1y+qSQvU0a0Ih98TNQn/HvLliMM=;
 b=AIQLFJNkLR+b+lZ2DyFd9TPcNODpEnYJvyVCvo/vV78NJ/TenyKFPwrc4hlHoHtwAqckM09S6QI8jV5Oi5aWIO2xwUehabmNiTdFnhSElcF963wBSPW3kYskJzOk0L2gBrMK0MRUi+oNsQ4aqmCqI4oCn0jVFcMhKAqAFtTx1Dk=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1615.namprd15.prod.outlook.com (10.175.135.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Fri, 17 May 2019 16:32:47 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%11]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 16:32:47 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "kasong@redhat.com" <kasong@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
Thread-Topic: Getting empty callchain from perf_callchain_kernel()
Thread-Index: AQHVDEJXbyjc1nknl06FlgTGlvLrzKZu8J8AgAAG+ICAAIw1AA==
Date:   Fri, 17 May 2019 16:32:47 +0000
Message-ID: <8EF9E8F7-0B89-43E2-B767-AECD86E627B5@fb.com>
References: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com>
 <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
 <20190517081057.GQ2650@hirez.programming.kicks-ass.net>
In-Reply-To: <20190517081057.GQ2650@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::2:7648]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cd2a4e7-9385-40a5-27d5-08d6dae54c05
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1615;
x-ms-traffictypediagnostic: MWHPR15MB1615:
x-microsoft-antispam-prvs: <MWHPR15MB1615B7229ADAC8DACF0EE797B30B0@MWHPR15MB1615.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39860400002)(396003)(189003)(199004)(81166006)(229853002)(6246003)(81156014)(6506007)(8676002)(46003)(6436002)(6512007)(33656002)(5660300002)(6486002)(8936002)(86362001)(54906003)(14454004)(36756003)(14444005)(256004)(2906002)(82746002)(4326008)(186003)(57306001)(53546011)(68736007)(50226002)(316002)(66556008)(7736002)(64756008)(66946007)(53936002)(66446008)(486006)(73956011)(66476007)(305945005)(476003)(76116006)(2616005)(25786009)(478600001)(11346002)(446003)(99286004)(6916009)(83716004)(71190400001)(102836004)(71200400001)(6116002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1615;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +F9Gbpmv/5yrFSawFZqyjwJiZIliDbpBfZO9BSwmQXRV5K8KUyhuAfCzpYrvqcwZQDNsqyaa60b4S7PGginvzIcM9NaKpbmQhiwo6k/Sp1wk4xEeEkbkt8ys1fbKftP8M+zENEq6yJCCoIT5vDCiBseWaH8SQzyOwlRYzr7+eBdtDsYw8qfW/WUyPkPvo773Up7Jjrd0svHPgigWfG2DkrwZWlppnyWLtkOz/OfURm0eWFY7un/vn0AKtKvTT+NZUejdpCXP40ge+QD3RzsbRQC1MXllHfKG1JhbD1vwZ9/Zmkx016b+hMjIitqVJ6A9f+W0ZKWQ11QAC0lrNr8RCfv8bii7aKaY8zrLWdtYmpx1M0OF1mLmp/DWsWNQFa1WEyA4CYBRBe9rdfhpF7bM/rY1XThbs4lxu0qNqMNy/HQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3DCF5FA2E41BC4390A1C0C59C671E04@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd2a4e7-9385-40a5-27d5-08d6dae54c05
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 16:32:47.5644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1615
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-17_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905170099
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 17, 2019, at 1:10 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Fri, May 17, 2019 at 09:46:00AM +0200, Peter Zijlstra wrote:
>> On Thu, May 16, 2019 at 11:51:55PM +0000, Song Liu wrote:
>>> Hi,=20
>>>=20
>>> We found a failure with selftests/bpf/tests_prog in test_stacktrace_map=
 (on bpf/master
>>> branch).=20
>>>=20
>>> After digging into the code, we found that perf_callchain_kernel() is g=
iving empty
>>> callchain for tracepoint sched/sched_switch. And it seems related to co=
mmit
>>>=20
>>> d15d356887e770c5f2dcf963b52c7cb510c9e42d
>>> ("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")
>>>=20
>>> Before this commit, perf_callchain_kernel() returns callchain with regs=
->ip. With
>>> this commit, regs->ip is not sent for !perf_hw_regs(regs) case.=20
>>=20
>> So while I think the below is indeed right; we should store regs->ip
>> regardless of the unwind path chosen, I still think there's something
>> fishy if this results in just the 1 entry.
>>=20
>> The sched/sched_switch event really should have a non-trivial stack.
>>=20
>> Let me see if I can reproduce with just perf.
>=20
> $ perf record -g -e "sched:sched_switch" -- make clean
> $ perf report -D
>=20
> 12 904071759467 0x1790 [0xd0]: PERF_RECORD_SAMPLE(IP, 0x1): 7236/7236: 0x=
ffffffff81c29562 period: 1 addr: 0
> ... FP chain: nr:10
> .....  0: ffffffffffffff80
> .....  1: ffffffff81c29562
> .....  2: ffffffff81c29933
> .....  3: ffffffff8111f688
> .....  4: ffffffff81120b9d
> .....  5: ffffffff81120ce5
> .....  6: ffffffff8100254a
> .....  7: ffffffff81e0007d
> .....  8: fffffffffffffe00
> .....  9: 00007f9b6cd9682a
> ... thread: sh:7236
> ...... dso: /lib/modules/5.1.0-12177-g41bbb9129767/build/vmlinux
>=20

Hmm... I also get this FP chain even with CONFIG_UNWINDER_ORC=3Dy.=20
I guess it is actually from ORC?=20

Thanks,
Song=20


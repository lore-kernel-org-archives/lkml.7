Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AFDC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 23:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A4620815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 23:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qYJkR7CO";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="gbRiMWP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfEPXwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 19:52:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44100 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726523AbfEPXwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 19:52:13 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x4GNgRSq030202;
        Thu, 16 May 2019 16:51:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=KpK2qlgYpFNsxONJ17kK+Zs+kjfkCPZW7FB4LBExeZM=;
 b=qYJkR7COGNhi4TrfNCYQMXxicsP+POJZhP2f/wblr8uRvHXkmTmy342UtozNQopHS+XO
 +WW1Vjbj0GxkYcBrPkiEPIbflhi9FLn6VishKejWepgBmUnos68mPKnhNIVflvfxDOC9
 Wh1z0b+VrT7D/tPk0Ryf04yFHR/vTG1PDKQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2shh8qg3qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 May 2019 16:51:58 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 16 May 2019 16:51:57 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 16 May 2019 16:51:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpK2qlgYpFNsxONJ17kK+Zs+kjfkCPZW7FB4LBExeZM=;
 b=gbRiMWP8nHSw69tB1osNNN8A5EZK2DjMl+vA2n0Im8W/55WXu73/x1Vr9yqdsncfw3bNKsj7HlL8C6cty0eRyJE+nM615PyIB2ShxvugGoJj6LQEgy/C5wFKZhqKk/3HPsPg7Z+2Dn2W+mNyep8JJxeHa07/kUDry6arVgbp3DY=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1150.namprd15.prod.outlook.com (10.175.2.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Thu, 16 May 2019 23:51:56 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%11]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 23:51:56 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "kasong@redhat.com" <kasong@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Getting empty callchain from perf_callchain_kernel() 
Thread-Topic: Getting empty callchain from perf_callchain_kernel() 
Thread-Index: AQHVDEJXYtrotGS6bU+cxwR7BKWjbA==
Date:   Thu, 16 May 2019 23:51:55 +0000
Message-ID: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::1:73ac]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7be8c581-a0c3-4204-3870-08d6da597a6c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1150;
x-ms-traffictypediagnostic: MWHPR15MB1150:
x-microsoft-antispam-prvs: <MWHPR15MB11507358BA094A6619CCA2BFB30A0@MWHPR15MB1150.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(39860400002)(346002)(51874003)(199004)(189003)(66946007)(305945005)(73956011)(6486002)(5660300002)(36756003)(64756008)(2616005)(476003)(66556008)(66476007)(86362001)(7736002)(66446008)(33656002)(6436002)(82746002)(76116006)(478600001)(6512007)(486006)(6116002)(14454004)(14444005)(256004)(6506007)(57306001)(186003)(71200400001)(83716004)(71190400001)(8936002)(2906002)(68736007)(99286004)(2501003)(46003)(50226002)(4743002)(4326008)(110136005)(54906003)(316002)(102836004)(25786009)(81166006)(8676002)(81156014)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1150;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZWCETRn1B/zffy4IQ0LQGAxoy7ufAGA30+4rBBDSNCg0YyneJ+Kloq4dNSYGTogZzlSlQlPiIYh2TSTBfZF4iIwuxyIouZPqLv/mzqFB8tXmEZNGW7HO4csRL9QbmF10JNI5EVftGYZjL/NlCsideHOVtotB/5UZCq3XRtS9eXX2a3Wx1s0q+3G5pDZYGwPA6Gry623bKBQyopRI59ykI2jYljRgVOpde+FJL2QFUnLaaXBIQa1cEJqjKWFxDFwH/ukK5vu3Hmyk8x/uoFOOpGBzoLWtoQ4wskddH/nv+d94MaSVEm7dc7TTgxEt5VyqytE8J9uUbls6nEIHlYqL3MbqvpucU4vhRiaRRGjMIZQK+idbv61C/pmSlZHoVyt5UvXd1JJ7YLNlObB+tRajcQJ+2p3FjMxUeA3xI2/o/wg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22E648044058D844ADB93EB37E311ECC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be8c581-a0c3-4204-3870-08d6da597a6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 23:51:55.8579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1150
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-16_19:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905160144
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=20

We found a failure with selftests/bpf/tests_prog in test_stacktrace_map (on=
 bpf/master
branch).=20

After digging into the code, we found that perf_callchain_kernel() is givin=
g empty
callchain for tracepoint sched/sched_switch. And it seems related to commit

d15d356887e770c5f2dcf963b52c7cb510c9e42d
("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")

Before this commit, perf_callchain_kernel() returns callchain with regs->ip=
. With
this commit, regs->ip is not sent for !perf_hw_regs(regs) case.=20

I found the following change fixes the selftest. But I am not very sure, it=
 is=20
the best solution here.=20

Please share comments and suggestions on this.=20

Thanks in advance!

Song


diff --git i/arch/x86/events/core.c w/arch/x86/events/core.c
index f315425d8468..7b8a9eb4d5fd 100644
--- i/arch/x86/events/core.c
+++ w/arch/x86/events/core.c
@@ -2402,9 +2402,9 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx=
 *entry, struct pt_regs *re
                return;
        }

+       if (perf_callchain_store(entry, regs->ip))
+               return;
        if (perf_hw_regs(regs)) {
-               if (perf_callchain_store(entry, regs->ip))
-                       return;
                unwind_start(&state, current, regs, NULL);
        } else {
                unwind_start(&state, current, NULL, (void *)regs->sp);




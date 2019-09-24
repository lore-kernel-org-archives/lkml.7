Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B237AC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C083217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IA08SVyz";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="kLnhlD6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501901AbfIXRYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 13:24:33 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:14330 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439388AbfIXRYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 13:24:33 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8OHJek1024044;
        Tue, 24 Sep 2019 10:23:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=g7YPSGUerHh/sdizMdKM8U9/L433ZWlY2ZfOHL/FftM=;
 b=IA08SVyzrLlZ3KyliJX9UofgMAkch1dHlzMTmPxUSdYfcjVh6DWt8ZCgffot0oHpIkKb
 9oi94TvrjsO3j1Io1alM7zsbSTa6JWkBcyKObBiStSFPrIBdnCPvlHjB1/FeN8zk2aK4
 MMrd7mw/o4s9l0zUS4h1UgaaUHOUZuvv8h8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2v5ssfd2c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Sep 2019 10:23:37 -0700
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Sep 2019 10:23:36 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 24 Sep 2019 10:23:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIDlmCE07fyI2tL0y9AJ2JvvxqwxKsX1wzG56RM3LmvjUhWio9kZ33rgDh6WsLiFQaZ/Gz6uHOHPSr9QP7i0+xwIz8qWl5YzjMLzjP4q2umfWbpqlzFCclPcW6zxWWF+zKVxThm24/5s7z7/Taivl3tae4KqoIu2nV7Y1yaSOjMWBppRMVeRKOHJAso5bnY3z6xU6tf2RQX8+FjbMnMexnamE/itldNpLj5oyvk0V+HWtjV5nGT9CsdDlB0PVvNROU7RqGdcbKDeZ9C/ET/UFq++el2URzuHne4RT1pFZHZe4LNm6rZZHK7gW15n9ok3MrZ3o2mfVLseEdiIJzBiog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7YPSGUerHh/sdizMdKM8U9/L433ZWlY2ZfOHL/FftM=;
 b=eCPRE23mY/+obSa1nNNowP9tNrXrVrRzR3TOEIOW/TmBxAlPTc69Isb+wQMZi6tgiXXraAgj7e8ywN2L5lqG2jpTug7e/+X5m5TdxdxwliVjh0E2KYu5X0Wowe2loMPbPBENeVWp/dfRqY+Fzxyn1c0OUyEXCLGIHNORIB06RvXhA1KRRQZi2HknfFHaydD6WbHK1vUN8KIzewAzcxjcN380gJsji5FXC66ylUBHVxRrn+gW5tEOAeC1ujwsxxVmWgfmdDC7COKOL+tmfAiueJ+TmN0ya2aFlqbgeG/3KsEbj3cnO7TOHH8ETpNkXgkOWlAjeoxfhlZSB/Xqd64ojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7YPSGUerHh/sdizMdKM8U9/L433ZWlY2ZfOHL/FftM=;
 b=kLnhlD6AJT+G8p1GAzOfU/MldRSJzzrIpsaLREmK/JOOCw3kz5UeXteI2G8u7B/f/iKKPttRv4yG2rowcenJ8YHnVDzWkl1V3k9m+i1E2cqXRWcIkArNS0AyUHrmkJE1YZFZmdlw6Hi39ROLbcHt9Zov6B6LJ8tC/79KGxnn9/g=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2897.namprd15.prod.outlook.com (20.178.218.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.21; Tue, 24 Sep 2019 17:23:35 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::8174:3438:91db:ec29]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::8174:3438:91db:ec29%5]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 17:23:35 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC] mm: memcg: add priority for soft limit reclaiming
Thread-Topic: [RFC] mm: memcg: add priority for soft limit reclaiming
Thread-Index: AQHVcqrcmh/ExiaGZUaasMlnhte8a6c60xEAgABBKgA=
Date:   Tue, 24 Sep 2019 17:23:35 +0000
Message-ID: <20190924172330.GB1978@tower.DHCP.thefacebook.com>
References: <20190924073642.3224-1-hdanton@sina.com>
 <20190924133016.GT23050@dhcp22.suse.cz>
In-Reply-To: <20190924133016.GT23050@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2001CA0021.namprd20.prod.outlook.com
 (2603:10b6:301:15::31) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:7406]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a9d255b-2b91-4e0d-2f31-08d74113ee1d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN8PR15MB2897;
x-ms-traffictypediagnostic: BN8PR15MB2897:
x-microsoft-antispam-prvs: <BN8PR15MB2897878BECF5B1034426C86EBE840@BN8PR15MB2897.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(39860400002)(396003)(366004)(189003)(199004)(11346002)(316002)(6916009)(5660300002)(478600001)(486006)(6436002)(186003)(446003)(81156014)(46003)(8676002)(81166006)(86362001)(8936002)(6512007)(7736002)(9686003)(229853002)(99286004)(476003)(25786009)(6486002)(6116002)(66476007)(6506007)(386003)(54906003)(33656002)(52116002)(256004)(14454004)(71200400001)(66946007)(14444005)(66556008)(71190400001)(66446008)(64756008)(76176011)(4326008)(102836004)(2906002)(6246003)(1076003)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2897;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aZPMFSKrw4/cXx/A8ipA8CJgs/6GGiXYZYTIQKnuqEev5G8Jp5Mk9jPVyFTG36zWvxFUJOOZZ9bfrFLUXCUOKBKU9AwdmfFX7MtwxxQAwExJyCojUqw/k5XS7sK8GIAjSYCova87smyO9KxDGuQdCEzwdnUPmHdWUj0IadNMF3ZGww5+ukvzlfqfapDRXaJ2+L/P8PYhSviI9cFfYTRAPv7zwALY6jWWr6v4GaAAScpE042J5qr4eKWNpjKkruRMS0YVJsfMW9Kef0YI5s7auFjbBMHJBcD/rHjC6jDIrs4MTB9jVLVgklYYRTEoPqc+iOz4wAlf4ojf69WM+WAKBQwU/SZqmA/J9mBhsB5jKmlnFQD88xMtVFcWCNuztCCJ7Szzz5vZtfKBYSIvgw0pHU4Dz4KT14tqIE92ZYv1pF0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2F1233EDA5E1E24196541AC12BC8C1BE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9d255b-2b91-4e0d-2f31-08d74113ee1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 17:23:35.3077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DcwQ0g+zUM1OK0apMFeYI9BE+C1k/C/WnNI09Mu8lndmDqXKMMAcjJUzxr4Ptu/Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2897
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-24_07:2019-09-23,2019-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 phishscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909240151
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 03:30:16PM +0200, Michal Hocko wrote:
> On Tue 24-09-19 15:36:42, Hillf Danton wrote:
> >=20
> > On Mon, 23 Sep 2019 21:28:34 Michal Hocko wrote:
> > >=20
> > > On Mon 23-09-19 21:04:59, Hillf Danton wrote:
> > > >
> > > > On Thu, 19 Sep 2019 21:32:31 +0800 Michal Hocko wrote:
> > > > >
> > > > > On Thu 19-09-19 21:13:32, Hillf Danton wrote:
> > > > > >
> > > > > > Currently memory controler is playing increasingly important ro=
le in
> > > > > > how memory is used and how pages are reclaimed on memory pressu=
re.
> > > > > >
> > > > > > In daily works memcg is often created for critical tasks and th=
eir pre
> > > > > > configured memory usage is supposed to be met even on memory pr=
essure.
> > > > > > Administrator wants to make it configurable that the pages cons=
umed by
> > > > > > memcg-B can be reclaimed by page allocations invoked not by mem=
cg-A but
> > > > > > by memcg-C.
> > > > >
> > > > > I am not really sure I understand the usecase well but this sound=
s like
> > > > > what memory reclaim protection in v2 is aiming at.
> > > > >
> > > Please describe the usecase.
> > >=20
> > It is for quite a while that task-A has been able to preempt task-B for
> > cpu cycles. IOW the physical resource cpu cycles are preemptible.
> >=20
> > Are physical pages are preemptible too in the same manner?
> > Nope without priority defined for pages currently (say the link between
> > page->nice and task->nice).
> >=20
> > The slrp is added for memcg instead of nice because 1) it is only used
> > in the page reclaiming context (in memcg it is soft limit reclaiming),
> > and 2) it is difficult to compare reclaimer and reclaimee task->nice
> > directly in that context as only info about reclaimer and lru page is
> > available.
> >=20
> > Here task->nice is replaced with memcg->slrp in order to do page
> > preemption, PP. There is no way for task-A to PP task-B, but the
> > group containing task-A can PP the group containing task-B.
> > That preemption needs code within 100 lines as you see on top of
> > the current memory controller framework.
>=20
> This is exactly what the reclaim protection in memcg v2 is meant to be
> used for. Also soft limit reclaim is absolutely terrible to achieve that
> because it is just too gross to result in any smooth experience (just
> have a look how it is doing priority 0 scannig!).
>=20
> I am not going to even go further wrt the implementation because I
> belive the priority is even semantically broken wrt hierarchical
> behavior.
>=20
> But really, make sure you look into the existing feature set that memcg
> v2 provides already and come back if you find it unsuitable and we can
> move from there. Soft limit reclaim is dead and we should let it RIP.

Can't agree more here.

Cgroup v2 memory protection mechanisms (memory.low/min) should perfectly
solve the described problem. If not, let's fix them rather than extend soft
reclaim which is already dead.

Thanks!

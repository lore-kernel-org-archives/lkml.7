Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA174C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671D020830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="c1G3/Csg";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XD65v0sq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387483AbfDJQjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:39:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40844 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731199AbfDJQjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:39:35 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3AGb8vF032439;
        Wed, 10 Apr 2019 09:38:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=6Zf+0GO20JMRxuYupZdCAEfNMQAXzeSewE20VmKy428=;
 b=c1G3/CsgGfXYh3tsBJnJzAT18WNPMNECMNhPCSlE96MkgTB6jKGvaIUqIOWu/q7hgbyH
 kiy0TweQx1H1W+fQOn2KsqL3n0hJG2443N2imBWpnmjaUuvtgNN4OjJzdLvNu5R3ocif
 RcinjXPCJQR7K21p4QWhTF+mFVjFxs+JKrI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rsm5tg1b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Apr 2019 09:38:27 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 10 Apr 2019 09:38:01 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 10 Apr 2019 09:38:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Zf+0GO20JMRxuYupZdCAEfNMQAXzeSewE20VmKy428=;
 b=XD65v0sqY0+GQvjluJ8IBXniuhk3eamcvBI0P4RfNuG0DeJev6VRV4H1tYZkOWMe6Mx5r4lS61wTo3H4+jlj8YYqMXlPBPowERiSxDyB1ligdZ54b/lBWnQn203D40AHYSVWr5g/u9em+CjRitMkRbSVEooq2pHWO7WNOToqhT8=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB3367.namprd15.prod.outlook.com (20.179.58.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Wed, 10 Apr 2019 16:37:59 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::38bf:bbed:e968:767e]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::38bf:bbed:e968:767e%5]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 16:37:59 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Yue Haibing <yuehaibing@huawei.com>,
        "paul.burton@mips.com" <paul.burton@mips.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH] MIPS: eBPF: Make ebpf_to_mips_reg() static
Thread-Topic: [PATCH] MIPS: eBPF: Make ebpf_to_mips_reg() static
Thread-Index: AQHU76UcAusHwHQ5o06kZhGdcsmH+qY1mC4A
Date:   Wed, 10 Apr 2019 16:37:59 +0000
Message-ID: <58a14b8c-8df7-25ca-99c0-0e29b6a8642d@fb.com>
References: <20190410134923.35100-1-yuehaibing@huawei.com>
In-Reply-To: <20190410134923.35100-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1401CA0005.namprd14.prod.outlook.com
 (2603:10b6:301:4b::15) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:61dc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb4ebd36-c1b5-49a6-e683-08d6bdd2e436
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3367;
x-ms-traffictypediagnostic: BYAPR15MB3367:
x-microsoft-antispam-prvs: <BYAPR15MB3367652AB3E0127B4B3278E0D32E0@BYAPR15MB3367.namprd15.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(346002)(366004)(39860400002)(199004)(189003)(14444005)(316002)(486006)(229853002)(11346002)(6636002)(6436002)(476003)(305945005)(6486002)(2616005)(97736004)(46003)(6116002)(2906002)(105586002)(106356001)(68736007)(53936002)(71200400001)(2501003)(186003)(25786009)(110136005)(7736002)(31686004)(54906003)(446003)(7416002)(558084003)(6246003)(478600001)(81156014)(5660300002)(102836004)(14454004)(4326008)(386003)(6512007)(53546011)(2201001)(81166006)(76176011)(8676002)(8936002)(86362001)(256004)(6506007)(36756003)(52116002)(31696002)(71190400001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3367;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mIDAyhYP8waqbeKCbO6uevNUbZFMRcpIrZYqgQKkTo+JVNJ9huHyRulacHVAFNUL75C/VOsOm3Xr/h9eljW0tXjedOJCDFJ/n65xhRgNLIMvbx2xmvh4RQx+mjGLjPcc8N9lp4ApYpefHBXUncoZLUvmFoAYzGJ/T/4r3tbdyZT9/lwmP0kPGQSQfW/+J63jhV4iMUIwdt1wQR7L+j9NlTMb380nAiLVGp7CBYHVRZOohRIb/vzRoGbJTXAj96i2Ni7H62Ytb6du1d/MjIjW1f8oCReoDHDfkDPFOuqr7OlBJF1FpIxKzjjFLFjwDECqo3JYDiC9ewAUy61gYBrH/38dp2OTpjDVuIAVpvYoJXdzaRJfk2xV1YmC0XiRS97sZsNO9ICuEPdIisB3ELBm0f48jScKkU4X4GV+9roWXao=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85E2A74684D47841BB3B70D57F546882@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4ebd36-c1b5-49a6-e683-08d6bdd2e436
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 16:37:59.1910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3367
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvMTAvMTkgNjo0OSBBTSwgWXVlIEhhaWJpbmcgd3JvdGU6DQo+IEZyb206IFl1ZUhh
aWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4NCj4gDQo+IEZpeCBzcGFyc2Ugd2FybmluZzoN
Cj4gDQo+IGFyY2gvbWlwcy9uZXQvZWJwZl9qaXQuYzoxOTY6NTogd2FybmluZzoNCj4gICBzeW1i
b2wgJ2VicGZfdG9fbWlwc19yZWcnIHdhcyBub3QgZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0
aWM/DQo+IA0KPiBSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1YXdlaS5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IFl1ZUhhaWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4NCg0KQWNr
ZWQtYnk6IFlvbmdob25nIFNvbmcgPHloc0BmYi5jb20+DQo=

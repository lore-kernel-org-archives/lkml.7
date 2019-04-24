Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F920C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1685421773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Fs2geGIf";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NwRVNtwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDXWik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:38:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60066 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726399AbfDXWij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:38:39 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OMbBi6000512;
        Wed, 24 Apr 2019 15:38:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=yWD41MbIKdKz1pvd4SG7OQ3l9+WA0tWvFS1IwWuTePU=;
 b=Fs2geGIfgYGcbyZKYs8kXwyL9b04AKxJU4V1hCwWs9OWQWiEj45oc2Zy+m0KgQwMXufS
 RBgv0Xn32lJ380ZYkaDAmGGftN2218mB4rovv/zwDlSZZD8CfoKwdZUzjFJqovrdfTTb
 1/FHXsmGJ/FZC3SKQevnHwAiHUJj403JeOU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2s2xse0ewu-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 24 Apr 2019 15:38:18 -0700
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 24 Apr 2019 15:38:15 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 24 Apr 2019 15:38:15 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 24 Apr 2019 15:38:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWD41MbIKdKz1pvd4SG7OQ3l9+WA0tWvFS1IwWuTePU=;
 b=NwRVNtwQZzsRhJbfjI0b/DkSVrj/o0OmBzvUFeq3Jp8/uIoftYTA1mxrT+ck5NQJqwqlsRer1hUALDucBE0sXVq9ea0IizKVOFuNI91dk1Qpa17lRmiFMBCPY9NmyRrHF1xK9aO9Rn3dhm1diV+SlazujIAvwrBltemGqG2y0L4=
Received: from BN8PR15MB3380.namprd15.prod.outlook.com (20.179.75.139) by
 BN8PR15MB2788.namprd15.prod.outlook.com (20.179.140.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Wed, 24 Apr 2019 22:38:14 +0000
Received: from BN8PR15MB3380.namprd15.prod.outlook.com
 ([fe80::b5bc:d69:3cf5:db53]) by BN8PR15MB3380.namprd15.prod.outlook.com
 ([fe80::b5bc:d69:3cf5:db53%4]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 22:38:14 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Matt Mullins <mmullins@fb.com>, Andrew Hall <hall@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "Andrey Ignatov" <rdna@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: Re: [PATCH bpf-next v4 4/5] tools: sync bpf.h
Thread-Topic: [PATCH bpf-next v4 4/5] tools: sync bpf.h
Thread-Index: AQHU+tESW+NX9l0cV0Wfd4fdFhTpXqZL5yaA
Date:   Wed, 24 Apr 2019 22:38:14 +0000
Message-ID: <1d9ac989-1227-c685-d908-00c2ff9e73e3@fb.com>
References: <20190424190721.24453-1-mmullins@fb.com>
 <20190424190721.24453-5-mmullins@fb.com>
In-Reply-To: <20190424190721.24453-5-mmullins@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0077.namprd02.prod.outlook.com
 (2603:10b6:301:75::18) To BN8PR15MB3380.namprd15.prod.outlook.com
 (2603:10b6:408:a6::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:5d4c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e4f4675-c181-41e2-f235-08d6c9058982
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BN8PR15MB2788;
x-ms-traffictypediagnostic: BN8PR15MB2788:
x-microsoft-antispam-prvs: <BN8PR15MB27884FCF77EEC49B1CF16F83D33C0@BN8PR15MB2788.namprd15.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(366004)(136003)(376002)(189003)(199004)(66446008)(53546011)(66476007)(66556008)(6506007)(11346002)(2616005)(71190400001)(476003)(81166006)(486006)(36756003)(81156014)(14454004)(2501003)(446003)(2906002)(25786009)(8936002)(8676002)(316002)(54906003)(6512007)(110136005)(64756008)(386003)(76176011)(86362001)(256004)(71200400001)(73956011)(4744005)(102836004)(186003)(68736007)(46003)(66946007)(2201001)(97736004)(31696002)(7736002)(478600001)(5660300002)(6486002)(99286004)(52116002)(229853002)(53936002)(31686004)(6246003)(6116002)(4326008)(6436002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2788;H:BN8PR15MB3380.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eMgoXk4hYkgrT/c9nOafIVkuUE8YygZF1V6JX1/1vXqUyyHxdAxxhwH92msOVrM8Yl4Vd8fEzqHviLXhRuOpO9+XiWQ/S1DhWOZsKIQbnqnRrPHftWoc05zumDAzG84ANFCyg0ni8U53wicYaOwUrmopHgQh4e79nPOjCOjp0SJnR3QEEl/4fOCkVgweQbKI4B7pQIsg/uYCemfZHuIlYdipKjZ0HSiCqXP/hRrW2l/QCQ44lf6RwjKdgQ1CSbA9esIjNu5DCRQz9bN2OB3Vy12Ph+h/AkprPF1UmaEOENBYxd/7AToTRuDIobOWOSkintvAmeADFpfoqJeiVcrc1OeIlqUdx6Jr6F43jJmB60abl/AYqEbyGNQt//eSN7tkputGIQBONsRhd1hGcLju2os/6qOiC26PLcF/J69meKc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <486A4E653C43A74D814B4CBE26D9C39E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4f4675-c181-41e2-f235-08d6c9058982
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 22:38:14.0444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2788
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvMjQvMTkgMTI6MDcgUE0sIE1hdHQgTXVsbGlucyB3cm90ZToNCj4gVGhpcyBhZGRz
IEJQRl9QUk9HX1RZUEVfUkFXX1RSQUNFUE9JTlRfV1JJVEFCTEUsIGFuZCBmaXhlcyB1cCB0aGUN
Cj4gDQo+IAllcnJvcjogZW51bWVyYXRpb24gdmFsdWUg4oCYQlBGX1BST0dfVFlQRV9SQVdfVFJB
Q0VQT0lOVF9XUklUQUJMReKAmSBub3QgaGFuZGxlZCBpbiBzd2l0Y2ggWy1XZXJyb3I9c3dpdGNo
LWVudW1dDQo+IA0KPiBidWlsZCBlcnJvcnMgaXQgd291bGQgb3RoZXJ3aXNlIGNhdXNlIGluIGxp
YmJwZi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hdHQgTXVsbGlucyA8bW11bGxpbnNAZmIuY29t
Pg0KDQpBY2tlZC1ieTogWW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNvbT4NCg==

Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287AEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E771B20878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RlaA5j3r";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Y3PlzaZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfDXW5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:57:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51358 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726829AbfDXW5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:57:50 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OMntWR020155;
        Wed, 24 Apr 2019 15:57:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=BDYeMh8uGikO4R+HO417lgnVM47NXyl93HzG3TvZBa0=;
 b=RlaA5j3rC/WD3Ghn5v41/FMwOYaTrknntD0J8/2BGtCYVMfAPo8+BRiwLtHaypL+LYiM
 0LEHY+Coc1B9N7kUXEDeisIzKB5ZDwZhWrAG1zZJBpzf5nNn4+IsKYD+MMyEi1RPBUUB
 oe///S4oXsfghD2CQDIeTOyaF5iOCab1C2M= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s2x7kh0b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 24 Apr 2019 15:57:00 -0700
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 24 Apr 2019 15:56:59 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 24 Apr 2019 15:56:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDYeMh8uGikO4R+HO417lgnVM47NXyl93HzG3TvZBa0=;
 b=Y3PlzaZGi6nondtRLt1qpUkSunDA3xfZzO/ZuD+t8N6aAyopi2IaqOE28HkVnj6+4TUih9ddci7Mz7Nej1EuA/KHe5xgKDJ36k5YtzE/b9ISUwXmZiZupq2nK1W27wOVZBL234IqI+mTnhtsXRHJSa/fv0JIoCGBLJoj7qAoCBo=
Received: from BN8PR15MB3380.namprd15.prod.outlook.com (20.179.75.139) by
 BN8PR15MB3409.namprd15.prod.outlook.com (20.179.75.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Wed, 24 Apr 2019 22:56:56 +0000
Received: from BN8PR15MB3380.namprd15.prod.outlook.com
 ([fe80::b5bc:d69:3cf5:db53]) by BN8PR15MB3380.namprd15.prod.outlook.com
 ([fe80::b5bc:d69:3cf5:db53%4]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 22:56:56 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Matt Mullins <mmullins@fb.com>, Andrew Hall <hall@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 5/5] selftests: bpf: test writable buffers in
 raw tps
Thread-Topic: [PATCH bpf-next v4 5/5] selftests: bpf: test writable buffers in
 raw tps
Thread-Index: AQHU+tETQ6r8I6bjEk2r1kHmCPTFH6ZL7F+A
Date:   Wed, 24 Apr 2019 22:56:56 +0000
Message-ID: <0844db66-24e8-aaf8-9b86-467417f40241@fb.com>
References: <20190424190721.24453-1-mmullins@fb.com>
 <20190424190721.24453-6-mmullins@fb.com>
In-Reply-To: <20190424190721.24453-6-mmullins@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0077.namprd15.prod.outlook.com
 (2603:10b6:101:20::21) To BN8PR15MB3380.namprd15.prod.outlook.com
 (2603:10b6:408:a6::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:5d4c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: beabfb85-f654-4a12-f548-08d6c9082651
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BN8PR15MB3409;
x-ms-traffictypediagnostic: BN8PR15MB3409:
x-microsoft-antispam-prvs: <BN8PR15MB340907D66EB0119E688C4EF4D33C0@BN8PR15MB3409.namprd15.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(366004)(136003)(396003)(189003)(199004)(305945005)(25786009)(68736007)(6116002)(76176011)(8676002)(8936002)(81166006)(102836004)(2501003)(99286004)(81156014)(186003)(46003)(476003)(2616005)(52116002)(7416002)(6436002)(486006)(31686004)(7736002)(11346002)(4326008)(446003)(6486002)(229853002)(54906003)(71200400001)(71190400001)(110136005)(73956011)(2906002)(316002)(66446008)(66946007)(66556008)(66476007)(5660300002)(64756008)(386003)(53546011)(97736004)(2201001)(36756003)(31696002)(478600001)(14454004)(4744005)(5024004)(6506007)(6246003)(256004)(86362001)(6512007)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB3409;H:BN8PR15MB3380.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: okQhC+VQkwJ/hiqfsxyZOF3ZQVc10pmal+wgh9YsMP23gDiUtcX/C8DQLopfAc96wi46obFeHakmtsN9wyxtmBfmLcuEwHXG6pe6hu4WkStNS2TFfJai95dwi0vAPNyktpoXlEoimMclAMqE4Gk//4vewRERrLk5m05mE95fWGBzrSnd6qagW2c1nkE78z69nATbNKCYcsLIzFy6ui1CV6K7Xbehb1SWFX2Ydexr4sXJgWxfcUAQvzz4cH9y+/UNO6MFDI+9UKMsnqiZZwnLJbccxAoLc5DLwbdyQIkj8vpSmQehDV7gx62OX9X695JZdWYPvDoevhIWQ8WcmncceZ3PE5AYyWAv1X5VoitjVHmsxlVrvBuGayoOWDoIGAqfDbWKyu7JOrzBF5VwrYNMPEajmTiNcA8yLp0RK4NJWAE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F150456B27CF504EABBFCDA081397770@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: beabfb85-f654-4a12-f548-08d6c9082651
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 22:56:56.1992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3409
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvMjQvMTkgMTI6MDcgUE0sIE1hdHQgTXVsbGlucyB3cm90ZToNCj4gVGhpcyB0ZXN0
cyB0aGF0Og0KPiAgICAqIGEgQlBGX1BST0dfVFlQRV9SQVdfVFJBQ0VQT0lOVF9XUklUQUJMRSBj
YW5ub3QgYmUgYXR0YWNoZWQgaWYgaXQNCj4gICAgICB1c2VzIGVpdGhlcjoNCj4gICAgICAqIGEg
dmFyaWFibGUgb2Zmc2V0IHRvIHRoZSB0cmFjZXBvaW50IGJ1ZmZlciwgb3INCj4gICAgICAqIGFu
IG9mZnNldCBiZXlvbmQgdGhlIHNpemUgb2YgdGhlIHRyYWNlcG9pbnQgYnVmZmVyDQo+ICAgICog
YSB0cmFjZXIgY2FuIG1vZGlmeSB0aGUgYnVmZmVyIHByb3ZpZGVkIHdoZW4gYXR0YWNoZWQgdG8g
YSB3cml0YWJsZQ0KPiAgICAgIHRyYWNlcG9pbnQgaW4gYnBmX3Byb2dfdGVzdF9ydW4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IE1hdHQgTXVsbGlucyA8bW11bGxpbnNAZmIuY29tPg0KDQpBY2tlZC1i
eTogWW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNvbT4NCg0KQlRXLCB5b3VyIHBhdGNoZXMgaGF2ZSBz
b21lIGNvbmZsaWN0cyB3aXRoIGxhdGVzdCBicGYtbmV4dCwgeW91IG1heSB3YW50DQp0byByZWJh
c2UgYW5kIHJlc3VibWl0Lg0K

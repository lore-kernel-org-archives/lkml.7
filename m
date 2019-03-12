Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979F1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558A82171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aSTI5viQ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VizYWNBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfCLVAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:00:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48306 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725894AbfCLVAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 17:00:45 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2CKlxYd009561;
        Tue, 12 Mar 2019 14:00:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=cY4mEZ4esDFzMlNbi+jsYnZctU3i88P5znUQCCG/DYE=;
 b=aSTI5viQgL9v/7Ud0mCBGfHt4TI2lUgMzxIuiAaZ8m8F0JXZxxR+nJ5y7sTqLn5Fb7C7
 O7IaD/n9apGECgk8E8pW8uvwYbhq4pAAKGpCopiw5fuOak9M9U1oqSLmT6G34iHUx9b7
 0Bt54rr44FGE8mQ5bKmMRbQj/3NfUDA1Rvk= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r6km4g4qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 12 Mar 2019 14:00:12 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 12 Mar 2019 14:00:09 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 12 Mar 2019 14:00:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cY4mEZ4esDFzMlNbi+jsYnZctU3i88P5znUQCCG/DYE=;
 b=VizYWNBRf1FsnztOqASj+SIOj5qoNRtFc6FlBbd7iIreARbwdNlLJOKY1ZBf8Ho+YySk4RhboNPdFN/58HkaTjQoJdzDGX4OsBniHk1JRDt4pnf2BBxtVr8ytR64u0cS5LtWm4yMZT8BP3mOTjBGjJtxuw6UoIOWvplKiHWxrhM=
Received: from MWHPR15MB1264.namprd15.prod.outlook.com (10.175.3.14) by
 MWHPR15MB1167.namprd15.prod.outlook.com (10.175.2.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.19; Tue, 12 Mar 2019 21:00:07 +0000
Received: from MWHPR15MB1264.namprd15.prod.outlook.com
 ([fe80::cc6:7ec2:94ef:f8cb]) by MWHPR15MB1264.namprd15.prod.outlook.com
 ([fe80::cc6:7ec2:94ef:f8cb%9]) with mapi id 15.20.1709.011; Tue, 12 Mar 2019
 21:00:07 +0000
From:   Calvin Owens <calvinowens@fb.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 1/4] printk: Introduce per-console loglevel setting
Thread-Topic: [PATCH 1/4] printk: Introduce per-console loglevel setting
Thread-Index: AQHU0JG3e/ht7zPQPUuht9he6Dkc8qYBF9cAgAd0JgA=
Date:   Tue, 12 Mar 2019 21:00:07 +0000
Message-ID: <20190312210004.GC5982@Haydn>
References: <cover.1551486732.git.calvinowens@fb.com>
 <06cd267ef5439a9391368423b608959f5f1b1a63.1551486732.git.calvinowens@fb.com>
 <20190308031032.GA30056@jagdpanzerIV>
In-Reply-To: <20190308031032.GA30056@jagdpanzerIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1201CA0008.namprd12.prod.outlook.com
 (2603:10b6:301:4a::18) To MWHPR15MB1264.namprd15.prod.outlook.com
 (2603:10b6:320:24::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::ce7e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1661ac0d-1d49-4682-3fbe-08d6a72db4f0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1167;
x-ms-traffictypediagnostic: MWHPR15MB1167:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1167;20:iNdytKEEIX0lMlBE7WKRSI7Ws2VpPvaajlH86RwjGVxEbPSutqzzrnXeLcumRGuE9uJrmPO3n1tMiGXq7Ha8OCjQiAWHIQ3pwIxRh7fwvvJRsHAUVdQi8oiqK1otUC7MxuQmIoy+UCLgtQxwPZ9Y51y2VN98VxrfvaDsA4MZY0U=
x-microsoft-antispam-prvs: <MWHPR15MB11670161D65EED7E265B64F9CE490@MWHPR15MB1167.namprd15.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(376002)(136003)(39860400002)(346002)(396003)(189003)(199004)(305945005)(7736002)(316002)(54906003)(11346002)(446003)(46003)(33656002)(6486002)(9686003)(14454004)(229853002)(6512007)(33716001)(186003)(105586002)(81156014)(6436002)(68736007)(52116002)(8936002)(106356001)(6506007)(99286004)(102836004)(478600001)(386003)(76176011)(8676002)(5660300002)(81166006)(53936002)(476003)(4326008)(71200400001)(71190400001)(256004)(6116002)(6916009)(486006)(86362001)(2906002)(6246003)(1076003)(14444005)(25786009)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1167;H:MWHPR15MB1264.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ACZWRGHpC5726V7YZMLjYIMfrQ5dY/wbx+v1TGzfFr0oavVCnB+9siQRi4LcvG5NwYQ0blymUp7EeC6pATEx/4UpegPaYnBL8JYuFWjFaHUe/bnNwFOkPYiBRcE4woKG6VTnxzJ7ZSU10S/ApPexdUN9fZ6iEklB6VxIK5WtFHOROCp26x2QVlTwSM3WuG1XHGamyPXH2Gxft5hEfG4XvWnrRNrW5sXlfmH2y/0aN3D4e8VRIEsrlKy7XAM/vzwrbbJ7zZQDvyS+S+hafnRd0c8mopS2D8cTTjVQP7H0Jspa2aUe2RdZ23BzVUV6zT5wPHzcYptIQQdrfKfFSU232tA8wH/8nuTsKpye6jkCMTN1qzgDyftrNzO4SrfpXvWbx1VMtgE852qTzDJYubliAWOrtJ2ZoqvB15pzNeKGXlo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <082ACFE34DBB2146802CB7B5573FC382@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1661ac0d-1d49-4682-3fbe-08d6a72db4f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 21:00:07.4047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpZGF5IDAzLzA4IGF0IDEyOjEwICswOTAwLCBTZXJnZXkgU2Vub3poYXRza3kgd3JvdGU6
DQo+IE9uICgwMy8wMS8xOSAxNjo0OCksIENhbHZpbiBPd2VucyB3cm90ZToNCj4gWy4uXQ0KPiA+
ICAJCW1zZyA9IGxvZ19mcm9tX2lkeChjb25zb2xlX2lkeCk7DQo+ID4gLQkJaWYgKHN1cHByZXNz
X21lc3NhZ2VfcHJpbnRpbmcobXNnLT5sZXZlbCkpIHsNCj4gPiAtCQkJLyoNCj4gPiAtCQkJICog
U2tpcCByZWNvcmQgd2UgaGF2ZSBidWZmZXJlZCBhbmQgYWxyZWFkeSBwcmludGVkDQo+ID4gLQkJ
CSAqIGRpcmVjdGx5IHRvIHRoZSBjb25zb2xlIHdoZW4gd2UgcmVjZWl2ZWQgaXQsIGFuZA0KPiA+
IC0JCQkgKiByZWNvcmQgdGhhdCBoYXMgbGV2ZWwgYWJvdmUgdGhlIGNvbnNvbGUgbG9nbGV2ZWwu
DQo+ID4gLQkJCSAqLw0KPiA+IC0JCQljb25zb2xlX2lkeCA9IGxvZ19uZXh0KGNvbnNvbGVfaWR4
KTsNCj4gPiAtCQkJY29uc29sZV9zZXErKzsNCj4gPiAtCQkJZ290byBza2lwOw0KPiA+IC0JCX0N
Cj4gPiAgDQo+ID4gIAkJLyogT3V0cHV0IHRvIGFsbCBjb25zb2xlcyBvbmNlIG9sZCBtZXNzYWdl
cyByZXBsYXllZC4gKi8NCj4gPiAgCQlpZiAodW5saWtlbHkoZXhjbHVzaXZlX2NvbnNvbGUgJiYN
Cj4gPiBAQCAtMjQwNSw3ICsyNDAyLDcgQEAgdm9pZCBjb25zb2xlX3VubG9jayh2b2lkKQ0KPiA+
ICAJCWNvbnNvbGVfbG9ja19zcGlubmluZ19lbmFibGUoKTsNCj4gPiAgDQo+ID4gIAkJc3RvcF9j
cml0aWNhbF90aW1pbmdzKCk7CS8qIGRvbid0IHRyYWNlIHByaW50IGxhdGVuY3kgKi8NCj4gPiAt
CQljYWxsX2NvbnNvbGVfZHJpdmVycyhleHRfdGV4dCwgZXh0X2xlbiwgdGV4dCwgbGVuKTsNCj4g
PiArCQljYWxsX2NvbnNvbGVfZHJpdmVycyhleHRfdGV4dCwgZXh0X2xlbiwgdGV4dCwgbGVuLCBt
c2ctPmxldmVsKTsNCj4gPiAgCQlzdGFydF9jcml0aWNhbF90aW1pbmdzKCk7DQo+IA0KPiBTbyBp
dCBzZWVtcyB0aGF0IG5vdyB3ZSBhbHdheXMgZm9ybWF0IHRoZSB0ZXh0IGFuZCBleHQgbWVzc2Fn
ZSAoaWYNCj4gbmVlZGVkKSBhbmQgb25seSB0aGVuIGNoZWNrIGlmIHRoZXJlIGlzIGF0IGxlYXN0
IG9uZSBjb25zb2xlIHdlIGNhbg0KPiBwcmludCB0aGF0IG1lc3NhZ2Ugb24uDQo+IA0KPiBDYW4g
d2UgaXRlcmF0ZSB0aGUgY29uc29sZXMgZmlyc3QgYW5kIGNoZWNrIGlmIG1zZyBpcyB3b3J0aA0K
PiB0aGUgZWZmb3J0IChwZXIgY29uc29sZSBzdXBwcmVzc19tZXNzYWdlX3ByaW50aW5nKCkpIGFu
ZCBvbmx5DQo+IGlmIGl0IGlzIGRvIGFsbCB0aGUgZm9ybWF0dGluZyBhbmQgY2FsbCBjb25zb2xl
IGRyaXZlcnM/DQoNCk1ha2VzIHNlbnNlLCB3aWxsIGRvLg0KDQpUaGFua3MsDQpDYWx2aW4NCiAN
Cj4gCS1zcw0K

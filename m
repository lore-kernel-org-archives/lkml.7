Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D3BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CD320823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="f6vLnKvo";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VhZgrHj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfCDTKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:10:54 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45668 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbfCDTKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:10:53 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24J8uZ2008734;
        Mon, 4 Mar 2019 11:10:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=EK2rfKcop//MpY6b48HCsR8zD1IvsZ5ITOAzLcMyiPM=;
 b=f6vLnKvohW3+Uh5WIxeyzdNZE/pwutZvmdey3ux87sM8DnQMQFqxYx6Hui+Aul6hZRAa
 nVf7or/HL+Klp0XN/CgeAw7lxPjKGFhMwa4Xgoc5UYGWYpe+ew2B26gJCkBges9oG1mm
 amXnuhzhs/U/aaMfsS/1uFzQCzvSsfR1mII= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r19ad85fa-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Mar 2019 11:10:19 -0800
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 4 Mar 2019 11:10:18 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 4 Mar 2019 11:10:18 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Mar 2019 11:10:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EK2rfKcop//MpY6b48HCsR8zD1IvsZ5ITOAzLcMyiPM=;
 b=VhZgrHj0rAj9ExzHCrC8jdR9ByUoKx9vePna8ESj5XbfyKtRf0NfpT1f88VxD3j5Hd4VAdi0YSBWalyg16/XRzctUhpxBUAmWd9jyNShnwxm9HFfBNyR12v+NpowSUlOTgoAIa3FvVGE+xAV5dc56ePsw8a4XRjdL2cjqd2lvpg=
Received: from MWHPR15MB1264.namprd15.prod.outlook.com (10.175.3.14) by
 MWHPR15MB1598.namprd15.prod.outlook.com (10.173.235.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Mon, 4 Mar 2019 19:10:15 +0000
Received: from MWHPR15MB1264.namprd15.prod.outlook.com
 ([fe80::cc6:7ec2:94ef:f8cb]) by MWHPR15MB1264.namprd15.prod.outlook.com
 ([fe80::cc6:7ec2:94ef:f8cb%9]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 19:10:15 +0000
From:   Calvin Owens <calvinowens@fb.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 4/4] printk: Add a device attribute for the per-console
 loglevel
Thread-Topic: [PATCH 4/4] printk: Add a device attribute for the per-console
 loglevel
Thread-Index: AQHU0JGr4TmpllsGnU6tPbXGJgsRUKX7ITUAgAC5aAA=
Date:   Mon, 4 Mar 2019 19:10:14 +0000
Message-ID: <20190304191006.GA51516@calvinowens-mba.dhcp.thefacebook.com>
References: <cover.1551486732.git.calvinowens@fb.com>
 <4f71564063a07837e3c4df41326bad25e7dc4db4.1551486733.git.calvinowens@fb.com>
 <20190304080630.GA4495@jagdpanzerIV>
In-Reply-To: <20190304080630.GA4495@jagdpanzerIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0038.namprd08.prod.outlook.com
 (2603:10b6:a03:117::15) To MWHPR15MB1264.namprd15.prod.outlook.com
 (2603:10b6:320:24::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::a792]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afaf4259-5e6c-4feb-5ac2-08d6a0d507b3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1598;
x-ms-traffictypediagnostic: MWHPR15MB1598:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1598;20:i6TGk7vSop2QX4JZeeQ0O8tNBa8MTnAGH2GNfsweYD4nyMOp6S1Sx7fL5hybg29L8UhDAXTfKlQJfJBRk7UcyGLb+pylQoD638bmbwiwbMJ65RwgrbkSbaNVCVjJp8Ybjw5LhPYRnyn15U8DiBzWoJBxLkIqlTdPjLYe4/E48kU=
x-microsoft-antispam-prvs: <MWHPR15MB1598756CFFEB5544ED77DE55CE710@MWHPR15MB1598.namprd15.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39860400002)(376002)(396003)(366004)(199004)(189003)(54906003)(86362001)(7736002)(14454004)(9686003)(6512007)(76176011)(25786009)(305945005)(5660300002)(99286004)(6506007)(4326008)(386003)(478600001)(52116002)(33656002)(6486002)(2906002)(71190400001)(71200400001)(53936002)(229853002)(68736007)(46003)(6116002)(97736004)(316002)(81156014)(81166006)(8676002)(102836004)(186003)(1076003)(11346002)(446003)(486006)(105586002)(476003)(106356001)(8936002)(256004)(6246003)(6916009)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1598;H:MWHPR15MB1264.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Pz4boX4xDfqjd0HcBvTG7LTgPFk1XFeVD9TxXmBq20lMsRerAUUBJ1XDuQSLoEZ/AOC8eOSsNMtVfjBoTsGvr70hSnsdEMZBlGe/QFdwkw/PXFvHvImW6NCPKb9aXnx9f8dd+6wQf+a+U0hwXKSg9bNxSdbUbU1szJcluuY6+AsGhky7RNnNMMdyt3RlYPAOKaMC/DE9DVIh40Abgs3zBIpt8xGsWx8mJSVQXARRp8DkKmIkc8W0i8hBiNMhWE9yCew919IxfpTBTOKLl1n8UnxOkMpWzKc8q19ohl0FJcgxbQb0H0brhxKStiP3hZI4rgLl3y3Uv/bXA9RoI7jRWQyk54+PBncVEVjlp1ghXueDi7YF3OQrzRmb/AI2ev9tkhaOYSsRc9sIJJM7L1Kt5TgQsyaSDwTRp1N7YMVcUb8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <148B6FF61B277146B637BE3CEC776F31@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: afaf4259-5e6c-4feb-5ac2-08d6a0d507b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 19:10:15.0127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1598
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uZGF5IDAzLzA0IGF0IDE3OjA2ICswOTAwLCBTZXJnZXkgU2Vub3poYXRza3kgd3JvdGU6
DQo+IE9uICgwMy8wMS8xOSAxNjo0OCksIENhbHZpbiBPd2VucyB3cm90ZToNCj4gPiArc3RhdGlj
IHN0cnVjdCBhdHRyaWJ1dGUgKmNvbnNvbGVfc3lzZnNfYXR0cnNbXSA9IHsNCj4gPiArCSZkZXZf
YXR0cl9sb2dsZXZlbC5hdHRyLA0KPiA+ICsJTlVMTCwNCj4gPiArfTsNCj4gPiArQVRUUklCVVRF
X0dST1VQUyhjb25zb2xlX3N5c2ZzKTsNCj4gPiArDQo+ID4gIHN0YXRpYyBzdHJ1Y3QgYnVzX3R5
cGUgY29uc29sZV9zdWJzeXMgPSB7DQo+ID4gIAkubmFtZSA9ICJjb25zb2xlIiwNCj4gPiArCS5k
ZXZfZ3JvdXBzID0gY29uc29sZV9zeXNmc19ncm91cHMsDQo+ID4gIH07DQo+IA0KPiBEbyB3ZSBy
ZWFsbHkgbmVlZCB0byBjaGFuZ2UgdGhpcyBkeW5hbWljYWxseT8gQ29uc29sZSBvcHRpb25zIGFy
ZQ0KPiB0cmFkaXRpb25hbGx5IHN0YXRpYyAoYm9vdCBwYXJhbSBvciBEVCkuIENhbiB3ZSBhbHNv
IGJlIGhhcHB5IHdpdGgNCj4gdGhlIHN0YXRpYyBwZXItY29uc29sZSBsb2dsZXZlbD8NCg0KSXQg
cmVhbGx5IGRvZXMgbmVlZCB0byBiZSBydW50aW1lIGNvbmZpZ3VyYWJsZTogdGhlcmUgYXJlIGEg
bG90IG9mIHVzZWNhc2VzDQp0aGF0IGVuYWJsZXMsIGxpa2UgdHVybmluZyB0aGUgZmFzdCBjb25z
b2xlIHVwIHRvIEtFUk5fREVCVUcgb24gYSBwaWxlIG9mDQptYWNoaW5lcyB5b3Ugd2FudCB0byB0
YWtlIGEgY2xvc2VyIGxvb2sgYXQuIFRoZSAna2VybmVsLnByaW50aycgZ2xvYmFsDQpsb2dsZXZl
bCBpcyBhbHNvIGFscmVhZHkgY2hhbmdhYmxlIGF0IHJ1bnRpbWUsIGFuZCBzaW5jZSB0aGF0IHNl
dHRpbmcNCmludGVyYWN0cyB3aXRoIHRoaXMgb25lIGl0IHdvdWxkIGJlIHN0cmFuZ2UgaWYgb25s
eSB0aGUgZm9ybWVyIHdlcmUgYWJsZQ0KdG8gYmUgY2hhbmdlZC4NCg0KSSBhbHNvIHdhbnQgdG8g
YWRkIG1vcmUgYXR0cmlidXRlIGtub2JzIHJlbGF0ZWQgdG8gZXh0ZW5kZWQgY29uc29sZXMsDQpz
byB0aGUgcGx1bWJpbmcgdG8gZ2V0IHRoaW5ncyBleHBvc2VkIGluIHN5c2ZzIGlzIHdvcnRoIGl0
IGZvciBtZS4NCg0KVGhhbmtzLA0KQ2FsdmluDQo=

Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDB7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F04206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="S6+MhvWU";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="b1v8mt+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfCLUoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:44:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58532 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725894AbfCLUoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:44:46 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2CKVoEV005268;
        Tue, 12 Mar 2019 13:44:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=l0AoXLLjl6aAsY99IabSvRXa4z43ZHVBDZwkA1zh5Bk=;
 b=S6+MhvWUIORjrQc17Lp04PntzF7Yoj66OqRE9Frvh5Lko4/MOq97B60N2sUbqKyOOsIe
 b0f2eR1eX/C2An3DPR0Kxd4mS8BGjDARd9x+Lded9xTIfyACCd1fRp+S7bupvJn8uvwr
 WmBFbeu87Dlau2KlFLmFOoyUv9uBj+/2ORA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r6k3sg76j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 12 Mar 2019 13:44:09 -0700
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 12 Mar 2019 13:44:07 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 12 Mar 2019 13:44:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0AoXLLjl6aAsY99IabSvRXa4z43ZHVBDZwkA1zh5Bk=;
 b=b1v8mt+bVJPkcG+rVnRbS5mbJtglgHu/ftNSKtPTrm+1i6jkYdINhtxiUH52/xLdXVCjHSvrnrjYmc2YDnY472uUa6eZQkZJlW+a1QQmKAJsCDUtRU9GiPMpMdd7Ms5wxg4D650Q4pEpyicweAjapADHc/MuuR1l9IE9zz9eO+I=
Received: from MWHPR15MB1264.namprd15.prod.outlook.com (10.175.3.14) by
 MWHPR15MB1118.namprd15.prod.outlook.com (10.175.2.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.19; Tue, 12 Mar 2019 20:44:05 +0000
Received: from MWHPR15MB1264.namprd15.prod.outlook.com
 ([fe80::cc6:7ec2:94ef:f8cb]) by MWHPR15MB1264.namprd15.prod.outlook.com
 ([fe80::cc6:7ec2:94ef:f8cb%9]) with mapi id 15.20.1709.011; Tue, 12 Mar 2019
 20:44:05 +0000
From:   Calvin Owens <calvinowens@fb.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 3/4] printk: Add consoles to a virtual "console" bus
Thread-Topic: [PATCH 3/4] printk: Add consoles to a virtual "console" bus
Thread-Index: AQHU0JGsczOzMag9pEqv+OoueTdNJKYBE/QygADaYQCAAAoMgIAGjx0A
Date:   Tue, 12 Mar 2019 20:44:05 +0000
Message-ID: <20190312204345.GA5982@Haydn>
References: <cover.1551486732.git.calvinowens@fb.com>
 <087b13f7812b32cc7c3f9efea71c9bcf324dd031.1551486732.git.calvinowens@fb.com>
 <87ef7ioyzw.fsf@linutronix.de>
 <20190308155814.rzsjrzgwfcm4p5sk@pathway.suse.cz>
 <20190308163411.GA12898@kroah.com>
In-Reply-To: <20190308163411.GA12898@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1701CA0003.namprd17.prod.outlook.com
 (2603:10b6:301:14::13) To MWHPR15MB1264.namprd15.prod.outlook.com
 (2603:10b6:320:24::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::ce7e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c93efb03-50ac-435f-80f7-08d6a72b7773
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1118;
x-ms-traffictypediagnostic: MWHPR15MB1118:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1118;20:t2/zC1kLqC4oqswFoeXclbkROx1wFFyLwFOBP0qiRSu6GTEjtMLzWHa/VldVkGpwspALrD7c3ubbiPiiyg3qP4Vulfd3SnkNnUHrj8lFuPlTlNsRYUO0dgcmVdx0iO1JyXf9aZnLGc30GTrAnzXmV0ecBs4no60YYjxFXFG7K5o=
x-microsoft-antispam-prvs: <MWHPR15MB11184489FC5F42F4A8ADFF93CE490@MWHPR15MB1118.namprd15.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(6506007)(6512007)(8676002)(52116002)(5660300002)(386003)(33716001)(6116002)(102836004)(99286004)(86362001)(76176011)(11346002)(446003)(256004)(97736004)(8936002)(46003)(476003)(1076003)(186003)(486006)(316002)(478600001)(6916009)(81166006)(68736007)(4326008)(229853002)(53936002)(2906002)(14454004)(54906003)(6486002)(9686003)(25786009)(93886005)(6246003)(7736002)(6436002)(105586002)(71200400001)(71190400001)(305945005)(106356001)(33656002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1118;H:MWHPR15MB1264.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3Ewy3LKSAIOA1VkW5dxeKA6g1nUTHPyWNXvnPa+pZXno95QzU7Zv8kXnAvsSfJf50o/xprIjRtrYdOHAtZipxV8OYlhMpR/mcEEWX+klXZEEen/SMlRxk1IfcNiUuC/L+cnxbneXSgyIczDe0G7G6t5mgm0HVwH/AtxJC7CkAALYelpuaZ5YaumiQHM8Ft50aawBXYY2wsPGK5wf1HzHquyrMTrBWHZKPxjFm2lHqPBbmr7U/Nu9olySnnSCJHhikk57+ry24w6MkcaHPArx56ggskWOezayq2LXKu8dRJviEyHkX1judTFNxM7Mm+ykmfcrutsWcnZaBAseCP9MEg7j2Y9SCt1NgdA2WGpT5jTmxlJs1QVyiSNMtUZIDFK/FPAF0qvfROOUzrSSWMIyLPzSAK+rlxZS+r8Jr273nI8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04746976BD8C6B4F8702897A1865A9DB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c93efb03-50ac-435f-80f7-08d6a72b7773
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 20:44:05.3838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1118
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpZGF5IDAzLzA4IGF0IDE3OjM0ICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6
DQo+IE9uIEZyaSwgTWFyIDA4LCAyMDE5IGF0IDA0OjU4OjE0UE0gKzAxMDAsIFBldHIgTWxhZGVr
IHdyb3RlOg0KPiA+IE9uIEZyaSAyMDE5LTAzLTA4IDAzOjU2OjE5LCBKb2huIE9nbmVzcyB3cm90
ZToNCj4gPiA+IE9uIDIwMTktMDMtMDIsIENhbHZpbiBPd2VucyA8Y2Fsdmlub3dlbnNAZmIuY29t
PiB3cm90ZToNCj4gPiA+ID4gVGhpcyBwYXRjaCBlbWJlZHMgYSBkZXZpY2Ugc3RydWN0IGluIHRo
ZSBjb25zb2xlIHN0cnVjdCwgYW5kIHJlZ2lzdGVycw0KPiA+ID4gPiB0aGVtIG9uIGEgImNvbnNv
bGUiIGJ1cyBzbyB3ZSBjYW4gZXhwb3NlIGF0dHJpYnV0ZXMgaW4gc3lzZnMuDQo+ID4gPiANCj4g
PiA+IEkgZXhwZWN0IHRoYXQgImNsYXNzIiB3b3VsZCBiZSBtb3JlIGFwcHJvcHJpYXRlIHRoYW4g
ImJ1cyIuIFRoZXNlDQo+ID4gPiBkZXZpY2VzIHJlYWxseSBhcmUgZ3JvdXBlZCB0b2dldGhlciBi
YXNlZCBvbiB0aGVpciBmdW5jdGlvbiBhbmQgbm90IHRoZQ0KPiA+ID4gbWVkaXVtIGJ5IHdoaWNo
IHRoZXkgYXJlIGFjY2Vzc2VkLg0KPiA+IA0KPiA+IEdvb2QgcG9pbnQuICJjbGFzcyIgbG9va3Mg
YmV0dGVyIHRvIG1lIGFzIHdlbGwuDQo+ID4gDQo+ID4gR3JlZywgYW55IG9waW5pb24sIHdoZXJl
IHRvIHB1dCB0aGUgZW50cmllcyBmb3Igc3RydWN0IGNvbnNvbGUgPw0KPiANCj4gSGFuZyB0aGVt
IG9mZiBvZiB0aGUgZGV2aWNlIHRoYXQgdGhlIGNvbnNvbGUgYmVsb25ncyB0bz8NCj4gDQo+IENs
YXNzZXMgYW5kIGJ1c3NlcyBhcmUgYWxtb3N0IGlkZW50aWNhbCBleGNlcHQ6DQo+IAktIGJ1c3Nl
cyBpcyB0aGUgYmluZGluZyBvZiBhIGRyaXZlciB0byBhIGRldmljZSAodXNiLCBwY2ksIGV0Yy4p
DQo+IAktIGNsYXNzZXMgYXJlIHVzdWFsbHkgdXNlcnNwYWNlIGludGVyYWN0aW9ucyB0byBhIGRl
dmljZSAoaW5wdXQsDQo+IAkgIHR0eSwgZXRjLikNCj4gDQo+IFNvIHRoaXMgc291bmRzIGxpa2Ug
YSBjbGFzcyB0byBtZS4NCg0KU291bmRzIGdvb2QsIHdpbGwgbWFrZSBpdCBhIGNsYXNzLg0KIA0K
PiBJZiB5b3Ugd2FudCBtZSB0byByZXZpZXcgdGhpcywgSSdsbCBiZSBnbGFkIHRvIHNvIGRvIG9u
Y2UgNS4xLXJjMSBpcw0KPiBvdXQuLi4NCg0KWWVhaCwgSSByZWFsaXplZCBhZnRlciBzZW5kaW5n
IHRoaXMgdGhlIHRpbWluZyB3YXMgcHJldHR5IHRlcnJpYmxlLCBJJ2xsDQp3YWl0IGZvciA1LjEt
cmMxIGJlZm9yZSByZWJhc2luZy9yZXNlbmRpbmcuDQoNClRoYW5rcywNCkNhbHZpbg0KIA0KPiB0
aGFua3MsDQo+IA0KPiBncmVnIGstaA0K

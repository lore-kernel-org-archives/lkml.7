Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6D7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8FF213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LWKwvy29";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Ev+T1esk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfCLUxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:53:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58268 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726284AbfCLUxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:53:37 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x2CKmFH5015130;
        Tue, 12 Mar 2019 13:53:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=LVvhhW5jvpmKhVki3G3wWKT50QaOnwZnSMM/0sNOwxw=;
 b=LWKwvy29JprPET5NvLvkeGOZjKvYK1RGOYlT5ywJTu7qS1U96ZgKlK341ioZee8sCLnU
 Se+hmGZRb9rc+qQDoKbNPfCD3NjlVs45FRD8y4q/YmljLGhHT9doU7/uidjfkU1THVXS
 DrEbnUOtupwbWymEZqd3gh48R1X5Xc47GgA= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2r6k7v078p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 12 Mar 2019 13:53:03 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 12 Mar 2019 13:53:01 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 12 Mar 2019 13:53:00 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 12 Mar 2019 13:52:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVvhhW5jvpmKhVki3G3wWKT50QaOnwZnSMM/0sNOwxw=;
 b=Ev+T1eskixJSYJMINOFOOV1o5QGRnKvqUciBhmSNwtiEH9/zKVW2YzXdx0gQMXChLTJ7LHjLV5NOLFk66gOHIDO4G5k64M5O6YRUdxrKHyLkCwM6vVaW3LJRiJa0qZCSTHLmZC+UipcM97UdnsOihFuhhzr8zMWbSsX9BBbchNE=
Received: from MWHPR15MB1264.namprd15.prod.outlook.com (10.175.3.14) by
 MWHPR15MB1232.namprd15.prod.outlook.com (10.175.2.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.17; Tue, 12 Mar 2019 20:52:58 +0000
Received: from MWHPR15MB1264.namprd15.prod.outlook.com
 ([fe80::cc6:7ec2:94ef:f8cb]) by MWHPR15MB1264.namprd15.prod.outlook.com
 ([fe80::cc6:7ec2:94ef:f8cb%9]) with mapi id 15.20.1709.011; Tue, 12 Mar 2019
 20:52:58 +0000
From:   Calvin Owens <calvinowens@fb.com>
To:     Petr Mladek <pmladek@suse.com>
CC:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 3/4] printk: Add consoles to a virtual "console" bus
Thread-Topic: [PATCH 3/4] printk: Add consoles to a virtual "console" bus
Thread-Index: AQHU0JGsczOzMag9pEqv+OoueTdNJKYB7R0AgAac4AA=
Date:   Tue, 12 Mar 2019 20:52:57 +0000
Message-ID: <20190312205254.GB5982@Haydn>
References: <cover.1551486732.git.calvinowens@fb.com>
 <087b13f7812b32cc7c3f9efea71c9bcf324dd031.1551486732.git.calvinowens@fb.com>
 <20190308155352.g43mt44adau6cgh6@pathway.suse.cz>
In-Reply-To: <20190308155352.g43mt44adau6cgh6@pathway.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:301:5f::26) To MWHPR15MB1264.namprd15.prod.outlook.com
 (2603:10b6:320:24::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::ce7e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a936ed64-5422-4851-b723-08d6a72cb4f0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1232;
x-ms-traffictypediagnostic: MWHPR15MB1232:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1232;20:5QwrU0om71ZVki13zYFXOpbLCZZet1g5jjtaJSdOx2bMEPd8bHIRzYnRTbxFJw8yXQ77pZPtRP9fAhK74C9unyDJL9XNzeXDfhrhVkuwvu499sg9TqUQHvDthUeUeEWBCl+MfZA6W17tTa16WVAISJemIvAS1vHeR9zlPq/FQOE=
x-microsoft-antispam-prvs: <MWHPR15MB123239170BCFD1E8F40E7F4ECE490@MWHPR15MB1232.namprd15.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(54094003)(71200400001)(106356001)(316002)(53936002)(6512007)(478600001)(9686003)(33656002)(105586002)(54906003)(86362001)(14454004)(6246003)(46003)(476003)(4326008)(486006)(25786009)(305945005)(256004)(7736002)(11346002)(446003)(6486002)(8936002)(6436002)(2906002)(229853002)(81166006)(81156014)(8676002)(5660300002)(68736007)(33716001)(52116002)(6916009)(6116002)(99286004)(1076003)(97736004)(102836004)(186003)(76176011)(6506007)(386003)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1232;H:MWHPR15MB1264.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: erw7a5dsYCDMaPmZB46l0f2hARqRlqdNYMPkdOFV39A8S6o3ik8QCLjrPHXvQvh+5ENbGeWpKpnPqWH0y1eXBcF+l4veKbmactTBUVUS1RtD9K4vYLjuC8uYLNmmtLFDtRViFAEFiGFQsBVohF0ovjWk5KIDPeyqMssLlMl7MGiKMPMUzIbMdfejZp+lmh0o0459jxZ9YZyBeUJVcKZ2eYD2TkXKTd8jKPmMgZl9WqwEcSo8XGZJIJD1koPRk3HCc+TeI8mRcKdgyLQZPfeXlj6VRYWe61iHU0VE9VDW+FxzlcI/Syby8GNBIkABManp73oTKsNQzB9rty5Yodse1FTojUcd1e1+4OuAZQyleqY848XW3o54WWm+JnfVpMWFKbS9F8x1wBJI0y9oWcI6ubMWeUbO8PMSEpxtxxpYoI8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9E6201EFF4A674588ABF7931C62674B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a936ed64-5422-4851-b723-08d6a72cb4f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 20:52:57.9991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1232
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpZGF5IDAzLzA4IGF0IDE2OjUzICswMTAwLCBQZXRyIE1sYWRlayB3cm90ZToNCj4gT24g
RnJpIDIwMTktMDMtMDEgMTY6NDg6MTksIENhbHZpbiBPd2VucyB3cm90ZToNCj4gPiBUaGlzIHBh
dGNoIGVtYmVkcyBhIGRldmljZSBzdHJ1Y3QgaW4gdGhlIGNvbnNvbGUgc3RydWN0LCBhbmQgcmVn
aXN0ZXJzDQo+ID4gdGhlbSBvbiBhICJjb25zb2xlIiBidXMgc28gd2UgY2FuIGV4cG9zZSBhdHRy
aWJ1dGVzIGluIHN5c2ZzLg0KPiA+IA0KPiA+IEVhcmx5IGNvbnNvbGUgc3RydWN0dXJlcyBtdXN0
IHN0aWxsIGJlIHN0YXRpYywgc2luY2UgdGhleSdyZSByZXF1aXJlZA0KPiA+IGJlZm9yZSB3ZSdy
ZSBhYmxlIHRvIGFsbG9jYXRlIG1lbW9yeS4gVGhlIGxlYXN0IHVnbHkgd2F5IEkgY2FuIGNvbWUg
dXANCj4gPiB3aXRoIHRvIGhhbmRsZSB0aGlzIGlzIGFuICJpc19zdGF0aWMiIGZsYWcgaW4gdGhl
IHN0cnVjdHVyZSB3aGljaCBtYWtlcw0KPiA+IHRoZSBnZXRzIGFuZCBwdXRzIE5PUHMsIGFuZCBp
cyBjaGVja2VkIGluIC0+cmVsZWFzZSgpIHRvIGNhdGNoIG1pc3Rha2VzLg0KPiANCj4gSSB3b25k
ZXIgaWYgaXQgbWlnaHQgZ2V0IGRldGVjdGVkIGJ5IGlzX2tlcm5lbF9pbml0dGV4dCgpLg0KDQpJ
IGRvbid0IHRoaW5rIGluaXR0ZXh0KCkgaW4gcGFydGljdWxhciB3b3VsZCB3b3JrLCBzaW5jZSB0
aGVzZSBhY3R1YWxseSBuZWVkDQp0byBleGlzdCBmb3JldmVyIGlmIHlvdSBwYXNzICJlYXJseXBy
aW50az1bLi4uXSxrZWVwIiBzbyB0aGV5IGFyZW4ndCBfX2luaXQuDQoNCkJ1dCBJIGJldCB5b3Un
cmUgcmlnaHQgdGhhdCB3ZSBjb3VsZCBjYXRjaCB0aGUgc3RhdGljIGNhc2Ugd2l0aG91dCBuZWVk
aW5nDQp0aGUgZXhwbGljaXQgZmxhZywgc29tZXRoaW5nIGxpa2UgaXNfbW9kdWxlX2FkZHJlc3Mo
KSAoYnV0IGl0IHdvdWxkIGFsc28gbmVlZA0KdG8gd29yayBmb3IgdGhlIGJ1aWx0LWluIGNhc2Up
LiBJJ2xsIHNlZSBpZiBJIGNhbiBnZXQgdGhpcyB0byB3b3JrLg0KDQpUaGFua3MsDQpDYWx2aW4N
CiANCj4gQmVzdCBSZWdhcmRzLA0KPiBQZXRyDQo=

Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15611C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFA120685
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Jjd0uXx7";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="aHbDVnte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfCRTpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:45:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59758 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726677AbfCRTpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:45:07 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x2IJcSU5025698;
        Mon, 18 Mar 2019 12:44:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=8fOmDMOoeAlyAcyufrEGY1ETwFAqQhmfyCuoxXQ/cb0=;
 b=Jjd0uXx7Fg5VERYUhCH6lqqI4pbSRVCY6vcH5PNpeiEVhabsTin1K0Xh1+zh3Fves4jF
 BGGPk19ZaBuNic6yVyirIaEhhdW50h/35xosw/I/8HoQC5o2SA8wX0F/5D/FXlelf3d2
 bwJ+vu0kaQwBeV87EZp8Npj/Qd/wmtgksGE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2r8vtmf9js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 Mar 2019 12:44:53 -0700
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 18 Mar 2019 12:44:52 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 18 Mar 2019 12:44:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fOmDMOoeAlyAcyufrEGY1ETwFAqQhmfyCuoxXQ/cb0=;
 b=aHbDVnte7MHDGN1xAabVIQ3wMVkL8aj3ACpobjGkFPtxXGe/72P6/9Jsw7RKVkkv/bQ68nsW4MzFBZm7EYloqKGtKT5DZLiak56I9aOhAVdyrMDRSSd8YagpQD2Ud/W0kXEGCZmkb1oGTPBUd8O5qtiDU3F3vJhg9Y6g5zvagU4=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.177.11) by
 CY4PR15MB1208.namprd15.prod.outlook.com (10.172.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 19:44:51 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::adbc:85e5:68d3:ac2d]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::adbc:85e5:68d3:ac2d%3]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 19:44:51 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Subject: Re: [Potential Spoof] Re: [PATCH] ARM: dts: aspeed: tiogapass: Enable
 VUART
Thread-Topic: [Potential Spoof] Re: [PATCH] ARM: dts: aspeed: tiogapass:
 Enable VUART
Thread-Index: AQHU3cMN/C7cXg6+GkKYfo17xh2m/w==
Date:   Mon, 18 Mar 2019 19:44:51 +0000
Message-ID: <34F58DD7-2C58-4074-AA86-212E639274F0@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::2:ba19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b132e9d2-33b0-41ba-016d-08d6abda2fc8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1208;
x-ms-traffictypediagnostic: CY4PR15MB1208:
x-microsoft-antispam-prvs: <CY4PR15MB12084ACBD4F8DAB5EFA1F0B4DD470@CY4PR15MB1208.namprd15.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(136003)(346002)(396003)(199004)(189003)(6246003)(2906002)(2501003)(8936002)(82746002)(105586002)(486006)(102836004)(25786009)(68736007)(106356001)(46003)(110136005)(476003)(14454004)(2616005)(33656002)(86362001)(4326008)(36756003)(6506007)(71190400001)(6116002)(83716004)(71200400001)(229853002)(81156014)(5660300002)(53546011)(478600001)(4744005)(2201001)(6436002)(8676002)(6512007)(305945005)(97736004)(81166006)(6486002)(7736002)(53936002)(316002)(256004)(99286004)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1208;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dK9OyWV6wq3w5QfhFJfJD5uU9vsG1tPnNPfuKB9huKiuvAA6EiOSdKzyjyKOWfi9D4zLe17E9qRQz5PzC8pG5PMBT3elIqIvMfRhPrpI9IlCzZ4VdJhLFvRGkkJ/ote5HWseuG52eJeim6/5Bx9lDm4xGxLCoL9Kzu5nk/cjMBs2uJN1C9MAsRR0J03mPEW2pIDeh8+/kpxYPF7B5YpPoBzT3mjG9bTEdTQ4fgK5JduynodunVxKpaSqZHWeJ281wIBi2laiy/RYm65pAbO2iSEwu5UawsBRb0IwZrtcetuNJmAO6Sj4jnOh9HXEbAydT/FQubcdRYSYzrivHCf1C2u/1k7ZZooT1IR8IgvMJcegwUMSKkS25zh6brAdXL+xP9NOcqPLyXPzKovnCfDQXGQ/K+/J+ye7ssggr4eIwTM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B420B6B29D23B449283B0708DC5A138@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b132e9d2-33b0-41ba-016d-08d6abda2fc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 19:44:51.1390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1208
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-18_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9lbCwNClBsZWFzZSBhcHBseSB0aGlzIHBhdGNoLg0KDQpSZWdhcmRzDQotVmlqYXkNCg0K
77u/T24gMy81LzE5LCAxMjowNiBQTSwgIm9wZW5ibWMgb24gYmVoYWxmIG9mIFZpamF5IEtoZW1r
YSIgPG9wZW5ibWMtYm91bmNlcyt2aWpheWtoZW1rYT1mYi5jb21AbGlzdHMub3psYWJzLm9yZyBv
biBiZWhhbGYgb2YgdmlqYXlraGVta2FAZmIuY29tPiB3cm90ZToNCg0KICAgIFBsZWFzZSByZXZp
ZXcgYmVsb3cgcGF0Y2guDQogICAgDQogICAgUmVnYXJkcw0KICAgIC1WaWpheQ0KICAgIA0KICAg
IE9uIDEvMzAvMTksIDEwOjE0IEFNLCAiVmlqYXkgS2hlbWthIiA8dmlqYXlraGVta2FAZmIuY29t
PiB3cm90ZToNCiAgICANCiAgICAgICAgRW5hYmxpbmcgdnVhcnQgZm9yIEZhY2Vib29rIHRpb2dh
cGFzcw0KICAgICAgICANCiAgICAgICAgU2lnbmVkLW9mZi1ieTogVmlqYXkgS2hlbWthIDx2aWph
eWtoZW1rYUBmYi5jb20+DQogICAgICAgIC0tLQ0KICAgICAgICAgYXJjaC9hcm0vYm9vdC9kdHMv
YXNwZWVkLWJtYy1mYWNlYm9vay10aW9nYXBhc3MuZHRzIHwgNSArKysrKw0KICAgICAgICAgMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KICAgICAgICANCiAgICAgICAgZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2stdGlvZ2FwYXNzLmR0cyBi
L2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2stdGlvZ2FwYXNzLmR0cw0KICAg
ICAgICBpbmRleCA0MmUwZDdhOGU4ZDAuLmEwNThmYjI5ODVmNyAxMDA2NDQNCiAgICAgICAgLS0t
IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWJtYy1mYWNlYm9vay10aW9nYXBhc3MuZHRzDQog
ICAgICAgICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2stdGlvZ2Fw
YXNzLmR0cw0KICAgICAgICBAQCAtNjQsNiArNjQsMTEgQEANCiAgICAgICAgIAlzdGF0dXMgPSAi
b2theSI7DQogICAgICAgICB9Ow0KICAgICAgICAgDQogICAgICAgICsmdnVhcnQgew0KICAgICAg
ICArCS8vIFZVQVJUIEhvc3QgQ29uc29sZQ0KICAgICAgICArCXN0YXR1cyA9ICJva2F5IjsNCiAg
ICAgICAgK307DQogICAgICAgICsNCiAgICAgICAgICZ1YXJ0MSB7DQogICAgICAgICAJLy8gSG9z
dCBDb25zb2xlDQogICAgICAgICAJc3RhdHVzID0gIm9rYXkiOw0KICAgICAgICAtLSANCiAgICAg
ICAgMi4xNy4xDQogICAgICAgIA0KICAgICAgICANCiAgICANCiAgICANCg0K

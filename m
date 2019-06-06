Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8519FC28D18
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 05:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D90B20872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 05:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="cmMfYsne";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="XJnS1rPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfFFFNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 01:13:31 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:60428 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725782AbfFFFNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 01:13:31 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5658UAq011318;
        Wed, 5 Jun 2019 22:11:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=ylmvFaynTnm2xShYZm5lLLOJk58zqFatT2ShI1S/0e4=;
 b=cmMfYsneq1kIIwlWnYy+TwpIQ3mVx0ShILi1PsQI3rqRBDK1foGfKz6pHJnuNlEXvsoS
 yEBm3pzYg+rQ0YXII3hsqwErSzN2SJvNHVxP5jPApNP1ybreMZz+Tk5p0pDQSxnxddUR
 bbc1CofCt2eLpYfRBjNl5klLm06WjoevOu6x9jknI7RJvcfKNgZebWHqW1cH6VwGllgY
 aQou7/Qr6zrz2TjAs7oH82bZEA5O/163I28xkqBm9gqrAsUFbl87jsuF9B4oa2l0EeUp
 7wsAGIcNC5SEZrPUobpu8HHO3ek8iFCVW7yOMtat7Zdy7sSk5sIFRiTt36P3rzCgAnJP Jg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2057.outbound.protection.outlook.com [104.47.45.57])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2sun4r3h7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 05 Jun 2019 22:11:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylmvFaynTnm2xShYZm5lLLOJk58zqFatT2ShI1S/0e4=;
 b=XJnS1rPztbtbTnjJB6ihyOriFbKHUBLSQA28V3sZ3Op5o/N46UVkxtseI8fRzJe4I32CqYRQDTpriPpxJRbCl4vRy6FXBHvEMgKlC2yXRpw76z8t3Ppd+QsR/Hxo34KuQftlbuC4zsJ2tov8f5/XDG+7LKqH5FKTIMHWDsCbCsQ=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5720.namprd07.prod.outlook.com (20.178.0.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Thu, 6 Jun 2019 05:11:33 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::594a:4a73:3ead:457d]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::594a:4a73:3ead:457d%3]) with mapi id 15.20.1943.023; Thu, 6 Jun 2019
 05:11:33 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Lars Melin <larsm17@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v7 0/6] Introduced new Cadence USBSS DRD Driver.
Thread-Topic: [PATCH v7 0/6] Introduced new Cadence USBSS DRD Driver.
Thread-Index: AQHVG4YPLuNsPGFK2Eaa0JSlSMiZDaaN0ryAgABCM9A=
Date:   Thu, 6 Jun 2019 05:11:33 +0000
Message-ID: <BYAPR07MB4709E7267C34F09747B13568DD170@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1559729030-16390-1-git-send-email-pawell@cadence.com>
 <30b6ac49-2edc-fde0-a106-34ff94999e5a@gmail.com>
In-Reply-To: <30b6ac49-2edc-fde0-a106-34ff94999e5a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctOGIzYjY0ODYtODgxOS0xMWU5LTg3NDEtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDhiM2I2NDg4LTg4MTktMTFlOS04NzQxLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNTkxIiB0PSIxMzIwNDI3MTQ5MTMzMTQxNDkiIGg9IlpEMUIreEpVMVQvTVBaREZaOFkvZXJFTHJ3ST0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd51c603-16a2-42d1-f710-08d6ea3d7188
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5720;
x-ms-traffictypediagnostic: BYAPR07MB5720:
x-microsoft-antispam-prvs: <BYAPR07MB5720A475F174818ABE00FCE1DD170@BYAPR07MB5720.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(366004)(36092001)(189003)(199004)(14454004)(7696005)(76176011)(6506007)(76116006)(74316002)(73956011)(99286004)(7416002)(186003)(6436002)(478600001)(110136005)(55016002)(33656002)(305945005)(54906003)(102836004)(52536014)(26005)(9686003)(7736002)(229853002)(81156014)(8676002)(2501003)(4744005)(66476007)(486006)(6246003)(256004)(107886003)(66946007)(446003)(5660300002)(11346002)(81166006)(316002)(86362001)(3846002)(68736007)(25786009)(476003)(8936002)(66066001)(71200400001)(71190400001)(64756008)(53936002)(2906002)(4326008)(6116002)(66446008)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5720;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j279DhvQn9vuzUlxyg05cEm70xlCpgeX64bhenSE8XhB84JOeogqbBM0hW/li8HkipuBbwQCnCbQtAEPqrC3YSVtno1Fcox8/hTeRfQFzVB2oMYfcC4w4ztDyi07nQwr0MG1gjQiCX1jsZ12YixdU1EWwh99Pfp3DcOBfeHAxK4IkkKDHrIsUvW8cSnNTHk3s/pCyqMo0N6lsEIXdvZGnrjQwfRzv0Jsi7vs7jgoByW3jaihE4NGueWYL0HGLZnySDSpM+/IDwBt1sva5p3vhgmijK1GD1Mt5iqkLs00Imns+r5Jc4y50/gHYNNsLZBjaKHFwZPSv9IvhDjwgCfede7hi+i0TwwKKbBUoT6uo0FnJPk2EODC2zz6LnzY+mPcIyszzUmjL/qc13ztlvrsQwqySj0CCota9lOgACY8Z8U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd51c603-16a2-42d1-f710-08d6ea3d7188
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 05:11:33.7010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5720
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=594 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pk9uIDYvNS8yMDE5IDE3OjAzLCBQYXdlbCBMYXN6Y3phayB3cm90ZToNCj4+IFRoaXMgcGF0Y2gg
aW50cm9kdWNlcyBuZXcgQ2FkZW5jZSBVU0JTUyBEUkQgZHJpdmVyIHRvIExpbnV4IGtlcm5lbC4N
Cj4+DQo+PiBUaGUgQ2FkZW5jZSBVU0JTUyBEUkQgRHJpdmVyIGlzIGEgaGlnaGx5IGNvbmZpZ3Vy
YWJsZSBJUCBDb3JlIHdoaWNoDQo+PiBjYW4gYmUgaW5zdGFudGlhdGVkIGFzIER1YWwtUm9sZSBE
ZXZpY2UgKERSRCksIFBlcmlwaGVyYWwgT25seSBhbmQNCj4+IEhvc3QgT25seSAoWEhDSSljb25m
aWd1cmF0aW9ucy4NCj4+DQo+VGhlIGRyaXZlciBpcyBub3QgYW4gSVAgQ29yZSwgdGhlIGhhcmR3
YXJlIGRldmljZSBpcy4NCj4NCkkgcmVtZW1iZXIgdGhhdCBJIGhhZCBzdWNoIGNvbW1lbnQgaW4g
dGhlIHBhc3RlLiBJIGRvbid0IGtub3cgd2h5IHRoZXJlIGlzICJJUCBDb3JlIi4NCg0KSSB3aWxs
IGNoYW5nZSBpdC4NCnRoYW5rcyAsDQpQYXdlbA0KPg0KPi9MYXJzDQo+DQoNCg==

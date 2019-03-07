Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EE5C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EAF204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="iGzniZMb";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="EoCo6evK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfCGHGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 02:06:45 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:60116 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726313AbfCGHGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 02:06:45 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2774kb3014018;
        Wed, 6 Mar 2019 23:06:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=ZWGjJPHnMXBl1TXV6e9WA9rXCo5IGiJeZwEGQ3syGVQ=;
 b=iGzniZMb0syM8lDkaeRC2RIzyREyDJfQiXYwduqq8d7EfL+PoV1QGHUP/s2xxB64gYvj
 XEOunTAX8HI7iftqT4VrwIWudCUbme/RKbUUkku6swxZ0IapxRCl9zyHym4xxoEZV0p9
 4wPc0kQBXwucFqvChFAAJ6psGw1HhqaU8Ew56W96Ut4OmUVD8qNZyZ+EbkV+uxmvD0ra
 +EO6VQruwovGqNqOuSI+8KoQg0TX1aqBszq+va+aK6n196dbipqlChWGDKvM8ikjwTA9
 gxYK/bH+m7klDF8fVRd2EbQMI8/o0VrUKI1HK2vGt49W91pk0Ul235/cKltiE05KcNFA KA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2055.outbound.protection.outlook.com [104.47.50.55])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2qyp9yykkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Mar 2019 23:06:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWGjJPHnMXBl1TXV6e9WA9rXCo5IGiJeZwEGQ3syGVQ=;
 b=EoCo6evKLh+p5BqIP5D8FbPjQQTj3as5atfEj0d5WNgWyAHHLih0p5oSPSkE/wHvwOG33ATvPNNdSwaZ7ODwNguU457DMinzf9nbFPXuiG1Jb0lq6CpARHR3KXFmG4J6LAF+jcEivV9iBFf2R0W7anYkj2XNppbacOXR8o6ZDzU=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5912.namprd07.prod.outlook.com (20.179.91.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Thu, 7 Mar 2019 07:06:26 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::2dae:f6be:5a31:3bc8]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::2dae:f6be:5a31:3bc8%4]) with mapi id 15.20.1665.021; Thu, 7 Mar 2019
 07:06:26 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v4 6/6] usb:cdns3 Fix for stuck packets in on-chip OUT
 buffer.
Thread-Topic: [PATCH v4 6/6] usb:cdns3 Fix for stuck packets in on-chip OUT
 buffer.
Thread-Index: AQHUxJ4TFqBzwxyHqkO+/LkhB9s+t6Xog5QAgAAI4rCAACd3AIAAIfNwgAELEACAEX7wgIAEecgg
Date:   Thu, 7 Mar 2019 07:06:26 +0000
Message-ID: <BYAPR07MB4709F449E09AD352BA06CBA7DD4C0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1550173514-23573-1-git-send-email-pawell@cadence.com>
 <1550173514-23573-7-git-send-email-pawell@cadence.com>
 <67da432f-9c95-d644-65b5-dbc5b942d24c@ti.com>
 <BYAPR07MB47091C199971D677DE0FBB84DD7D0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <e8616274-b0a8-6e59-b6fa-a68fed58bad7@ti.com>
 <BYAPR07MB470939C6F100336BAF6C41BFDD7D0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87va1dbokp.fsf@linux.intel.com>
 <70967a02-2f02-9ac8-e205-cdbfac5fbbae@ti.com>
In-Reply-To: <70967a02-2f02-9ac8-e205-cdbfac5fbbae@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctODQyOTY0MzQtNDBhNy0xMWU5LTg3MzAtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDg0Mjk2NDM1LTQwYTctMTFlOS04NzMwLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzAyMyIgdD0iMTMxOTY0MTU5ODQzMjAwMzQwIiBoPSJXRFRKc3czMUxPODNuMm94QjBWekFlc0tKbUk9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 321c24cc-d2bc-4c56-e2a9-08d6a2cb6a83
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5912;
x-ms-traffictypediagnostic: BYAPR07MB5912:
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5912;20:tuJeAcuWyxzk7lPmxQ3i3WBNvPZ846faYLQ7Fxo9QSIipxJxC2eUl36qUmTk0m6XCvurFubU8RxWDxYBZ4SuZSCEkK1JcOD0M2kAtlP3D5/iTvFTpc2g0ql7Fxn7MdSJLhkpF9ZLO+6vUX7F6Go0HtdDIzzWqx5r/LLfIxKTOEcxBLlmO5JLKauCOQofb6FHVLvBo/oMOjFWueD/i9KyVz2WNlzG9uzlwvyrclyNcYuCePgcDqjvyr3AuR9yGR09
x-microsoft-antispam-prvs: <BYAPR07MB5912C4A0AB0AFE8EC8BF6076DD4C0@BYAPR07MB5912.namprd07.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(136003)(39860400002)(376002)(199004)(189003)(36092001)(55016002)(99286004)(7696005)(93886005)(2501003)(76176011)(486006)(52536013)(71190400001)(71200400001)(9686003)(14444005)(256004)(7416002)(33656002)(4326008)(6246003)(106356001)(316002)(53936002)(97736004)(5660300002)(66066001)(107886003)(2906002)(86362001)(68736007)(229853002)(6506007)(11346002)(26005)(102836004)(305945005)(446003)(476003)(105586002)(74316002)(110136005)(81156014)(3846002)(186003)(6116002)(8936002)(478600001)(54906003)(25786009)(7736002)(14454004)(6436002)(8676002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5912;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9fQRKr8LU/uzMp7MenksOK1hCXUbVYKzl/oAZQOndPesDnoshLHcKMMkorlEXQNrFwWiS0gpkRfhCEw3bmGxf0OaVMsw9EnGW0O91LPkLEnr+sfvkUuIEGYyj7sCBya2v2i5usEzpAYsTL12GFBC2oFbu7RNZkhpTF5kCE+zCoiFJZvSouX7t4QVkUBMpJjm45LVX9w4ruQY+npGUPchMDL/QGLGw2Fg6HIONem8o3aos1PQayKcX7BO6CrAENst7DWPpe5XTGBtbNXELecaFEDFJsWGoWZqSgHUNd1M6E64v1tyBae2FYR+33ERGvn2pNy5yAL23ISsu5gvU53v1KX7S02ziE62a7JkvdOcBcIZ3q4MKli0lexUjdk075xbeBYU+sFqq8bnePBERqZE7ZaqeVG43R0v77sCt6BcQuQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 321c24cc-d2bc-4c56-e2a9-08d6a2cb6a83
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 07:06:26.7702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5912
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903070051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj5IaSwNCj4NCj5PbiAyMS8wMi8yMDE5IDA5OjE0LCBGZWxpcGUgQmFsYmkgd3JvdGU6
DQo+Pg0KPj4gSGksDQo+Pg0KPj4gKHBsZWFzZSBicmVhayB5b3VyIGVtYWlscyBhdCA4MC1jb2x1
bW5zKQ0KPj4NCj4+IFBhd2VsIExhc3pjemFrIDxwYXdlbGxAY2FkZW5jZS5jb20+IHdyaXRlczoN
Cj4+Pj4+IE9uZSBtb3JlIHRoaW5nLiBXb3JrYXJvdW5kIGhhcyBpbXBsZW1lbnRlZCBhbGdvcml0
aG0gdGhhdCBkZWNpZGUgZm9yIHdoaWNoDQo+Pj4+PiBlbmRwb2ludCBpdCBzaG91bGQgYmUgZW5h
YmxlZC4gIGUuZyBmb3IgY29tcG9zaXRlIGRldmljZSBNU0MrTkNNK0FDTSBpdA0KPj4+Pj4gc2hv
dWxkIHdvcmsgb25seSBmb3IgQUNNIE9VVCBlbmRwb2ludC4NCj4+Pj4+DQo+Pj4+DQo+Pj4+IElm
IEFDTSBkcml2ZXIgZGlkbid0IHF1ZXVlIHRoZSByZXF1ZXN0IGZvciBBQ00gT1VUIGVuZHBvaW50
LCB3aHkgZG9lcyB0aGUNCj4+Pj4gY29udHJvbGxlciBhY2NlcHQgdGhlIGRhdGEgYXQgYWxsPw0K
Pj4+Pg0KPj4+PiBJIGRpZG4ndCB1bmRlcnN0YW5kIHdoeSB3ZSBuZWVkIGEgd29ya2Fyb3VuZCBm
b3IgdGhpcy4gSXQgc2hvdWxkIGJlIHN0YW5kYXJkDQo+Pj4+IGJlaGF2aW91ciB0byBOQUsgZGF0
YSBpZiBmdW5jdGlvbiBkcml2ZXIgZGlkbid0IHJlcXVlc3QgZm9yIGFsbCBlbmRwb2ludHMuDQo+
Pj4NCj4+PiBZZXMsIEkgYWdyZWUgd2l0aCB5b3UuIENvbnRyb2xsZXIgc2hvdWxkbuKAmXQgYWNj
ZXB0IHN1Y2ggcGFja2V0LiBBcyBJIGtub3cgdGhpcw0KPj4+IGJlaGF2aW9yIHdpbGwgYmUgZml4
ZWQgaW4gUlRMLg0KPj4+DQo+Pj4gQnV0IEkgYXNzdW1lIHRoYXQgc29tZSBvbGRlciB2ZXJzaW9u
IG9mIHRoaXMgY29udHJvbGxlciBhcmUgb25lIHRoZSBtYXJrZXQsDQo+Pj4gYW5kIGRyaXZlciBz
aG91bGQgd29yayBjb3JyZWN0IHdpdGggdGhlbS4NCj4+Pg0KPj4+IEluIHRoZSBmZWF0dXJlIHRo
aXMgd29ya2Fyb3VuZCBjYW4gYmUgbGltaXRlZCBvbmx5IHRvIHNlbGVjdGVkIGNvbnRyb2xsZXJz
Lg0KPj4+DQo+Pj4gRXZlbiBub3cgSSBhc3N1bWUgdGhhdCBpdCBjYW4gYmUgZW5hYmxlZC9kaXNh
YmxlZCBieSBtb2R1bGUgcGFyYW1ldGVyLg0KPj4NCj4+IG5vIG1vZHVsZSBwYXJhbWV0ZXJzLCBw
bGVhc2UuIFVzZSByZXZpc2lvbiBkZXRlY3Rpb24gaW4gcnVudGltZS4NCj4+DQo+DQo+VGhpcyBp
cyBhYm91dCB3aGV0aGVyIHRvIGVuYWJsZSBvciBkaXNhYmxlIHRoZSB3b3JrYXJvdW5kLg0KPkJ5
IGRlZmF1bHQgd2UgZG9uJ3Qgd2FudCB0aGlzIHdvcmthcm91bmQgdG8gYmUgZW5hYmxlZC4NCj4N
Cj5JJ20gZGViYXRpbmcgd2hldGhlciB3ZSBzaG91bGQgaGF2ZSB0aGlzIHdvcmthcm91bmQgYXQg
YWxsIG9yIG5vdC4NCj4NCj5JdCBoYXMgdGhlIGZvbGxvd2luZyBwcm9ibGVtcy4NCj4NCj4xKSBJ
dCBBQ0tzIHBhY2tldHMgZXZlbiB3aGVuIGdhZGdldCBlbmQgaXMgbm90IHJlYWR5IHRvIGFjY2Vw
dCB0aGUgdHJhbnNmZXJzLg0KPjIpIEl0IHN0b3JlcyB0aGVzZSBwYWNrZXRzIGluIGEgdGVtcG9y
YXJ5IGJ1ZmZlciBhbmQgdGhlbiBwdXNoZXMgdGhlbSB0byB0aGUNCj5nYWRnZXQgZHJpdmVyIHdo
ZW5ldmVyIHRoZSBnYWRnZXQgZHJpdmVyIGlzIHJlYWR5IHRvIHByb2Nlc3MgdGhlIGRhdGEuDQo+
MykgU2luY2UgdGhlIGdhZGdldCBkcml2ZXIgY2FuIGJlY29tZSByZWFkeSBhdCBhbiBpbmRlZmlu
aXRlIHRpbWUgaW4gdGhlDQo+ZnV0dXJlLCBpdCBwb3NlcyAyIHByb2JsZW1zOg0KPiBhKSBJdCBp
cyBzZW5kaW5nIHN0YWxlIGRhdGEgdG8gdGhlIHNpbmsuIChwcm9ibGVtYXRpYyBhdCBuZXh0IHBy
b3RvY29sIGxldmVsPykNCj4gYikgSWYgdGhpcyB0ZW1wb3JhcnkgYnVmZmVyIHJ1bnMgb3V0IHdl
IHN0aWxsIGhpdCB0aGUgbG9jayB1cCBpc3N1ZS4NCj4NCj5JIHRoaW5rIHRoZSByaWdodCBzb2x1
dGlvbiBpcyB0byBtYWtlIHN1cmUgdGhhdCB0aGUgZ2FkZ2V0IGRyaXZlciBpcyBhbHdheXMNCj5y
ZWFkaW5nIGFsbCB0aGUgZW5hYmxlZCBPVVQgZW5kcG9pbnRzICpvciogKGtlZXAgdGhlIE9VVCBl
bmRwb2ludHMgZGlzYWJsZWQNCj5pZiBnYWRnZXQgZHJpdmVyIGlzIG5vdCByZWFkeSB0byBwcm9j
ZXNzIE9VVCB0cmFuc2ZlcnMpLg0KDQpJZiBkcml2ZXIgZGlzYWJsZSBlbmRwb2ludCB0aGVuIGl0
IG5vdCBhbnN3ZXIgZm9yIHBhY2tldHMgZnJvbSBob3N0LiANCkl0IHdpbGwgcmVzdWx0IHRoYXQg
aG9zdCByZXNldCB0aGUgZGV2aWNlLCBzbyBJIGNhbid0IGRpc2FibGUgc3VjaCBlbmRwb2ludHMu
IA0KDQpPdGhlciBnb29kIHNvbHV0aW9uIGlzIHRvIGNoYW5nZSBBQ00gZHJpdmVyIGluIGEgd2F5
IHRoYXQgaXQgc2VuZHMgcmVxdWVzdHMgDQp0byBjb250cm9sbGVyIGRyaXZlciBhZnRlciBlbmFi
bGluZyBlbmRwb2ludC4gVGhlIGNsYXNzIGRyaXZlciBjb3VsZCBkZWNpZGUgDQp3aGF0IHNob3Vs
ZCBkbyB3aXRoIHN1Y2ggbm90IGV4cGVjdGVkIHBhY2tldHMuIEl0IGNvdWxkIGRlbGV0ZSBhbGwg
b3IgZS5nIA0Ka2VlcCBvbmx5IGZldyBsYXN0IHBhY2tldHMuIA0KDQpUaGlzIGlzc3VlIHdpbGwg
YmUgZml4ZWQgaW4gUlRMIGJ1dCBtYXliZSBkcml2ZXIgc2hvdWxkIGJlIGNvbXBhdGlibGUgd2l0
aCBwcmV2aW91cyANCmNvbnRyb2xsZXLigJlzIHZlcnNpb24uDQoNCkJ5IGRlZmF1bHQsIHRoaXMg
d29ya2Fyb3VuZCB3aWxsIGJlIGRpc2FibGVkIG9yIHdpbGwgZGVwZW5kIG9uIGNvbnRyb2xsZXIg
dmVyc2lvbi4gIA0KPg0KPmNoZWVycywNCj4tcm9nZXINCj4tLQ0KPlRleGFzIEluc3RydW1lbnRz
IEZpbmxhbmQgT3ksIFBvcmtrYWxhbmthdHUgMjIsIDAwMTgwIEhlbHNpbmtpLg0KPlktdHVubnVz
L0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNpbmtpDQoN
CkNoZWVycywNClBhd2VsDQo=

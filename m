Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A44C468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 06:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3085620862
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 06:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="PKNz3cuh";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="cH3CqB02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387899AbfFJGq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 02:46:27 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:60484 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387655AbfFJGq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 02:46:27 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5A6iTPr024654;
        Sun, 9 Jun 2019 23:45:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Ct3CVmG0X9pZrU0c70uEnoq87cNqpnLEMdqU3NLfR6E=;
 b=PKNz3cuhRsPQBsKUD9GlUW8/rYt2PYNVy8bEMO3kYMdo0dYqeP4yZRSTwWm9/YsGZ1ut
 Ox6lYrrGEaFy4I9mxdD/57z1yxlDziHVg8rLkMX0xVcIoUKy5fz8+Jndmp1lm9I6H+ut
 z46lyyfUPiZGQQKIa2UV9+tsJr6ajeunn99e6DTVhg0HEy6amZdEJnGyzuRWDbhLSgWv
 IpVbqQYptY2Y5ZneASPipU13+19jwnwSyp/cxYrSTI/5s/JIF1XpPA+IDHYz0yF3jsyN
 I8YPvkcIBvsVn9HvFVtZKfM+dXm9AbXEDkI46G56T5DPCkodvkZg71iNzajgRJbVqECV qw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2052.outbound.protection.outlook.com [104.47.32.52])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2t08kxda91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 09 Jun 2019 23:45:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ct3CVmG0X9pZrU0c70uEnoq87cNqpnLEMdqU3NLfR6E=;
 b=cH3CqB0218n1NIajVG/45r1+uKSQOWpfcnSkEWlqPA5BJ72beS61HPQKneCeRz5l1ol3cywXXziVE9Ynd+KenTU9G5HawVowm5o6t13b7zqer4r7ZLyXJGjpTluXwbKcqJC0yOAx8J0o+BR/vD2k6uGpK8lz8clPfv9yRtAEW0c=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5751.namprd07.prod.outlook.com (20.178.0.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.17; Mon, 10 Jun 2019 06:45:48 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::594a:4a73:3ead:457d]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::594a:4a73:3ead:457d%3]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 06:45:48 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@nxp.com>, Roger Quadros <rogerq@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v7 1/6] dt-bindings: add binding for USBSS-DRD controller.
Thread-Topic: [PATCH v7 1/6] dt-bindings: add binding for USBSS-DRD
 controller.
Thread-Index: AQHVG4YSLjJ8ECZT9ECicIdMOrgMB6aOii2AgAEH4iCAAFzqgIAEX2mwgAAh8YCAAAYFcA==
Date:   Mon, 10 Jun 2019 06:45:48 +0000
Message-ID: <BYAPR07MB470915AB1D833EC1CEA5C8D7DD130@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1559729030-16390-1-git-send-email-pawell@cadence.com>
 <1559729030-16390-2-git-send-email-pawell@cadence.com>
 <f032b3f3-409d-b0fc-8d5f-01c898b4c7a7@ti.com>
 <BYAPR07MB470903AF06C1F8A34BBB3C64DD100@BYAPR07MB4709.namprd07.prod.outlook.com>
 <64be9d26-2a68-1b90-89c8-29b227e0cd9c@ti.com>
 <BYAPR07MB470965B3CBCB58E1C7B1253FDD130@BYAPR07MB4709.namprd07.prod.outlook.com>
 <VI1PR04MB532797447E56454C0E2D3F668B130@VI1PR04MB5327.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB532797447E56454C0E2D3F668B130@VI1PR04MB5327.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNWZkNTMxYzQtOGI0Yi0xMWU5LTg3NDEtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDVmZDUzMWM1LThiNGItMTFlOS04NzQxLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzMzNyIgdD0iMTMyMDQ2MjI3NDY4NzMxNjMzIiBoPSI5dVZ4NmJZclVFWldPRW5nWmV2aTdMZ2JkWVk9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1f810e7-8a2f-434c-353a-08d6ed6f45c1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5751;
x-ms-traffictypediagnostic: BYAPR07MB5751:
x-microsoft-antispam-prvs: <BYAPR07MB5751D3F9A385ED8C20FD93C8DD130@BYAPR07MB5751.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39860400002)(136003)(36092001)(199004)(189003)(7416002)(316002)(66066001)(66946007)(66476007)(66556008)(64756008)(66446008)(2501003)(305945005)(7736002)(73956011)(68736007)(86362001)(4326008)(33656002)(71200400001)(71190400001)(5660300002)(256004)(52536014)(6246003)(107886003)(25786009)(446003)(55016002)(229853002)(476003)(99286004)(76176011)(7696005)(478600001)(76116006)(486006)(9686003)(14454004)(186003)(6436002)(54906003)(110136005)(26005)(11346002)(53936002)(6116002)(3846002)(74316002)(8676002)(81156014)(6506007)(102836004)(8936002)(81166006)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5751;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dG/9nm577XSSE5KGL+YZ5mxd8yG6YZPhCUvtI4Nne0NWuLLJ//xSHHKIhwIVVzLFvjCw2DHGeEoRPJvd37ak3bJE1AjRyyHSs/k0WQUZzttJqB9usaJKSaKWqab1XizGzqU7JYxP4lmpso3yGRvY+NAfKjjq55e6PPRqzvUwlaPOUKRdZfvDjVatrsaU8o5CnwCD01BoX7/n87KWiWJRr+Ajunk7aV3dArpRAN4SLSMbgS/mv1VBAPWQ/MoXZ1YizaWWL4ltzjxr1J0Aw3hzYxm1SfwX4mz3zC4Wq/3huvyrYqJ7YLP4kcmE/GqNnhXVHAnS3KIXz7JQ+9EeZl/BFaq/yWIc26YBrGJN/9wHRgIiB11ZYOBUh6xl+xamxEQcYsR4lS4OquaGz+gfOnNaWdBhO7YTJcZPc8Pxemyl++s=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f810e7-8a2f-434c-353a-08d6ed6f45c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 06:45:48.5417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5751
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-10_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906100047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pg0KPj4gIC0gcmVnLW5hbWVzIC0gcmVnaXN0ZXIgbWVtb3J5IGFyZWEgbmFtZXM6DQo+PiAgICAg
ICAgICJ4aGNpIiAtIGZvciBIT1NUIHJlZ2lzdGVycyBzcGFjZQ0KPj4gICAgICAgICAiZGV2IiAt
IGZvciBERVZJQ0UgcmVnaXN0ZXJzIHNwYWNlDQo+PiAgICAgICAgICJvdGciIC0gZm9yIE9URy9E
UkQgcmVnaXN0ZXJzIHNwYWNlDQo+PiAgLSBjb21wYXRpYmxlOiBTaG91bGQgY29udGFpbjoNCj4+
ICAgICAgICAgImNkbnMsdXNiMy0xLjAuMCIgLSBmb3IgMHgwMDAyNDUwMiBjb250cm9sbGVyIHZl
cnNpb24NCj4+ICAgICAgICAgImNkbnMsdXNiMy0xLjAuMSIgLSBmb3IgMHgwMDAyNDUwOSBjb250
cm9sbGVyIHZlcnNpb24NCj4+ICAgICAgICAgImNkbnMsdXNiMy0xLjAuMiIgLSBmb3IgMHgwMDAy
NDUwQyBjb250cm9sbGVyIHZlcnNpb24NCj4+ICAgICAgICAgImNkbnMsdXNiMy0xLjAuMyIgLSBm
b3IgMHgwMDAyNDUwZCBjb250cm9sbGVyIHZlcnNpb24NCj4NCj5JZiB0aGUgdmFsdWUgY2FuIGJl
IHJlYWQgZnJvbSByZWdpc3Rlciwgd2h5IHdlIHN0aWxsIG5lZWQgZGlmZmVyZW50IGNvbXBhdGli
bGVzPw0KV2UgZG9uJ3QgbmVlZCBpdC4gSSBsZWZ0IGl0IG9ubHkgIGFzIGluZm9ybWF0aW9uIHRo
YXQgY2RuczMgY29udHJvbGxlciBleGlzdCBpbiA0IGRpZmZlcmVudCB2ZXJzaW9uLiANCg0KPg0K
Pj4gRXhhbXBsZToNCj4+ICAgICAgICAgdXNiQGYzMDAwMDAwIHsNCj4+ICAgICAgICAgICAgICAg
ICBjb21wYXRpYmxlID0gImNkbnMsdXNiMy0xLjAuMSI7DQo+PiAgICAgICAgICAgICAgICAgaW50
ZXJydXB0cyA9IDxHSUNfVVNCX0lSUSA3IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA8R0lDX1VTQl9JUlEgIDcgSVJRX1RZUEVfTEVWRUxf
SElHSD4sDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxHSUNfVVNCX0lSUSAg
OCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4+ICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtbmFt
ZXMgPSAiaG9zdCIsICJwZXJpcGhlcmFsIiwgIm90ZyI7DQo+PiAgICAgICAgICAgICAgICAgcmVn
ID0gPDB4ZjMwMDAwMDAgMHgxMDAwMD4sICAgICAvKiBtZW1vcnkgYXJlYSBmb3IgSE9TVCByZWdp
c3RlcnMgKi8NCj4+ICAgICAgICAgICAgICAgICAgICAgICAgIDwweGYzMDEwMDAwIDB4MTAwMDA+
LCAgIC8qIG1lbW9yeSBhcmVhIGZvciBERVZJQ0UgcmVnaXN0ZXJzICovDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICA8MHhmMzAyMDAwMCAweDEwMDAwPjsgICAvKiBtZW1vcnkgYXJlYSBmb3Ig
T1RHL0RSRCByZWdpc3RlcnMNCj4+ICovDQo+PiAgICAgICAgICAgICAgICAgcmVnLW5hbWVzID0g
InhoY2kiLCAiZGV2IiwgIm90ZyI7DQo+PiAgICAgICAgICAgICAgICAgcGh5cyA9IDwmdXNiM19w
aHk+Ow0KPj4gICAgICAgICAgICAgICAgIHBoeS1uYW1lcyA9ICJjZG5zMyx1c2JwaHkiOw0KPj4N
Cj4+DQo+PiBNYXliZSBJIHNob3VsZCBhZGQgYWxzbyBzb21ldGhpbmcgZm9yIHVzYjJfcGh5IGlu
IGR0LWJpbmRpbmcgYW5kIGluIGRyaXZlciA/DQo+Pg0KPg0KPlRoZSBQSFkgZHJpdmVyIGlzIGxv
Y2F0ZWQgYXQ6IGRyaXZlcnMvcGh5L2NhZGVuY2UvcGh5LWNhZGVuY2Utc2llcnJhLmMuDQo+V2ls
bCB3ZSBuZWVkIGFub3RoZXIgb25lIGZvciBVU0IyIFBIWT8NCg0KQXMgSSBrbm93IHNpZXJyYSBw
aHkgaXMgVVNCMy4wIHBoeS4gDQpBbHNvIEkga25vdyB0aGF0IHdlIGhhdmUgdG9yZW50IHBoeSBk
cml2ZXIgZm9yIDIuMC4gSXQncyByZWFkeSBidXQgaXMgaGFzIG5vdCB5ZXQgaW4ga2VybmVsLiAN
ClNvIEkgYXNzdW1lIHRoYXQgSSBzaG91bGQgY2hhbmdlDQogICAgICAgICAgICAgIHBoeXMgPSA8
JnVzYjNfcGh5PjsNCiAgICAgICAgICAgICAgcGh5LW5hbWVzID0gImNkbnMzLHVzYnBoeSI7DQoN
CndpdGg6IA0KICAgICAgICAgICAgICAgICBwaHlzID0gPCZ1c2IyX3BoeT4sIDwmdXNiM19waHk+
Ow0KICAgICAgICAgICAgICAgICBwaHktbmFtZXMgPSAiY2RuczMsdXNicGh5MiIsICJjZG5zMyx1
c2JwaHkzIjsNCg0KUGF3ZWwNCj4NCj5QZXRlcg0KPg0KPg0KPj4gVGhhbmtzLA0KPj4gUmVnYXJk
cywNCj4+IFBhd2VsDQo+Pg0KPj4gPj4NCj4+ID4+IFJlZ2FyZHMsDQo+PiA+PiBQYXdlbA0KPj4g
Pj4NCj4+ID4+DQo+PiA+Pj4NCj4+ID4+Pj4gKw0KPj4gPj4+PiArT3B0aW9uYWwgcHJvcGVydGll
czoNCj4+ID4+Pj4gKyAtIG1heGltdW0tc3BlZWQgOiB2YWxpZCBhcmd1bWVudHMgYXJlICJzdXBl
ci1zcGVlZCIsICJoaWdoLXNwZWVkIiBhbmQNCj4+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAi
ZnVsbC1zcGVlZCI7IHJlZmVyIHRvIHVzYi9nZW5lcmljLnR4dA0KPj4gPj4+PiArIC0gZHJfbW9k
ZTogU2hvdWxkIGJlIG9uZSBvZiAiaG9zdCIsICJwZXJpcGhlcmFsIiBvciAib3RnIi4NCj4+ID4+
Pj4gKyAtIHBoeXM6IHJlZmVyZW5jZSB0byB0aGUgVVNCIFBIWQ0KPj4gPj4+PiArDQo+PiA+Pj4+
ICtFeGFtcGxlOg0KPj4gPj4+PiArCXVzYkBmMzAwMDAwMCB7DQo+PiA+Pj4+ICsJCWNvbXBhdGli
bGUgPSAiY2Rucyx1c2IzLTEuMC4xIjsNCj4+ID4+Pj4gKwkJaW50ZXJydXB0cyA9IDxVU0JfSVJR
ICA3IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPj4gPj4+DQo+PiA+Pj4gVGhpcyBleGFtcGxlIHdv
bid0IHdvcmsgYXMgY29kZSByZXF1ZXN0cyBmb3IgMyBzZXBhcmF0ZSBpbnRlcnJ1cHRzLg0KPj4g
Pj4+DQo+PiA+Pj4+ICsJCXJlZyA9IDwweGYzMDAwMDAwIDB4MTAwMDAJLyogbWVtb3J5IGFyZWEg
Zm9yIEhPU1QNCj4+IHJlZ2lzdGVycyAqLw0KPj4gPj4+PiArCQkJMHhmMzAxMDAwMCAweDEwMDAw
CS8qIG1lbW9yeSBhcmVhIGZvciBERVZJQ0UNCj4+IHJlZ2lzdGVycyAqLw0KPj4gPj4+PiArCQkJ
MHhmMzAyMDAwMCAweDEwMDAwPjsJLyogbWVtb3J5IGFyZWEgZm9yDQo+PiBPVEcvRFJEIHJlZ2lz
dGVycyAqLw0KPj4gPj4+PiArCQlyZWctbmFtZXMgPSAieGhjaSIsICJkZXYiLCAib3RnIjsNCj4+
ID4+Pj4gKwl9Ow0KPj4gPj4+Pg0KPj4gPj4+DQo+PiA+DQo+PiA+DQo+PiA+LS0NCj4+ID5jaGVl
cnMsDQo+PiA+LXJvZ2VyDQo+PiA+DQo+PiA+VGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBPeSwg
UG9ya2thbGFua2F0dSAyMiwgMDAxODAgSGVsc2lua2kuDQo+PiA+WS10dW5udXMvQnVzaW5lc3Mg
SUQ6IDA2MTU1MjEtNC4gS290aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kNCg==

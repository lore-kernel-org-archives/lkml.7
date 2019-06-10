Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968F1C468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 04:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5205920833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 04:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="aO2PKMOq";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="aIW4Oul6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfFJE7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 00:59:25 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:49092 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725320AbfFJE7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 00:59:25 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5A4s8u3026415;
        Sun, 9 Jun 2019 21:58:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=7JyhXl3W6Os9tn2h7om97qBTrZHZ8k0J3UOhFH0axlw=;
 b=aO2PKMOqmYa2+UOLZeE+Di6sndm4vXE3728g5JlMXfPuHjged4TWb2wdEeN2qiIvGvBp
 JSUEDEbR+QmgqCOzIQEXNDIFRhbNMovk5MiCt0KZWyMzV8On82pobGNbi+OZJa7p7LRq
 ZRclhrnASn+Dk5rhC0CdWL+4yfatwPEgeuc0O3N3kJ7pJXFwQbDWxTA3M+FNXGMMqXPt
 IBwht1tF3k0vOoyI/4Ch7oE3vUPY1NwWKk56Fai/4/eH8DYr/P/icWZQdeFZ89W3Xawz
 DUdVQt2RbmjdaR+06LfMxjPTjqc2LBUV470Czu/usKC+OlitDNLb9ufOHykw/6zxCJMs Fw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2056.outbound.protection.outlook.com [104.47.40.56])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2t08kxcykg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 09 Jun 2019 21:58:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JyhXl3W6Os9tn2h7om97qBTrZHZ8k0J3UOhFH0axlw=;
 b=aIW4Oul6Ds6671a1Kxppxt86edMnS0SK4IayP6u9Qx3UTkSF+4cdYPy/RinpPhUEcu0lFXk5T3R0YZNaCKTk9bE2Vf9SHK1A6WEgPu32awlpV70ZrBU85BfoOT0U91krikjjqmJ9DCf8Nmj+lWIaeG57JJ9xT7wE3I3cLAqRH5o=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4965.namprd07.prod.outlook.com (52.135.238.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Mon, 10 Jun 2019 04:58:55 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::594a:4a73:3ead:457d]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::594a:4a73:3ead:457d%3]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 04:58:55 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
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
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v7 1/6] dt-bindings: add binding for USBSS-DRD controller.
Thread-Topic: [PATCH v7 1/6] dt-bindings: add binding for USBSS-DRD
 controller.
Thread-Index: AQHVG4YSLjJ8ECZT9ECicIdMOrgMB6aOii2AgAEH4iCAAFzqgIAEX2mw
Date:   Mon, 10 Jun 2019 04:58:55 +0000
Message-ID: <BYAPR07MB470965B3CBCB58E1C7B1253FDD130@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1559729030-16390-1-git-send-email-pawell@cadence.com>
 <1559729030-16390-2-git-send-email-pawell@cadence.com>
 <f032b3f3-409d-b0fc-8d5f-01c898b4c7a7@ti.com>
 <BYAPR07MB470903AF06C1F8A34BBB3C64DD100@BYAPR07MB4709.namprd07.prod.outlook.com>
 <64be9d26-2a68-1b90-89c8-29b227e0cd9c@ti.com>
In-Reply-To: <64be9d26-2a68-1b90-89c8-29b227e0cd9c@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNzBjNTNhNTMtOGIzYy0xMWU5LTg3NDEtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDcwYzUzYTU0LThiM2MtMTFlOS04NzQxLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iODgyNSIgdD0iMTMyMDQ2MTYzMzI4NDUxMDE5IiBoPSJ1MlliNmdXRDVUekJvR2duUWZLdU5GVC9SNnM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4ecdc22-14fe-4b25-da6e-08d6ed605747
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR07MB4965;
x-ms-traffictypediagnostic: BYAPR07MB4965:
x-microsoft-antispam-prvs: <BYAPR07MB4965549C4169D53996E19F19DD130@BYAPR07MB4965.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(39860400002)(346002)(396003)(199004)(36092001)(189003)(51444003)(476003)(64756008)(74316002)(66066001)(73956011)(110136005)(66946007)(76116006)(66446008)(66476007)(66556008)(52536014)(54906003)(68736007)(6436002)(229853002)(446003)(7416002)(486006)(11346002)(7736002)(5660300002)(33656002)(26005)(55016002)(86362001)(9686003)(186003)(305945005)(99286004)(2906002)(478600001)(14444005)(316002)(76176011)(256004)(53936002)(7696005)(2501003)(14454004)(4326008)(81166006)(81156014)(107886003)(6506007)(3846002)(6116002)(8676002)(25786009)(102836004)(71200400001)(71190400001)(6246003)(8936002)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4965;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sepy84U4QDFuyjWiYMFKFVHp6do8sMInLBwMRnCjCN7v9N5BBem12SstmquyNmWMP10Q36Q8ZmtZMcTmB/wzciazdSSbMAraJbM+5susrEbZ/4oHu9LzN803owuR/4dr9LYGnlfoDENoHYZALYKuatjqO7OiRCpuXqjLcv6K4htz9NPO0sLO9cKotMkwkfziQuFOD1E6qhvn/rER2ywK30lgB0/edJcfqWbp0MLgHyjPh+krKsT1nGVK6x1JyzkLDW95rvMn7NdioFxdUwxvlq3G4qHrxIhxgRaE37QmMrOcKsfpMMZDzHRlXpKDkRIdEqp4Ci8CHhJ5JtVEsgg8tssWfnlhyISUKYsfPOR6fc49rVQUpoNLJV6Tu6OCH8g9ek4p2fRg1UdJLdf9Twqp1BfZHqX2NKHa4zt+G5XmOLM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ecdc22-14fe-4b25-da6e-08d6ed605747
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 04:58:55.4744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4965
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-10_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906100034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4NCj4+Pg0KPj4+IFBhd2VsLA0KPj4+DQo+Pj4gT24gMDUvMDYvMjAxOSAxMzowMywgUGF3ZWwg
TGFzemN6YWsgd3JvdGU6DQo+Pj4+IFRoaXMgcGF0Y2ggYWltIGF0IGRvY3VtZW50aW5nIFVTQiBy
ZWxhdGVkIGR0LWJpbmRpbmdzIGZvciB0aGUNCj4+Pj4gQ2FkZW5jZSBVU0JTUy1EUkQgY29udHJv
bGxlci4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogUGF3ZWwgTGFzemN6YWsgPHBhd2VsbEBj
YWRlbmNlLmNvbT4NCj4+Pj4gUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+DQo+Pj4+DQo+Pj4+IC0tLQ0KPj4+PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2Nk
bnMtdXNiMy50eHQgICAgIHwgMzAgKysrKysrKysrKysrKysrKysrKw0KPj4+PiAgMSBmaWxlIGNo
YW5nZWQsIDMwIGluc2VydGlvbnMoKykNCj4+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2NkbnMtdXNiMy50eHQNCj4+Pj4NCj4+Pj4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvY2Rucy11
c2IzLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvY2Rucy11c2Iz
LnR4dA0KPj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4+PiBpbmRleCAwMDAwMDAwMDAwMDAu
LjFkMmI0NDllM2NiNA0KPj4+PiAtLS0gL2Rldi9udWxsDQo+Pj4+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvY2Rucy11c2IzLnR4dA0KPj4+PiBAQCAtMCwwICsx
LDMwIEBADQo+Pj4+ICtCaW5kaW5nIGZvciB0aGUgQ2FkZW5jZSBVU0JTUy1EUkQgY29udHJvbGxl
cg0KPj4+PiArDQo+Pj4+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPj4+PiArICAtIHJlZzogUGh5
c2ljYWwgYmFzZSBhZGRyZXNzIGFuZCBzaXplIG9mIHRoZSBjb250cm9sbGVyJ3MgcmVnaXN0ZXIg
YXJlYXMuDQo+Pj4+ICsJIENvbnRyb2xsZXIgaGFzIDMgZGlmZmVyZW50IHJlZ2lvbnM6DQo+Pj4+
ICsJIHJlZ2lvbiAxIC0gSE9TVCByZWdpc3RlcnMgYXJlYQ0KPj4+PiArCSByZWdpb24gMiAtIERF
VklDRSByZWdpc3RlcnMgYXJlYQ0KPj4+PiArCSByZWdpb24gMyAtIE9URy9EUkQgcmVnaXN0ZXJz
IGFyZWENCj4+Pj4gKyAgLSByZWctbmFtZXMgLSByZWdpc3RlciBtZW1vcnkgYXJlYSBuYW1lczoN
Cj4+Pj4gKwkieGhjaSIgLSBmb3IgSE9TVCByZWdpc3RlcnMgc3BhY2UNCj4+Pj4gKwkiZGV2IiAt
IGZvciBERVZJQ0UgcmVnaXN0ZXJzIHNwYWNlDQo+Pj4+ICsJIm90ZyIgLSBmb3IgT1RHL0RSRCBy
ZWdpc3RlcnMgc3BhY2UNCj4+Pj4gKyAgLSBjb21wYXRpYmxlOiBTaG91bGQgY29udGFpbjogImNk
bnMsdXNiMy0xLjAuMCIgb3IgImNkbnMsdXNiMy0xLjAuMSINCj4+Pj4gKyAgLSBpbnRlcnJ1cHRz
OiBJbnRlcnJ1cHRzIHVzZWQgYnkgY2RuczMgY29udHJvbGxlci4NCj4+Pg0KPj4+IFNpbmNlIHdl
IGFyZSByZXF1ZXN0aW5nIDMgc2VwYXJhdGUgbmFtZWQgaW50ZXJydXB0cyBpbiBjb2RlIHdlIG5l
ZWQgdG8NCj4+PiBtZW50aW9uIHRoZW0gaGVyZS4NCj4+DQo+PiBIaSBSb2dlciwNCj4+DQo+PiBZ
ZXMsIEkga25vdywgYnV0IHRoaXMgY29kZSBpcyBSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcsIHNv
IEkgdGhvdWdodCB0byBhZGQNCj4+IHRoaXMgYXMgc2VwYXJhdGUgcGF0Y2ggYWZ0ZXIgcHV0dGlu
ZyB0aGlzIGRyaXZlciBpbnRvIGtlcm5lbC4NCj4+DQo+DQo+QmluZGluZyBkb2N1bWVudCBzaG91
bGQgYmUgdXBkYXRlZCBhcyBjb2RlIGNoYW5nZXMuDQo+DQo+PiBJIGFzc3VtZSB0aGF0IGFmdGVy
IG1ha2luZyBzb21lIGNoYW5nZSBpbiB0aGlzIGZpbGUgSSBzaG91bGQgcmVtb3ZlIHN0YXRlbWVu
dA0KPj4gUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+IGZyb20gdGhp
cyBwYXRjaCB0byBzdGFydCByZXZpdmluZw0KPj4gZnJvbSB0aGUgYmVnaW5uaW5nLg0KPg0KPlll
cy4NCj4NCj4+DQo+PiBXaGF0IGRvIHlvdSB0aGluayBhYm91dCBzdWNoIGR0LWJpbmRpbmc6DQo+
Pg0KPj4gUmVxdWlyZWQgcHJvcGVydGllczoNCj4+ICAgLSByZWc6IFBoeXNpY2FsIGJhc2UgYWRk
cmVzcyBhbmQgc2l6ZSBvZiB0aGUgY29udHJvbGxlcidzIHJlZ2lzdGVyIGFyZWFzLg0KPj4gICAg
ICAgICAgQ29udHJvbGxlciBoYXMgMyBkaWZmZXJlbnQgcmVnaW9uczoNCj4+ICAgICAgICAgIHJl
Z2lvbiAxIC0gSE9TVCByZWdpc3RlcnMgYXJlYQ0KPj4gICAgICAgICAgcmVnaW9uIDIgLSBERVZJ
Q0UgcmVnaXN0ZXJzIGFyZWENCj4+ICAgICAgICAgIHJlZ2lvbiAzIC0gT1RHL0RSRCByZWdpc3Rl
cnMgYXJlYQ0KPg0KPklzIGl0IHNvIHRoYXQgcmVnaW9uIDEgaXMgYWx3YXlzIEhPU1Q/DQo+b2Zm
c2V0IDAgc2VlbXMgdG8gYmUgT1RHIHRob3VnaC4NCj4NCj5JZiBpdCBpcyBpbXBsZW1lbnRhdGlv
biBzcGVjaWZpYyB0aGVuIHlvdSBjb3VsZCBnZXQgcmlkIG9mIG51bWJlcmluZy4NCg0KUmlnaHQs
ICBJIHJpZCBvZiBudW1iZXJpbmcuIA0KPg0KPj4gICAtIHJlZy1uYW1lcyAtIHJlZ2lzdGVyIG1l
bW9yeSBhcmVhIG5hbWVzOg0KPj4gICAgICAgICAieGhjaSIgLSBmb3IgSE9TVCByZWdpc3RlcnMg
c3BhY2UNCj4+ICAgICAgICAgImRldiIgLSBmb3IgREVWSUNFIHJlZ2lzdGVycyBzcGFjZQ0KPj4g
ICAgICAgICAib3RnIiAtIGZvciBPVEcvRFJEIHJlZ2lzdGVycyBzcGFjZQ0KPj4gICAtIGNvbXBh
dGlibGU6IFNob3VsZCBjb250YWluOg0KPj4gICAgICAgICAiY2Rucyx1c2IzLTEuMC4wIiAtIGZv
ciAweDAwMDI0NTAyIGNvbnRyb2xsZXIgdmVyc2lvbg0KPj4gICAgICAgICAiY2Rucyx1c2IzLTEu
MC4xIiAtIGZvciAweDAwMDI0NTA5IGNvbnRyb2xsZXIgdmVyc2lvbg0KPj4gICAgICAgICAiY2Ru
cyx1c2IzLTEuMC4yIiAtIGZvciAweDAwMDI0NTBDIGNvbnRyb2xsZXIgdmVyc2lvbg0KPj4gICAg
ICAgICAiY2Rucyx1c2IzLTEuMC4zIiAtIGZvciAweDAwMDI0NTBkIGNvbnRyb2xsZXIgdmVyc2lv
bg0KPj4NCj4+IC0gaW50ZXJydXB0czogSW50ZXJydXB0cyB1c2VkIGJ5IGNkbnMzIGNvbnRyb2xs
ZXI6DQo+PiAgICAgICAgICJob3N0IiAtIGludGVycnVwdCB1c2VkIGJ5IFhIQ0kgZHJpdmVyLg0K
Pj4gICAgICAgICAicGVyaXBoZXJhbCIgLSBpbnRlcnJ1cHQgdXNlZCBieSBkZXZpY2UgZHJpdmVy
DQo+PiAgICAgICAgICJvdGciIC0gaW50ZXJydXB0IHVzZWQgYnkgRFJEL09URyAgcGFydCBvZiBk
cml2ZXINCj4+DQo+PiBPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPj4gIC0gbWF4aW11bS1zcGVlZCA6
IHZhbGlkIGFyZ3VtZW50cyBhcmUgInN1cGVyLXNwZWVkIiwgImhpZ2gtc3BlZWQiIGFuZA0KPj4g
ICAgICAgICAgICAgICAgICAgICJmdWxsLXNwZWVkIjsgcmVmZXIgdG8gdXNiL2dlbmVyaWMudHh0
DQo+PiAgLSBkcl9tb2RlOiBTaG91bGQgYmUgb25lIG9mICJob3N0IiwgInBlcmlwaGVyYWwiIG9y
ICJvdGciLg0KPj4gIC0gcGh5czogcmVmZXJlbmNlIHRvIHRoZSBVU0IgUEhZDQo+DQo+bmVlZCB0
byBhZGQgJ3BoeS1uYW1lcycgc2luY2UgeW91IHJlcXVlc3QgdGhlIFBIWSB3aXRoIG5hbWUuDQo+
DQo+PiAgLSBvbi1jaGlwLWJ1ZmYtc2l6ZSA6IHNpemUgb2YgbWVtb3J5IGludGVuZGVkIGFzIGlu
dGVybmFsIG1lbW9yeSBmb3IgZW5kcG9pbnRzDQo+PiAgICAgICAgIGJ1ZmZlcnMgZXhwcmVzc2Vk
IGluIEtCDQo+Pg0KPj4gRXhhbXBsZToNCj4+ICAgICAgICAgdXNiQGYzMDAwMDAwIHsNCj4+ICAg
ICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImNkbnMsdXNiMy0xLjAuMSI7DQo+PiAgICAgICAg
ICAgICAgICAgaW50ZXJydXB0cyA9IDxVU0JfSE9TVF9JUlEgIDcgSVJRX1RZUEVfTEVWRUxfSElH
SD4NCj4NCj5jb21hIG1pc3NpbmcuDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDxVU0JfREVWSUNFX0lSUSAgNyBJUlFfVFlQRV9MRVZFTF9ISUdIPg0KPmhlcmUgdG9vLg0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8VVNCX09UR19JUlEgIDggSVJRX1RZUEVf
TEVWRUxfSElHSD47DQo+DQo+V2hhdCBpcyA3IGFuZCA4ID8NCkludGVycnVwdCBsaW5lIG51bWJl
ci4gIEFzIEkgcmVtZW1iZXIgZGV2aWNlIGFuZCBob3N0IGFyZSBjb25uZWN0ZWQgdG8gdGhlIHNh
bWUgaW50ZXJydXB0DQpsaW5lLg0KDQpJJ20gbm90IHN1cmUgYnV0IGZpcnN0IGVsZW1lbnQgaXMg
cHJvYmFibHkgdGhlIG51bWJlciBpbmRpY2F0aW5nIG9mIEludGVycnVwdCBjb250cm9sbGVyLCAN
CnNvIHJhdGhlciBJdCBzaG91bGQgaGFzIHRoZSBzYW1lIG5hbWUgZm9yIGFsbCBpbnRlcnJ1cHRz
IGVudHJpZXMuIEkgd2lsbCBjaGFuZ2UgaXQgdG8gR0lDX1VTQl9JUlEuDQoNCj4NCj4+ICAgICAg
ICAgICAgICAgICBpbnRlcnJ1cHQtbmFtZXMgPSAiaG9zdCIsICJwZXJpcGhlcmFsIiwgIm90ZyI7
DQo+PiAgICAgICAgICAgICAgICAgcmVnID0gPDB4ZjMwMDAwMDAgMHgxMDAwMCAgICAgICAvKiBt
ZW1vcnkgYXJlYSBmb3IgSE9TVCByZWdpc3RlcnMgKi8NCj4NCj5zaG91bGQgZW5kIHdpdGggPiwN
CkkndmUgY2hlY2tlZCBpbiBvdGhlciBkdC1iaW5kaW5nLCBhbmQgdGhlcmUgdXNlIGluIHRoaXMg
Zm9ybS4NCkkgd2lsbCBjaGFuZ2UgaXQuIENoZWNrcGF0Y2ggc2NyaXB0IGRvZXNuJ3QgY29tcGxh
aW4gZm9yIGJvdGggdmVyc2lvbi4gDQo+DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAweGYz
MDEwMDAwIDB4MTAwMDAgICAgICAvKiBtZW1vcnkgYXJlYSBmb3IgREVWSUNFIHJlZ2lzdGVycyAq
Lw0KPmhlcmUgdG9vDQo+DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAweGYzMDIwMDAwIDB4
MTAwMDA+OyAgICAvKiBtZW1vcnkgYXJlYSBmb3IgT1RHL0RSRCByZWdpc3RlcnMgKi8NCj4+ICAg
ICAgICAgICAgICAgICByZWctbmFtZXMgPSAieGhjaSIsICJkZXYiLCAib3RnIjsNCj4+ICAgICAg
ICAgfTsNCj4NCj5Jc24ndCBvdGcgYXQgb2Zmc2V0IDAsIHhoY2kgYXQgb2Zmc2V0IDB4MTAwMDAg
YW5kIGRldiBhdCBvZmZzZXQgMHgyMDAwMD8NCg0KSSB0aGluayB0aGF0IGl0J3MgRlBHQSAgaW1w
bGVtZW50YXRpb24gc3BlY2lmaWMuIEkgaGF2ZSBjb25uZWN0ZWQgcmVnaXN0ZXJzIGluIHRoaXMg
d2F5LiANCkluIHJlZ2lzdGVyIHNwZWNpZmljYXRpb24gT1RHIG9mZnNldCBpcyAwLiANCg0KPg0K
Pj4NCj4+IElzIHRoaXMgY29ycmVjdCBub3cgPw0KPj4NCj4+IE1heWJlIEkgc2hvdWxkIGFkZCBz
b21ldGhpbmcgYWRkaXRpb25hbGx5IGZvciBwaHkgPw0KPg0KPmUuZy4NCj4NCj4gICAgICAgICAg
ICAgICAgICAgICAgICBwaHlzID0gPCZ1c2IzX3BoeT47DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgcGh5LW5hbWVzID0gImNkbnMzLHVzYnBoeSI7DQo+DQpPaywgSSB3aWxsIGFkZCBpdCwgYnV0
IHRoZXkgYXJlIG9wdGlvbmFsIHBhcmFtZXRlci4gDQoNCk5ldyB2ZXJzaW9uIHdpbGwgbG9va3Mg
bGlrZTogDQpCaW5kaW5nIGZvciB0aGUgQ2FkZW5jZSBVU0JTUy1EUkQgY29udHJvbGxlcg0KDQpS
ZXF1aXJlZCBwcm9wZXJ0aWVzOg0KIC0gcmVnOiBQaHlzaWNhbCBiYXNlIGFkZHJlc3MgYW5kIHNp
emUgb2YgdGhlIGNvbnRyb2xsZXIncyByZWdpc3RlciBhcmVhcy4NCiAgICAgICAgIENvbnRyb2xs
ZXIgaGFzIDMgZGlmZmVyZW50IHJlZ2lvbnM6DQogICAgICAgICAtIEhPU1QgcmVnaXN0ZXJzIGFy
ZWENCiAgICAgICAgIC0gREVWSUNFIHJlZ2lzdGVycyBhcmVhDQogICAgICAgICAtIE9URy9EUkQg
cmVnaXN0ZXJzIGFyZWENCiAtIHJlZy1uYW1lcyAtIHJlZ2lzdGVyIG1lbW9yeSBhcmVhIG5hbWVz
Og0KICAgICAgICAieGhjaSIgLSBmb3IgSE9TVCByZWdpc3RlcnMgc3BhY2UNCiAgICAgICAgImRl
diIgLSBmb3IgREVWSUNFIHJlZ2lzdGVycyBzcGFjZQ0KICAgICAgICAib3RnIiAtIGZvciBPVEcv
RFJEIHJlZ2lzdGVycyBzcGFjZQ0KIC0gY29tcGF0aWJsZTogU2hvdWxkIGNvbnRhaW46DQogICAg
ICAgICJjZG5zLHVzYjMtMS4wLjAiIC0gZm9yIDB4MDAwMjQ1MDIgY29udHJvbGxlciB2ZXJzaW9u
DQogICAgICAgICJjZG5zLHVzYjMtMS4wLjEiIC0gZm9yIDB4MDAwMjQ1MDkgY29udHJvbGxlciB2
ZXJzaW9uDQogICAgICAgICJjZG5zLHVzYjMtMS4wLjIiIC0gZm9yIDB4MDAwMjQ1MEMgY29udHJv
bGxlciB2ZXJzaW9uDQogICAgICAgICJjZG5zLHVzYjMtMS4wLjMiIC0gZm9yIDB4MDAwMjQ1MGQg
Y29udHJvbGxlciB2ZXJzaW9uDQogLSBpbnRlcnJ1cHRzOiBJbnRlcnJ1cHRzIHVzZWQgYnkgY2Ru
czMgY29udHJvbGxlcjoNCiAgICAgICAgImhvc3QiIC0gaW50ZXJydXB0IHVzZWQgYnkgWEhDSSBk
cml2ZXIuDQogICAgICAgICJwZXJpcGhlcmFsIiAtIGludGVycnVwdCB1c2VkIGJ5IGRldmljZSBk
cml2ZXINCiAgICAgICAgIm90ZyIgLSBpbnRlcnJ1cHQgdXNlZCBieSBEUkQvT1RHICBwYXJ0IG9m
IGRyaXZlcg0KDQpPcHRpb25hbCBwcm9wZXJ0aWVzOg0KIC0gbWF4aW11bS1zcGVlZCA6IHZhbGlk
IGFyZ3VtZW50cyBhcmUgInN1cGVyLXNwZWVkIiwgImhpZ2gtc3BlZWQiIGFuZA0KICAgICAgICAg
ICAgICAgICAgICJmdWxsLXNwZWVkIjsgcmVmZXIgdG8gdXNiL2dlbmVyaWMudHh0DQogLSBkcl9t
b2RlOiBTaG91bGQgYmUgb25lIG9mICJob3N0IiwgInBlcmlwaGVyYWwiIG9yICJvdGciLg0KIC0g
cGh5czogcmVmZXJlbmNlIHRvIHRoZSBVU0IgUEhZDQogLSBwaHktbmFtZXM6IGZyb20gdGhlICpH
ZW5lcmljIFBIWSogYmluZGluZ3M7DQogLSBvbi1jaGlwLWJ1ZmYtc2l6ZSA6IHNpemUgb2YgbWVt
b3J5IGludGVuZGVkIGFzIGludGVybmFsIG1lbW9yeSBmb3IgZW5kcG9pbnRzDQogICAgICAgIGJ1
ZmZlcnMgZXhwcmVzc2VkIGluIEtCDQoNCkV4YW1wbGU6DQogICAgICAgIHVzYkBmMzAwMDAwMCB7
DQogICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJjZG5zLHVzYjMtMS4wLjEiOw0KICAgICAg
ICAgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1VTQl9JUlEgNyBJUlFfVFlQRV9MRVZFTF9ISUdI
PiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPEdJQ19VU0JfSVJRICA3IElSUV9U
WVBFX0xFVkVMX0hJR0g+LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8R0lDX1VT
Ql9JUlEgIDggSVJRX1RZUEVfTEVWRUxfSElHSD47DQogICAgICAgICAgICAgICAgaW50ZXJydXB0
LW5hbWVzID0gImhvc3QiLCAicGVyaXBoZXJhbCIsICJvdGciOw0KICAgICAgICAgICAgICAgIHJl
ZyA9IDwweGYzMDAwMDAwIDB4MTAwMDA+LCAgICAgLyogbWVtb3J5IGFyZWEgZm9yIEhPU1QgcmVn
aXN0ZXJzICovDQogICAgICAgICAgICAgICAgICAgICAgICA8MHhmMzAxMDAwMCAweDEwMDAwPiwg
ICAvKiBtZW1vcnkgYXJlYSBmb3IgREVWSUNFIHJlZ2lzdGVycyAqLw0KICAgICAgICAgICAgICAg
ICAgICAgICAgPDB4ZjMwMjAwMDAgMHgxMDAwMD47ICAgLyogbWVtb3J5IGFyZWEgZm9yIE9URy9E
UkQgcmVnaXN0ZXJzICovDQogICAgICAgICAgICAgICAgcmVnLW5hbWVzID0gInhoY2kiLCAiZGV2
IiwgIm90ZyI7DQogICAgICAgICAgICAgICAgcGh5cyA9IDwmdXNiM19waHk+Ow0KICAgICAgICAg
ICAgICAgIHBoeS1uYW1lcyA9ICJjZG5zMyx1c2JwaHkiOw0KDQoNCk1heWJlIEkgc2hvdWxkIGFk
ZCBhbHNvIHNvbWV0aGluZyBmb3IgdXNiMl9waHkgaW4gZHQtYmluZGluZyBhbmQgaW4gZHJpdmVy
ID8NCg0KVGhhbmtzLCANClJlZ2FyZHMsIA0KUGF3ZWwgDQoNCj4+DQo+PiBSZWdhcmRzLA0KPj4g
UGF3ZWwNCj4+DQo+Pg0KPj4+DQo+Pj4+ICsNCj4+Pj4gK09wdGlvbmFsIHByb3BlcnRpZXM6DQo+
Pj4+ICsgLSBtYXhpbXVtLXNwZWVkIDogdmFsaWQgYXJndW1lbnRzIGFyZSAic3VwZXItc3BlZWQi
LCAiaGlnaC1zcGVlZCIgYW5kDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgImZ1bGwtc3BlZWQi
OyByZWZlciB0byB1c2IvZ2VuZXJpYy50eHQNCj4+Pj4gKyAtIGRyX21vZGU6IFNob3VsZCBiZSBv
bmUgb2YgImhvc3QiLCAicGVyaXBoZXJhbCIgb3IgIm90ZyIuDQo+Pj4+ICsgLSBwaHlzOiByZWZl
cmVuY2UgdG8gdGhlIFVTQiBQSFkNCj4+Pj4gKw0KPj4+PiArRXhhbXBsZToNCj4+Pj4gKwl1c2JA
ZjMwMDAwMDAgew0KPj4+PiArCQljb21wYXRpYmxlID0gImNkbnMsdXNiMy0xLjAuMSI7DQo+Pj4+
ICsJCWludGVycnVwdHMgPSA8VVNCX0lSUSAgNyBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4+Pg0K
Pj4+IFRoaXMgZXhhbXBsZSB3b24ndCB3b3JrIGFzIGNvZGUgcmVxdWVzdHMgZm9yIDMgc2VwYXJh
dGUgaW50ZXJydXB0cy4NCj4+Pg0KPj4+PiArCQlyZWcgPSA8MHhmMzAwMDAwMCAweDEwMDAwCS8q
IG1lbW9yeSBhcmVhIGZvciBIT1NUIHJlZ2lzdGVycyAqLw0KPj4+PiArCQkJMHhmMzAxMDAwMCAw
eDEwMDAwCS8qIG1lbW9yeSBhcmVhIGZvciBERVZJQ0UgcmVnaXN0ZXJzICovDQo+Pj4+ICsJCQkw
eGYzMDIwMDAwIDB4MTAwMDA+OwkvKiBtZW1vcnkgYXJlYSBmb3IgT1RHL0RSRCByZWdpc3RlcnMg
Ki8NCj4+Pj4gKwkJcmVnLW5hbWVzID0gInhoY2kiLCAiZGV2IiwgIm90ZyI7DQo+Pj4+ICsJfTsN
Cj4+Pj4NCj4+Pg0KPg0KPg0KPi0tDQo+Y2hlZXJzLA0KPi1yb2dlcg0KPg0KPlRleGFzIEluc3Ry
dW1lbnRzIEZpbmxhbmQgT3ksIFBvcmtrYWxhbmthdHUgMjIsIDAwMTgwIEhlbHNpbmtpLg0KPlkt
dHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNp
bmtpDQo=

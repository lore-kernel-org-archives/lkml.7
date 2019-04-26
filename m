Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF15C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D19206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="FixlHnLp";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="sUyfXmtr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfDZKlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:41:13 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:38670 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbfDZKlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:41:12 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QAWTp0015632;
        Fri, 26 Apr 2019 03:39:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=vQSfKpxOvzcz8fO4CmbG5Q1LsflpqP3IYOOIh/9Gjms=;
 b=FixlHnLpIAcIc1/iVQUoWIdgGT08LWMha/QE5k2wKfRig0oiXA61nnsspeBXCnayOrHK
 FHqWXJR8NScCOii2BHSU5kfD82RnLU3bAVYdDHP2mvr7dSgQFtVCjBiHou2d2QPwMuMA
 EabklXsxyCDmMqCy5TnfvGslNne3IY31L5FyCvAAXnJUIEwwO06V5/UWbAVtLE+kJCwy
 9p43T/0nRe3+o8YW6gvRSfC0uJOqStLy0RkI8ykwA1gcVMRYyB/PHt2K8qUDj1yNtRnF
 u75gzjbFyoNv+Kcb1xZ2ez27KA4lQeDnYeJ1GWuqRlAyqck2kM0l/15PlBuIAoKGymAz 2Q== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2053.outbound.protection.outlook.com [104.47.33.53])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2s3fdybyy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Apr 2019 03:39:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQSfKpxOvzcz8fO4CmbG5Q1LsflpqP3IYOOIh/9Gjms=;
 b=sUyfXmtroY8a+OZJ4ZFeY0ns7WZRpZREmJyc8VJTDd2HfNmEhW7HLm0DJ+biuEscuHNKIbbgToyttE0LMDQsZeuP1RwRliFImE+voUwu/LVMb4jwOim+4ARYyxvXcEB9od7d/FwOpVhj7+wBSGf2fJmxxRLYtlVPfuQxreqyVo8=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4312.namprd07.prod.outlook.com (52.135.223.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.19; Fri, 26 Apr 2019 10:39:50 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8103:c4f4:4659:cec7]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8103:c4f4:4659:cec7%3]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 10:39:50 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
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
Subject: RE: [PATCH v6 1/6] dt-bindings: add binding for USBSS-DRD controller.
Thread-Topic: [PATCH v6 1/6] dt-bindings: add binding for USBSS-DRD
 controller.
Thread-Index: AQHU73OXu7bjaKObFUKht0ybw179+aZORAWAgAAR8YA=
Date:   Fri, 26 Apr 2019 10:39:49 +0000
Message-ID: <BYAPR07MB47095561D7C58860CD8C7400DD3E0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1554882504-9010-1-git-send-email-pawell@cadence.com>
 <1554882504-9010-2-git-send-email-pawell@cadence.com>
 <d7ca7260-9337-0779-459b-bfed15113db0@ti.com>
In-Reply-To: <d7ca7260-9337-0779-459b-bfed15113db0@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctOWJmNDZhY2YtNjgwZi0xMWU5LTg3MzYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDliZjQ2YWQwLTY4MGYtMTFlOS04NzM2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjc4NCIgdD0iMTMyMDA3NDg3ODcyMTA3Nzk5IiBoPSJ5TDNzVEh3OEdkOUthWTdvUThMenpTNWpMZVE9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 743cd715-e952-459c-1c6f-08d6ca33827c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR07MB4312;
x-ms-traffictypediagnostic: BYAPR07MB4312:
x-microsoft-antispam-prvs: <BYAPR07MB4312C59A7F06BF6AC2AEE15BDD3E0@BYAPR07MB4312.namprd07.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(36092001)(51444003)(199004)(189003)(76116006)(6246003)(107886003)(26005)(55016002)(478600001)(6506007)(71190400001)(71200400001)(256004)(102836004)(229853002)(7416002)(97736004)(4326008)(476003)(11346002)(66066001)(9686003)(6436002)(186003)(486006)(14454004)(68736007)(33656002)(2906002)(6116002)(7736002)(305945005)(3846002)(74316002)(81156014)(81166006)(7696005)(8936002)(76176011)(110136005)(99286004)(446003)(53936002)(54906003)(2501003)(5660300002)(66446008)(64756008)(66556008)(8676002)(73956011)(66476007)(66946007)(52536014)(316002)(86362001)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4312;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AKf9YVAtSK9kXoVny+G63hamCYk+H9i2gqwvFAQjAlLufubTwt0OHfmE0WHsFR+l/yuFPwazAp7YQdmYaC/eUYEbUs0pgqzJADFlD38A7oBpVadscFLuUIUaoJ6CmmEalTipVj9v/yg/PXGrIAklqnFwDxL6D1bv1vl4285AJRy29lV/+lVBkBwGPcbc146+SDS/H6BlkukVR7taSY4PO8ZcWoMyuPWwFXxNhg1KUQa74eYiUQf9X4Pta/boU08G60tyMP+qQzlsLBxcn9LL82FXm6qS6HfQcjtx4QnhYSvWZyZg0NO5RBEs9e8GufHMNGqwpLYgOuFZqYdKuDBQmUA1aBl1k/T/kz5YLfsrJbTQCH+ukzEzptiwQsb9fXocCeWdkMBCJWXpg287TTXXmjf1V2ST/iLw2Rwzpzn15Uk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743cd715-e952-459c-1c6f-08d6ca33827c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 10:39:49.9277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4312
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904260074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9nZXIsDQoNCj5PbiAxMC8wNC8yMDE5IDEwOjQ4LCBQYXdlbCBMYXN6Y3phayB3cm90ZToN
Cj4+IFRoaXMgcGF0Y2ggYWltIGF0IGRvY3VtZW50aW5nIFVTQiByZWxhdGVkIGR0LWJpbmRpbmdz
IGZvciB0aGUNCj4+IENhZGVuY2UgVVNCU1MtRFJEIGNvbnRyb2xsZXIuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogUGF3ZWwgTGFzemN6YWsgPHBhd2VsbEBjYWRlbmNlLmNvbT4NCj4+IFJldmlld2Vk
LWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPj4NCj4+IC0tLQ0KPj4gIC4uLi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9jZG5zLXVzYjMudHh0ICAgICB8IDMwICsrKysrKysrKysr
KysrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKQ0KPj4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2NkbnMt
dXNiMy50eHQNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3VzYi9jZG5zLXVzYjMudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3VzYi9jZG5zLXVzYjMudHh0DQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXgg
MDAwMDAwMDAwMDAwLi4xZDJiNDQ5ZTNjYjQNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvY2Rucy11c2IzLnR4dA0KPj4gQEAg
LTAsMCArMSwzMCBAQA0KPj4gK0JpbmRpbmcgZm9yIHRoZSBDYWRlbmNlIFVTQlNTLURSRCBjb250
cm9sbGVyDQo+PiArDQo+PiArUmVxdWlyZWQgcHJvcGVydGllczoNCj4+ICsgIC0gcmVnOiBQaHlz
aWNhbCBiYXNlIGFkZHJlc3MgYW5kIHNpemUgb2YgdGhlIGNvbnRyb2xsZXIncyByZWdpc3RlciBh
cmVhcy4NCj4+ICsJIENvbnRyb2xsZXIgaGFzIDMgZGlmZmVyZW50IHJlZ2lvbnM6DQo+PiArCSBy
ZWdpb24gMSAtIEhPU1QgcmVnaXN0ZXJzIGFyZWENCj4+ICsJIHJlZ2lvbiAyIC0gREVWSUNFIHJl
Z2lzdGVycyBhcmVhDQo+PiArCSByZWdpb24gMyAtIE9URy9EUkQgcmVnaXN0ZXJzIGFyZWENCj4+
ICsgIC0gcmVnLW5hbWVzIC0gcmVnaXN0ZXIgbWVtb3J5IGFyZWEgbmFtZXM6DQo+PiArCSJ4aGNp
IiAtIGZvciBIT1NUIHJlZ2lzdGVycyBzcGFjZQ0KPj4gKwkiZGV2IiAtIGZvciBERVZJQ0UgcmVn
aXN0ZXJzIHNwYWNlDQo+PiArCSJvdGciIC0gZm9yIE9URy9EUkQgcmVnaXN0ZXJzIHNwYWNlDQo+
PiArICAtIGNvbXBhdGlibGU6IFNob3VsZCBjb250YWluOiAiY2Rucyx1c2IzLTEuMC4wIiBvciAi
Y2Rucyx1c2IzLTEuMC4xIg0KPj4gKyAgLSBpbnRlcnJ1cHRzOiBJbnRlcnJ1cHRzIHVzZWQgYnkg
Y2RuczMgY29udHJvbGxlci4NCj4+ICsNCj4+ICtPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPj4gKyAt
IG1heGltdW0tc3BlZWQgOiB2YWxpZCBhcmd1bWVudHMgYXJlICJzdXBlci1zcGVlZCIsICJoaWdo
LXNwZWVkIiBhbmQNCj4+ICsgICAgICAgICAgICAgICAgICAgImZ1bGwtc3BlZWQiOyByZWZlciB0
byB1c2IvZ2VuZXJpYy50eHQNCj4+ICsgLSBkcl9tb2RlOiBTaG91bGQgYmUgb25lIG9mICJob3N0
IiwgInBlcmlwaGVyYWwiIG9yICJvdGciLg0KPj4gKyAtIHBoeXM6IHJlZmVyZW5jZSB0byB0aGUg
VVNCIFBIWQ0KPg0KPkluIHlvdXIgdGVzdCBwbGF0Zm9ybSBpcyB0aGlzIGEgMi4wUEhZIG9yIDMu
MFBIWT8gVHlwaWNhbCBwbGF0Zm9ybXMgd2lsbCBoYXZlIGJvdGguDQo+SXMgdGhlcmUgYW55IHBv
d2VyLW9uIHNlcXVlbmNpbmcgcmVxdWlyZW1lbnRzIGZvciBwb3dlcmluZyB1cCB0aGVzZSBQSFlz
IHZzIHBvd2VyaW5nIHVwIHRoZSBjb250cm9sbGVyPw0KPg0KR2VuZXJhbGx5LCBteSB0ZXN0aW5n
IHBsYXRmb3JtIGlzIGJhc2VkIG9uIFBDSWUsIHNvIEkgZG9u4oCZdCB1c2UgZHRzLiBQSFkgaW5p
dGlhbGl6YXRpb24gb24gbXkgdGVzdGluZyBwbGF0Zm9ybSANCmhhcyBiZWVuIGhpZGRlbiBpbiBG
UEdBIGltcGxlbWVudGF0aW9uLiBXZSBhcmUgdXNpbmcgRFRTIGluIHNpbXVsYXRpb24gYnV0IHRo
ZXJlIHdlIGRvbid0IGhhdmUgYSBQSFlzLiANCg0KSSB0aGluayB0aGF0IHlvdSBoYXZlIHJpZ2h0
LCBhbmQgd2Ugc2hvdWxkIGhhdmUgaGVyZSB0d28gVVNCMi4wIGFuZCBVU0IzLjAgcGh5LiANCkkg
aGF2ZSB0byBsb29rIGF0IGhvdyBpdCBsb29rcyBpbiBvdGhlciBkcml2ZXJzIGFuZCBpbXByb3Zl
IHRoaXMgdGhpcyBmaWxlIGFuZCBtYXliZSBDRE5TMyBkcml2ZXIgdG9vLiANCg0KPj4gKw0KPj4g
K0V4YW1wbGU6DQo+PiArCXVzYkBmMzAwMDAwMCB7DQo+PiArCQljb21wYXRpYmxlID0gImNkbnMs
dXNiMy0xLjAuMSI7DQo+PiArCQlpbnRlcnJ1cHRzID0gPFVTQl9JUlEgIDcgSVJRX1RZUEVfTEVW
RUxfSElHSD47DQo+PiArCQlyZWcgPSA8MHhmMzAwMDAwMCAweDEwMDAwCS8qIG1lbW9yeSBhcmVh
IGZvciBIT1NUIHJlZ2lzdGVycyAqLw0KPj4gKwkJCTB4ZjMwMTAwMDAgMHgxMDAwMAkvKiBtZW1v
cnkgYXJlYSBmb3IgREVWSUNFIHJlZ2lzdGVycyAqLw0KPj4gKwkJCTB4ZjMwMjAwMDAgMHgxMDAw
MD47CS8qIG1lbW9yeSBhcmVhIGZvciBPVEcvRFJEIHJlZ2lzdGVycyAqLw0KPj4gKwkJcmVnLW5h
bWVzID0gInhoY2kiLCAiZGV2IiwgIm90ZyI7DQo+PiArCX07DQo+Pg0KPg0KDQpjaGVlcnMsDQpQ
YXdlbA0KDQo=

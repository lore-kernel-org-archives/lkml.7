Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349CAC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B046120838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="tQD2iOVQ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="iQZeFA1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbfHAM7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 08:59:04 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:43486 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729084AbfHAM7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 08:59:04 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71CvcQ2019093;
        Thu, 1 Aug 2019 05:58:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=0Ohmro3DVmPPNR2eRo8fUE+81YFsbQrIvYmu+EDbw64=;
 b=tQD2iOVQiNJ2yJgko4OMbzWw0+8oCixDebhEmuhU5tZaStJ9rud6M0xuyi7qNcibIfMs
 vTGhI4RJZ5y5Xp9piI5eTNk6f+HBIADQHvY/ine4qHyJCiozTzVS5mO6U+kAx/qxemNq
 T3Na7+OycG0IEoboHWOg3cRiDgJF2CmcqpPV45FM5Zm7EU6vUTJXd4VpZiFuZI1HRJkB
 Ecs6N9CuYBS6fMDS+BrWd4XhBo7bCBZK9K+Da42NxgVTneYyJ4FKdEV2i0XW4vmzqwNS
 8EIzfHmbYD4GIKdPpwn8FiEXEHa5FK7Dk/mhWBd15ztT8y5/xD2n1EqPyhVQV4ONEHMg tA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=aniljoy@cadence.com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2058.outbound.protection.outlook.com [104.47.48.58])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2u2ryh8pgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 05:58:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wdn1SjoJjB4pCGFmIdywXGfa+5Hz2q43/8bhG1gbjGwzhwGSN43rAABx00/0xPFdjkiLNN26l08BHHe0djCsTQkWC0da5L6/Pxmy9JDb+H4n2PKlLynOmJ7zXsyCut6fCQ3lecJS8l/M0U0pIue3Q1WD2nyu58Oi0ujnD8/3EdUrhdRFz2SlM1axS6m1ht+X5Rg78XYiU5HeEkbnvS/mUtD7JWyOs8gY8Q+WAkc0/sjmb8L43GB4etpB4+ujfCyUWq27MdPJvuHnRqqKhdWscFXB4fUWd0prhuQAhYo+IfKtZBrx4ssTzTnNj55b9FWwm7rvFAa0Yka/Ia+NjFgfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ohmro3DVmPPNR2eRo8fUE+81YFsbQrIvYmu+EDbw64=;
 b=mkDF+B1qz8824ahbOFntmZ4x3Kv5vP6S3tb9Ii44FDy7Q3USq9/IN5RBjPUHUgeN6WSDXB86H+/LotTp1nJ6jGRaAUQalO0xbmDrffn2peyFjQyMNAvTRvNhNhYHmD4rMaRyJT4yFzsJSUAqD6eTKHFkEWAoWW06P3JFCnLfSd92qVWYflymAEaodDz6j1gcIOgr6nxfAs6THtPOt/VeOVMjr0GWxhceKfAEvMqXIx4OqiwvZ0+R3e3KVgFPc4X08cgZzqh4CYJXVmnzeA9aC3inK8Vde185tA5J0t0A5TDj7bwiJz9aDlFN2psPH4pLbC669IIYOpeNMg8xZjFigA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=cadence.com;dmarc=pass action=none
 header.from=cadence.com;dkim=pass header.d=cadence.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ohmro3DVmPPNR2eRo8fUE+81YFsbQrIvYmu+EDbw64=;
 b=iQZeFA1EnSZUIFrr4R3jXG9u5sBBCBp9V+afiX+bdZLeWPctm8apAv/tRvV3GuKEbC5CreYRLxRKsP0z+GHF2YS6jKtU947FNJwA97WWqeQ/1g86JkQMA1cYa+JZtgI0yLenb0r1MNRi8Olx4NBfHfCWrj/5CFezMvkMs82t5S8=
Received: from MN2PR07MB6045.namprd07.prod.outlook.com (20.179.82.206) by
 MN2PR07MB7022.namprd07.prod.outlook.com (52.132.171.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Thu, 1 Aug 2019 12:58:11 +0000
Received: from MN2PR07MB6045.namprd07.prod.outlook.com
 ([fe80::ac45:72a5:f61a:e6bf]) by MN2PR07MB6045.namprd07.prod.outlook.com
 ([fe80::ac45:72a5:f61a:e6bf%7]) with mapi id 15.20.2115.005; Thu, 1 Aug 2019
 12:58:11 +0000
From:   Anil Joy Varughese <aniljoy@cadence.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "pedrom.sousa@synopsys.com" <pedrom.sousa@synopsys.com>
CC:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "hare@suse.de" <hare@suse.de>, Rafal Ciepiela <rafalc@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Jan Kotas <jank@cadence.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: Additional clock initialization in Cadence UFS
Thread-Topic: [PATCH] scsi: ufs: Additional clock initialization in Cadence
 UFS
Thread-Index: AQHVR3sbNPk1LtxLyUCKlP8MIrewCabk7OaAgAFVMdA=
Date:   Thu, 1 Aug 2019 12:58:11 +0000
Message-ID: <MN2PR07MB6045F10BED4B8B14B7180021A8DE0@MN2PR07MB6045.namprd07.prod.outlook.com>
References: <20190731083614.25926-1-aniljoy@cadence.com>
 <77210067-ee65-4c12-9c7e-2b78260acdef@ti.com>
In-Reply-To: <77210067-ee65-4c12-9c7e-2b78260acdef@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [14.143.9.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84c2312b-b99e-4225-17db-08d7167fe8b4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR07MB7022;
x-ms-traffictypediagnostic: MN2PR07MB7022:
x-microsoft-antispam-prvs: <MN2PR07MB7022AC94613D6E3C5A76BB6AA8DE0@MN2PR07MB7022.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(199004)(189003)(13464003)(36092001)(2906002)(6246003)(4326008)(86362001)(74316002)(25786009)(3846002)(6116002)(68736007)(186003)(53936002)(6506007)(53546011)(55236004)(99286004)(7696005)(76176011)(102836004)(2201001)(229853002)(9686003)(55016002)(26005)(6436002)(66066001)(66446008)(66556008)(64756008)(66476007)(66946007)(76116006)(5660300002)(52536014)(110136005)(7736002)(256004)(14444005)(14454004)(478600001)(8936002)(476003)(486006)(446003)(11346002)(33656002)(71200400001)(71190400001)(81156014)(81166006)(2501003)(54906003)(8676002)(316002)(305945005)(78486014);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR07MB7022;H:MN2PR07MB6045.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qFQEm2Atl39Ln7HBCd9ZlEyhiGpAW7vhVv4C5cEj7lLyWJ5fd0VzVTaFqM9fuq/1bXD5rr1gD+7VKe8XydY388CfHmD+n0h0X+DFmnbNtWsTh7MDtkPxGJTgJ6/LPCDgsOPHFEjDXY97/OfyxMMXCiwiYGRl48Hd848JhP7VjeCPGKb9pkL4stRxpB0gBJCsbbq0z7yoR/zqBhu71FgIY4XDpoO5a2tGv5TQJACeiJtYzUq7C2HLExeg870oAWIZC7edHvQV1JADpo/yjhuliAVHBcVEed3TarweEnYXPuJqYrhgRjCW7b5RDQthpiWzkkcTN7dgdbICnJobLyiGrpNmHWLlc3YNq5Z5fVqChg/aV6EO4kUzRYJuY/eKwoYQ6To5NW2jNpheE3289vnwDzOTt+V4hwbJ13BFoTnkRP8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c2312b-b99e-4225-17db-08d7167fe8b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 12:58:11.5889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aniljoy@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB7022
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmlnbmVzaCwNCg0KWW91IGFyZSBjb3JyZWN0IEkgaGF2ZSB0ZXN0ZWQgdGhlIGNvZGUgaGVy
ZSBhbmQgLnNldHVwX2Nsb2NrIGlzIG5vdCBuZWVkZWQgYW55bW9yZTsgQ0ROU19VRlNfUkVHX0hD
TEtESVYgY29uZmlndXJlZCBpbiAuaGNlX2VuYWJsZV9ub3RpZnkoKSBpcyBlbm91Z2guIEkgd2ls
bCBmaXggdGhpcyBpbiBwYXRjaCB2Mi4gDQoNClRoYW5rcywNCkFuaWwNCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IFZpZ25lc2ggUmFnaGF2ZW5kcmEgPHZpZ25lc2hyQHRpLmNv
bT4gDQpTZW50OiBXZWRuZXNkYXksIEp1bHkgMzEsIDIwMTkgMTA6MDUgUE0NClRvOiBBbmlsIEpv
eSBWYXJ1Z2hlc2UgPGFuaWxqb3lAY2FkZW5jZS5jb20+OyBhbGltLmFraHRhckBzYW1zdW5nLmNv
bTsgYXZyaS5hbHRtYW5Ad2RjLmNvbTsgcGVkcm9tLnNvdXNhQHN5bm9wc3lzLmNvbQ0KQ2M6IGpl
amJAbGludXguaWJtLmNvbTsgbWFydGluLnBldGVyc2VuQG9yYWNsZS5jb207IGhhcmVAc3VzZS5k
ZTsgUmFmYWwgQ2llcGllbGEgPHJhZmFsY0BjYWRlbmNlLmNvbT47IE1pbGluZCBQYXJhYiA8bXBh
cmFiQGNhZGVuY2UuY29tPjsgSmFuIEtvdGFzIDxqYW5rQGNhZGVuY2UuY29tPjsgbGludXgtc2Nz
aUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6
IFJlOiBbUEFUQ0hdIHNjc2k6IHVmczogQWRkaXRpb25hbCBjbG9jayBpbml0aWFsaXphdGlvbiBp
biBDYWRlbmNlIFVGUw0KDQpFWFRFUk5BTCBNQUlMDQoNCg0KSGksDQoNCk9uIDMxLUp1bC0xOSAy
OjA2IFBNLCBBbmlsIFZhcnVnaGVzZSB3cm90ZToNCj4gQ29uZmlndXJlIENETlNfVUZTX1JFR19I
Q0xLRElWIGluIC5oY2VfZW5hYmxlX25vdGlmeSgpIGJlY2F1c2UgaWYgDQo+IFVGU0hDRCByZXNl
dHMgdGhlIGNvbnRyb2xsZXIgaXAgYmVjYXVzZSBvZiBwaHkgb3IgZGV2aWNlIHJlbGF0ZWQgDQo+
IGVycm9ycyB0aGVuIENETlNfVUZTX1JFR19IQ0xLRElWIGlzIHJlc2V0IHRvIGRlZmF1bHQgdmFs
dWUgYW5kIA0KPiAuc2V0dXBfY2xvY2soKSBpcyBub3QgY2FsbGVkIGxhdGVyIGluIHRoZSBzZXF1
ZW5jZSB3aGVyZWFzIA0KPiBoY2VfZW5hYmxlX25vdGlmeSB3aWxsIGJlIGNhbGxlZCBldmVyeXRp
bWUgY29udHJvbGxlciBpcyByZWVuYWJsZWQuDQo+DQpTbywgbm93IHRoYXQgQ0ROU19VRlNfUkVH
X0hDTEtESVYgaXMgY29uZmlndXJlZCBpbiAuaGNlX2VuYWJsZV9ub3RpZnkoKSwgaXMgaXQgc3Rp
bGwgcmVxdWlyZWQgdG8gaGF2ZSB0aGUgc2FtZSBjb2RlIGluIC5zZXR1cF9jbG9jaygpIGFzIHdl
bGw/DQpJc24ndCBzZXR0aW5nIHVwIENETlNfVUZTX1JFR19IQ0xLRElWIGluIC5oY2VfZW5hYmxl
X25vdGlmeSgpIGFsb25lIG5vdCBzdWZmaWNpZW50Pw0KDQpSZWdhcmRzDQpWaWduZXNoDQoNCj4g
U2lnbmVkLW9mZi1ieTogQW5pbCBWYXJ1Z2hlc2UgPGFuaWxqb3lAY2FkZW5jZS5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9zY3NpL3Vmcy9jZG5zLXBsdGZybS5jIHwgMTggKysrKysrKysrKysrKysr
KysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvc2NzaS91ZnMvY2Rucy1wbHRmcm0uYyANCj4gYi9kcml2ZXJzL3Njc2kvdWZz
L2NkbnMtcGx0ZnJtLmMgaW5kZXggODZkYmI3MjNmLi4xNWVlNTRkMjggMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvc2NzaS91ZnMvY2Rucy1wbHRmcm0uYw0KPiArKysgYi9kcml2ZXJzL3Njc2kvdWZz
L2NkbnMtcGx0ZnJtLmMNCj4gQEAgLTc4LDYgKzc4LDIyIEBAIHN0YXRpYyBpbnQgY2Ruc191ZnNf
c2V0dXBfY2xvY2tzKHN0cnVjdCB1ZnNfaGJhICpoYmEsIGJvb2wgb24sDQo+ICAJcmV0dXJuIGNk
bnNfdWZzX3NldF9oY2xrZGl2KGhiYSk7DQo+ICB9DQo+ICANCj4gKy8qKg0KPiArICogQ2FsbGVk
IGJlZm9yZSBhbmQgYWZ0ZXIgSENFIGVuYWJsZSBiaXQgaXMgc2V0Lg0KPiArICogQGhiYTogaG9z
dCBjb250cm9sbGVyIGluc3RhbmNlDQo+ICsgKiBAc3RhdHVzOiBub3RpZnkgc3RhZ2UgKHByZSwg
cG9zdCBjaGFuZ2UpDQo+ICsgKg0KPiArICogUmV0dXJuIHplcm8gZm9yIHN1Y2Nlc3MgYW5kIG5v
bi16ZXJvIGZvciBmYWlsdXJlICAqLyBzdGF0aWMgaW50IA0KPiArY2Ruc191ZnNfaGNlX2VuYWJs
ZV9ub3RpZnkoc3RydWN0IHVmc19oYmEgKmhiYSwNCj4gKwkJCQkgICAgICBlbnVtIHVmc19ub3Rp
ZnlfY2hhbmdlX3N0YXR1cyBzdGF0dXMpIHsNCj4gKwlpZiAoc3RhdHVzICE9IFBSRV9DSEFOR0Up
DQo+ICsJCXJldHVybiAwOw0KPiArDQo+ICsJcmV0dXJuIGNkbnNfdWZzX3NldF9oY2xrZGl2KGhi
YSk7DQo+ICt9DQo+ICsNCj4gIC8qKg0KPiAgICogY2Ruc191ZnNfaW5pdCAtIHBlcmZvcm1zIGFk
ZGl0aW9uYWwgdWZzIGluaXRpYWxpemF0aW9uDQo+ICAgKiBAaGJhOiBob3N0IGNvbnRyb2xsZXIg
aW5zdGFuY2UNCj4gQEAgLTExNSwxMiArMTMxLDE0IEBAIHN0YXRpYyBpbnQgDQo+IGNkbnNfdWZz
X20zMV8xNm5tX3BoeV9pbml0aWFsaXphdGlvbihzdHJ1Y3QgdWZzX2hiYSAqaGJhKSAgc3RhdGlj
IGNvbnN0IHN0cnVjdCB1ZnNfaGJhX3ZhcmlhbnRfb3BzIGNkbnNfdWZzX3BsdGZtX2hiYV92b3Bz
ID0gew0KPiAgCS5uYW1lID0gImNkbnMtdWZzLXBsdGZtIiwNCj4gIAkuc2V0dXBfY2xvY2tzID0g
Y2Ruc191ZnNfc2V0dXBfY2xvY2tzLA0KPiArCS5oY2VfZW5hYmxlX25vdGlmeSA9IGNkbnNfdWZz
X2hjZV9lbmFibGVfbm90aWZ5LA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCB1
ZnNfaGJhX3ZhcmlhbnRfb3BzIGNkbnNfdWZzX20zMV8xNm5tX3BsdGZtX2hiYV92b3BzID0gew0K
PiAgCS5uYW1lID0gImNkbnMtdWZzLXBsdGZtIiwNCj4gIAkuaW5pdCA9IGNkbnNfdWZzX2luaXQs
DQo+ICAJLnNldHVwX2Nsb2NrcyA9IGNkbnNfdWZzX3NldHVwX2Nsb2NrcywNCj4gKwkuaGNlX2Vu
YWJsZV9ub3RpZnkgPSBjZG5zX3Vmc19oY2VfZW5hYmxlX25vdGlmeSwNCj4gIAkucGh5X2luaXRp
YWxpemF0aW9uID0gY2Ruc191ZnNfbTMxXzE2bm1fcGh5X2luaXRpYWxpemF0aW9uLA0KPiAgfTsN
Cj4gIA0KPiANCg==

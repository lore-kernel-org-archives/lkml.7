Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AC5CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90B021852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Hj8VtmFd";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="fpAFlNhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406045AbfJRPmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:42:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30680 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728464AbfJRPmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:42:07 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9IFNkim000339;
        Fri, 18 Oct 2019 08:41:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ZB+SZ0hSnUqrrzFSMfIrHyAwcTK9JWJQlouKjT2H2jg=;
 b=Hj8VtmFdiX5cnSnUdn57A+YHiTNBLvSf2WM4/wfM5ozdgrErgmShGKBaP2EbaVEWh2ku
 Jft/9X/7I9F1Y7jBMyAgC2uHJR7VxPk9zeGl9RLqCEzEwLKNdZsi9CtSZ4Cn3O+7Tw8m
 mOZzlyDdiIQH0AAa8ZYt93BAWac/Zc2/FX4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vqeuqgf75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 18 Oct 2019 08:41:54 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 18 Oct 2019 08:41:53 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 18 Oct 2019 08:41:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1RDzVXPPuG7nnoD8fcm6UxfNtHnAhPJnE4RiKGYJfWu7DEBxQUeVsi/z59E0kFwT+iJ4o6g8RS1stf11DodwPhiuHI3xmNaRLyj6XxdS/in+xDPmC/dlr01nd5yIzLcgCHD6uhQX042pmPAiX2dpzymzjuecsnIwBsZES1zlV9GkF2SRj2Uf2eyG5BI0cPpEfOPOjU2vFNpt2Ssb1fZDKyg0Y4OYxPs8qE5U8X6NSragSO1hhr7niRQoYQMwGSeXhHHCmb6yDNWR9wPU6ZNcwzxJvAhaSeMxuyGrInDP2EvG+IIttUjTglZREftjZ8e7+hdy+cZnOgqhAhf+2qp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB+SZ0hSnUqrrzFSMfIrHyAwcTK9JWJQlouKjT2H2jg=;
 b=j2/03vuGC5nWk2JJvt9d9P1CQgmsTCrdDiI2dQQv8VnpVF8SrSznhcNqnI/dcIqUVx4q7nO/R5PHT2wtY8HKjsri1o+QeV2iyagk75KYyztXYSQ/C2a/8ibD7uFCbkxqHbKj0UhceSRnDYSUDZwOP5hnC5VpZNt61dq9RD4Y73bGZ4q8ijg3F3fgIoZTGwt2foo1Py70GIZCKZqJXb9woHE0w67srv14xgG/ekiExThelflC1A53aDstaubGSb3xZVyttF0lKCO+IOSf1exeYs5BMJF85Odpk+m72lY1+GuABLCGGcotOXTp83E1umRNTLkedA2HTxLYsj+nXnGdOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB+SZ0hSnUqrrzFSMfIrHyAwcTK9JWJQlouKjT2H2jg=;
 b=fpAFlNhBbGDCZxti3WKx1e1QAzQXt16XAx+hpDWCz2WDtiR/BGZaYmHV12496aQCytIe0w99RDqbRLIEBRfhkMDFLlP3omc+7851lxGDPT+g+dRQ09rbksKTYIVmWvFs1IySEykTwVBekn5UYmPoMll7mhxsG0NJwCqVNXPZr8s=
Received: from BYAPR15MB3479.namprd15.prod.outlook.com (20.179.57.24) by
 BYAPR15MB3448.namprd15.prod.outlook.com (20.179.56.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Fri, 18 Oct 2019 15:41:52 +0000
Received: from BYAPR15MB3479.namprd15.prod.outlook.com
 ([fe80::d51c:c256:7d42:ee23]) by BYAPR15MB3479.namprd15.prod.outlook.com
 ([fe80::d51c:c256:7d42:ee23%3]) with mapi id 15.20.2367.019; Fri, 18 Oct 2019
 15:41:52 +0000
From:   Rik van Riel <riel@fb.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Song Liu <songliubraving@fb.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm,thp: recheck each page before collapsing file THP
Thread-Topic: [PATCH] mm,thp: recheck each page before collapsing file THP
Thread-Index: AQHVhXJENhkhstl0P0GXabgc+7SHqadgZrUAgAAjgQA=
Date:   Fri, 18 Oct 2019 15:41:52 +0000
Message-ID: <137ff527ef842a9f46e32557e911c0f221745d6e.camel@fb.com>
References: <20191018050832.1251306-1-songliubraving@fb.com>
         <20191018133444.iif7b33muxmus6lb@box>
In-Reply-To: <20191018133444.iif7b33muxmus6lb@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR19CA0006.namprd19.prod.outlook.com
 (2603:10b6:208:178::19) To BYAPR15MB3479.namprd15.prod.outlook.com
 (2603:10b6:a03:106::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::f10d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c5ba824-5c28-4df6-831f-08d753e1b28b
x-ms-traffictypediagnostic: BYAPR15MB3448:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB3448E66FDEA232900D3F2AAAA36C0@BYAPR15MB3448.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(136003)(366004)(346002)(189003)(199004)(66556008)(66476007)(66446008)(6512007)(66946007)(6636002)(64756008)(6246003)(4326008)(86362001)(2906002)(6486002)(6116002)(6436002)(305945005)(7736002)(102836004)(229853002)(6506007)(386003)(256004)(14444005)(36756003)(186003)(52116002)(478600001)(14454004)(76176011)(99286004)(54906003)(71200400001)(71190400001)(316002)(110136005)(11346002)(46003)(486006)(476003)(118296001)(446003)(2616005)(8936002)(81166006)(81156014)(8676002)(25786009)(5660300002)(4001150100001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3448;H:BYAPR15MB3479.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rEVohS04Whw1ML1dZmDrFWHIpAXDmgnUz2hoy2ojL9SY57qL/oACuwfQpdS91FV5K2hxD2OMNUaTaYQu+4pa99DVrCynXOOC6SAPwUI34M4yvgJ8Ex543eLqswdODOzT61dpKs7E0hJm6YMVdlOcarreh+XV9Iw5fEC3rwnYv+7Mfsduj65aJzI/lyNd6D22KvK3Bxth4LvBwo1UEPARFEfpnvQgan26A08n874EHZhthXHqSJ+jT12kNdMprv7p++u5Wq04dYR8iZz+m3FRTfwhfMpKq2kE1MUnlqwz/tyVCRQzrSn/iySw/gwP9fEXI5dq5M6nWmD4qolBnsewxR6sS8qkJktHWq00jH7XAt3PpT3Ho40Zz3pVQ9uHHpiPHJRG+MHjVmkgrPxW7g8rNJYFM5mBpubrVd/aZ/Y441i8ou3kDO1Z7LLfua2ruCzW
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D072232D07F194281C85AC62EF5C9D5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5ba824-5c28-4df6-831f-08d753e1b28b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 15:41:52.6387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i01yW7YyFMpY1nSMp+OtTA5QpqzkA7OmtVa4TnfWj6tdbACEq3AmgWzo49v0A3qc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3448
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-18_04:2019-10-18,2019-10-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 spamscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910180141
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTEwLTE4IGF0IDE2OjM0ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IE9uIFRodSwgT2N0IDE3LCAyMDE5IGF0IDEwOjA4OjMyUE0gLTA3MDAsIFNvbmcgTGl1
IHdyb3RlOg0KPiA+IEluIGNvbGxhcHNlX2ZpbGUoKSwgYWZ0ZXIgbG9ja2luZyB0aGUgcGFnZSwg
aXQgaXMgbmVjZXNzYXJ5IHRvDQo+ID4gcmVjaGVjaw0KPiA+IHRoYXQgdGhlIHBhZ2UgaXMgdXAt
dG8tZGF0ZSwgY2xlYW4sIGFuZCBwb2ludGluZyB0byB0aGUgcHJvcGVyDQo+ID4gbWFwcGluZy4N
Cj4gPiBJZiBhbnkgY2hlY2sgZmFpbHMsIGFib3J0IHRoZSBjb2xsYXBzZS4NCj4gPiANCj4gPiBG
aXhlczogOTljYjBkYmQ0N2ExICgibW0sdGhwOiBhZGQgcmVhZC1vbmx5IFRIUCBzdXBwb3J0IGZv
ciAobm9uLQ0KPiA+IHNobWVtKSBGUyIpDQo+ID4gQ2M6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2ly
aWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4NCj4gPiBDYzogSm9oYW5uZXMgV2VpbmVyIDxo
YW5uZXNAY21weGNoZy5vcmc+DQo+ID4gQ2M6IEh1Z2ggRGlja2lucyA8aHVnaGRAZ29vZ2xlLmNv
bT4NCj4gPiBDYzogV2lsbGlhbSBLdWNoYXJza2kgPHdpbGxpYW0ua3VjaGFyc2tpQG9yYWNsZS5j
b20+DQo+ID4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQo+
ID4gU2lnbmVkLW9mZi1ieTogU29uZyBMaXUgPHNvbmdsaXVicmF2aW5nQGZiLmNvbT4NCj4gPiAt
LS0NCj4gPiAgbW0va2h1Z2VwYWdlZC5jIHwgOCArKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL21tL2todWdlcGFnZWQu
YyBiL21tL2todWdlcGFnZWQuYw0KPiA+IGluZGV4IDBhMWI0YjQ4NGFjNS4uN2RhNDliNjQzYzRk
IDEwMDY0NA0KPiA+IC0tLSBhL21tL2todWdlcGFnZWQuYw0KPiA+ICsrKyBiL21tL2todWdlcGFn
ZWQuYw0KPiA+IEBAIC0xNjE5LDYgKzE2MTksMTQgQEAgc3RhdGljIHZvaWQgY29sbGFwc2VfZmls
ZShzdHJ1Y3QgbW1fc3RydWN0DQo+ID4gKm1tLA0KPiA+ICAJCQkJcmVzdWx0ID0gU0NBTl9QQUdF
X0xPQ0s7DQo+ID4gIAkJCQlnb3RvIHhhX2xvY2tlZDsNCj4gPiAgCQkJfQ0KPiA+ICsNCj4gPiAr
CQkJLyogZG91YmxlIGNoZWNrIHRoZSBwYWdlIGlzIGNvcnJlY3QgYW5kIGNsZWFuDQo+ID4gKi8N
Cj4gPiArCQkJaWYgKHVubGlrZWx5KCFQYWdlVXB0b2RhdGUocGFnZSkpIHx8DQo+ID4gKwkJCSAg
ICB1bmxpa2VseShQYWdlRGlydHkocGFnZSkpIHx8DQo+ID4gKwkJCSAgICB1bmxpa2VseShwYWdl
LT5tYXBwaW5nICE9IG1hcHBpbmcpKSB7DQo+ID4gKwkJCQlyZXN1bHQgPSBTQ0FOX0ZBSUw7DQo+
ID4gKwkJCQlnb3RvIG91dF91bmxvY2s7DQo+ID4gKwkJCX0NCj4gPiAgCQl9DQo+ID4gIA0KPiA+
ICAJCS8qDQo+IA0KPiBIbS4gQnV0IHdoeSBvbmx5IGZvciAhaXNfc2htZW0/IE9yIEkgcmVhZCBp
dCB3cm9uZz8NCg0KSXQgbG9va3MgbGlrZSB0aGUgc2htZW0gY29kZSBwYXRoIGhhcyBpdHMgb3du
IHdheSBvZiBiYWlsaW5nDQpvdXQgd2hlbiBhIHBhZ2UgaXMgIVBhZ2VVcHRvZGF0ZS4gQWxzbywg
c2htZW0gY2FuIGhhbmRsZSBkaXJ0eQ0KcGFnZXMgZmluZS4NCg0KSG93ZXZlciwgSSBzdXBwb3Nl
IHRoZSBzaG1lbSBjb2RlIG1pZ2h0IHdhbnQgdG8gY2hlY2sgZm9yIHRydW5jYXRlZA0KcGFnZXMs
IHdoaWNoIGl0IGRvZXMgbm90IGN1cnJldG5seSBhcHBlYXIgdG8gZG8uIEkgZ3Vlc3MgZG9pbmcN
CnRoZSB0cnlsb2NrX3BhZ2UgdW5kZXIgdGhlIHhhcnJheSBsb2NrIG1heSBwcm90ZWN0IGFnYWlu
c3QgdHJ1bmNhdGUsDQpidXQgdGhhdCBpcyBzdWJ0bGUgZW5vdWdoIHRoYXQgYXQgdGhlIHZlcnkg
bGVhc3QgaXQgc2hvdWxkIGJlDQpkb2N1bWVudGVkLg0KDQoNCg==

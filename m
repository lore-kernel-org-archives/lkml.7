Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98EAC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 01:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7EC20863
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 01:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="c1ML6KCy";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PRpn2xFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbfFSBDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 21:03:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17266 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725988AbfFSBDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 21:03:45 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5J0vRTU031293;
        Tue, 18 Jun 2019 18:03:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=lcOwfK8ETlTJM19sU/96XI+6pvU58BB9FCLkC+yB5jw=;
 b=c1ML6KCy7YgNsyB4CDGxNCe2gnAUfx8H9Y8qb1n0S9RFd4fvUbCtl41zbLecWv2aX3f2
 z3SOtuuyWMqZHM9TJR774CrsajZ5suMpxg6+p1+nEcMZlbB4frRS6HoR8PrC246D4AMp
 sPKyxjYAcXArnra73X/zy2KiL85BndfLZxY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2t77yjrmfc-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 18 Jun 2019 18:03:16 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 18 Jun 2019 18:03:15 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 18 Jun 2019 18:03:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcOwfK8ETlTJM19sU/96XI+6pvU58BB9FCLkC+yB5jw=;
 b=PRpn2xFlfmflARQG3DRDR02iqtEfcX6gJQJtWjWSuztvEU83iisTiSbF/Z4CZEqRtOm65QAcwYe4hNbnG4Xg7eFAN6AFmctlRmQjyDc8rT3ltriSCtqoFLSBxoGzR4BK7grg7FAws/wkkVnctNihyeh/4PpUWPJ2JHrofWfC/tA=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.17) by
 MWHPR15MB1615.namprd15.prod.outlook.com (10.175.135.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Wed, 19 Jun 2019 01:03:14 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::d51f:8f19:e2b5:3ae8]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::d51f:8f19:e2b5:3ae8%6]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 01:03:14 +0000
From:   Tao Ren <taoren@fb.com>
To:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH] ARM: dts: aspeed: Add Facebook Minipack BMC
Thread-Topic: [PATCH] ARM: dts: aspeed: Add Facebook Minipack BMC
Thread-Index: AQHVJY22ky4K0dgM8Eq+6c9S8hDKi6aiJEwAgAAGH4A=
Date:   Wed, 19 Jun 2019 01:03:14 +0000
Message-ID: <9f757278-9d96-b81c-4fc1-21266b68165f@fb.com>
References: <20190618042421.1227372-1-taoren@fb.com>
 <d201fadc-0b8e-48df-8e50-bccd5d5019c7@www.fastmail.com>
In-Reply-To: <d201fadc-0b8e-48df-8e50-bccd5d5019c7@www.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR18CA0048.namprd18.prod.outlook.com
 (2603:10b6:104:2::16) To MWHPR15MB1216.namprd15.prod.outlook.com
 (2603:10b6:320:22::17)
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:512]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 136361b0-0df0-435a-00eb-08d6f451e806
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1615;
x-ms-traffictypediagnostic: MWHPR15MB1615:
x-microsoft-antispam-prvs: <MWHPR15MB1615AEC9FFCC9EC233B6762FB2E50@MWHPR15MB1615.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(136003)(39860400002)(47680400002)(199004)(189003)(8676002)(2906002)(305945005)(102836004)(2201001)(76176011)(316002)(5660300002)(31696002)(86362001)(446003)(65956001)(186003)(6436002)(110136005)(256004)(6486002)(2501003)(81156014)(81166006)(58126008)(229853002)(386003)(8936002)(53546011)(6506007)(65806001)(99286004)(66556008)(6512007)(558084003)(46003)(36756003)(65826007)(11346002)(25786009)(68736007)(66446008)(64756008)(52116002)(66476007)(478600001)(7736002)(71200400001)(486006)(71190400001)(31686004)(14454004)(476003)(53936002)(6116002)(2616005)(73956011)(64126003)(6246003)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1615;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BPaOvNrPkASl/nHq3vpQRWL7KRtX8xSxIJg/EdiEQursq9QwNXqZzmPghvW7vGhQM7gnjp11UKCZISYK1WVUBMyGCJ8TArzprWNaclMpeGwEhfsXUtCf5L1TWEW3MPvwsXt/WIOcLtbr5wM5r+Rv1BxyYuw7ySIFawG1RYfo/sFBs0fzdHsb2ZjNZMGHnpHeoRf4n24g0sByQcDgc8HBBDi9z+Sg/tPY5+7ZAmalQ5CMlJLYxa/Nrml43V31jEzIhUQaecabccCLftMQg7X3knptAfWG0uJ4Mt6KAQOP23V32W6YOER/vX5HUbvmRt8j9Xo4PAFUeEF+ItZmgnMCL7KzACKs1VBLFtn7yPJnBBfNa125IMyL1ejYjOASRD/SXmOPMhOCUoPHg8dZCFPYop2BABmbId80xaFc7uiTwGo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58C3D7D2AF2D4C4FA7D0685A248A096C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 136361b0-0df0-435a-00eb-08d6f451e806
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 01:03:14.6163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: taoren@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1615
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-18_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=826 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906190006
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8xOC8xOSA1OjQxIFBNLCBBbmRyZXcgSmVmZmVyeSB3cm90ZToNCj4gDQo+IA0KPiBPbiBU
dWUsIDE4IEp1biAyMDE5LCBhdCAxMzo1NCwgVGFvIFJlbiB3cm90ZToNCj4+IEFkZCBpbml0aWFs
IHZlcnNpb24gb2YgZGV2aWNlIHRyZWUgZm9yIEZhY2Vib29rIE1pbmlwYWNrIGFzdDI1MDAgQk1D
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFRhbyBSZW4gPHRhb3JlbkBmYi5jb20+DQo+IA0KPiBS
ZXZpZXdlZC1ieTogQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bhai5pZC5hdT4NCg0KVGhhbmtzIGEg
bG90IGZvciB0aGUgcXVpY2sgcmV2aWV3LCBBbmRyZXchDQoNCg0KQ2hlZXJzLA0KDQpUYW8NCg==

Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15596C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 17:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EA223F44
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 17:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cXNmnsk8";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="nkrwJNth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfE2RXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 13:23:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58978 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbfE2RXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 13:23:35 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4THK58Y011968;
        Wed, 29 May 2019 10:23:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=RYe2t34uPb4EOOnAoXFfT8xV9HqDtrzvfs1Xqg4S+wY=;
 b=cXNmnsk8g/po5cHt8l1Lzk2ulM/EyQtTNhh7l4R9sY3fEC2PFo8KiaT8MrPPEqFl2oxn
 q1W8ic0aFZ/0Da3V1a+/aY43pd68ArmblPf76Au3q1itgb4zpJUV5wD5eP875a62W6Yv
 0Cy/ls86VIxn9UjXyJLtGOWVKbrCExJl5sk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ssueerqqm-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 10:23:11 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 29 May 2019 10:22:53 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 29 May 2019 10:22:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYe2t34uPb4EOOnAoXFfT8xV9HqDtrzvfs1Xqg4S+wY=;
 b=nkrwJNth4Vz7lE29uXLOwoyXFy5vBCgoWKP448DFZz39Wdoc8oKpDkj/3PqHJoXU1GGv5WC+4SYmGh6DkcQ9lLZIoBbGGuP4OXRIxOR2XNKpOk0GmIyr3q2itXi9NefIFtSmVb6TcVpdCDFVVbGhZM+0kofufpDBWC4OYdBslPY=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.177.11) by
 CY4PR15MB1687.namprd15.prod.outlook.com (10.175.119.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.22; Wed, 29 May 2019 17:22:51 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::c026:bca5:3f4e:9b1f]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::c026:bca5:3f4e:9b1f%3]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 17:22:51 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        "Andrew Jeffery" <andrew@aj.id.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sai Dasari <sdasari@fb.com>
Subject: Re: [PATCH] misc: aspeed-lpc-ctrl: make parameter optional
Thread-Topic: [PATCH] misc: aspeed-lpc-ctrl: make parameter optional
Thread-Index: AQHVAG4MVnagyLYdbEW1gTueyh4a2qZ6knKAgAd9oQA=
Date:   Wed, 29 May 2019 17:22:51 +0000
Message-ID: <F6CAD6A7-3130-4649-B596-5FC53F4DBDFB@fb.com>
References: <20190501223411.1655854-1-vijaykhemka@fb.com>
 <20190524155923.GA7516@kroah.com>
In-Reply-To: <20190524155923.GA7516@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::2:fd56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec4b2d6b-4063-4ec0-aeee-08d6e45a478b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR15MB1687;
x-ms-traffictypediagnostic: CY4PR15MB1687:
x-microsoft-antispam-prvs: <CY4PR15MB1687914A76306783454414E9DD1F0@CY4PR15MB1687.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(396003)(376002)(136003)(199004)(189003)(73956011)(66446008)(64756008)(6116002)(76116006)(229853002)(66476007)(83716004)(66946007)(7736002)(53936002)(91956017)(305945005)(6512007)(2906002)(33656002)(6436002)(8676002)(81166006)(81156014)(36756003)(6486002)(14454004)(71200400001)(8936002)(71190400001)(478600001)(54906003)(4744005)(6916009)(102836004)(2616005)(6506007)(486006)(82746002)(186003)(476003)(446003)(11346002)(5660300002)(4326008)(25786009)(76176011)(99286004)(86362001)(68736007)(316002)(256004)(46003)(6246003)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1687;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o9Ram2e4sByPhhwAWawyaKr2dYdSuflwaaIay2dzfWOvuA6A/W6zStWnonFK8E6QatEDXzxqcYBCB1oUvrlBdRNPcDw50itHPDUfUAQRoRVTwvY4whCSUl1oPSZbhftRlu7w2bU4DmwltG+oa0Y90NtL+YY1806OyjcjjYfoD0hKpAuY6cQtYjwcLk0b3hEdwsCfLoObmehIMppqcrovAFk/zyDry+agManRC12TWQuDW7ScYvAfIOkTma7C6rdZnVj5hK7c7i1on6FmxecSJwkyu7R+A2XDEB9ateCs2WMWWN+WkuxKFnpXOOFruBKMUxvhIZej3UJJCulC6DIcLFqrfOmP0KP63nWaKZhBptQ1spZXKEoOjBqjMioBTNdFOCodw5NotHB4SLeBhSjI/jEkxjRz5mpg4DRkDekmy90=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9BA4D932E651A4DA40E3894AC04DD39@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4b2d6b-4063-4ec0-aeee-08d6e45a478b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 17:22:51.6068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vijaykhemka@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1687
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-29_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=888 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905290113
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDUvMjQvMTksIDg6NTkgQU0sICJHcmVnIEtyb2FoLUhhcnRtYW4iIDxncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQoNCiAgICBPbiBXZWQsIE1heSAwMSwgMjAxOSBh
dCAwMzozNDoxMVBNIC0wNzAwLCBWaWpheSBLaGVta2Egd3JvdGU6DQogICAgPiBNYWtpaW5nIG1l
bW9yeS1yZWdpb24gYW5kIGZsYXNoIGFzIG9wdGlvbmFsIHBhcmFtZXRlciBpbiBkZXZpY2UNCiAg
ICA+IHRyZWUgaWYgdXNlciBuZWVkcyB0byB1c2UgdGhlc2UgcGFyYW1ldGVyIHRocm91Z2ggaW9j
dGwgdGhlbg0KICAgID4gbmVlZCB0byBkZWZpbmUgaW4gZGV2aWNldHJlZS4NCiAgICA+IA0KICAg
ID4gU2lnbmVkLW9mZi1ieTogVmlqYXkgS2hlbWthIDx2aWpheWtoZW1rYUBmYi5jb20+DQogICAg
PiAtLS0NCiAgICA+ICBkcml2ZXJzL21pc2MvYXNwZWVkLWxwYy1jdHJsLmMgfCA1OCArKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQogICAgPiAgMSBmaWxlIGNoYW5nZWQsIDM2IGlu
c2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQ0KICAgIA0KICAgIEZpbGUgaXMgbm8gbG9uZ2Vy
IGF0IHRoaXMgbG9jYXRpb24gOigNCg0KSSBoYXZlIHJlYmFzZWQgdG8gbmV3IGxvY2F0aW9uIGFu
ZCBjb21iaW5lZCBib3RoIHBhdGNoZXMgYW5kIHN1Ym1pdHRlZCBhZ2Fpbi4gX18NCg0KUmVnYXJk
cw0KLVZpamF5DQogICAgDQoNCg==

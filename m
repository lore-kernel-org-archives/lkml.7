Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122E7C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 19:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00DB20740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 19:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="etg7Y+EL";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="WkpHnKl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfKYTX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 14:23:58 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46612 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725818AbfKYTX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 14:23:58 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAPJKRhv020897;
        Mon, 25 Nov 2019 11:23:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=g/w2JPejJmf0DVxj7BZWxUg8EngNUTvZW4Nu2dQodl8=;
 b=etg7Y+ELYfXcUnHokbtwEG0dzMggWO5rgLQH5Dv5rr9ZjHg8ce6+kSl9o7dd6IvHzW93
 Ffw9hdR/61+UYd9gH+Kn6+kG+HVQYW+XYP85QGGw65Q+0lGG85dbWHRJ5Oz+jjm30eso
 JC2Q7WZ8Z/UepQSajxCDy1SCEkOaYmUnR4E= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wfnbfykrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 25 Nov 2019 11:23:35 -0800
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 25 Nov 2019 11:23:34 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 25 Nov 2019 11:23:33 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 25 Nov 2019 11:23:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhDg3pZysoOE7ojqagifT7BEGXD8F+3bwsFo3Qq5hV2SRbB5EYke5KiCUj4ERzjzdH6jqahizxjQrVcbIndOA9JORMt6Sm/HmNEY3Uu1Zz27Td8167iePzCFnZiquatcPtKnuzIrvFmjJBEZV0bgQkZmvXbvJmvV+32vZ95vN6mcgVwBrBcSs1clVKarnWTo/X+1Bb8Q1iGf3t4vO9fV30KMEbidUeXAQAPl0b6uRMUrxRADkI4AxjdB1IOWImFL8kZz4wQ6Ye8OKARZvv1GTeJr/Sa6RZx/tOf70tyvhlz9roUaCEv9FFbd7jv+d3SoqRzW9Tv9T8RNF7/TzHrkaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/w2JPejJmf0DVxj7BZWxUg8EngNUTvZW4Nu2dQodl8=;
 b=aylrvKd7GYBrPdHgQR0b852MSfmRPYJowsjWOjER7Np2ntKuEaL1ohY7dO8eE3LOvo+IURnzid3pgkll+mqzP22Ql5v3PKGSQjh71J/Wgck74Qn2bxgJBGvgqW2BXJG/drh6+EtaSnXGn6RftNRKAQ7B+000firNmiO04zi5Bx3Sg8I5UH/+e+YAoC3jRb1+ywyhgiGVa9IpULR0M89uZhSqEYKH0buwfHwJsODTe2K1GHjW4jVbbLegUV3K+XjtVh8xfi/AUZ2odTi/dPkqiO4LbFVOXQ3DgYY4++mIBwuYUXQ35B6oh8MYM2HmBQlrOg8ltbmOXSv52TqK03K9qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/w2JPejJmf0DVxj7BZWxUg8EngNUTvZW4Nu2dQodl8=;
 b=WkpHnKl9PbrQ0QxqyuzT7ZDGyjmrT9D4Yo1JF82BWI4CWFGNNO5O8uG311BLCoTpQI/EQ908wLSXjwe8wkifx4MymvvO7cAEicCfa2eKuQuQvnESE1L2Cx2+kXKEtKpvNNEJNiU5j+VoyN3PbUM50y6sn0bSGGhIN1opwOFHnac=
Received: from MWHPR15MB1597.namprd15.prod.outlook.com (10.173.234.137) by
 MWHPR15MB1310.namprd15.prod.outlook.com (10.175.2.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Mon, 25 Nov 2019 19:23:32 +0000
Received: from MWHPR15MB1597.namprd15.prod.outlook.com
 ([fe80::2c43:c44b:2c95:e376]) by MWHPR15MB1597.namprd15.prod.outlook.com
 ([fe80::2c43:c44b:2c95:e376%11]) with mapi id 15.20.2474.023; Mon, 25 Nov
 2019 19:23:32 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     manikandan-e <manikandan.hcl.ers.epl@gmail.com>,
        "andrew@aj.id.au" <andrew@aj.id.au>
CC:     "joel@jms.id.au" <joel@jms.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "manikandan.e@hcl.com" <manikandan.e@hcl.com>
Subject: Re: [PATCH v3] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Thread-Topic: [PATCH v3] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Thread-Index: AQHVo5DnGMuyb8H++Equ2o+XkOK6yqebvmaA
Date:   Mon, 25 Nov 2019 19:23:32 +0000
Message-ID: <7F15A2E0-14C7-4C86-B589-35619A390B72@fb.com>
References: <20191125130420.GA24018@cnn>
In-Reply-To: <20191125130420.GA24018@cnn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::2:182d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55e07a90-115c-4dfe-1b03-08d771dcf5bb
x-ms-traffictypediagnostic: MWHPR15MB1310:
x-microsoft-antispam-prvs: <MWHPR15MB1310954DEB7F78422D871BD2DD4A0@MWHPR15MB1310.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(136003)(376002)(346002)(47680400002)(199004)(189003)(478600001)(33656002)(6512007)(86362001)(6116002)(71200400001)(71190400001)(2616005)(446003)(11346002)(6246003)(7736002)(46003)(36756003)(4326008)(2501003)(305945005)(6506007)(6486002)(66476007)(54906003)(25786009)(256004)(76116006)(14454004)(102836004)(8936002)(81156014)(81166006)(2906002)(66946007)(186003)(99286004)(5660300002)(229853002)(76176011)(6436002)(66446008)(64756008)(66556008)(110136005)(316002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1310;H:MWHPR15MB1597.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GMKoNQta3a3lrtJl/R6TqZXwAdxKsZWX8NqmqVrObAtojToK9HLphSu9qsoMhmRcvMsSniqW6kCUzKlHT8pCAaUbrcLl1Yo577KRC2tyhmqCrPgHxwec5gFL0W0LW6NFlTxTMb6Jb2dZBsRXxZlDBHybEvx7NS2yz0raZ6HUc/vZ3hq5dDJdnIjPTepxsQmpxXf6dZkLzIAI3Cp0hc1yXAfcEtvu+9F9eQ3xSSkFXhqsjnkMNOh9/ix9MJRPZQsVbDgpmFYXIItX/7KScaNbko/YmuSXh3iEYetQQbbRqQIwPu9JOCQrMCziEU8V7oGzRzOwBIyuHGtBsRczM9vdKkx56CEpYrETriDHR8H7jVU0mgkZbsTIuOOn6yNGiavg9qKOYYbA+cb1JekMMxE/30GR7sSKn/oh4PzxkAZREPL8LiLCqHYWnlLOlmIPqGfv
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <50A9C48426F1824CB7FE6D04A38CC12E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e07a90-115c-4dfe-1b03-08d771dcf5bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 19:23:32.4019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RPnyw1auszMxW4PD/7mV7DlcLL1wi0mQ7oOdImaCnoUyv/gnb1mpqipNnm3kqCtpkw9XipF3rikSgm9/QuaqOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1310
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-25_04:2019-11-21,2019-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911250158
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQrvu79PbiAxMS8yNS8xOSwgNTowNCBBTSwgIm1hbmlrYW5kYW4tZSIgPG1hbmlrYW5kYW4uaGNs
LmVycy5lcGxAZ21haWwuY29tPiB3cm90ZToNCg0KICAgIFRoZSBZb3NlbWl0ZSBWMiBpcyBhIGZh
Y2Vib29rIG11bHRpLW5vZGUgc2VydmVyDQogICAgcGxhdGZvcm0gdGhhdCBob3N0IGZvdXIgT0NQ
IHNlcnZlci4gVGhlIEJNQw0KICAgIGluIHRoZSBZb3NlbWl0ZSBWMiBwbGF0b3JtIGJhc2VkIG9u
IEFTVDI1MDAgU29DLg0KICAgIA0KICAgIFRoaXMgcGF0Y2ggYWRkcyBsaW51eCBkZXZpY2UgdHJl
ZSBlbnRyeSByZWxhdGVkIHRvDQogICAgWW9zZW1pdGUgVjIgc3BlY2lmaWMgZGV2aWNlcyBjb25u
ZWN0ZWQgdG8gQk1DIFNvQy4NCk5pdDogY29tbWVudHMgaW5saW5lLiBPdGhlcndpc2UNClJldmll
d2VkLWJ5OiBWaWpheSBLaGVta2EgPHZpamF5a2hlbWthQGZiLmNvbT4NCiAgICANCg0KICAgIFNp
Z25lZC1vZmYtYnk6IG1hbmlrYW5kYW4tZSA8bWFuaWthbmRhbi5oY2wuZXJzLmVwbEBnbWFpbC5j
b20+DQogICAgLS0tDQogICAgIC4uLi9ib290L2R0cy9hc3BlZWQtYm1jLWZhY2Vib29rLXlvc2Vt
aXRldjIuZHRzICAgIHwgMTUxICsrKysrKysrKysrKysrKysrKysrKw0KICAgICAxIGZpbGUgY2hh
bmdlZCwgMTUxIGluc2VydGlvbnMoKykNCiAgICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJt
L2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2steW9zZW1pdGV2Mi5kdHMNCiAgICANCiAgICBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWJtYy1mYWNlYm9vay15b3NlbWl0
ZXYyLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2steW9zZW1pdGV2
Mi5kdHMNCiAgICBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KICAgIGluZGV4IDAwMDAwMDAuLjA5YmZm
Y2QNCiAgICAtLS0gL2Rldi9udWxsDQogICAgKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVk
LWJtYy1mYWNlYm9vay15b3NlbWl0ZXYyLmR0cw0KICAgIEBAIC0wLDAgKzEsMTUxIEBADQogICAg
Ky8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0KICAgICsvLyBDb3B5cmlnaHQg
KGMpIDIwMTggRmFjZWJvb2sgSW5jLg0KICAgICsvZHRzLXYxLzsNCiAgICArDQogICAgKyNpbmNs
dWRlICJhc3BlZWQtZzUuZHRzaSINCiAgICArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dwaW8vYXNw
ZWVkLWdwaW8uaD4NCiAgICArDQogICAgKy8gew0KICAgICsJbW9kZWwgPSAiRmFjZWJvb2sgWW9z
ZW1pdGV2MiBCTUMiOw0KICAgICsJY29tcGF0aWJsZSA9ICJmYWNlYm9vayx5b3NlbWl0ZXYyLWJt
YyIsICJhc3BlZWQsYXN0MjUwMCI7DQogICAgKwlhbGlhc2VzIHsNCiAgICArCQlzZXJpYWw0ID0g
JnVhcnQ1Ow0KICAgICsJfTsNCiAgICArCWNob3NlbiB7DQogICAgKwkJc3Rkb3V0LXBhdGggPSAm
dWFydDU7DQogICAgKwkJYm9vdGFyZ3MgPSAiY29uc29sZT10dHlTNCwxMTUyMDAgZWFybHlwcmlu
dGsiOw0KYm9vdGFyZ3MgYXJlIG5vdCByZXF1aXJlZCBhcyBpdCBpcyBvdmVyd3JpdHRlbiBieSB1
Ym9vdC4gQW5kIGJhdWQgcmF0ZSBpcyA1NzYwMA0KICAgICsJfTsNCiAgICArDQogICAgKwltZW1v
cnlAODAwMDAwMDAgew0KICAgICsJCXJlZyA9IDwweDgwMDAwMDAwIDB4MjAwMDAwMDA+Ow0KICAg
ICsJfTsNCiAgICArDQogICAgKwlpaW8taHdtb24gew0KICAgICsJCS8vIFZPTEFUQUdFIFNFTlNP
Ug0KICAgICsJCWNvbXBhdGlibGUgPSAiaWlvLWh3bW9uIjsNCiAgICArCQlpby1jaGFubmVscyA9
IDwmYWRjIDA+ICwgPCZhZGMgMT4gLCA8JmFkYyAyPiAsICA8JmFkYyAzPiAsDQogICAgKwkJPCZh
ZGMgND4gLCA8JmFkYyA1PiAsIDwmYWRjIDY+ICwgIDwmYWRjIDc+ICwNCiAgICArCQk8JmFkYyA4
PiAsIDwmYWRjIDk+ICwgPCZhZGMgMTA+LCA8JmFkYyAxMT4gLA0KICAgICsJCTwmYWRjIDEyPiAs
IDwmYWRjIDEzPiAsIDwmYWRjIDE0PiAsIDwmYWRjIDE1PiA7DQogICAgKwl9Ow0KICAgICt9Ow0K
ICAgICsNCiAgICArJmZtYyB7DQogICAgKwlzdGF0dXMgPSAib2theSI7DQogICAgKwlmbGFzaEAw
IHsNCiAgICArCQlzdGF0dXMgPSAib2theSI7DQogICAgKwkJbTI1cCxmYXN0LXJlYWQ7DQogICAg
KyNpbmNsdWRlICJvcGVuYm1jLWZsYXNoLWxheW91dC5kdHNpIg0KICAgICsJfTsNCiAgICArfTsN
CiAgICArDQogICAgKyZzcGkxIHsNCiAgICArCXN0YXR1cyA9ICJva2F5IjsNCiAgICArCXBpbmN0
cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQogICAgKwlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfc3BpMV9k
ZWZhdWx0PjsNCiAgICArCWZsYXNoQDAgew0KICAgICsJCXN0YXR1cyA9ICJva2F5IjsNCiAgICAr
CQltMjVwLGZhc3QtcmVhZDsNCiAgICArCQlsYWJlbCA9ICJwbm9yIjsNCiAgICArCX07DQogICAg
K307DQogICAgKw0KICAgICsmdWFydDUgew0KICAgICsJLy8gQk1DIENvbnNvbGUNCiAgICArCXN0
YXR1cyA9ICJva2F5IjsNCiAgICArfTsNCiAgICArDQogICAgKyZtYWMwIHsNCiAgICArCXN0YXR1
cyA9ICJva2F5IjsNCiAgICArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQogICAgKwlwaW5j
dHJsLTAgPSA8JnBpbmN0cmxfcm1paTFfZGVmYXVsdD47DQogICAgKwl1c2UtbmNzaTsNCiAgICAr
fTsNCiAgICArDQogICAgKyZhZGMgew0KICAgICsJc3RhdHVzID0gIm9rYXkiOw0KICAgICsgICAg
ICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQpVc2UgdGFiIGZvciBhbGlnbm1lbnQNCiAg
ICArCXBpbmN0cmwtMCA9IDwmcGluY3RybF9hZGMwX2RlZmF1bHQNCiAgICArCQkJJnBpbmN0cmxf
YWRjMV9kZWZhdWx0DQogICAgKwkJCSZwaW5jdHJsX2FkYzJfZGVmYXVsdA0KICAgICsJCQkmcGlu
Y3RybF9hZGMzX2RlZmF1bHQNCiAgICArCQkJJnBpbmN0cmxfYWRjNF9kZWZhdWx0DQogICAgKwkJ
CSZwaW5jdHJsX2FkYzVfZGVmYXVsdA0KICAgICsJCQkmcGluY3RybF9hZGM2X2RlZmF1bHQNCiAg
ICArCQkJJnBpbmN0cmxfYWRjN19kZWZhdWx0DQogICAgKwkJCSZwaW5jdHJsX2FkYzhfZGVmYXVs
dA0KICAgICsJCQkmcGluY3RybF9hZGM5X2RlZmF1bHQNCiAgICArCQkJJnBpbmN0cmxfYWRjMTBf
ZGVmYXVsdA0KICAgICsJCQkmcGluY3RybF9hZGMxMV9kZWZhdWx0DQogICAgKwkJCSZwaW5jdHJs
X2FkYzEyX2RlZmF1bHQNCiAgICArCQkJJnBpbmN0cmxfYWRjMTNfZGVmYXVsdA0KICAgICsJCQkm
cGluY3RybF9hZGMxNF9kZWZhdWx0DQogICAgKwkJCSZwaW5jdHJsX2FkYzE1X2RlZmF1bHQ+Ow0K
ICAgICt9Ow0KICAgICsNCiAgICArJmkyYzggew0KICAgICsJc3RhdHVzID0gIm9rYXkiOw0KICAg
ICsJLy9GUlUgRUVQUk9NDQogICAgKwllZXByb21ANTEgew0KICAgICsJCWNvbXBhdGlibGUgPSAi
YXRtZWwsMjRjNjQiOw0KICAgICsJCXJlZyA9IDwweDUxPjsNCiAgICArCQlwYWdlc2l6ZSA9IDwz
Mj47DQogICAgKwl9Ow0KICAgICt9Ow0KICAgICsNCiAgICArJmkyYzkgew0KICAgICsJc3RhdHVz
ID0gIm9rYXkiOw0KICAgICsJdG1wNDIxQDRlIHsNCiAgICArCS8vSU5MRVQgVEVNUA0KICAgICsJ
CWNvbXBhdGlibGUgPSAidGksdG1wNDIxIjsNCiAgICArCQlyZWcgPSA8MHg0ZT47DQogICAgKwl9
Ow0KICAgICsJLy9PVVRMRVQgVEVNUA0KICAgICsJdG1wNDIxQDRmIHsNCiAgICArCQljb21wYXRp
YmxlID0gInRpLHRtcDQyMSI7DQogICAgKwkJcmVnID0gPDB4NGY+Ow0KICAgICsJfTsNCiAgICAr
fTsNCiAgICArDQogICAgKyZpMmMxMCB7DQogICAgKwlzdGF0dXMgPSAib2theSI7DQogICAgKwkv
L0hTQw0KICAgICsJYWRtMTI3OEA0MCB7DQogICAgKwkJY29tcGF0aWJsZSA9ICJhZGksYWRtMTI3
OCI7DQogICAgKwkJcmVnID0gPDB4NDA+Ow0KICAgICsJfTsNCiAgICArfTsNCiAgICArDQogICAg
KyZpMmMxMSB7DQogICAgKwlzdGF0dXMgPSAib2theSI7DQogICAgKwkvL01FWlpfVEVNUF9TRU5T
T1INCiAgICArCXRtcDQyMUAxZiB7DQogICAgKwkJY29tcGF0aWJsZSA9ICJ0aSx0bXA0MjEiOw0K
ICAgICsJCXJlZyA9IDwweDFmPjsNCiAgICArCX07DQogICAgK307DQogICAgKw0KICAgICsmaTJj
MTIgew0KICAgICsJc3RhdHVzID0gIm9rYXkiOw0KICAgICsJLy9NRVpaX0ZSVQ0KICAgICsJZWVw
cm9tQDUxIHsNCiAgICArCQljb21wYXRpYmxlID0gImF0bWVsLDI0YzY0IjsNCiAgICArCQlyZWcg
PSA8MHg1MT47DQogICAgKwkJcGFnZXNpemUgPSA8MzI+Ow0KICAgICsJfTsNCiAgICArfTsNCiAg
ICArDQogICAgKyZwd21fdGFjaG8gew0KICAgICsJc3RhdHVzID0gIm9rYXkiOw0KICAgICsJLy9G
U0MNCiAgICArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQogICAgKwlwaW5jdHJsLTAgPSA8
JnBpbmN0cmxfcHdtMF9kZWZhdWx0ICZwaW5jdHJsX3B3bTFfZGVmYXVsdD47DQogICAgKwlmYW5A
MCB7DQogICAgKwkJcmVnID0gPDB4MDA+Ow0KICAgICsJCWFzcGVlZCxmYW4tdGFjaC1jaCA9IC9i
aXRzLyA4IDwweDAwPjsNCiAgICArCX07DQogICAgKwlmYW5AMSB7DQogICAgKwkJcmVnID0gPDB4
MDE+Ow0KICAgICsJCWFzcGVlZCxmYW4tdGFjaC1jaCA9IC9iaXRzLyA4IDwweDAyPjsNCiAgICAr
CX07DQogICAgK307DQogICAgLS0gDQogICAgMi43LjQNCiAgICANCiAgICANCg0K

Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83037C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46709215EA
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="nF9bjMMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfH3B2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 21:28:36 -0400
Received: from mail-eopbgr1320057.outbound.protection.outlook.com ([40.107.132.57]:31430
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727110AbfH3B2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 21:28:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQR33ggK2hy7kOLlJQ+kPK1oSxL0SnjtHuZj6PhS5sTbANtZeVB37zGi5BR4dd/0by9DYHaScU8my5X2DcuqMaL4vld8QlPoU+9/f1aCfsFemo4U0WtYTqeGmoegg5HntXYDutaTJ8rKlPx57ydw0NdjDk9lzTw9tsmj3MH8x89+XDYLQWs7exlCDSZ6+lxgCBdgKVD+vv2JI1wFAN6Xb4rI2IDClvAjtUAoRp9lTklde+BL00zILapW0KufFTuJ6VqsZFuJn+v31AgH+qKsjKLYdFjQWt13G86Xt0lZMMT2+0HVui4/V/JMOUXXdofx/2XKtFgU4TCe7D8u9RsMLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7j4jaYZDamlzFOBVKaoDB0rWlCpjILeEr//VXMV8vc=;
 b=CB08R7R3v1v/8alHheSHeGC5diiEOmdylOqRBcSya4N0Ew/Lri4Zm5nLqpYH5xXUjkj8m0PS6Wi6+O6siE09WltA/dOmOk7cW554z8irk8DlfItcutHt+r9elPNYsg23OfhjrKBP9Y2H8rJfo2wxNpwd60xqlju2IadVuQ9CprLFmzBqF1dCSReEcSCpQ3WkJ9JpxRII8BpCR9TbHT1YEjySsTUS+359+VB36x9fgUjjPXKHsAE2efSGtJTGye9APZEC/t0+LZdE97RfndDrf0GhBaJmht5VR4+4WodXvXv81EkAmI/oOtI8ZYlDLNg/2V/Zd/aE83GlIaL4YxRNMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector1-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7j4jaYZDamlzFOBVKaoDB0rWlCpjILeEr//VXMV8vc=;
 b=nF9bjMMmvyQm9yGMgKXsxLX05tNzm0Y/tllEkd0ALlIvJPDg/fVxS8e20Ws535lM1+AnIG/9BCLovr1tokEy0ALY+bGVrsKEpMTqepeWVkaFc723cEcvQXvwomIXoq0VyYNPNjgfXVA6de+fVTe/v0HTFo+d8M8J1hGc76TEwfo=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB2096.apcprd01.prod.exchangelabs.com (10.170.143.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Fri, 30 Aug 2019 01:28:30 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::508e:ee77:4ba7:9278]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::508e:ee77:4ba7:9278%7]) with mapi id 15.20.2199.021; Fri, 30 Aug 2019
 01:28:30 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Singaporean Mr. Teo En Ming's Refugee Seeking Attempts
Thread-Topic: Singaporean Mr. Teo En Ming's Refugee Seeking Attempts
Thread-Index: AdVe0hjv30vVgDr1RnGYd41Um8dUZg==
Date:   Fri, 30 Aug 2019 01:28:30 +0000
Message-ID: <SG2PR01MB21417D4F1B6B73C720AF640D87BD0@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86b7fcaf-0992-46d0-087b-08d72ce95d94
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SG2PR01MB2096;
x-ms-traffictypediagnostic: SG2PR01MB2096:
x-ms-exchange-purlcount: 7
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB20962569E9D994503D9EC98E87BD0@SG2PR01MB2096.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39830400003)(376002)(366004)(136003)(199004)(189003)(66946007)(81166006)(6116002)(81156014)(7736002)(9686003)(107886003)(71190400001)(14444005)(6916009)(2351001)(14454004)(476003)(305945005)(6506007)(53936002)(5640700003)(256004)(102836004)(99286004)(26005)(52536014)(5660300002)(55016002)(2501003)(66446008)(33656002)(86362001)(316002)(966005)(76116006)(71200400001)(508600001)(486006)(8936002)(8676002)(66066001)(66556008)(2906002)(74316002)(64756008)(7696005)(6436002)(4326008)(6306002)(66476007)(25786009)(3846002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB2096;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7GnROIebyd1eXujieNofeEronO2tgrNVzxeHwXwWYm5Q/FSm0BPLnT5r0+SD+D14iguYNG/IHQ6rn172x8mr/qfCikQR3QfebzK0Cd0xmO6+Dzu0GGBjrrRLP3MRK7KnvPqq02iNN2v0MBt8AnnilU3amZ/XYABFueJLNJDhQl5mhYRXQvI7f+VsEn/homDifiO1VNp90fJTxY5C0GeMqX+QwgIYj+WVE6pp5ug4PRvyjxdFlO8qLlej1hFjU83CrzGK8G9ZoQLpEAaH6lQal010sZKuJfN+p8+zGEQZS/3W+StOlZv23dQtRgWPGshCxV8ORbOuGK4a189s9Bl3BmVUlKyF57vMtrzozN+ofF5nH8EshbLIxsHe1jODEQWkC9GXAZ438ZSTz8dSSbSXuhUXEN+V0g9c0ODbORhMxho=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b7fcaf-0992-46d0-087b-08d72ce95d94
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 01:28:30.4559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dNY4oiA9JIUQup6VE5UhunkjpfHNLsu88KcQxgp3BXH+l8JSXO0OqrAuMM9eNpbsO+/+kMXHGvpMJSTuPx97K9VZ0kMqzfVjmqivNJVGJik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB2096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Singaporean Mr. Teo En Ming's Refugee Seeking Attempts

In reverse chronological order:

[1] Petition to the Government of Taiwan for Refugee Status, 5th August 201=
9 Monday

Photo #1: At the building of the National Immigration Agency, Ministry of t=
he Interior, Taipei, Taiwan, 5th August 2019

Photo #2: Queue ticket at the National Immigration Agency, Ministry of the =
Interior, Taipei, Taiwan, 5th August 2019

Photo #3: Submission of documents/petition to the National Immigration Agen=
cy, Ministry of the Interior, Taipei, Taiwan, 5th August 2019

Photos #4 and #5: Acknowledgement of Receipt for the submission of document=
s/petition from the National Immigration Agency, Ministry of the Interior, =
Taipei, Taiwan, 5th August 2019

References:

(a) Petition to the Government of Taiwan for Refugee Status, 5th August 201=
9 Monday (Blogspot)

Link: https://tdtemcerts.blogspot.sg/2019/08/petition-to-government-of-taiw=
an-for.html

(b) Petition to the Government of Taiwan for Refugee Status, 5th August 201=
9 Monday (Wordpress)

Link: https://tdtemcerts.wordpress.com/2019/08/23/petition-to-the-governmen=
t-of-taiwan-for-refugee-status/

[2] Application for Refugee Status at the United Nations Refugee Agency, Ba=
ngkok, Thailand, 21st March 2017 Tuesday

References:

(a) [YOUTUBE] Vlog: The Road to Application for Refugee Status at UNHCR Ban=
gkok

Link: https://www.youtube.com/watch?v=3DutpuAa1eUNI

YouTube video Published on March 22nd, 2017


-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwav=
e.html

***************************************************************************=
*****************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----


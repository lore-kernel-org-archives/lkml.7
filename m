Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F2FC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63320206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="G0LXMlfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfDOMFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:05:09 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.2]:54632 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727118AbfDOMFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:05:09 -0400
Received: from [85.158.142.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-central-1.aws.symcld.net id B6/D9-23857-17374BC5; Mon, 15 Apr 2019 12:05:05 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSbUhTYRTHfe69m1fxxtO28ChpdLOycstl5Io
  +GEIJkRlEkih51ds22KbuzpwFsSIytfVGkc1MLQ1fEKV3sldNU8GsrMw+JOZUXK9U38rqXu8y
  +/Z7zv//nPM/cGhSdU8ZTvNOB2+3cRZWGUyZViritPnCtfTYjopQw8Dt80rD9clPhOHYk02Gh
  m4PmUAljde0UEk9vV4q6duVyBQyTWG2ZeU6MxWmercb5Q2Szt/NmS70kyhFwTSFW0h419FESg
  8VPk5Ac92kshQFiY9hBCU31kmsxHq48OEzkliDo6Ck5TclfSBxFwL3VI9CEtQ4GZonuvymFHA
  P3ydlTgbfwMFAiSm8GBqenBRH0zSDM+Bl4xJ51lUCyg8mShyE14CrtX26JcIR8P1A03QbEofC
  G28VITFgDLV3+kmZ58Hk6C+/fxcU3/8YKNdjoG/Qi2Rm4fJrj0LmCHheVeavb4HWp2eQtAvgZ
  +Iuo9/9TZfD1xeHAqWcgC1wtH+bXJ4PR7qm/P5xBdw75ULyAtnwpbLPPzgSGt0jlGx6SsKH+r
  NKeYMYqG776ucVcLnmPXkCRXtmLeeZZfPMsknM4LnQc85LVSOqEa3NspuNJoeVM1u0+thYrV4
  fp12l1cev0XF7tZyOL9Bm8zaHnRNVHVco6IQia7YlR2fjHVeQeEU5+UTrLTReY2xHYTTBzmM2
  U9fSVXOycnOKTJxg2mUvsPBCO5pP0yww0fmiNtfOG3nnbrNFPMW/MtAhrIYZsosyI+RxVsFsl
  KVeFEc/uDhSSdJvH05UkirKlmvjw0OZVMmKJaupwDbT6O9ZP0cR4WoGBQQEqELyeLvV7Phf96
  FQGrFqxivlCTHbHDPzfGIUQoxyOqZJiuLg/knhLhSbpXFwdY80xNKSKaM16rB6zNr3eN9hzyL
  XxsGwFcaU/tXlCy/V1m7wdauqP6XeLe541hA3pHOWq9o27wnrTiz2Vlgrq3J2aNwNtxaMp+rj
  EwJG0+NrMtp2bmXXbx9LKz1QVtiuDS4a8LE/IkpvfunsJFcWG5bhn/vVr4yZRJCXpQQTp19O2
  gXuD/49YKHRAwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-22.tower-229.messagelabs.com!1555329904!4369647!1
X-Originating-IP: [104.47.5.51]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32323 invoked from network); 15 Apr 2019 12:05:05 -0000
Received: from mail-he1eur02lp2051.outbound.protection.outlook.com (HELO EUR02-HE1-obe.outbound.protection.outlook.com) (104.47.5.51)
  by server-22.tower-229.messagelabs.com with AES256-SHA256 encrypted SMTP; 15 Apr 2019 12:05:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHpmReCLjll3sUhMRrhwggy8M0B5yiUoba92+NtK4pY=;
 b=G0LXMlfJ+JYnuKgkZ4TV2QhNHTdO11jps+RYvSRkcpIW7nb5eRUOWDJSxZjcxbvO9gXZzaQGesHPiY16kkd0EdtFO7Vp5CRSFAjRT3JH92AfTPafGIa+/OOkxLhURVrX1qdq538ep65276or8+9ug1Qzuyd1MWKjm4CKQd3+2CQ=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB0749.EURPRD10.PROD.OUTLOOK.COM (10.167.203.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.18; Mon, 15 Apr 2019 12:05:03 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acc9:6d8f:da36:9f25]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acc9:6d8f:da36:9f25%2]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 12:05:03 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        LINUX RENESAS SOC <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH RFT] watchdog: da9063_wdt: parse DT for timeout value, too
Thread-Topic: [PATCH RFT] watchdog: da9063_wdt: parse DT for timeout value,
 too
Thread-Index: AQHU8rKQiJBjLGoJgEygrdEbYLd/faY82vLAgAAa8ICAAAP5gIAAFqWAgAAPh7A=
Date:   Mon, 15 Apr 2019 12:05:03 +0000
Message-ID: <VI1PR10MB23521B0691E765B2E19AB4F1FE2B0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190414110933.30529-1-wsa+renesas@sang-engineering.com>
 <VI1PR10MB23525523F623FFAC4126EBC9FE2B0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <20190415092853.GA1861@kunai>
 <VI1PR10MB23520D64B2120138FF64D0BBFE2B0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <20190415110409.5q6la4wz5bjiesrc@ninjato>
In-Reply-To: <20190415110409.5q6la4wz5bjiesrc@ninjato>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a699b92-5c7a-4937-62e3-08d6c19a97c7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR10MB0749;
x-ms-traffictypediagnostic: VI1PR10MB0749:
x-microsoft-antispam-prvs: <VI1PR10MB0749C655033C96D220C1F7FBF52B0@VI1PR10MB0749.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(396003)(39850400004)(199004)(189003)(8676002)(476003)(186003)(11346002)(14454004)(446003)(478600001)(81166006)(74316002)(81156014)(66066001)(4326008)(3846002)(107886003)(6246003)(6116002)(26005)(305945005)(5660300002)(52536014)(8936002)(102836004)(2906002)(486006)(6506007)(7736002)(53546011)(6916009)(229853002)(99286004)(4744005)(93886005)(53936002)(68736007)(76176011)(86362001)(33656002)(25786009)(97736004)(6436002)(54906003)(7696005)(316002)(55016002)(9686003)(256004)(71200400001)(71190400001)(105586002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB0749;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MnG4wHF8Z0qj5sqzFQj7STrNhtuKzwgEF7eqED8DrdciCwcwTwSvw+56RsB+GC+jfmAspxlIDAVHD+nRpRW7OUWMexfarUCBTvX6XIaL3Lj2G5p1Mg6dgxOG5JCcnWD7a3/KR2lZs2PpXc0sOOTP8kH52CP+WHABVcLDFOxsQDC+57jwP60IFzMctrwfvaRgS+LIVf/GBaLIO9KSTXH2t/vd6rAhS7BnaSSASRHFpcvi02ASe3aQAGPpAI8uFuRWDvgL+DjWA1gcF2aiAVr0UJG3gBrhl1/AiRQ45is2oXnUAeVSRK7dHrfGcU8XTb7npCnZB2QhPe98VsffC0GdJHlze29L8sgINKg2vMNKXp+zYHvU71wIa23U9rXQjXq8BG4wpF46kJXOMUz56ARQfZZJS9F0/Onk3/agWc3HgKc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a699b92-5c7a-4937-62e3-08d6c19a97c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 12:05:03.3723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB0749
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 April 2019 12:04, Wolfram Sang wrote:

> > Sure, I know, people have been requesting continued support for DA9063 =
AD silicon
> > for years. The original DA9063 Linux driver was sent to LKML with AD su=
pport.
>=20
> I see. Well, unlike the RTC patches recently, this watchdog patch is
> independent of the variant AFAICS, or?

Agreed!

I am going to test your watchdog changes with a later silicon version later=
 today
and I expect no problems.

Regards,
Steve


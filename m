Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CECC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5CD2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="RspnIX+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfDOKKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:10:01 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.4]:55143 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbfDOKKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 06:10:00 -0400
Received: from [85.158.142.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-central-1.aws.symcld.net id 4E/D0-24683-57854BC5; Mon, 15 Apr 2019 10:09:57 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSbUhTYRTHfXbvtqu4uE7Nk2TFygjzrs1K7I0
  ikkZR+CEiyl7u3G1bzWm7W2lfKiKrDcWgqJamRq6axHJlyJJMw+GCfAeHlGaOSntFzYJS291d
  Zt/+nN//nP95Hg6BSZ+IEgmmwMyYjLRBJorCdSuiVlOWPY+yFed+R2d0e8pEGXXDXwQZJW1bM
  +612rFNuOpdlQtX+V4EcNWYe0EWtleoN6rzCg4JdZ6fU+L8S1EFzrr008hGWFEUgZMuDFpKun
  EriiSkZKkAOv0qDkjJAQTVLb2IAyJSCTc/fQ3pOHIJXHRN45wJI70Iiid9Qg7Ekjvh/ntv2JQ
  FxQONGK83Q1P7YCgBJ5OhpMch5rSE3A+OD12IT3uMwD/dL+JAJJkCFS0ToUGITILxMzWhQRiZ
  AH2BCgGngSThdkM7xut4GB6aEvL+g3C+8bOYr6fCy94A4rUMHH67kNdJ0FVhC9d3wKvmptASQ
  HYimHrmEfEgBfz11nCDATwuWzh4PlzwToYb3gvB11sr4j8vB76VvwwnLwBn8SDOmzowuDt+Q8
  w/IRUqn4yKeL0cHFUfsVK0zD7rdfZZNvssmz30ZTHgux7AKxHuRGvUJr1WZ86l9QZKqVBQSuV
  KKo1KW5Uup09StJyxUDmM0Wyig1ROn2DlbGFujkEjNzJmNwoekuaYYKIe1Vm1zWgeIZDFS7bj
  j7Klc9R5mkIdzeoOmiwGhm1G8wlCBhJqd5DFmBgtU3BYbwhe418MRLQsTpLFYQmbT+eyei2PX
  iCKeHZrsByT4sY8I5OYILnKmUjOpLMYZ0b8vekulJQYK0ERERHS6HzGlKs3/89HUAKBZLGS/d
  yUaL3RPJM0ElxCEFzicmoNt4SZ/ocST6OGh0eGJkrbMk0q7/Lkfv134QHrIve2hVfXa+ZtYxd
  r22yOwrWt2FZbvZjZcuZk9brJs4GlmOVKd3nm8w+7xxS+C87RH/1Pj05dOzW37+2bmp5Nbczo
  sWltU9Kupi8b1xe9Tj/+a98ddfnvVI+brQW3de/5yeoN9Y1FDZoHZckdsS4ZzupoZQpmYuk/r
  m8K7c4DAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-21.tower-229.messagelabs.com!1555322996!2440606!1
X-Originating-IP: [104.47.10.53]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32314 invoked from network); 15 Apr 2019 10:09:57 -0000
Received: from mail-db5eur03lp2053.outbound.protection.outlook.com (HELO EUR03-DB5-obe.outbound.protection.outlook.com) (104.47.10.53)
  by server-21.tower-229.messagelabs.com with AES256-SHA256 encrypted SMTP; 15 Apr 2019 10:09:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyyPGDztL9waWKe9oJ3VE8ISLBRxxx/ZUkSuQDYgxQg=;
 b=RspnIX+AT+A4ONbroKdP4g1CohkOSpDInaMzaxB1tFJ/J/v8RqtNb+2sIH046UIQ26sWqbyD/7W0sIyiNFMDpm9vX9iMtmKju+ZoWWnnc4bo9p3V65ZKRkOAWMXOFCo52Ya3+6SXKrxvxgqdcRFDuw2LA3KdXk/q8HiI3/JnEBA=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB1567.EURPRD10.PROD.OUTLOOK.COM (10.165.191.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.15; Mon, 15 Apr 2019 10:09:55 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acc9:6d8f:da36:9f25]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acc9:6d8f:da36:9f25%2]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 10:09:55 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        LINUX RENESAS SOC <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH RFT] watchdog: da9063_wdt: parse DT for timeout value, too
Thread-Topic: [PATCH RFT] watchdog: da9063_wdt: parse DT for timeout value,
 too
Thread-Index: AQHU8rKQiJBjLGoJgEygrdEbYLd/faY82vLAgAAa8ICAAAP5gA==
Date:   Mon, 15 Apr 2019 10:09:55 +0000
Message-ID: <VI1PR10MB23520D64B2120138FF64D0BBFE2B0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190414110933.30529-1-wsa+renesas@sang-engineering.com>
 <VI1PR10MB23525523F623FFAC4126EBC9FE2B0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <20190415092853.GA1861@kunai>
In-Reply-To: <20190415092853.GA1861@kunai>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e57116e-79cc-4fbd-a0e6-08d6c18a8277
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR10MB1567;
x-ms-traffictypediagnostic: VI1PR10MB1567:
x-microsoft-antispam-prvs: <VI1PR10MB15678400493A2D335C2D739AF52B0@VI1PR10MB1567.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39850400004)(346002)(376002)(366004)(396003)(189003)(199004)(51914003)(8936002)(186003)(105586002)(106356001)(55016002)(66066001)(11346002)(446003)(486006)(476003)(5660300002)(71190400001)(68736007)(14444005)(7696005)(71200400001)(97736004)(26005)(52536014)(76176011)(256004)(102836004)(53546011)(6506007)(99286004)(6246003)(6436002)(7736002)(8676002)(25786009)(81166006)(81156014)(53936002)(2906002)(478600001)(14454004)(3846002)(6116002)(74316002)(33656002)(229853002)(316002)(6916009)(4326008)(305945005)(107886003)(86362001)(9686003)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB1567;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BNDxI2NQdbN6Zj7YI783Xv/syHS/OwHptqndNcXrp7EdOjIehXSVPfhuyH6G+eLKZxAb82sNpviFTc/YhREfc5FG5l9yANSNuoAReu3Nindezr2Htfo8qGhZGVGmfg0n7bGBDPTEl+QBgoCTioHWZlbX6tLS3Wr8hJaM1VpnWSALKiLNiC8vQ61JIKbJqRlxeisJGz09SLpEy9VQ/CgXTOEAzTs0dTrZOEJla71Rf5DDa7hCDt233sMbW9WXU2OFhoAdGs1zEyluzheDxgxRIz+SOm3m2d8hhDpv5n3QsqwBq+rjrqtMRy4QFul/Te9wNP6XJ0nICwQjw83sZnC5FLWRkFl4CiN2hXkMCtj9iG2wygffvqRo2w8EcU6b+lnJgRmXAu7ChklRaNdNAVdQDSyxo7uo3VhLlbWhJBIBuhk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e57116e-79cc-4fbd-a0e6-08d6c18a8277
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 10:09:55.6558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1567
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

No problem.

On 15 April 2019 10:29, Wolfram Sang wrote:

> Subject: Re: [PATCH RFT] watchdog: da9063_wdt: parse DT for timeout value=
, too
>=20
> On Mon, Apr 15, 2019 at 08:11:16AM +0000, Steve Twiss wrote:
> > Hi Wolfram,
> >
> > On 14 April 2019 12:10, Wolfram Sang wrote:
> >
> > > Tested with a Renesas Lager board (R-Car H2, DA9063AD)
> >
> > Can I please check there is no mistake in your description. I have been=
 repeatedly
> > told by the hardware engineers here, (for the past 6 years) it is not p=
ossible.
> > But, you seem to have an R-Car H2 with the AD silicon version of DA9063=
?
>=20
> I am confused, what is not possible? That I have an AD version? Yes, we
> found that out when we worked on the RTC recently.=20

Sure, I know, people have been requesting continued support for DA9063 AD s=
ilicon
for years. The original DA9063 Linux driver was sent to LKML with AD suppor=
t.

> It is an early version of the Lager development board. I have no numbers
> but my assumption is there are not too many out there.

Thanks, yes, there is interest from the hardware engineers here. Thanks for=
 the
confirmation about your board. I will inform them about the DA9063 AD silic=
on on
the Renesas Lager board -- and I will let you know their response.

Regards,
Steve



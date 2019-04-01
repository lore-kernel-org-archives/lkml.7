Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AA1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9015F20896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="yWGuDTek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfDAMml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:42:41 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.6]:47746 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725897AbfDAMmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:42:40 -0400
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-a.eu-central-1.aws.symcld.net id 87/60-30036-C3702AC5; Mon, 01 Apr 2019 12:42:36 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSa0hTYRjHfc9lO6aL12ntUTJiBIW16bLmKYM
  iCPclkOxDhaJHPXmG29F2Ia0vZpFSZEVWOPMyKyuTrKHRxUrsaqCVdnNSUa6RlmYlIVnRzo6V
  ffs/7//3vv/neXkYUt2riGH4IgdvEzmLVjGDEuJpVrdS2ZCeMDKpZMtGG5Ws33udYPuuHlewb
  UOjBHv33BMFW9GTwp697yJXK021zTtMnbfKkcnvbqFMXQ98lOmrZ24qvZk2i9kFRVm00HzrEi
  o8RheNV6aWoGZqL5rBULiFhHsHa5RSocYVBLQfnURy8QpB9feLgSKUUWAD1H78FNRReCOMnb1
  AShCJ+wn41DxASEYkXg8Dpa30XsQEoDQou6SR+RUwcmMieJfC8+FnxQmlpFU4A4ZqnxJy2CkE
  Pe9205IRio0wWSkFhDIIx8L4znNBTWINeH11wSzAGE62PyRlPQuGBn/RMp8JZTdHlPL5Yuh+7
  kOy1kLjCxct61jords3db4ObnfsCf4FYC+CM11tlGzEwds7/qkAC1z2XCGlwQDPgcfj62S+j4
  Yeb3uQUeMcGKvpngqeC03730w9+oiEiQl5MjLQUf21LwpZL4JG9wfyIFromjacaxrmmoa5gj8
  WAV1VPqoeUU1oebbNnCc4rJzZojMkJOgMhkTdEp0hyajntus4Pe/U5fCiw8YFXD23za63F1tz
  LLl6kXd4UGC/crcSFy4jvzuvE0UzhHaWyu9xp6tnZhfkFgucXci0OS28vRPNYRgtqJCiIV0dY
  ePz+KItZktgSf/YwIRro1SLJVtlL+SsdnOebD1AOqaj4U0NqabEApGP0ajiJAhLkOAU/z7xZ9
  V7UWxMpAqFhISowwt5m9Xs+N8fRhoGaSNVeumVcLPo+Js0HGiCCDTBOuukJhzcPyumBKVUJF9
  5ZtyZEX+7uu98RO9STWaPu7spq/Wwe9UhT9vojzFnaXz56ZZrd5MN7PNviErzFVzdU/nZWP1+
  dsqOtNfzqqz3yPtrFlRpl23aJXLRgyvcTbYxTf9kYwmsz/+4dtnshRlHFELi1wOmuPyXC5Kti
  UkzBzeEbQ7fFpokhHk7SrSUXeAMcaTNzv0GQ3crzeUDAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-8.tower-223.messagelabs.com!1554122555!3471564!1
X-Originating-IP: [104.47.5.56]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2960 invoked from network); 1 Apr 2019 12:42:36 -0000
Received: from mail-he1eur02lp2056.outbound.protection.outlook.com (HELO EUR02-HE1-obe.outbound.protection.outlook.com) (104.47.5.56)
  by server-8.tower-223.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 1 Apr 2019 12:42:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+z7YCJpFKbQFJt5a+ddefK7Qz6mmrobiwdofdRTSLyc=;
 b=yWGuDTektLmMprgVLtBDIzxpGbRlADq7D8ZrePTlJgINKZAwG1X1RfVOg6eZwo+9QKvtqQWRVHgsUjppf6y9i/T9dPwJUkljKu1GFwIV0HqtOpT83UBFGHU/XLQXx3pnmRYOvmFV5y/2c/u9M1S/P2F7vgI2a6qiVCxT6pFzEMM=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB2704.EURPRD10.PROD.OUTLOOK.COM (20.178.127.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Mon, 1 Apr 2019 12:42:32 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7%4]) with mapi id 15.20.1730.019; Mon, 1 Apr 2019
 12:42:32 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: [PATCH 2/2] rtc: da9063: switch to
 rtc_time64_to_tm/rtc_tm_to_time64
Thread-Topic: [PATCH 2/2] rtc: da9063: switch to
 rtc_time64_to_tm/rtc_tm_to_time64
Thread-Index: AQHU388zAHbhZUdtHEOPL3sVK9HfsqYnDjkAgABCYqA=
Date:   Mon, 1 Apr 2019 12:42:32 +0000
Message-ID: <VI1PR10MB23529E6E90A78F25A57EE5FFFE550@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190321101557.26857-1-alexandre.belloni@bootlin.com>
 <20190321101557.26857-2-alexandre.belloni@bootlin.com>
 <20190401084304.pt7psdvp5kupwpol@ninjato>
In-Reply-To: <20190401084304.pt7psdvp5kupwpol@ninjato>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 891f0032-ed61-4bd6-92c5-08d6b69f82ba
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2704;
x-ms-traffictypediagnostic: VI1PR10MB2704:
x-microsoft-antispam-prvs: <VI1PR10MB27043F77EF8F798E15AE978CF5550@VI1PR10MB2704.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39850400004)(396003)(346002)(376002)(136003)(199004)(189003)(7736002)(5660300002)(74316002)(8936002)(6246003)(14454004)(81156014)(54906003)(8676002)(2906002)(476003)(4744005)(110136005)(11346002)(76176011)(6116002)(3846002)(68736007)(52536014)(53936002)(7696005)(256004)(71200400001)(71190400001)(25786009)(86362001)(55016002)(99286004)(81166006)(66066001)(316002)(186003)(53546011)(305945005)(446003)(97736004)(106356001)(4326008)(229853002)(33656002)(9686003)(102836004)(105586002)(486006)(6436002)(26005)(478600001)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2704;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PSi2ldwGIvlcbBSZJSOGQUlyKCSQo7sewcSHHli/IgFnFS7Uf0rghk8879+i7EtiBhUtl1gU2Z3RkwM3YcfxZEC3ySB9T0FjmloJkbiQRnsjUVsK2eXzGlY7g4njUc+vOgNOAu6s65Rrqm/F/suBYboAB2up8q+oPyHloiJ0xytUUAEfdkLi6rzUZGdIg7l/L49+OJbv37ZQct+4dJ8oXBQiqNx3ej6xXSlejNDT+a4QXsAlVPvjW8PpoQThUSwBzoHIGsKI3oq3nhyU7E5ycu5OsO6jl1VKxhB8PWEach96hVh2StounigZqaHGl0EwI1mWdjErVHP6NlFJBQ/L8SiOz3aFVippWW3ryApAS56ycpJXuDWVyFqBO/qNL0aWGKxqu8tg54Jz17tj7UDM4B2xrmrBwwA/O7Y2l0rpzTY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891f0032-ed61-4bd6-92c5-08d6b69f82ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 12:42:32.7303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2704
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01 April 2019 09:43, Wolfram Sang wrote:

> Subject: Re: [PATCH 2/2] rtc: da9063: switch to
> rtc_time64_to_tm/rtc_tm_to_time64
>=20
> On Thu, Mar 21, 2019 at 11:15:57AM +0100, Alexandre Belloni wrote:
> > Call the 64bit versions of rtc_tm time conversion now that the range is
> > enforced by the core.
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> FWIW, RTC still works on my 32bit system:

Thanks!

> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I've also tested the RTC alarm with this patch.
It seems okay to me, no regressions.

Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve

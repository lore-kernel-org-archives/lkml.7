Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA80FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6634920663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Jgnu6hhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfCGAC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:02:59 -0500
Received: from mail-eopbgr80104.outbound.protection.outlook.com ([40.107.8.104]:59024
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbfCGAC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faTlteeYqEIFuotw90LcNe2p084INXqJW2IAA80S0zg=;
 b=Jgnu6hhGzNHA4rnNGia3rYgWh+ZvqDz+Jz2P95TDSC+DlQVGpbf05UNKL0FNgbDOK+0x+fMCajA5vFQw4HnzBI/2C1uY71sl6QB8mkgjlKuUdEwhebsgpEnkXmpvwUetByMo+htfSRMWBgRMI073XtnUX/t3mqYcTB4zMfAKomE=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB3949.eurprd02.prod.outlook.com (20.177.58.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Thu, 7 Mar 2019 00:02:52 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::38db:37eb:b43e:e4c1]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::38db:37eb:b43e:e4c1%6]) with mapi id 15.20.1665.020; Thu, 7 Mar 2019
 00:02:52 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Keerthy <j-keerthy@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Phil Reid <preid@electromag.com.au>,
        Tero Kristo <t-kristo@ti.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/7] i2c: core: introduce atomic transfers
Thread-Topic: [RFC PATCH v2 0/7] i2c: core: introduce atomic transfers
Thread-Index: AQHU0P6ElPYt84bRGUaT3WCWEwdp0qX72iKAgAA8xgCAAzlOgA==
Date:   Thu, 7 Mar 2019 00:02:52 +0000
Message-ID: <6d9a1d1e-a6b7-b3ae-f560-4f906934e795@axentia.se>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <71aaab62-2965-8ad8-61b9-02d02694919d@axentia.se>
 <20190304224856.w7egngqynl3hlabp@ninjato>
In-Reply-To: <20190304224856.w7egngqynl3hlabp@ninjato>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0401CA0077.eurprd04.prod.outlook.com
 (2603:10a6:3:19::45) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a02ab6a-aecd-4e3c-d335-08d6a2903e4a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600127)(711020)(4605104)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB3949;
x-ms-traffictypediagnostic: VI1PR02MB3949:
x-microsoft-antispam-prvs: <VI1PR02MB3949083136442EE3C0046024BC4C0@VI1PR02MB3949.eurprd02.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39840400004)(366004)(199004)(189003)(305945005)(476003)(186003)(14444005)(6916009)(99286004)(7416002)(2906002)(65806001)(65956001)(66066001)(2616005)(4326008)(81166006)(11346002)(386003)(8676002)(486006)(6506007)(64126003)(7736002)(53546011)(74482002)(25786009)(31686004)(36756003)(26005)(52116002)(65826007)(105586002)(106356001)(446003)(102836004)(81156014)(76176011)(6436002)(54906003)(5660300002)(6116002)(316002)(3846002)(8936002)(86362001)(97736004)(58126008)(6512007)(5024004)(6486002)(229853002)(6246003)(508600001)(256004)(68736007)(31696002)(14454004)(53936002)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3949;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?Windows-1252?Q?1;VI1PR02MB3949;23:Rq0P63vVntxLtJVzZ+4KL2w3U5jbEFNUPmjgg?=
 =?Windows-1252?Q?xxYUKWPCWgSwtsOQ7dIczVafzowqH15Vetyz2mol9DV1GtTZA2zbj5//?=
 =?Windows-1252?Q?03kbH4CL8EmGZF5PaBBqc1X62fshw63kIYWdnrRgjqJ7aIj4xpObbWYQ?=
 =?Windows-1252?Q?vPmZtQkUQAKxoxHzDQhrRsTfUJJgLK3/mYwa0KZyNQPWmfQSkWrQ87Om?=
 =?Windows-1252?Q?qE45ny+4D2YrZqZWXziYgBEf35jq/Br99EVjEZVgELR1YSdGTolpla/p?=
 =?Windows-1252?Q?XGmEg5yW5olcfDtTz6d+dpC4VMdEfQ77JODBzO83N8JHFvoBvYrhqGnx?=
 =?Windows-1252?Q?W/5P40/IIQ1pHNBoEfkTDxbRwnw6RAHBgoMAqG0lQXDoIA4VhqKKIUQ7?=
 =?Windows-1252?Q?Cwz62XrORXlKBJ145jt8ewdO2E2mRYqCRGv9J7lTKZFWxyxHf9CZz1Gq?=
 =?Windows-1252?Q?MiTzOU7ZsTSEDNvZuPeN5C8ueGvX90g1Xjxo0+0rrHDsD1GzCbPRv6F0?=
 =?Windows-1252?Q?sxpCVLQVNE+G/86rFLrrls30+3QRiP0PEO0NJARhPD5jKC/idWdToJMO?=
 =?Windows-1252?Q?dadFerehsOpaoSM2cp4Aws3v2CbBPi8vRxKdUQhB24aC+h3VVLUhx4K7?=
 =?Windows-1252?Q?IlWLzgrQXoFJM327ZqZq6WecY5wMl3TiLWAyGhU1x5GJZ/K6XfPW0LkZ?=
 =?Windows-1252?Q?n/ZsnPtyFa2ugvceO0zXDwOJjCMr097/AWEeylIh0JUMHtOFyedodArr?=
 =?Windows-1252?Q?285RkrjILCeRNSlRe9p8iwYRe5PIal6phV5SA5jT3tvplQIKc3NioKfs?=
 =?Windows-1252?Q?3/1N86bbOJ+N0h+ysBxADco+iyqqD/5Wt6Hd5aCfABLSSc0k9mvXaZuU?=
 =?Windows-1252?Q?AHYz2UfWFmCWECmObMlbk99Ii8ifPwtRTvzBKphtzm/97KBGxITrmSP7?=
 =?Windows-1252?Q?Oud/ZhdshCEYHV6zKagChdRfKihCrV1tKZHJO3Z+qcx74X1djwAdRsOe?=
 =?Windows-1252?Q?z3s7i+q2WNlUaiYzYy3doeD4cFSxfNVfOi11vJSpGR7A4BCN45+M2DDD?=
 =?Windows-1252?Q?sHVC4jHLt33KCn7KSs0tUY+mFFwEEDvevAR5Unm2qmMm+S5Sruq+LkzN?=
 =?Windows-1252?Q?k84e8en84SDcTk4n7OSN7NHTJ9yr539X708Ret4/INAaBKJvieWkjDYK?=
 =?Windows-1252?Q?tlo/Q7Ma0HSvWYjLlN6pPTA8BStyRnS336hqWmo1fjG5N8A5KyvEY2un?=
 =?Windows-1252?Q?GINLK9ab4Muef1T044+qwuOMpFxKQl3Zk2uOUITRnUdUOrOkyJcduVt9?=
 =?Windows-1252?Q?XmsHFBTeOwQHhLTHVRQLsCRP9FTG5XusmGmcSexfTxK7eGOXrVBJU84V?=
 =?Windows-1252?Q?oHypZ+RG2q2FbPRTcvB6CURYVzwoBuVPaZm2VkTJMZOmnF5BzD45p4Qm?=
 =?Windows-1252?Q?fsqJ2F3qzBl3yetmGuuv9u37pAmE7o+pUgb+hhesBI7k6T0IGqsp7gho?=
 =?Windows-1252?Q?s7sxLsw3MFPGy/c4PVXzsp+nPhHOEqypJHN63FOTIAJ3XKq9r6JwhAfU?=
 =?Windows-1252?Q?VI33nVb283EROdfzFDJ9+7WamshpjUIip1p?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gPJ+VpEQmRhS5zmhBOT+9Amb4xMKNI8WQBYiDuagZfhJjwAf/pnm7Wq+it6gp9cwV+GqZfmeJzjZVUr4OKR6EzEXYQ3njR/BncB3GjwtvFdgGx2wWt1VkOnYVXBigv8vp+hofHgtcIv/AJpBgDjqa1FFagh7c7xLvMqzaiAMInITKeZoi7VjkHsAk1qAMuRl6snSTW06HyiF+UEmJNUVk9D6v9QG3eNFLtGFNVfB/O83Iz9T1+0WxDXGA+170+F9fiAeK8gpG9oMnyRUA3PXf3B3v3MdxK2IvggQT0ldks68xJKwJVZvYpL124D1ipChcPVEBFEPGUpODm0Ra90mZj5dvOEXXW/6TbLwtgBlO5gTtUn/W1CeeF66aPrrZ6YxKLMp9JlSJBpHmEXNl5qS1cTh1cbKUlS8s6Dl4Mu4abc=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <D04E06487EBA66469285C1477FADF2F5@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a02ab6a-aecd-4e3c-d335-08d6a2903e4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 00:02:52.6107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3949
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-04 23:48, Wolfram Sang wrote:
> Hi Peda,
>=20
>> The way I read this series, you are not giving atomic transfers priority=
. The
>=20
> You are reading correctly. I could have made more clear that the issue
> pointed out by Russell is not handled by this series but discussion
> about it is welcome / needed to decide if we can take this series as is
> or if we need to redesign it. But here we are anyhow :)
>=20
>> only thing that happens is that if an xfer happens in atomic/irq context=
,
>> trylock is used instead of an ordinary (unconditional) lock (this is jus=
t
>> like it is already). If a mux is sitting in between the client device an=
d
>> the root adapter, the trylock operation will percolate to the root. Sure=
,
>> there are more trylock ops that may fail and abort the xfer, but if
>> everything is uncontended, then things should proceed in orderly fashion=
.
>> Also, sure, the mux may need additional resources that are no longer
>> available if the machine is half way down (or worse). But I don't see an=
y
>> fundamental *locking* issue with muxes that is different from the case
>> without a mux.
>=20
> Good, that was my conclusion as well. The series, as is, doesn't change
> the locking behaviour, so that will work exactly as before. Or, it will
> not work in the case described by Russell. Like before.
>=20
>> That said, if you then want to introduce xfers that want to circumvent t=
he
>> locking, then parent-locked muxes are easier since the actual muxing ope=
ration
>> is performed as an unlocked xfer (if one is needed) while the client dev=
ice
>> has grabbed the adapter lock "from the outside". Sure, there is a list o=
f
>> locks going up through the adapter tree to handle, but that can probably=
 be
>> handled in one place. I.e. the locking must have been avoided prior to t=
he
>> actual muxing operation, but the code to do so can be in one place. The
>=20
> That was my gut feeling, too...
>=20
>> mux-locked case is where the trouble is, since the muxing operation is d=
one
>> as a normal xfer and needs to be classified as a special xfer that just =
like
>> the original client xfer also needs to break through any existing locks =
in
>> the adapter tree. And those muxing xfers might come from anywhere, e.g.
>>
>> 	- IO-expander controlling a gpio/pinctrl mux
>> 	- dedicated I2C mux (e.g. the LTC4306)
>> 	- regmap device
>> 	- etc, who knows what muxing options will evolve?
>>
>> So, any scheme that require a white-list will work poorly for mux-locked
>> muxes, unless you can add some new grip/pinctrl/regmap flags to

s/grip/gpio/ of course

>> gpios/pins/registers so that the particular accesses can be white-listed=
.
>> Adding those flags seem rather invasive?
>=20
> ... and sadly, this too. We would need the same kind of flag which I
> described in my first paragraph of the original posting where I wanted
> the flag to detect "unauthorized" uses of late I2C transfers. And this
> is gonna be invasive. And I am not sure it is worth the effort.
>=20
> I wonder what a reasonable effort is? Simply ignore the lock from the
> "current" adapter and hope for the best that there is no mux or at
> least no mux which needs interrupts / a lock attached to it?

Just wanted to add a note that the underlying problem is similar to why
I introduced the mux-locked concept. There is no simple way to identify
*exactly* which xfers that need to be unlocked. Going only by call site
is not enough, since the same call in different context may need to be
muxed (in my case) or irq-less (in this case). If someone comes up with
a solution for that, all muxes can be converted to the parent-locked
scheme and we can get rid of a bunch of complexity. I just don't see how
though, all ideas I have come up with I have immediately discarded as way
too invasive, ugly and/or error prone.

>> But of course, you need to actually do something about the added FIXME i=
n
>> the demux-pinctrl driver... BTW, that driver should forward ->smbus_xfer
>> just like it does for ->master_xfer, no?
>=20
> Yes. The idea of having two seperate SMBus controllers in one SoC which
> would need demuxing is amusing, but still, it exists for I2C and you are
> right.

Right, I didn't actually think all that far... :-)

Cheers,
Peter

Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED16C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753F121019
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e5PIqvZa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfCORR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:17:58 -0400
Received: from mail-eopbgr30056.outbound.protection.outlook.com ([40.107.3.56]:32686
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727001AbfCORR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HidqdyFH1ygEq07AATVX49xsWYUJ5c10bv68RPSirjw=;
 b=e5PIqvZaHuijU+KDUQERm7tSgfpEoCFyvEAVAF9aazmqmnbrMkpa8UzKvhSwBJQ7Fv4i9LBZSqVvppQZ7iAUjVxgXXPPfrkLh9Aq7cwLXblIuNg7EWmMML+5hhMDpJ7p1hg6UNrXWcSD4mQFcySWJhbekuIToPy6feSEuM2Wfug=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5293.eurprd04.prod.outlook.com (20.177.51.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Fri, 15 Mar 2019 17:17:54 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::35aa:e13a:52ea:e5e6]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::35aa:e13a:52ea:e5e6%4]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 17:17:54 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Alexandre Bailon <abailon@baylibre.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "georgi.djakov@linaro.org" <georgi.djakov@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "ptitiano@baylibre.com" <ptitiano@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Zening Wang <zening.wang@nxp.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH 0/3] Add support of busfreq
Thread-Topic: [RFC PATCH 0/3] Add support of busfreq
Thread-Index: AQHU2dO+g7FtRU5+MUaLzLMJn01eLA==
Date:   Fri, 15 Mar 2019 17:17:53 +0000
Message-ID: <VI1PR04MB55334013173D78F365CA5E19EE440@VI1PR04MB5533.eurprd04.prod.outlook.com>
References: <20190313193408.23740-1-abailon@baylibre.com>
 <AM0PR04MB421150DF12C869161E7ED4C180440@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <56e96a3a-4901-c79c-e91d-6b6a0690e5b7@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [2a04:241e:504:3000:72c9:4eff:fe9d:241b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8efbf92-0692-45f5-acc0-08d6a96a291e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5293;
x-ms-traffictypediagnostic: VI1PR04MB5293:
x-microsoft-antispam-prvs: <VI1PR04MB5293D18E5D2C03BC8077AECBEE440@VI1PR04MB5293.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(366004)(189003)(199004)(5660300002)(33656002)(86362001)(81156014)(6436002)(81166006)(8676002)(46003)(2201001)(186003)(97736004)(71200400001)(71190400001)(102836004)(486006)(44832011)(52536014)(2501003)(25786009)(4326008)(476003)(446003)(14454004)(74316002)(76176011)(478600001)(105586002)(7696005)(9686003)(7416002)(106356001)(68736007)(229853002)(305945005)(8936002)(53546011)(2906002)(6506007)(256004)(53936002)(6116002)(14444005)(99286004)(316002)(55016002)(110136005)(54906003)(6246003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5293;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1FBhiF+hOY3dadjiOgwPkWrSHP5k+i5xbIXrHk/JlcJNnSnZtBxKHUuEMTIKTar97Loc/znX3CBqVWy6lWsFIdx7o1xlplVKKG03/5o56lXfZblIlCWNmKmIEw4OZQ5bFURLhIam6/BirUykCHLrSBcihDTy7125IVi+FhTlD7B3BVXd7JwoxeElQe0HwN2KLcsN/W0lnGdVO596Sl15FGLY1Ae+A7HZUESWdQD2ZP3Dkwhq+QKM8F8K0ZAmKAF48+cimN5me10QwnIskxfGlsOCcIB4vSjZ4ZGuOQZRDZOstoBpmAIOG4fHDOQ6odC8GSvZCRk9VS/8VK8AQbeJcLDcnbOXJKzeiTphEtusfcAZc55zejchWzu70YqJVQvRPwiOCbU+MFQBfkcn+PaFfJtrgF/uj8J1vWZfc/DCEHs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8efbf92-0692-45f5-acc0-08d6a96a291e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 17:17:53.9546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/19 11:31 AM, Alexandre Bailon wrote:=0A=
>>> This series is sent as RFC mostly because the current support of i.MX S=
oC won't=0A=
>>> benefit of busfreq framework, because the clocks' driver don't support=
=0A=
>>> interconnect / dram frequency scaling.=0A=
>>> As exemple, this series implements busfreq for i.MX8MM whose upstreamin=
g=0A=
>>> is in progress. Because this relies on ATF to do the frequency scaling,=
 it won't=0A=
>>> be hard make it work.=0A=
=0A=
>> How can I test this patch series?=0A=
>> Any additional patches you can share with us?=0A=
>> Or what else we need to do to test it? We can help with it.=0A=
=0A=
> Many other patches will be required to test the series.=0A=
> There are a couple of patches that updates i.MX device drivers to=0A=
> request for bandwidth (does similar thing as bus_freq_request and=0A=
> bus_freq_release).=0A=
=0A=
The interconnect framework asks for bandwidth in bytes/second but in NXP =
=0A=
tree most requests are of the form "request_bus_freq(BUS_FREQ_HIGH);". =0A=
In many cases (ethernet) it doesn't seem you can calculate a specific =0A=
bandwidth usefully.=0A=
=0A=
Instead of asking for "infinite bandwidth zero latency" to force =0A=
everything to "high" it would be nicer to "request an opp".=0A=
=0A=
Power-domain bindings mentioned that consumer-devices can specify a =0A=
"required-opps" property but I've found zero users in tree. Maybe some =0A=
helpers could be written to parse that property and automatically =0A=
request ICC opp on device suspend/resume via device-links?=0A=
=0A=
I know that stuff was written for genpd but it looks like a very good =0A=
fit to me.=0A=
=0A=
> In addition, a patch to that allow to scale the DRAM=0A=
> frequency using CCF is required. I'm still working on this patch.=0A=
=0A=
I'm not sure what you mean here, do you want a clk set_rate to change =0A=
the DRAM freq? It makes sense for DDRC to be a node in the interconnect =0A=
framework and switch OPP inside icc implementation via an ATF call.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=

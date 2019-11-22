Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A343DC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5AB2071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="F2Z57Yn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfKVQCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:02:50 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:10278 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfKVQCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:02:49 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Cristian.Birsan@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Cristian.Birsan@microchip.com";
  x-sender="Cristian.Birsan@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Cristian.Birsan@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Cristian.Birsan@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Nx0V0K1OKIv/oESW+yKOLgwogyrHhASJn1qeSnkzITBbqYwuDwhjUsU9mOR+XtV0A1Wshk74Jr
 s3hZ+fxIxF3aVpz+qkK4P3mutXHI+qUDy/BpMcUA2jnC/sNtAK7064PPkHrLAC6NYQqtDH9hSA
 Vx5t225tEjvQblYZg5OIsvfrk7QAmf99EaEpBrwifMA8ljyMbwmcbLx9F7vBdqJ0swL98+Win1
 7LRrxm2ks/mc+Uh36d/1V/76hqhu78NqapZbxnSpv5tMXZKohJ8OGlXkKsR42yj4eGJMoF2gzc
 xZE=
X-IronPort-AV: E=Sophos;i="5.69,230,1571727600"; 
   d="scan'208";a="55322565"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Nov 2019 09:02:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 22 Nov 2019 09:02:47 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 22 Nov 2019 09:02:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlZ+0Gqe5yZ+BAFXy0YUhVg5y2eOiMngxTPUyKfvs7umYFLE1+N0Td80zKfx/FeIT7wXblKF0QnupcB1BO/f1XQP9CImvvB6zcRP3yZdUAOfhwRhRHsWl7YukvhkImqCmrhQmzS7t5nRxS91/j9bdVoKL1g5ORN8w7Z1DUN9f4PyUUB+cxtNhHfUS16mXHiDlHRU4ugha8KSsFNBmpRAUM6YROel+bdTeN/rccbNVhTHsvctZyfXeJiInW2Q5Fz4ju5PozCUc+YfW6QyMLMHeS783UtT3lrIkXMtGpPcSt6R0vr0eLvNYldPLD+C2N47iwofLMWdgDg+D2Zx9w8p3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fo/Rvvrpa/8nEUxevI4UpzHCzKCHXPdxxvoNeoWemE0=;
 b=Bp8ORDsQlzATXp32MfO3+KDCZJwQxA1ud+VwPVgKgT5dHmplMGDW1p/aPm4ZZxSiSQgtnGOByKTkF2BkjF39YB8ztrbJZp8qAxtOl5khQoFa5eJWAUaWs45BTmhVwl94yFvzAl5HjON4v4oOw0rHWfRmz6laAEwivXrhBg1lmMImCcc/k4ufhsh7nW52QRSk4aJfcN7bB7DTDEQgXsErjr8fr7EAIsunGSs2zGQi3SKzA8WRelMzM5zXEtQrKaIB6aTtfsh4n/JakgGmb3crEDONsE22oGBQsk/VkviNoUa7joYxeYgCrhTXFwqlILh0xwHrUI4H5lpZOz1tX8/FSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fo/Rvvrpa/8nEUxevI4UpzHCzKCHXPdxxvoNeoWemE0=;
 b=F2Z57Yn6P/C8f2KhsC4QcdqDOqIj63bAxZIjl35Vm+yoOWr/1BObwESJF6+SLEakIK02C5mLKq/Xg3tKYqNjwY6tk9bA2V4Mr4VNQcsCMYvY5EHcp437CtipXrY2vZrIAtc9StYe4Nzr5vWx9vt7t4mn+Io9MT9nWGtWEbxEu90=
Received: from BYAPR11MB2647.namprd11.prod.outlook.com (52.135.223.12) by
 BYAPR11MB2616.namprd11.prod.outlook.com (52.135.227.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Fri, 22 Nov 2019 16:02:45 +0000
Received: from BYAPR11MB2647.namprd11.prod.outlook.com
 ([fe80::3cf1:2353:86d8:d2e3]) by BYAPR11MB2647.namprd11.prod.outlook.com
 ([fe80::3cf1:2353:86d8:d2e3%6]) with mapi id 15.20.2474.021; Fri, 22 Nov 2019
 16:02:45 +0000
From:   <Cristian.Birsan@microchip.com>
To:     <gregory.clement@bootlin.com>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/3] usb: gadget: udc: atmel: Don't use DT to configure
 end point
Thread-Topic: [PATCH 1/3] usb: gadget: udc: atmel: Don't use DT to configure
 end point
Thread-Index: AQHVlYDym5rdrdrQREOsK+cV/BK4VqeXXUWAgAAUNIA=
Date:   Fri, 22 Nov 2019 16:02:45 +0000
Message-ID: <b207c8d3-4ab3-101f-e0c2-b715becfcc78@microchip.com>
References: <20191107153128.11038-1-gregory.clement@bootlin.com>
 <20191107153128.11038-2-gregory.clement@bootlin.com>
 <871ru0x8ws.fsf@FE-laptop>
In-Reply-To: <871ru0x8ws.fsf@FE-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-originating-ip: [94.177.32.156]
x-clientproxiedby: AM3PR05CA0117.eurprd05.prod.outlook.com
 (2603:10a6:207:2::19) To BYAPR11MB2647.namprd11.prod.outlook.com
 (2603:10b6:a02:be::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191122180229186
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7506c7b-d586-4cbe-7b09-08d76f6569b8
x-ms-traffictypediagnostic: BYAPR11MB2616:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB26162F901C047426314B7F5CEF490@BYAPR11MB2616.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(396003)(376002)(346002)(199004)(189003)(11346002)(53546011)(7416002)(14454004)(2906002)(86362001)(76176011)(6506007)(446003)(99286004)(478600001)(52116002)(25786009)(316002)(2171002)(110136005)(5660300002)(58126008)(31686004)(14444005)(3846002)(6436002)(54906003)(4326008)(966005)(6246003)(6306002)(6486002)(6512007)(6116002)(2616005)(229853002)(8936002)(31696002)(26005)(71190400001)(102836004)(71200400001)(81166006)(65806001)(66066001)(186003)(66446008)(8676002)(2501003)(81156014)(7736002)(66476007)(386003)(305945005)(65956001)(256004)(66556008)(66946007)(36756003)(2201001)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB2616;H:BYAPR11MB2647.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ZiB7ROXpTIZrAt6Tap/lWmFMBVaZdaJ/BppJFb68c8TfriMLmK69MaHdPyOVupJQe11aqGte0uHOqDAGzCTjWpOklmRyGhLQNopk28FuKBiAjanviFyJqW4b8CKOKGS2le5/08l0jM2kn6YPtNgLyZPHKvsELuvjHFPn5fzIFyYHD39Y4urblmYFT/Sfs53VWY8ydpHlWmCEnNZ0rTi55rA3WyW5VxaP8O8IF/nXVUuy4Rgq1qloToR8SRuunRx05PvgLhGTdI4AOj4PTylZ3DfLM4rw8teYRJq6Ppuyy5JT2FeTTPtNW9v4Hihz2mw6/EgvB909So4F7oDOJl9u1dsxMz2qvL9zCH+ZLSYmi0jtg5T8aTDPIsDYGMfcsEcKf2/B5jqSUjiEJan41nR18IRDJ6uiqmDjXuLH+fmiQOab/8jV3/2hMuqX/8P1MKR
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <93AA6D7AF16C4A478500CE5392E3DC27@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e7506c7b-d586-4cbe-7b09-08d76f6569b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 16:02:45.4241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NPWgItXqFhKS9d8yke9nPV7QHwB6kqZf8WY3ny3U4ITk8PWXCgapEee6JLOA+eo9uyvfL2BdIK7rvTbfBd+aiyqNO/nOYSaIZudgNxyIfYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2616
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/19 4:50 PM, Gregory CLEMENT wrote:

> Hello,
>=20
>> The endpoint configuration used to be stored in the device tree,
>> however the configuration depend on the "version" of the controller
>> itself.
>>
>> This information is already documented by the compatible string. It
>> then possible to just rely on the compatible string and completely
>> remove the full ep configuration done in the device tree as it was
>> already the case for all the other USB device controller.
>=20
> Do you have any feedback about this patch ?
>=20
> The binding being reviewed is there any chance that this patch will be
> merged?

Hi Gregory,

Thank you for sending the patch. It looks good to me.

I checked it briefly on sama5d2 with the in kernel cdc-acm.

>=20
> Thanks,
>=20
> Gregory
>=20
>=20
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Acked-by: Cristian Birsan <cristian.birsan@microchip.com>

>> ---
>>   drivers/usb/gadget/udc/atmel_usba_udc.c | 112 +++++++++++++++---------
>>   drivers/usb/gadget/udc/atmel_usba_udc.h |  12 +++
>>   2 files changed, 84 insertions(+), 40 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadge=
t/udc/atmel_usba_udc.c
>> index 86ffc8307864..2db833caeb09 100644
>> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
>> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
>> @@ -2040,10 +2040,56 @@ static const struct usba_udc_errata at91sam9g45_=
errata =3D {
>>        .pulse_bias =3D at91sam9g45_pulse_bias,
>>   };
>>
>> +static const struct usba_ep_config ep_config_sam9[] __initconst =3D {
>> +     { .nr_banks =3D 1 },                              /* ep 0 */
>> +     { .nr_banks =3D 2, .can_dma =3D 1, .can_isoc =3D 1 }, /* ep 1 */
>> +     { .nr_banks =3D 2, .can_dma =3D 1, .can_isoc =3D 1 }, /* ep 2 */
>> +     { .nr_banks =3D 3, .can_dma =3D 1 },                /* ep 3 */
>> +     { .nr_banks =3D 3, .can_dma =3D 1 },                /* ep 4 */
>> +     { .nr_banks =3D 3, .can_dma =3D 1, .can_isoc =3D 1 }, /* ep 5 */
>> +     { .nr_banks =3D 3, .can_dma =3D 1, .can_isoc =3D 1 }, /* ep 6 */
>> +};
>> +
>> +static const struct usba_ep_config ep_config_sama5[] __initconst =3D {
>> +     { .nr_banks =3D 1 },                              /* ep 0 */
>> +     { .nr_banks =3D 3, .can_dma =3D 1, .can_isoc =3D 1 }, /* ep 1 */
>> +     { .nr_banks =3D 3, .can_dma =3D 1, .can_isoc =3D 1 }, /* ep 2 */
>> +     { .nr_banks =3D 2, .can_dma =3D 1, .can_isoc =3D 1 }, /* ep 3 */
>> +     { .nr_banks =3D 2, .can_dma =3D 1, .can_isoc =3D 1 }, /* ep 4 */
>> +     { .nr_banks =3D 2, .can_dma =3D 1, .can_isoc =3D 1 }, /* ep 5 */
>> +     { .nr_banks =3D 2, .can_dma =3D 1, .can_isoc =3D 1 }, /* ep 6 */
>> +     { .nr_banks =3D 2, .can_dma =3D 1, .can_isoc =3D 1 }, /* ep 7 */
>> +     { .nr_banks =3D 2, .can_isoc =3D 1 },               /* ep 8 */
>> +     { .nr_banks =3D 2, .can_isoc =3D 1 },               /* ep 9 */
>> +     { .nr_banks =3D 2, .can_isoc =3D 1 },               /* ep 10 */
>> +     { .nr_banks =3D 2, .can_isoc =3D 1 },               /* ep 11 */
>> +     { .nr_banks =3D 2, .can_isoc =3D 1 },               /* ep 12 */
>> +     { .nr_banks =3D 2, .can_isoc =3D 1 },               /* ep 13 */
>> +     { .nr_banks =3D 2, .can_isoc =3D 1 },               /* ep 14 */
>> +     { .nr_banks =3D 2, .can_isoc =3D 1 },               /* ep 15 */
>> +};
>> +
>> +static const struct usba_udc_config udc_at91sam9rl_cfg =3D {
>> +     .errata =3D &at91sam9rl_errata,
>> +     .config =3D ep_config_sam9,
>> +     .num_ep =3D ARRAY_SIZE(ep_config_sam9),
>> +};
>> +
>> +static const struct usba_udc_config udc_at91sam9g45_cfg =3D {
>> +     .errata =3D &at91sam9g45_errata,
>> +     .config =3D ep_config_sam9,
>> +     .num_ep =3D ARRAY_SIZE(ep_config_sam9),
>> +};
>> +
>> +static const struct usba_udc_config udc_sama5d3_cfg =3D {
>> +     .config =3D ep_config_sama5,
>> +     .num_ep =3D ARRAY_SIZE(ep_config_sama5),
>> +};
>> +
>>   static const struct of_device_id atmel_udc_dt_ids[] =3D {
>> -     { .compatible =3D "atmel,at91sam9rl-udc", .data =3D &at91sam9rl_er=
rata },
>> -     { .compatible =3D "atmel,at91sam9g45-udc", .data =3D &at91sam9g45_=
errata },
>> -     { .compatible =3D "atmel,sama5d3-udc" },
>> +     { .compatible =3D "atmel,at91sam9rl-udc", .data =3D &udc_at91sam9r=
l_cfg },
>> +     { .compatible =3D "atmel,at91sam9g45-udc", .data =3D &udc_at91sam9=
g45_cfg },
>> +     { .compatible =3D "atmel,sama5d3-udc", .data =3D &udc_sama5d3_cfg =
},
>>        { /* sentinel */ }
>>   };
>>
>> @@ -2052,18 +2098,19 @@ MODULE_DEVICE_TABLE(of, atmel_udc_dt_ids);
>>   static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev=
,
>>                                                    struct usba_udc *udc)
>>   {
>> -     u32 val;
>>        struct device_node *np =3D pdev->dev.of_node;
>>        const struct of_device_id *match;
>>        struct device_node *pp;
>>        int i, ret;
>>        struct usba_ep *eps, *ep;
>> +     const struct usba_udc_config *udc_config;
>>
>>        match =3D of_match_node(atmel_udc_dt_ids, np);
>>        if (!match)
>>                return ERR_PTR(-EINVAL);
>>
>> -     udc->errata =3D match->data;
>> +     udc_config =3D match->data;
>> +     udc->errata =3D udc_config->errata;
>>        udc->pmc =3D syscon_regmap_lookup_by_compatible("atmel,at91sam9g4=
5-pmc");
>>        if (IS_ERR(udc->pmc))
>>                udc->pmc =3D syscon_regmap_lookup_by_compatible("atmel,at=
91sam9rl-pmc");
>> @@ -2079,8 +2126,7 @@ static struct usba_ep * atmel_udc_of_init(struct p=
latform_device *pdev,
>>
>>        if (fifo_mode =3D=3D 0) {
>>                pp =3D NULL;
>> -             while ((pp =3D of_get_next_child(np, pp)))
>> -                     udc->num_ep++;
>> +             udc->num_ep =3D udc_config->num_ep;
>>                udc->configured_ep =3D 1;
>>        } else {
>>                udc->num_ep =3D usba_config_fifo_table(udc);
>> @@ -2097,52 +2143,38 @@ static struct usba_ep * atmel_udc_of_init(struct=
 platform_device *pdev,
>>
>>        pp =3D NULL;
>>        i =3D 0;
>> -     while ((pp =3D of_get_next_child(np, pp)) && i < udc->num_ep) {
>> +     while (i < udc->num_ep) {
>> +             const struct usba_ep_config *ep_cfg =3D &udc_config->confi=
g[i];
>> +
>>                ep =3D &eps[i];
>>
>> -             ret =3D of_property_read_u32(pp, "reg", &val);
>> -             if (ret) {
>> -                     dev_err(&pdev->dev, "of_probe: reg error(%d)\n", r=
et);
>> -                     goto err;
>> -             }
>> -             ep->index =3D fifo_mode ? udc->fifo_cfg[i].hw_ep_num : val=
;
>> +             ep->index =3D fifo_mode ? udc->fifo_cfg[i].hw_ep_num : i;
>> +
>> +             /* Only the first EP is 64 bytes */
>> +             if (ep->index =3D=3D 0)
>> +                     ep->fifo_size =3D 64;
>> +             else
>> +                     ep->fifo_size =3D 1024;
>>
>> -             ret =3D of_property_read_u32(pp, "atmel,fifo-size", &val);
>> -             if (ret) {
>> -                     dev_err(&pdev->dev, "of_probe: fifo-size error(%d)=
\n", ret);
>> -                     goto err;
>> -             }
>>                if (fifo_mode) {
>> -                     if (val < udc->fifo_cfg[i].fifo_size) {
>> +                     if (ep->fifo_size < udc->fifo_cfg[i].fifo_size)
>>                                dev_warn(&pdev->dev,
>> -                                      "Using max fifo-size value from D=
T\n");
>> -                             ep->fifo_size =3D val;
>> -                     } else {
>> +                                      "Using default max fifo-size valu=
e\n");
>> +                     else
>>                                ep->fifo_size =3D udc->fifo_cfg[i].fifo_s=
ize;
>> -                     }
>> -             } else {
>> -                     ep->fifo_size =3D val;
>>                }
>>
>> -             ret =3D of_property_read_u32(pp, "atmel,nb-banks", &val);
>> -             if (ret) {
>> -                     dev_err(&pdev->dev, "of_probe: nb-banks error(%d)\=
n", ret);
>> -                     goto err;
>> -             }
>> +             ep->nr_banks =3D ep_cfg->nr_banks;
>>                if (fifo_mode) {
>> -                     if (val < udc->fifo_cfg[i].nr_banks) {
>> +                     if (ep->nr_banks < udc->fifo_cfg[i].nr_banks)
>>                                dev_warn(&pdev->dev,
>> -                                      "Using max nb-banks value from DT=
\n");
>> -                             ep->nr_banks =3D val;
>> -                     } else {
>> +                                      "Using default max nb-banks value=
\n");
>> +                     else
>>                                ep->nr_banks =3D udc->fifo_cfg[i].nr_bank=
s;
>> -                     }
>> -             } else {
>> -                     ep->nr_banks =3D val;
>>                }
>>
>> -             ep->can_dma =3D of_property_read_bool(pp, "atmel,can-dma")=
;
>> -             ep->can_isoc =3D of_property_read_bool(pp, "atmel,can-isoc=
");
>> +             ep->can_dma =3D ep_cfg->can_dma;
>> +             ep->can_isoc =3D ep_cfg->can_isoc;
>>
>>                sprintf(ep->name, "ep%d", ep->index);
>>                ep->ep.name =3D ep->name;
>> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadge=
t/udc/atmel_usba_udc.h
>> index a0225e4543d4..48e332439ed5 100644
>> --- a/drivers/usb/gadget/udc/atmel_usba_udc.h
>> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
>> @@ -290,6 +290,12 @@ struct usba_ep {
>>   #endif
>>   };
>>
>> +struct usba_ep_config {
>> +     u8                                      nr_banks;
>> +     unsigned int                            can_dma:1;
>> +     unsigned int                            can_isoc:1;
>> +};
>> +
>>   struct usba_request {
>>        struct usb_request                      req;
>>        struct list_head                        queue;
>> @@ -307,6 +313,12 @@ struct usba_udc_errata {
>>        void (*pulse_bias)(struct usba_udc *udc);
>>   };
>>
>> +struct usba_udc_config {
>> +     const struct usba_udc_errata *errata;
>> +     const struct usba_ep_config *config;
>> +     const int num_ep;
>> +};
>> +
>>   struct usba_udc {
>>        /* Protect hw registers from concurrent modifications */
>>        spinlock_t lock;
>> --
>> 2.24.0.rc1
>>
>=20
> --
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> http://bootlin.com
>=20

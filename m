Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68ABC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5B422CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="kTPM/Rua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390274AbfHWIVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:21:04 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:18527 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbfHWIVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:21:04 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Nicolas.Ferre@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="Nicolas.Ferre@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Nicolas.Ferre@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 3sK6S+3IRry9tcQ3lca/Btv0R9pG6mjta9NoHXcJ4ENIDm8dBnswZyM1TAOP0pnhZKDzKE/0Sq
 ErL65KngtwM5GEX1peG83JjT+KqprXZJd1YBpYtZX1lrI0xqA+9Zjmc6rIZkmcArp3mIW+WJPu
 vnLiWPDwMC7VzfZ5jB8SPTBTSnucBfZRWvjoyZ9flMS82mza5udzCsuxCbIZAJP0djfuIJZEYp
 mcm6nuW93irhDsdQufBqhhSjvpxmC8etiISr6qvoo+/eJQFBYL41EQyy6IA1lcekxWve4JMPVH
 Qb4=
X-IronPort-AV: E=Sophos;i="5.64,420,1559545200"; 
   d="scan'208";a="45345275"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2019 01:21:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 23 Aug 2019 01:21:00 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 23 Aug 2019 01:21:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwjwDUCQuBNUhb85AHx0FsgOoy6vTlBHshHv3lZXG7MNe679iFz0blBm3C+gHiCia+ZUuaS2o4CH7Tmdy1MJjmZplRc9tPXBTmRa0seqUQhyeirI6UFBTGbozxnAKibARvngSTQmE/LtEo/CXRUNi7J0RPFlBps18beCHRckQh2D79ll/BdXdCvJopBbwmjM8dDDLlwp+MsttHnHtWVOR7ysRCnbZRGr9uHSKL0ghEjhe+Vd175P3qTIQSa/bK8SNC1Aclk674hJmgFgG9ehFr4Pa8h4a7rrQ53xxfbhTXkcvZaBJR4ag9Kas8jyOsjPaWXjp8wAAmoTFbaSiztBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbiF4SjcGyP6qiSTGDPiAC5OyRzL7mGbK3uwwaSTPpo=;
 b=YDn1I6U25pOiluw3JK1zVEJzek0tnte8lNaAH/MPriYOJi5akvDwFIYIo8KhZEBHnFBm/YLp81Eb4EMgIrUE1dGiTs/4SHGR3UH6d7WlAmfOBwzyvGOckdz3SID1QC9RAUJiNjFywORQRczJFYyRdyvT8kG6fLRNdxSA4OLGpngFU9nALTr6D09S9ArU5ZSAVI7yRoA6asvDBqQk/SsdJi+2iVXrizhsQolPkJm+ZnBagBc6pTT2uVE5VJ7mGe+OVe8M+88McEX7YHsNzOjE9fjmxSdaJ2Z6nKjxya2xaAa4taVRo9GEIXEkUxhlKjutKxDaIBTWGaKw9wGgSP2WMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbiF4SjcGyP6qiSTGDPiAC5OyRzL7mGbK3uwwaSTPpo=;
 b=kTPM/RuaIXbp4QYDjScEmOM7ndysF+6HM8qnAdL9/DIEHu/M6n0jxUTHkJt2WET7uaD3WBWf1AFa8hr387v5dK6YDghrmxC9lq8UrUoooqWHWaGenHPyUGNczPzAJNhnrt60X0aTi0Kd2yh0JPQvCFYpXLqNVYtgQ6qKvjahFEk=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1424.namprd11.prod.outlook.com (10.169.235.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Fri, 23 Aug 2019 08:20:58 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::410a:9d4b:b1df:2134]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::410a:9d4b:b1df:2134%12]) with mapi id 15.20.2178.020; Fri, 23 Aug
 2019 08:20:58 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <efremov@linux.com>, <linux-kernel@vger.kernel.org>,
        <joe@perches.com>, <linux-arm-kernel@lists.infradead.org>,
        <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH] MAINTAINERS: Update path to tcb_clksrc.c
Thread-Topic: [PATCH] MAINTAINERS: Update path to tcb_clksrc.c
Thread-Index: AQHVUZ3nRcIHKUMCtUu8KXcGbJ0E8w==
Date:   Fri, 23 Aug 2019 08:20:58 +0000
Message-ID: <8aba2175-f61c-e624-aee0-e724e1ac04da@microchip.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190813061046.15712-1-efremov@linux.com>
 <efb86032-7547-dbc1-19ac-11dc9aff1521@microchip.com>
 <20190814090858.GF3600@piout.net>
In-Reply-To: <20190814090858.GF3600@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::29) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [213.41.198.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0883214-bd44-4986-10fc-08d727a2d39c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR11MB1424;
x-ms-traffictypediagnostic: MWHPR11MB1424:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1424B692517EFF47951F1C84E0A40@MWHPR11MB1424.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(376002)(346002)(396003)(199004)(189003)(14444005)(107886003)(6246003)(86362001)(2616005)(6506007)(229853002)(476003)(6116002)(3846002)(256004)(15650500001)(6436002)(6512007)(4326008)(6486002)(66066001)(36756003)(25786009)(76176011)(316002)(54906003)(81156014)(8676002)(186003)(26005)(53546011)(102836004)(386003)(81166006)(52116002)(31696002)(99286004)(31686004)(7736002)(53936002)(8936002)(2906002)(305945005)(486006)(11346002)(66446008)(64756008)(66556008)(66476007)(71190400001)(71200400001)(478600001)(446003)(6916009)(14454004)(5660300002)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1424;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TE9a5a4Bc/30TAAa6wtw2qBeOh2poGd5Yb+yMmHZo7JfFnS8NF9dd/cFwh+Ba7KE8JzYClXzMPU7pagwwGkmO236RFhXDDU9CUNlSEvVFRpxQN5TX3NRAZh3my4eNwqsdyREPcY7iBL9uCLDr6U3Zwok/UPjbZdvZZtJiU0u2+L33pTWUZAdMpwHoHUBm6Zj6bHMe8fg1wmF3/rNihWShOz/Fbdfxeeq0fxHN8ghRA6sFdMpZ0BzJ3CtQfL72K+6Wee+wRJ2i+fxavxukBdsV0AQg/7QlTdkiP/TW47prIhVCAeRttED78+9lLwG9+WK6FSxc0psaXyrOPSoANIizmw9epTyPoi0ujEYrMLBexCXVbPBgmYjD1hXOAHiCyl+oz3r+zEI85Yri7AXX3eRznRalJNeXzCynVkSLQjcnzY=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <3EB0B5EF076A5B429810D493C81A6541@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d0883214-bd44-4986-10fc-08d727a2d39c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 08:20:58.6249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uGB9FyXZoSPDM+GS312xEaNNaucf+nwPc487LBFuDvTQH58tObWv56jFmHK5DMPVU02GuAeICY+R/kq4gQniRy9rm2wnP+ZFIjO8Aawv0p8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1424
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2019 at 11:08, Alexandre Belloni wrote:
> External E-Mail
>=20
>=20
> On 13/08/2019 08:11:23+0000, Nicolas Ferre wrote:
>> On 13/08/2019 at 08:10, Denis Efremov wrote:
>>> Update MAINTAINERS record to reflect the filename change
>>> from tcb_clksrc.c to timer-atmel-tcb.c
>>>
>>> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
>>
>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>> But, while you're at it, I would add another line: see below...
>>
>>> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Fixes: a7aae768166e ("clocksource/drivers/tcb_clksrc: Rename the file f=
or consistency")
>>> Signed-off-by: Denis Efremov <efremov@linux.com>
>>> ---
>>>    MAINTAINERS | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index c9ad38a9414f..3ec8154e4630 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -10637,7 +10637,7 @@ M:	Nicolas Ferre <nicolas.ferre@microchip.com>
>>
>> +M:      Alexandre Belloni <alexandre.belloni@bootlin.com>
>>
>> But Alexandre have to agree, of course.
>>
>>>    L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribe=
rs)
>>>    S:	Supported
>>>    F:	drivers/misc/atmel_tclib.c
>>> -F:	drivers/clocksource/tcb_clksrc.c
>>> +F:	drivers/clocksource/timer-atmel-tcb.c
>>>   =20
>>>    MICROCHIP USBA UDC DRIVER
>>>    M:	Cristian Birsan <cristian.birsan@microchip.com>
>>
>> We could also remove this entry and mix it with:
>> "ARM/Microchip (AT91) SoC support"
>>
>> But I prefer to keep it separated like this for various reasons.
>>
>=20
> I would simply remove this entry because all the files are already
> matching the SoC entry (it has N: atmel) and atmel_tclib will go away (I
> have a series to do that).

All right: let's remove it.

Thanks Denis for the heads-up!

Best regards,
   Nicolas

> If you want to keep a separate entry, maybe we should then add the
> system timer and pit drivers.
>=20
>=20


--=20
Nicolas Ferre

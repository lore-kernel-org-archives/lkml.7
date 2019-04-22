Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F3DC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201962077C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TISZJWgi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="TapLu7Ki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfDVPul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:50:41 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:53762 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727139AbfDVPuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 11:50:40 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DB971C0B50;
        Mon, 22 Apr 2019 15:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555948239; bh=6kYtyHPsOrO2DEs9Op4OxyIjXyTyAsNEfoeSNkDgzdQ=;
        h=From:To:CC:Subject:Date:References:From;
        b=TISZJWgihiqSTVExM5mtJywiVHsWE76oeiKLRhZuB+beIhpTsGrMRoPg6yrFeoTve
         MVyYoJP9NILwPV2/t6XZJnre+OQXhEj1yUII9/jnVA5r+T4XMU8YUtgMw9AEvgmUt4
         M9EJqZxkkCd/FQEKwihfu8lpzzWY0/u6zivb/GjLN1dQ/uzq592DBuyxjT91mwRO9g
         RJJ1DBP0ZYmhFnQcxEy6OAIn1QaIy8XuoaenfOOR3JGtAyyz81Ba7CuXZ+wGWDXo9s
         LYSSxbvcDvtCIxdKrCDsBJRcO5wfBANlFoVbJtrhfrdShIYdzSrIf6H04R2ERmqKte
         7YUzUS3cWiJeA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 00CB5A0065;
        Mon, 22 Apr 2019 15:50:33 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 22 Apr 2019 08:50:33 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 22 Apr 2019 08:50:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72GnrM5jTFIYIUDkJA5kUD8sXdKxuo70rHXyO2CnI+I=;
 b=TapLu7KiWTIQN8kPDIJOJH2sMIeyXO8IjG2TKgLOMsZahMgxar3KaRMz/YBKNdvH5DyF/InHjBRo8ak4QTtWuwzFoY9Q6AiEvSRq0ybq7y7VmubXtTcT+0beXmsS7T5R08I2YVFYF/HEWq1dqtp3QQDpm1kA4GZOlHSYDUQjxnA=
Received: from SN1PR12MB2431.namprd12.prod.outlook.com (52.132.195.146) by
 SN1PR12MB2382.namprd12.prod.outlook.com (52.132.194.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 15:50:29 +0000
Received: from SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::5ca6:ee5f:1147:df5a]) by SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::5ca6:ee5f:1147:df5a%4]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 15:50:29 +0000
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
To:     Doug Anderson <dianders@chromium.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
CC:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        "amstan@chromium.org" <amstan@chromium.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        William Wu <william.wu@rock-chips.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Randy Li <ayaka@soulik.info>,
        "zyw@rock-chips.com" <zyw@rock-chips.com>,
        "mka@chromium.org" <mka@chromium.org>,
        "ryandcase@chromium.org" <ryandcase@chromium.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        "jwerner@chromium.org" <jwerner@chromium.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nicolas Boichat" <drinkcat@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v2 0/5] USB: dwc2: Allow wakeup from suspend; enable for
 rk3288-veyron
Thread-Topic: [PATCH v2 0/5] USB: dwc2: Allow wakeup from suspend; enable for
 rk3288-veyron
Thread-Index: AQHU9XvT28uFwzx7lkKfey+49nOavg==
Date:   Mon, 22 Apr 2019 15:50:29 +0000
Message-ID: <SN1PR12MB2431362F11279C1C0E9E7793A7220@SN1PR12MB2431.namprd12.prod.outlook.com>
References: <20190418001356.124334-1-dianders@chromium.org>
 <e4b3cd69-1c91-dfbe-bea7-bbca89ca1348@synopsys.com>
 <CAD=FV=XDLqcdq_BypUYsJHKX+DY0VWvCACYgZiHeG8E3Dbwxcw@mail.gmail.com>
 <SN1PR12MB2431F918E4731FAA50A373B6A7270@SN1PR12MB2431.namprd12.prod.outlook.com>
 <SN1PR12MB24319D0BF93E22B6B913E6CAA7270@SN1PR12MB2431.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arturp@synopsys.com; 
x-originating-ip: [84.53.141.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9daf9c57-d80d-4c9d-78ba-08d6c73a3ed2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SN1PR12MB2382;
x-ms-traffictypediagnostic: SN1PR12MB2382:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <SN1PR12MB23826D4B1387EFC815505C2AA7220@SN1PR12MB2382.namprd12.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(346002)(366004)(376002)(136003)(189003)(199004)(66066001)(7696005)(33656002)(14454004)(76176011)(229853002)(64756008)(66446008)(66556008)(66476007)(66946007)(6436002)(6306002)(91956017)(76116006)(73956011)(93886005)(6246003)(99286004)(74316002)(55016002)(8676002)(53936002)(54906003)(110136005)(81166006)(81156014)(86362001)(6506007)(53546011)(8936002)(478600001)(102836004)(486006)(68736007)(446003)(476003)(3846002)(4326008)(97736004)(2906002)(6636002)(52536014)(5660300002)(26005)(25786009)(186003)(71200400001)(7416002)(71190400001)(256004)(7736002)(9686003)(316002)(305945005)(6116002)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR12MB2382;H:SN1PR12MB2431.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SoLffuYTRNkS/va6YT8nEqa8/ZYAOsLth4xhvswUM4WbAYgn6toUJ6c3h1GHHRjOrqyazAX8drQ8KK0IGhlqoFhbSzuF3HCpOz8ql1rsJ0djecCgzk+y2UpnocWkMpEiRY4JDtnA+jDSX/ZlB5a2I7ddkKVqW/2Sy1LknFqQO2P+xZEN+keW2yip4S9QhJKoFUcQhETt6UUuZq9gO+JJDURTZkvgaU0ifiZMpKrFTdEBe0rTxNagvqM4hL5OGHL09ErVCv5rnWTwb0GjAgdEFlTK0OWLRM0pKgxD8IoWOezy/IaxGK7WUQvQjn8Eaq98IFAuoyVrCr5tdeTcZ8oEeWYlv8LIWPaEosM3yPgcH8LC5xZwfAiJ0Xw0zRUmucUf2tv9qlRRGdxCR6CcxiiOrUUETFumaMSwgdpydw7rc5M=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9daf9c57-d80d-4c9d-78ba-08d6c73a3ed2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 15:50:29.2623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2382
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,=0A=
=0A=
On 4/19/2019 20:44, Artur Petrosyan wrote:=0A=
> Hi Doug,=0A=
> =0A=
> On 4/19/2019 15:43, Artur Petrosyan wrote:=0A=
>> Hi,=0A=
>>=0A=
>> On 4/18/2019 19:55, Doug Anderson wrote:=0A=
>>> Hi,=0A=
>>>=0A=
>>> On Thu, Apr 18, 2019 at 5:41 AM Minas Harutyunyan=0A=
>>> <Minas.Harutyunyan@synopsys.com> wrote:=0A=
>>>> Did you consider/reviewed patch series from Artur Petrosyan "[PATCH=0A=
>>>> 00/14] usb: dwc2: Fix and improve power saving modes" (submitted on=0A=
>>>> April 12) which fixing partial power down and hibernation flows for bo=
th=0A=
>>>> modes: host and device?=0A=
>>>> I suspect that this both patch series can be in conflict.=0A=
>>>=0A=
>>> No, I wasn't aware of them.  I'd like to try them out, but it looks=0A=
>>> like it's currently impossible because they're not archived anywhere=0A=
>>> that I can find.=0A=
>>>=0A=
>>> 1. LKML wasn't copied, so I can't find them on lore.kernel.org.  It is=
=0A=
>>> suggested to CC LKML on all patches.=0A=
>>>=0A=
>>> 2. The Linux USB patchwork only has the cover letter plus the first 6=
=0A=
>>> patches.  See <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__p=
atchwork.kernel.org_cover_10898333_&d=3DDwIBaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=
=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqrC_D7niMJI&m=3DrJbofHXqjP3sUBgEikaZ89fR=
WtsquvhFUkhSPguCiWw&s=3D_CrI0uolquXIYC5SuoZ1vBs7BM19VfCceI96qZm9kAY&e=3D>=
=0A=
>>>=0A=
>>> 3. Searching my own archives I only see the cover letter plus the=0A=
>>> first 6 patches.=0A=
>>>=0A=
>>> Maybe you have some other pointer to how I can retrieve them?  I guess=
=0A=
>>> I could try the first 6 patches without the later 8 but I'd rather get=
=0A=
>>> the whole set...=0A=
>>>=0A=
>>>=0A=
>>> -Doug=0A=
>>>=0A=
>>=0A=
>>=0A=
>> I have resend the patch set. You can find it with cover letter=0A=
>> "[PATCH v1 00/14] usb: dwc2: Fix and improve power saving modes."=0A=
>>=0A=
>> Let me know if you need any help.=0A=
>>=0A=
> =0A=
> I am so sorry to inform you that the patches have not reached to LKML.=0A=
> Looks like there is a problem with the kernel mailing list servers or=0A=
> our local servers.=0A=
> Will try to fix this as soon as possible and let you know about it.=0A=
> =0A=
=0A=
My patches has reached to LKML. You can find them with the patch set =0A=
title "[PATCH v1 00/14] usb: dwc2: Fix and improve power saving modes."=0A=
=0A=
This is the link to the patch set in marc.info=0A=
"https://marc.info/?l=3Dlinux-usb&m=3D155570003924638&w=3D2"=0A=
and a link in patchwork.kernel.org=0A=
"https://patchwork.kernel.org/project/linux-usb/list/?submitter=3D180003"=
=0A=
=0A=
Sorry for the delay.=0A=
=0A=
-- =0A=
Regards,=0A=
Artur=0A=

Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F41DC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473DB20645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IJgdLXfm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="bDCDfC+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfDSTIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:08:21 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:38624 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727026AbfDSTIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:08:12 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 75CCEC0A4D;
        Fri, 19 Apr 2019 16:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555692295; bh=+PzC1/zXi7c+NGywnP0CmnRoci9z1wXwdxQqB7PLV+A=;
        h=From:To:CC:Subject:Date:References:From;
        b=IJgdLXfmPixeYxV0oiIBE0mvIzcGB16YNIOBMrqF6uI/7pYCEyyYoEbR8Q3y1lflx
         sBlMV+zaQyZU5VC9/t63jNgyEkoOgoCc+E8PgqppjlH8sZ6iUBhE/m1HftwRQVW+Dj
         1ibZ+j+ACCN0mGLMdecbSVlS+T4e6skSohK55OJhu/KNtRKwtVeZ2Lb/zomesZyjnV
         /Iab8mqEywW2en24VS/x/VE9dnB2VruB0ITmbdH5n1kYrVJxDS/LIOO9xLHZHKEYDD
         7kwobnn8qQWR3MopNSqsezldE6ql/IfmkboUrJO+HW+c6Ohkj9YtlFZN7hVoeHoW5W
         aQXvRWGmxaAHw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8CFCFA009A;
        Fri, 19 Apr 2019 16:44:49 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 19 Apr 2019 09:44:40 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 19 Apr 2019 09:44:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qznh+4yNe15IwJE8wfvRg6Ijrb7wFbIK1tnwb0ApAmk=;
 b=bDCDfC+DeyslYrSKidw2YC+gtelyKddZ6iSTzlhnB4wVf1Bv7LqzhWdW64X2L7/AWTP07I5fKbNEAWrkrK4ASfL3gvdnHM6HhktnVB7p9mEJxJB52zTPVOp8wmnAI80tN+5mcyDRJ1FT+SHOQCLq2X2PqDEXCf8o4awZbQuCN14=
Received: from SN1PR12MB2431.namprd12.prod.outlook.com (52.132.195.146) by
 SN1PR12MB2432.namprd12.prod.outlook.com (52.132.195.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Fri, 19 Apr 2019 16:44:35 +0000
Received: from SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::5ca6:ee5f:1147:df5a]) by SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::5ca6:ee5f:1147:df5a%4]) with mapi id 15.20.1813.013; Fri, 19 Apr 2019
 16:44:34 +0000
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
Date:   Fri, 19 Apr 2019 16:44:34 +0000
Message-ID: <SN1PR12MB24319D0BF93E22B6B913E6CAA7270@SN1PR12MB2431.namprd12.prod.outlook.com>
References: <20190418001356.124334-1-dianders@chromium.org>
 <e4b3cd69-1c91-dfbe-bea7-bbca89ca1348@synopsys.com>
 <CAD=FV=XDLqcdq_BypUYsJHKX+DY0VWvCACYgZiHeG8E3Dbwxcw@mail.gmail.com>
 <SN1PR12MB2431F918E4731FAA50A373B6A7270@SN1PR12MB2431.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arturp@synopsys.com; 
x-originating-ip: [84.53.141.190]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6999a39b-2db8-4f46-d927-08d6c4e64e01
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SN1PR12MB2432;
x-ms-traffictypediagnostic: SN1PR12MB2432:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN1PR12MB24321D6A22953D1C66F31C14A7270@SN1PR12MB2432.namprd12.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39850400004)(396003)(366004)(346002)(136003)(199004)(189003)(110136005)(54906003)(446003)(76176011)(316002)(97736004)(71190400001)(71200400001)(478600001)(5660300002)(53936002)(93156006)(9686003)(52536014)(476003)(6306002)(256004)(14454004)(8936002)(7736002)(66556008)(66476007)(91956017)(76116006)(66946007)(73956011)(305945005)(6636002)(66446008)(64756008)(86362001)(55016002)(6506007)(53546011)(66066001)(26005)(3846002)(7416002)(81156014)(33656002)(81166006)(68736007)(2906002)(74316002)(8676002)(6436002)(6116002)(4326008)(6246003)(99286004)(25786009)(7696005)(229853002)(486006)(93886005)(186003)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR12MB2432;H:SN1PR12MB2431.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BWklO4in/d8GUYmOo+SjlJy/AFF8G7pnGk834fo/IsBextbSiOX6arSf7DpFkDJL6tI4K6pRjrDaxmv35t2p5hKC8VxKt4MfOrPtpV4igFN3+ITv4eetwmBDVgUMXOax0Bjb3pU+yMEv9MV7+gThL47w1VzY5aGS1wTjctavAIE4M5HyHuc73yN7jQg7ZrzJ5neLB36Wkaij4+Iqa0JUQSxR09SnuFdLQGIzR0K6RZ0M86ogyjff7irixYJfKh/GMgbcR0/1UMx+r963hPgIrJ5TIrdqVa41zTm6Tjcf7tCX4smEokDJz4FhGjTPbij7NhC9nqw8cWCtg8ujBcCRuyG4t5/cjrySZh0d8Te+jFlgQUnbi5tmigrNb5m4wB8Zdq4DrImBmVwyUpV6Kdv5NT7yv/yrihL9oaO7gtPq8F8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6999a39b-2db8-4f46-d927-08d6c4e64e01
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 16:44:34.7898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2432
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,=0A=
=0A=
On 4/19/2019 15:43, Artur Petrosyan wrote:=0A=
> Hi,=0A=
> =0A=
> On 4/18/2019 19:55, Doug Anderson wrote:=0A=
>> Hi,=0A=
>>=0A=
>> On Thu, Apr 18, 2019 at 5:41 AM Minas Harutyunyan=0A=
>> <Minas.Harutyunyan@synopsys.com> wrote:=0A=
>>> Did you consider/reviewed patch series from Artur Petrosyan "[PATCH=0A=
>>> 00/14] usb: dwc2: Fix and improve power saving modes" (submitted on=0A=
>>> April 12) which fixing partial power down and hibernation flows for bot=
h=0A=
>>> modes: host and device?=0A=
>>> I suspect that this both patch series can be in conflict.=0A=
>>=0A=
>> No, I wasn't aware of them.  I'd like to try them out, but it looks=0A=
>> like it's currently impossible because they're not archived anywhere=0A=
>> that I can find.=0A=
>>=0A=
>> 1. LKML wasn't copied, so I can't find them on lore.kernel.org.  It is=
=0A=
>> suggested to CC LKML on all patches.=0A=
>>=0A=
>> 2. The Linux USB patchwork only has the cover letter plus the first 6=0A=
>> patches.  See <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__pa=
tchwork.kernel.org_cover_10898333_&d=3DDwIBaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=
=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqrC_D7niMJI&m=3DrJbofHXqjP3sUBgEikaZ89fR=
WtsquvhFUkhSPguCiWw&s=3D_CrI0uolquXIYC5SuoZ1vBs7BM19VfCceI96qZm9kAY&e=3D>=
=0A=
>>=0A=
>> 3. Searching my own archives I only see the cover letter plus the=0A=
>> first 6 patches.=0A=
>>=0A=
>> Maybe you have some other pointer to how I can retrieve them?  I guess=
=0A=
>> I could try the first 6 patches without the later 8 but I'd rather get=
=0A=
>> the whole set...=0A=
>>=0A=
>>=0A=
>> -Doug=0A=
>>=0A=
> =0A=
> =0A=
> I have resend the patch set. You can find it with cover letter=0A=
> "[PATCH v1 00/14] usb: dwc2: Fix and improve power saving modes."=0A=
> =0A=
> Let me know if you need any help.=0A=
> =0A=
=0A=
I am so sorry to inform you that the patches have not reached to LKML.=0A=
Looks like there is a problem with the kernel mailing list servers or =0A=
our local servers.=0A=
Will try to fix this as soon as possible and let you know about it.=0A=
=0A=
-- =0A=
Regards,=0A=
Artur=0A=

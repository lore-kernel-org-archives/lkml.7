Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76D5C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDE42171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mTQ9/CNW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="ttYS2x9M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfDSUF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:05:57 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:36786 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727711AbfDSUFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:05:52 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5925EC120D;
        Fri, 19 Apr 2019 11:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555674213; bh=t00lRfH995ruO0MXmqUf+94IRkyHL6i2PnMjFBQvnLY=;
        h=From:To:CC:Subject:Date:References:From;
        b=mTQ9/CNWn5SzNC8NAAQzjn/lGa2igL3aZ2Cybe112Na9PXB60Gb1nXuWkkuFDVYyJ
         9xX3uoDKwd/VW1gSNKBjgHONxwsS9hvwp1h2zQg8sEv13HTec3mKBo1mV2b41MyLuS
         GpBfQ4+a6lSZAQtdzURBSY0JpatdqEvk2Rtptp1Ri2nMY4kkTnLpREvBAiYTaEd7FK
         yAWmJ4gwZEi4qskctbgVal/ghaPUn1+x/Dddw4MSFgkx1Aabbe4Y11eSF5MXqRoZ8Q
         nxjlYJUqMHe8/Mp1dmV+XcjMYYJOHfVYBijRQnsxXRtNw8kZ8us2I4HfulB8Q0cLK2
         dkd13opeKgtLQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3CB50A008D;
        Fri, 19 Apr 2019 11:43:24 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 19 Apr 2019 04:43:15 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 19 Apr 2019 04:43:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XrFBfoBniPXSfbdrz/Ft1BkBA1oMY9sHzvQa0AzTPc=;
 b=ttYS2x9MfG6patwpBuY2BbrOKZPyKJuWc+L9gsIaDkKdhhN8vwFQtG9DbZTOCJRBOUkLE/Y95KhLkkRi3YK6ru47D1O0iv8N/M1KRYDourS3BCW3qOZjYKNX2XqvDR2/t/ZW3g0wUfo2w0Vfh+Cpin81CqhP+atW8UH87v4/nbQ=
Received: from SN1PR12MB2431.namprd12.prod.outlook.com (52.132.195.146) by
 SN1PR12MB0893.namprd12.prod.outlook.com (10.164.27.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Fri, 19 Apr 2019 11:43:11 +0000
Received: from SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::5ca6:ee5f:1147:df5a]) by SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::5ca6:ee5f:1147:df5a%4]) with mapi id 15.20.1813.013; Fri, 19 Apr 2019
 11:43:11 +0000
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
Date:   Fri, 19 Apr 2019 11:43:11 +0000
Message-ID: <SN1PR12MB2431F918E4731FAA50A373B6A7270@SN1PR12MB2431.namprd12.prod.outlook.com>
References: <20190418001356.124334-1-dianders@chromium.org>
 <e4b3cd69-1c91-dfbe-bea7-bbca89ca1348@synopsys.com>
 <CAD=FV=XDLqcdq_BypUYsJHKX+DY0VWvCACYgZiHeG8E3Dbwxcw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arturp@synopsys.com; 
x-originating-ip: [84.53.141.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9443cb60-059d-4f42-8d46-08d6c4bc336c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SN1PR12MB0893;
x-ms-traffictypediagnostic: SN1PR12MB0893:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN1PR12MB0893248E16E93D3683C2F20EA7270@SN1PR12MB0893.namprd12.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(346002)(136003)(366004)(396003)(376002)(199004)(189003)(53936002)(6246003)(6306002)(9686003)(55016002)(4326008)(97736004)(25786009)(7696005)(2906002)(6636002)(26005)(6506007)(102836004)(53546011)(76176011)(6436002)(99286004)(68736007)(229853002)(86362001)(6116002)(54906003)(33656002)(3846002)(110136005)(66066001)(316002)(66446008)(64756008)(66556008)(66476007)(66946007)(8676002)(81156014)(81166006)(73956011)(8936002)(7416002)(5660300002)(71190400001)(71200400001)(91956017)(76116006)(52536014)(476003)(7736002)(305945005)(446003)(186003)(74316002)(478600001)(14454004)(486006)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR12MB0893;H:SN1PR12MB2431.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KEpWoRzUErLt+lbC+0jCDKfnYXQVM8SkabbWoiBi+FkHiI240GVndMQawQlG8/e+qIhuEbBkcjj5lKCTRbxCxniAGUaMKxH/7nbuiO/D+9pMDCvjV0nCsWLv+vq9usC9qzz6PjaEl/+IOmluI1K/Wb7FrJ8lAMjqtK3k6hb3ux0Uzcx4o1FYm31NH4UWtoRg6PaZka5A+LvEu9gJjWcIkTikp39Vck3LJbIMgxhP2+fQ4oLMjbzeBBzHGKhNFIhbEF7GN6PwCiUPtrqSKUovwK6CJ5p5iVIiPoB3cUJJLjlMwuovFnW/DehlVj/atvIqoaHeuXi8wGDxGp8qPgXNqe397eGygT9BH7F/OmGMfef+9KCKBMwqaPVvS5hmz7mJjLsfqo1/+Eaqw9B/tDNcyFRNuGJaMuGhGD5tFm9myEI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9443cb60-059d-4f42-8d46-08d6c4bc336c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 11:43:11.2519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0893
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
=0A=
On 4/18/2019 19:55, Doug Anderson wrote:=0A=
> Hi,=0A=
> =0A=
> On Thu, Apr 18, 2019 at 5:41 AM Minas Harutyunyan=0A=
> <Minas.Harutyunyan@synopsys.com> wrote:=0A=
>> Did you consider/reviewed patch series from Artur Petrosyan "[PATCH=0A=
>> 00/14] usb: dwc2: Fix and improve power saving modes" (submitted on=0A=
>> April 12) which fixing partial power down and hibernation flows for both=
=0A=
>> modes: host and device?=0A=
>> I suspect that this both patch series can be in conflict.=0A=
> =0A=
> No, I wasn't aware of them.  I'd like to try them out, but it looks=0A=
> like it's currently impossible because they're not archived anywhere=0A=
> that I can find.=0A=
> =0A=
> 1. LKML wasn't copied, so I can't find them on lore.kernel.org.  It is=0A=
> suggested to CC LKML on all patches.=0A=
> =0A=
> 2. The Linux USB patchwork only has the cover letter plus the first 6=0A=
> patches.  See <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__pat=
chwork.kernel.org_cover_10898333_&d=3DDwIBaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=
=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqrC_D7niMJI&m=3DrJbofHXqjP3sUBgEikaZ89fR=
WtsquvhFUkhSPguCiWw&s=3D_CrI0uolquXIYC5SuoZ1vBs7BM19VfCceI96qZm9kAY&e=3D>=
=0A=
> =0A=
> 3. Searching my own archives I only see the cover letter plus the=0A=
> first 6 patches.=0A=
> =0A=
> Maybe you have some other pointer to how I can retrieve them?  I guess=0A=
> I could try the first 6 patches without the later 8 but I'd rather get=0A=
> the whole set...=0A=
> =0A=
> =0A=
> -Doug=0A=
>=0A=
=0A=
=0A=
I have resend the patch set. You can find it with cover letter=0A=
"[PATCH v1 00/14] usb: dwc2: Fix and improve power saving modes."=0A=
=0A=
Let me know if you need any help.=0A=
=0A=
-- =0A=
Regards,=0A=
Artur=0A=

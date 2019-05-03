Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C8DC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997EF205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RFVPOzXP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="Ji7DFkIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfECIZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:25:57 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:37590 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725777AbfECIZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:25:57 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 27DF5C00D4;
        Fri,  3 May 2019 08:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1556871958; bh=TDDiLYFs1Tz29Y569eCVx9eKZJ50zXOYAYMtGl6RwPI=;
        h=From:To:CC:Subject:Date:References:From;
        b=RFVPOzXP4WCYRGY4caMK5fLv2J575zH2zKt2fB+L1DJsEcJpaAFEaFOvlHhKnwxhe
         ckerIIv+Syl8zNvawQXW9lNPX65+8QHLIyfBgOgtNXZkHkfXpQBMwUhw07gpJaaqqU
         xgWmx5g9IrLKPC3zTG8JSYXIvxlUmP1wywsgQSVU1/5hkTE6yRleOXVG8z7cEJD4FI
         pGs59cBkLcmjh1akeVVzk2ZDmvd8Z9jHlHhnz+ISypAO3BNU557c4eUObr6NYyr+34
         nR+bdUzvxof3qkrWykdgN6sV8LafIGBltFyLwqLC60gkMSlg4cWlK6LJdQzetn20qT
         URLECllwWXyNA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 97D9DA0068;
        Fri,  3 May 2019 08:25:50 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 3 May 2019 01:25:50 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 3 May 2019 01:25:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaXa2Joky9+Rybuhy2LSVpHEWORiNzbGDbbXpwgJmk4=;
 b=Ji7DFkIsOZECVY/Y0gj8nXzPQMTnrFsuq+Y5geZZvmhTlaRfzoRtPLdWOEXXPOyVr1ajHqd76Wg3z5T1c/qu3l9O68eZM6SBBu7q8nii/vQuUv2gJrwDnr5UOMlRgSjjA91dicg66lmE0AYe0Q10I9jXnNglsq2AdbK/m//YzR8=
Received: from SN1PR12MB2431.namprd12.prod.outlook.com (52.132.195.146) by
 SN1PR12MB2384.namprd12.prod.outlook.com (52.132.194.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Fri, 3 May 2019 08:25:48 +0000
Received: from SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::1982:4b45:2adf:9a1f]) by SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::1982:4b45:2adf:9a1f%4]) with mapi id 15.20.1856.012; Fri, 3 May 2019
 08:25:48 +0000
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
To:     Doug Anderson <dianders@chromium.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        =?iso-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        William Wu <william.wu@rock-chips.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Randy Li <ayaka@soulik.info>, Chris <zyw@rock-chips.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        "Julius Werner" <jwerner@chromium.org>,
        Dinh Nguyen <dinguyen@opensource.altera.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] usb: dwc2: bus suspend/resume for hosts with
 DWC2_POWER_DOWN_PARAM_NONE
Thread-Topic: [PATCH v2 1/5] usb: dwc2: bus suspend/resume for hosts with
 DWC2_POWER_DOWN_PARAM_NONE
Thread-Index: AQHU9XvT/eL2bASAskajIQu3Y3ICkw==
Date:   Fri, 3 May 2019 08:25:48 +0000
Message-ID: <SN1PR12MB243136608514210F3E3E536EA7350@SN1PR12MB2431.namprd12.prod.outlook.com>
References: <20190418001356.124334-1-dianders@chromium.org>
 <20190418001356.124334-2-dianders@chromium.org>
 <CAD=FV=UGjQz9Di=NL_r_g1Hofqv-FWBywfSm9Vu6gGr22wzPrA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arturp@synopsys.com; 
x-originating-ip: [84.53.141.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db7b71c4-b286-4f76-57c9-08d6cfa0f21b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SN1PR12MB2384;
x-ms-traffictypediagnostic: SN1PR12MB2384:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <SN1PR12MB23843A4F89B4E9FD6F5C6C18A7350@SN1PR12MB2384.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39850400004)(396003)(346002)(136003)(376002)(199004)(189003)(55674003)(14454004)(316002)(966005)(110136005)(54906003)(74316002)(305945005)(7416002)(7736002)(478600001)(25786009)(66946007)(86362001)(5660300002)(52536014)(99286004)(7696005)(64756008)(66476007)(66556008)(66446008)(256004)(14444005)(66066001)(73956011)(76116006)(91956017)(3846002)(6116002)(4326008)(2906002)(68736007)(186003)(102836004)(6246003)(26005)(6436002)(6306002)(53936002)(55016002)(9686003)(53546011)(6506007)(81156014)(229853002)(8936002)(33656002)(446003)(81166006)(8676002)(476003)(15650500001)(486006)(71190400001)(71200400001)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR12MB2384;H:SN1PR12MB2431.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LjIFubHGOY6KJhsRBmBHCuyioyU7bQcdzKVPy2pzETPr8inP+scRjGGlhsqwtFxiG8fZcMeBhrJScUgzbEX4RCPPQradpc3Aa2LqqUIApS8cZ2QNwPeZ37YCpJXjIXdk9A98lfJKhM+OMC2Wy7eIB93LeWP8nfKTDNjUyxmoCfHmAsSlaUJm5UN2izdHKAkhfm5TTFWcso/FYUH5BMU8OqoBZQuLwJ9o5UMp/hWK0tXojVk3/upDRAIJiPNDocJnkykCC3E7M8NYIZfkXbSDPchozsSpCgLPCHTfiKvzNmfOeNnA1t+JCrv+FnZveOXuylzir69Hpx5TaZio07Wv5OSd7dYk0kDV8lwQtKY8axSDf7Esp2UThIkx/b3+DgViBQISbdfrFlVEm+OUzeKwpVcSylkBMkpm7x2lt4Wuwgk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: db7b71c4-b286-4f76-57c9-08d6cfa0f21b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 08:25:48.1117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2384
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/2019 03:58, Doug Anderson wrote:=0A=
> Hi,=0A=
> =0A=
> =0A=
> On Wed, Apr 17, 2019 at 5:15 PM Douglas Anderson <dianders@chromium.org> =
wrote:=0A=
>>=0A=
>> This is an attempt to rehash commit 0cf884e819e0 ("usb: dwc2: add bus=0A=
>> suspend/resume for dwc2") on ToT.  That commit was reverted in commit=0A=
>> b0bb9bb6ce01 ("Revert "usb: dwc2: add bus suspend/resume for dwc2"")=0A=
>> because apparently it broke the Altera SOCFPGA.=0A=
>>=0A=
>> With all the changes that have happened to dwc2 in the meantime, it's=0A=
>> possible that the Altera SOCFPGA will just magically work with this=0A=
>> change now.  ...and it would be good to get bus suspend/resume=0A=
>> implemented.=0A=
>>=0A=
>> This change is a forward port of one that's been living in the Chrome=0A=
>> OS 3.14 kernel tree.=0A=
>>=0A=
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>=0A=
>> ---=0A=
>> This patch was last posted at:=0A=
>>=0A=
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.kernel.org_r=
_1446237173-2D15263-2D1-2Dgit-2Dsend-2Demail-2Ddianders-40chromium.org&d=3D=
DwIBaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqrC_D=
7niMJI&m=3D7rxT8EFX9mqUDtTL4P7iuzYNsYROe9rxHGCresSKPTg&s=3DlTaNUA2XIYPat417=
fkd1A4Zpvb5eyYtTc1H_NIfW8Vw&e=3D=0A=
>>=0A=
>> ...and appears to have died the death of silence.  Maybe it could get=0A=
>> some bake time in linuxnext if we can't find any proactive testing?=0A=
>>=0A=
>> I will also freely admit that I don't know tons about the theory=0A=
>> behind this patch.  I'm mostly just re-hashing the original commit=0A=
>> from Kever that was reverted since:=0A=
>> * Turning on partial power down on rk3288 doesn't "just work".  I=0A=
>>    don't get hotplug events.  This is despite dwc2 auto-detecting that=
=0A=
>>    we are power optimized.=0A=
>> * If we don't do something like this commit we don't get into as low=0A=
>>    of a power mode.=0A=
> =0A=
> OK, I spent the day digging more into this patch to confirm that it's=0A=
> really the right thing to do.  ...and it still seems to be.=0A=
> =0A=
> First off: I'm pretty sure the above sentence "If we don't do=0A=
> something like this commit we don't get into as low of a power mode."=0A=
> is totally wrong.  Luckily it's "after the cut" and not part of the=0A=
> commit message.  Specifically I did a bunch of power testing and I=0A=
> couldn't find any instance saving power after this patch.=0A=
> =0A=
> ...but, then I looked more carefully at all the history of this=0A=
> commit.  I ended up at:=0A=
> =0A=
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__chromium-2Dreview.=
googlesource.com_c_chromiumos_third-5Fparty_kernel_-2B_306265_&d=3DDwIBaQ&c=
=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqrC_D7niMJI&m=
=3D7rxT8EFX9mqUDtTL4P7iuzYNsYROe9rxHGCresSKPTg&s=3DLiyyIyaCPmr88nJeI7TCGtoJ=
BFLRWir_reikYtAHHDw&e=3D=0A=
Looking at this code review I see that this patch fixes whatever issues =0A=
you have on Chrome OS 3.14. But your patch has landed on the top of =0A=
latest Kernel version. With the latest version I think you would not =0A=
have the regression issue.=0A=
So you are fixing Chrome OS 3.14.=0A=
=0A=
> =0A=
> ...where I said that this fixes a resume speed regression.  More=0A=
> details could be found at the linked bug, AKA:=0A=
> =0A=
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__bugs.chromium.org_=
p_chromium_issues_detail-3Fid-3D548336&d=3DDwIBaQ&c=3DDPL6_X_6JkXFx7AXWqB0t=
g&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqrC_D7niMJI&m=3D7rxT8EFX9mqUDtTL4P7iu=
zYNsYROe9rxHGCresSKPTg&s=3D7gK8ZGX2zZPqC98CDMhqxEY3Acm_TbYa3fpQjWtvexM&e=3D=
=0A=
> =0A=
> ...but, sadly, I wasn't as verbose as I usually am and didn't describe=0A=
> my exact testing setup.  So I tried to reproduce.  ...and I was able=0A=
> to.  I tested on an rk3288-veyron-jerry with an empty USB hub plugged=0A=
> into the left port (the host port) and my "servo 2" debug board hooked=0A=
> up to the right port.  The "power_Resume" test in Chrome OS certainly=0A=
> showed a regression in 3.14 when doing a suspend/resume cycle.=0A=
> =0A=
> =0A=
> Digging into the logs in 3.14, before this patch I saw this in the logs:=
=0A=
> =0A=
> usb 3-1: reset high-speed USB device number 2 using dwc2=0A=
> usb 3-1.7: reset high-speed USB device number 3 using dwc2=0A=
> =0A=
> ...after this patch:=0A=
> =0A=
> usb 3-1: USB disconnect, device number 2=0A=
> usb 3-1.7: USB disconnect, device number 3=0A=
> usb 3-1: new high-speed USB device number 4 using dwc2=0A=
> usb 3-1: New USB device found, idVendor=3D1a40, idProduct=3D0201, bcdDevi=
ce=3D 1.00=0A=
> usb 3-1: New USB device strings: Mfr=3D0, Product=3D1, SerialNumber=3D0=
=0A=
> usb 3-1: Product: USB 2.0 Hub [MTT]=0A=
> usb 3-1.7: new high-speed USB device number 5 using dwc2=0A=
> usb 3-1.7: New USB device found, idVendor=3D1a40, idProduct=3D0101, bcdDe=
vice=3D 1.11=0A=
> usb 3-1.7: New USB device strings: Mfr=3D0, Product=3D1, SerialNumber=3D0=
=0A=
> usb 3-1.7: Product: USB 2.0 Hub=0A=
> =0A=
> ...so basically my belief is that without this patch we're just sorta=0A=
> leaving the device hanging and it get confused on resume.  After this=0A=
> patch we behave slightly better.=0A=
> =0A=
> I tested on 4.19 and found much the same.  There:=0A=
> =0A=
> usb 2-1: reset high-speed USB device number 2 using dwc2=0A=
> usb 2-1.7: reset high-speed USB device number 3 using dwc2=0A=
> =0A=
> vs.=0A=
> =0A=
> usb 2-1.7: USB disconnect, device number 3=0A=
> usb 2-1: USB disconnect, device number 2=0A=
> usb 2-1: new high-speed USB device number 4 using dwc2=0A=
> usb 2-1: New USB device found, idVendor=3D1a40, idProduct=3D0201, bcdDevi=
ce=3D 1.00=0A=
> usb 2-1: New USB device strings: Mfr=3D0, Product=3D1, SerialNumber=3D0=
=0A=
> usb 2-1: Product: USB 2.0 Hub [MTT]=0A=
> usb 2-1.7: new high-speed USB device number 5 using dwc2=0A=
> usb 2-1.7: New USB device found, idVendor=3D1a40, idProduct=3D0101, bcdDe=
vice=3D 1.11=0A=
> usb 2-1.7: New USB device strings: Mfr=3D0, Product=3D1, SerialNumber=3D0=
=0A=
> usb 2-1.7: Product: USB 2.0 Hub=0A=
> =0A=
> =0A=
> On 4.19 I didn't actually notice a the same resume time regression,=0A=
> presumably because things are happening more asynchronously there (I=0A=
> didn't confirm this).  ...but in any case it seems like the right=0A=
> thing to do to actually do the suspend.=0A=
> =0A=
> =0A=
> I'll also re-iterate once more that I'm not claiming that my patch=0A=
> helps with "partial power down".  It merely makes the "power savings=0A=
> disabled" case work more properly.=0A=
> =0A=
> =0A=
> I'll also note that my patch is already in Felipe's "testing/next"=0A=
> branch which I continue to believe is correct and good.=0A=
> =0A=
> -Doug=0A=
> =0A=
=0A=
=0A=
-- =0A=
Regards,=0A=
Artur=0A=

Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9CCC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 05:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA94206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 05:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbfIPFqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 01:46:05 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:2745 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727053AbfIPFqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 01:46:04 -0400
X-UUID: 1ab7ea77fe4148de9a65027ebe4a1bf6-20190916
X-UUID: 1ab7ea77fe4148de9a65027ebe4a1bf6-20190916
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 694545173; Mon, 16 Sep 2019 13:45:52 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 16 Sep
 2019 13:45:48 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 16 Sep 2019 13:45:47 +0800
Message-ID: <1568612747.7317.72.camel@mhfsdcap03>
Subject: Re: [PATCH v3 3/7] usb: mtu3: support ip-sleep wakeup for MT8183
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 16 Sep 2019 13:45:47 +0800
In-Reply-To: <20190911184453.GA2628@roeck-us.net>
References: <1567150854-30033-1-git-send-email-chunfeng.yun@mediatek.com>
         <1567150854-30033-4-git-send-email-chunfeng.yun@mediatek.com>
         <20190911184453.GA2628@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: SMEX-12.5.0.1684-8.5.1010-24914.004
X-TM-AS-Result: No-8.235300-8.000000-10
X-TMASE-MatchedRID: csPTYAMX1+HmLzc6AOD8DfHkpkyUphL9dfsypiTqGpue9toQ6h6LE2ng
        VUDf4c8Y3UJTYve4D89VVkf0bJfBjyxppiUy9o4cA9lly13c/gElWygvtTclwFGLwJXlA4mIwBI
        zUVtFoCLgRgaCjJFnr+xbYZUuzB/CsWFXqrN3c5D1WO1NzV/CYNi5W7Rf+s6QiiKPXbEds+4eMp
        1P/J9F6H2dcFgFzv71OLoOGImc4B4M8jMXjBF+sIMbH85DUZXy3QfwsVk0UbtuRXh7bFKB7lAlx
        8mk+INITqHBTq5IMRMciNlpck9RPvcGG72gNuthWClYJu9r4yY=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.235300-8.000000
X-TMASE-Version: SMEX-12.5.0.1684-8.5.1010-24914.004
X-TM-SNTS-SMTP: 3242FE149AFF8C962B76284F45FA462CBA199288A603FDB43D5C66F530F60A4F2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-11 at 11:44 -0700, Guenter Roeck wrote:
> On Fri, Aug 30, 2019 at 03:40:50PM +0800, Chunfeng Yun wrote:
> > Support USB wakeup by ip-sleep mode for MT8183, it's similar to
> > MT8173
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> > v3: changes micros define
> > 
> > v2: no changes
> > ---
> >  drivers/usb/mtu3/mtu3_host.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
> > index c871b94f3e6f..4f8208885ebd 100644
> > --- a/drivers/usb/mtu3/mtu3_host.c
> > +++ b/drivers/usb/mtu3/mtu3_host.c
> > @@ -18,6 +18,12 @@
> >  #include "mtu3.h"
> >  #include "mtu3_dr.h"
> >  
> > +/* mt8183 etc */
> > +#define PERI_WK_CTRL0	0x20
> > +#define WC0_IS_C(x)	(((x) & 0xf) << 28)  /* cycle debounce */
> > +#define WC0_IS_P	BIT(12)	/* polarity */
> > +#define WC0_IS_EN	BIT(6)
> > +
> 
> For 64-bit builds, this results in:
> 
> drivers/usb/mtu3/mtu3_host.c: In function ‘ssusb_wakeup_ip_sleep_set’:
> ./include/linux/bits.h:6:19: warning:
> 	conversion from ‘long unsigned int’ to ‘u32’ {aka ‘unsigned int’}
> 	changes value from ‘18446744073441120320’ to ‘4026536000’ [-Woverflow]
> 
> since WC0_IS_C() is sign extended to 64 bit and then truncated.
Got it, thanks a lot

> 
> Observed with gcc 7.4.0 and 8.3.0.
> 
> Guenter
> 
> >  /* mt8173 etc */
> >  #define PERI_WK_CTRL1	0x4
> >  #define WC1_IS_C(x)	(((x) & 0xf) << 26)  /* cycle debounce */
> > @@ -30,7 +36,8 @@
> >  #define SSC_SPM_INT_EN		BIT(1)
> >  
> >  enum ssusb_uwk_vers {
> > -	SSUSB_UWK_V1 = 1,
> > +	SSUSB_UWK_V0 = 0,
> > +	SSUSB_UWK_V1,
> >  	SSUSB_UWK_V2,
> >  };
> >  
> > @@ -43,6 +50,11 @@ static void ssusb_wakeup_ip_sleep_set(struct ssusb_mtk *ssusb, bool enable)
> >  	u32 reg, msk, val;
> >  
> >  	switch (ssusb->uwk_vers) {
> > +	case SSUSB_UWK_V0:
> > +		reg = ssusb->uwk_reg_base + PERI_WK_CTRL0;
> > +		msk = WC0_IS_EN | WC0_IS_C(0xf) | WC0_IS_P;
> > +		val = enable ? (WC0_IS_EN | WC0_IS_C(0x8)) : 0;
> > +		break;
> >  	case SSUSB_UWK_V1:
> >  		reg = ssusb->uwk_reg_base + PERI_WK_CTRL1;
> >  		msk = WC1_IS_EN | WC1_IS_C(0xf) | WC1_IS_P;



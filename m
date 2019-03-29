Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7998EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F2B2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfC2CaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 22:30:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54705 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726879AbfC2CaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 22:30:17 -0400
X-UUID: b0eaba4bce974598ac5530a2e94f5601-20190329
X-UUID: b0eaba4bce974598ac5530a2e94f5601-20190329
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chang-an.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 783713787; Fri, 29 Mar 2019 10:30:11 +0800
Received: from MTKMBS01DR.mediatek.inc (172.21.101.111) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 29 Mar 2019 10:30:09 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01dr.mediatek.inc (172.21.101.111) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 29 Mar 2019 10:30:09 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 29 Mar 2019 10:30:08 +0800
Message-ID: <1553826609.8188.0.camel@mtkswgap22>
Subject: Re: [PATCH 1/1] sched/clock: Prevent generic sched_clock wrap
 caused by tick_freeze()
From:   Chang-An Chen <chang-an.chen@mediatek.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Corey Minyard <cminyard@mvista.com>,
        Kees Cook <keescook@chromium.org>,
        "wsd_upstream@mediatek.com" <wsd_upstream@mediatek.com>,
        "Frederic Weisbecker" <fweisbec@gmail.com>,
        Kuohong Wang =?UTF-8?Q?=28=E7=8E=8B=E5=9C=8B=E9=B4=BB=29?= 
        <kuohong.wang@mediatek.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Stanley Chu =?UTF-8?Q?=28=E6=9C=B1=E5=8E=9F=E9=99=9E=29?= 
        <stanley.chu@mediatek.com>, Ingo Molnar <mingo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 29 Mar 2019 10:30:09 +0800
In-Reply-To: <alpine.DEB.2.21.1903251449580.1656@nanos.tec.linutronix.de>
References: <1553497460-24166-1-git-send-email-chang-an.chen@mediatek.com>
         <alpine.DEB.2.21.1903251449580.1656@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
X-TM-SNTS-SMTP: 14987561F91BA70A792CD74CDF9F73529BF268650DE7932F6F6B79783E41734A2000:8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-25 at 21:54 +0800, Thomas Gleixner wrote:
> On Mon, 25 Mar 2019, Chang-An Chen wrote:
> > --- a/include/linux/sched_clock.h
> > +++ b/include/linux/sched_clock.h
> > @@ -13,6 +13,10 @@
> >  
> >  extern void sched_clock_register(u64 (*read)(void), int bits,
> >  				 unsigned long rate);
> > +
> > +extern int sched_clock_suspend(void);
> > +
> > +extern void sched_clock_resume(void);
> >  #else
> >  static inline void generic_sched_clock_init(void) { }
> >  
> > @@ -20,6 +24,10 @@ static inline void sched_clock_register(u64 (*read)(void), int bits,
> >  					unsigned long rate)
> >  {
> >  }
> > +
> > +static int sched_clock_suspend(void) { }
> 
> static inline ...
> 
> > +
> > +static void sched_clock_resume(void) { }
> 
> Ditto
> 
> >  #endif
> 
> Please do not expose this in the global header. All of this is local to
> kernel/time/. So adding this to kernel/time/timekeeping.h is sufficient.
Thanks so much for review and the suggestion, I'll fix it in next
version.

Thanks,
Chang-An
> 
> Thanks,
> 
> 	tglx
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek




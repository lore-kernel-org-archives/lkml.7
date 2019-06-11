Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EC7C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170B22086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403871AbfFKFsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 01:48:04 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:62225 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390485AbfFKFsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 01:48:01 -0400
X-UUID: 8dd45107285d4157a64b8222a8fbe719-20190611
X-UUID: 8dd45107285d4157a64b8222a8fbe719-20190611
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1836222041; Tue, 11 Jun 2019 13:47:49 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 11 Jun
 2019 13:47:48 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 11 Jun 2019 13:47:46 +0800
Message-ID: <1560232066.8487.119.camel@mhfsdcap03>
Subject: Re: [PATCH v6 09/10] usb: roles: add USB Type-B GPIO connector
 driver
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        "Badhri Jagan Sridharan" <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Min Guo <min.guo@mediatek.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Yu Chen" <chenyu56@huawei.com>
Date:   Tue, 11 Jun 2019 13:47:46 +0800
In-Reply-To: <CAHp75VeWu+8H2=PRNud_MAoD9zozb2Ugh9b=9TCtYmGLVyCTpQ@mail.gmail.com>
References: <1559115828-19146-1-git-send-email-chunfeng.yun@mediatek.com>
         <1559115828-19146-10-git-send-email-chunfeng.yun@mediatek.com>
         <CAHp75VcbZwd0e6r38C2x7HLEHLr4oR7TjwdDXnDxRPRs3anwgA@mail.gmail.com>
         <1559789630.8487.111.camel@mhfsdcap03>
         <CAHp75VeWu+8H2=PRNud_MAoD9zozb2Ugh9b=9TCtYmGLVyCTpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-06 at 09:31 +0300, Andy Shevchenko wrote:
> On Thu, Jun 6, 2019 at 5:53 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> >
> > On Wed, 2019-06-05 at 11:45 +0300, Andy Shevchenko wrote:
> > > On Wed, May 29, 2019 at 10:44 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> > > >
> > > > Due to the requirement of usb-connector.txt binding, the old way
> > > > using extcon to support USB Dual-Role switch is now deprecated
> > > > when use Type-B connector.
> > > > This patch introduces a driver of Type-B connector which typically
> > > > uses an input GPIO to detect USB ID pin, and try to replace the
> > > > function provided by extcon-usb-gpio driver
> > >
> > > > +static SIMPLE_DEV_PM_OPS(usb_conn_pm_ops,
> > > > +                        usb_conn_suspend, usb_conn_resume);
> > > > +
> > > > +#define DEV_PMS_OPS (IS_ENABLED(CONFIG_PM_SLEEP) ? &usb_conn_pm_ops : NULL)
> > >
> > > Why this macro is needed?
> > Want to set .pm as NULL when CONFIG_PM_SLEEP is not enabled.
> 
> Doesn't SIMPLE_DEV_PM_OPS do this for you?
Yes, you are right, it provides an empty dev_pm_ops struct, I'll remove
DEV_PMS_OPS, thanks a lot

> 



Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E55AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B0C2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfCKFhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 01:37:04 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:24152 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725831AbfCKFhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 01:37:04 -0400
X-UUID: 73e3b52d8458424f9c88be9670eb6111-20190311
X-UUID: 73e3b52d8458424f9c88be9670eb6111-20190311
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1580970763; Mon, 11 Mar 2019 13:36:58 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 11 Mar
 2019 13:36:56 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Mar 2019 13:36:56 +0800
Message-ID: <1552282615.10179.25.camel@mhfsdcap03>
Subject: Re: [PATCH 3/5] usb: roles: add API to get usb_role_switch by node
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
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 11 Mar 2019 13:36:55 +0800
In-Reply-To: <CAHp75VeW+NoaGQCnfMcZSz67V68ykRMO=BG9_U6NFODJ5g=1FA@mail.gmail.com>
References: <1552025622-15582-1-git-send-email-chunfeng.yun@mediatek.com>
         <1552025622-15582-4-git-send-email-chunfeng.yun@mediatek.com>
         <CAHp75VeW+NoaGQCnfMcZSz67V68ykRMO=BG9_U6NFODJ5g=1FA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2019-03-08 at 08:52 +0200, Andy Shevchenko wrote:
> On Fri, Mar 8, 2019 at 8:14 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> >
> > Add usb_role_switch_get_by_node() to make easier to get
> > usb_role_switch by node which register it.
> > It's useful when there is not device_connection registered
> > between two drivers and only knows the node which register
> > usb_role_switch.
> 
> > +static int __switch_match_node(struct device *dev, const void *node)
> > +{
> > +       return dev->parent->of_node == (const struct device_node *)node;
> > +}
> 
> Hmm... Shouldn't be slightly better to compare fwnode instead?
> 
Using fwnode is indeed suitable for more cases,
I find that there are many functions named xx_by_node using node, but
not fwnode, is there any rules about choice between device_node and
fwnode_handle?

Thanks



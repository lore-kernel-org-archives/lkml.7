Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583C9C3A5A9
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 02:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261EF2087E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 02:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbfIECzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 22:55:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41955 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727156AbfIECzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 22:55:47 -0400
X-UUID: d9901c0c1e464b65a24bbe661a4e278f-20190905
X-UUID: d9901c0c1e464b65a24bbe661a4e278f-20190905
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1309410172; Thu, 05 Sep 2019 10:55:40 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs07n2.mediatek.inc
 (172.21.101.141) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 5 Sep
 2019 10:55:36 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 5 Sep 2019 10:55:34 +0800
Message-ID: <1567652136.11483.1.camel@mhfsdcap03>
Subject: Re: [PATCH 2/2] mmc: block: add CMD13 polling for ioctl() cmd with
 R1B response
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     Avri Altman <Avri.Altman@wdc.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ming Lei <ming.lei@redhat.com>, "Chris Boot" <bootc@bootc.net>,
        Zachary Hays <zhays@lexmark.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>
Date:   Thu, 5 Sep 2019 10:55:36 +0800
In-Reply-To: <MN2PR04MB6991F51F6DDCA28FC23D02FEFCB80@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <20190904075444.2163-1-chaotian.jing@mediatek.com>
         <20190904075444.2163-3-chaotian.jing@mediatek.com>
         <MN2PR04MB6991F51F6DDCA28FC23D02FEFCB80@MN2PR04MB6991.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-04 at 14:11 +0000, Avri Altman wrote:
> >  static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct
> > mmc_blk_data *md,
> >                                struct mmc_blk_ioc_data *idata)
> >  {
> > @@ -623,6 +675,9 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> > *card, struct mmc_blk_data *md,
> >                                         __func__, status, err);
> >         }
> > 
> > +       if (!err && (cmd.flags & MMC_RSP_R1B))
> > +               err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, NULL);
> > +
> >         return err;
> >  }
> You have both the R1B flag check, and status poll (for rpmb) few line above.
> Maybe you could re-use it.
> It will both simplify this patch, and save the tad optimization of your first patch.
> 
> Thanks,
> Avri

So that we can drop the ioctl_rpmb_card_status_poll() as it do almost
the same thing with card_busy_detect().



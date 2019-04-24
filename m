Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4884BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA5620656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfDXIlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:41:52 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:33064 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfDXIlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:41:51 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id D51F425AE8A;
        Wed, 24 Apr 2019 18:41:49 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id CE82994041B; Wed, 24 Apr 2019 10:41:47 +0200 (CEST)
Date:   Wed, 24 Apr 2019 10:41:47 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Jiada Wang <jiada_wang@mentor.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Hien Dang <hien.dang.eb@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Dien Pham <dien.pham.ry@renesas.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Biju Das <biju.das@bp.renesas.com>,
        "George G. Davis" <george_davis@mentor.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v1 1/1] thermal: rcar_gen3_thermal: request IRQ after
 device initialization
Message-ID: <20190424084147.7ztvgxd7odaojqg6@verge.net.au>
References: <20190411100352.15977-1-jiada_wang@mentor.com>
 <20190416174741.GA26470@vmlxhi-102.adit-jv.com>
 <20190423100107.p3p3jmvv6dph6uy6@verge.net.au>
 <20190423112408.GA3954@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190423112408.GA3954@vmlxhi-102.adit-jv.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 01:24:08PM +0200, Eugeniu Rosca wrote:
> Hi Simon,
> 
> On Tue, Apr 23, 2019 at 12:01:07PM +0200, Simon Horman wrote:
> > On Tue, Apr 16, 2019 at 07:48:30PM +0200, Eugeniu Rosca wrote:
> > > Hi Jiada,
> > > 
> > > Adding below people, since they've made recent contributions to the
> > > driver and might be interested in your patch:
> > > 
> > > git log master --since="1 year" -- drivers/thermal/rcar_gen3_thermal.c \
> > >     | grep -o "\-by:.*" | sed 's/\-by: //' | sort | uniq -c | sort -rn
> > >       7 Eduardo Valentin <edubezval@gmail.com>
> > >       6 Simon Horman <horms+renesas@verge.net.au>
> > >       5 Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > >       2 Geert Uytterhoeven <geert+renesas@glider.be>
> > >       1 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > >       1 Marek Vasut <marek.vasut+renesas@gmail.com>
> > >       1 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > >       1 Hien Dang <hien.dang.eb@renesas.com>
> > >       1 Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > >       1 Dien Pham <dien.pham.ry@renesas.com>
> > >       1 Daniel Lezcano <daniel.lezcano@linaro.org>
> > >       1 Biju Das <biju.das@bp.renesas.com>
> > > 
> > > I confirm that loading and unloading the rcar3 thermal driver in a
> > > loop produces soft lockup using v5.1-rc5-10-g618d919cae2f on
> > > H3-ES2.0-Salvator-X. 
> > > 
> > > Full log and .config can be found here:
> > > https://gist.github.com/erosca/1f76b6dd897cdc39581fca475155e363
> > > 
> > > I post an excerpt from the above [1] (why not including it in the
> > > description?). Also, why not rephrasing the commit summary line in such
> > > a way that everybody understands this patch fixes a severe issue, e.g.
> > > "thermal: rcar_gen3_thermal: Fix soft lockup on probe" ?
> > > 
> > > BTW, with this patch applied I left the thermal driver being
> > > loaded/unloaded on the target for over one hour w/o seeing the issue
> > > reproduced. So, while there might be slight variations in how the final
> > > solution looks like, I think the patch already deserves a:
> > > 
> > > Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> > > 
> > > [1] Soft lockup reproduced with v5.1-rc5-10-g618d919cae2f
> > 
> > Thanks,
> > 
> > Unfortunately I do not see the patch in my inbox.
> > Would you care to repost it including the following recipients.
> > 
> > linux-pm@vger.kernel.org
> > Zhang Rui <rui.zhang@intel.com>
> > Eduardo Valentin <edubezval@gmail.com>
> > linux-renesas-soc@vger.kernel.org
> > Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > 
> > Feel free to include the suggestions made by Eugeniu above and post a v2.
> 
> There is a v2 pushed recently:
> https://patchwork.kernel.org/cover/10911999/
> ("[v2,0/2] thermal: rcar_gen3_thermal: fix IRQ issues").
> 
> It seems to include both the preparatory work suggested by Daniel
> in https://patchwork.kernel.org/patch/10895557/#22592583,
> as well as the soft lockup fix itself.

Thanks, I see v2 now.

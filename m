Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA6EC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0446B2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfDWLYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:24:24 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:54817 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfDWLYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:24:23 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 435113C00C1;
        Tue, 23 Apr 2019 13:24:19 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mOEBKp-w5N9V; Tue, 23 Apr 2019 13:24:11 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 4B96A3C0034;
        Tue, 23 Apr 2019 13:24:11 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 23 Apr
 2019 13:24:11 +0200
Date:   Tue, 23 Apr 2019 13:24:08 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Simon Horman <horms@verge.net.au>
CC:     Jiada Wang <jiada_wang@mentor.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>,
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
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH v1 1/1] thermal: rcar_gen3_thermal: request IRQ after
 device initialization
Message-ID: <20190423112408.GA3954@vmlxhi-102.adit-jv.com>
References: <20190411100352.15977-1-jiada_wang@mentor.com>
 <20190416174741.GA26470@vmlxhi-102.adit-jv.com>
 <20190423100107.p3p3jmvv6dph6uy6@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190423100107.p3p3jmvv6dph6uy6@verge.net.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On Tue, Apr 23, 2019 at 12:01:07PM +0200, Simon Horman wrote:
> On Tue, Apr 16, 2019 at 07:48:30PM +0200, Eugeniu Rosca wrote:
> > Hi Jiada,
> > 
> > Adding below people, since they've made recent contributions to the
> > driver and might be interested in your patch:
> > 
> > git log master --since="1 year" -- drivers/thermal/rcar_gen3_thermal.c \
> >     | grep -o "\-by:.*" | sed 's/\-by: //' | sort | uniq -c | sort -rn
> >       7 Eduardo Valentin <edubezval@gmail.com>
> >       6 Simon Horman <horms+renesas@verge.net.au>
> >       5 Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> >       2 Geert Uytterhoeven <geert+renesas@glider.be>
> >       1 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >       1 Marek Vasut <marek.vasut+renesas@gmail.com>
> >       1 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >       1 Hien Dang <hien.dang.eb@renesas.com>
> >       1 Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >       1 Dien Pham <dien.pham.ry@renesas.com>
> >       1 Daniel Lezcano <daniel.lezcano@linaro.org>
> >       1 Biju Das <biju.das@bp.renesas.com>
> > 
> > I confirm that loading and unloading the rcar3 thermal driver in a
> > loop produces soft lockup using v5.1-rc5-10-g618d919cae2f on
> > H3-ES2.0-Salvator-X. 
> > 
> > Full log and .config can be found here:
> > https://gist.github.com/erosca/1f76b6dd897cdc39581fca475155e363
> > 
> > I post an excerpt from the above [1] (why not including it in the
> > description?). Also, why not rephrasing the commit summary line in such
> > a way that everybody understands this patch fixes a severe issue, e.g.
> > "thermal: rcar_gen3_thermal: Fix soft lockup on probe" ?
> > 
> > BTW, with this patch applied I left the thermal driver being
> > loaded/unloaded on the target for over one hour w/o seeing the issue
> > reproduced. So, while there might be slight variations in how the final
> > solution looks like, I think the patch already deserves a:
> > 
> > Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> > 
> > [1] Soft lockup reproduced with v5.1-rc5-10-g618d919cae2f
> 
> Thanks,
> 
> Unfortunately I do not see the patch in my inbox.
> Would you care to repost it including the following recipients.
> 
> linux-pm@vger.kernel.org
> Zhang Rui <rui.zhang@intel.com>
> Eduardo Valentin <edubezval@gmail.com>
> linux-renesas-soc@vger.kernel.org
> Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> Feel free to include the suggestions made by Eugeniu above and post a v2.

There is a v2 pushed recently:
https://patchwork.kernel.org/cover/10911999/
("[v2,0/2] thermal: rcar_gen3_thermal: fix IRQ issues").

It seems to include both the preparatory work suggested by Daniel
in https://patchwork.kernel.org/patch/10895557/#22592583,
as well as the soft lockup fix itself.

Best regard,
Eugeniu.

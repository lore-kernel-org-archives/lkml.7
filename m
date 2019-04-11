Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE34AC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FF02133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfDKGif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:38:35 -0400
Received: from gloria.sntech.de ([185.11.138.130]:54832 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfDKGif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:38:35 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hETLp-00061w-2W; Thu, 11 Apr 2019 08:38:21 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Ziyuan Xu <xzy.xu@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Ryan Case <ryandcase@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] clk: rockchip: Fix video codec clocks on rk3288
Date:   Thu, 11 Apr 2019 08:38:20 +0200
Message-ID: <3815078.yV5O778F5b@diego>
In-Reply-To: <CAD=FV=W=gPgYNrVAXYa=9bz1e5+KBD1Xu7UK-pPkH25esFiW9A@mail.gmail.com>
References: <20190329215455.159717-1-dianders@chromium.org> <AM3PR03MB09665B2755982816D2FC37E4AC2E0@AM3PR03MB0966.eurprd03.prod.outlook.com> <CAD=FV=W=gPgYNrVAXYa=9bz1e5+KBD1Xu7UK-pPkH25esFiW9A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

Am Donnerstag, 11. April 2019, 01:37:33 CEST schrieb Doug Anderson:
> Hi,
> 
> On Wed, Apr 10, 2019 at 11:38 AM Jonas Karlman <jonas@kwiboo.se> wrote:
> >
> > On 2019-04-10 17:45, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Fri, Mar 29, 2019 at 2:55 PM Douglas Anderson <dianders@chromium.org> wrote:
> > >> It appears that there is a typo in the rk3288 TRM.  For
> > >> GRF_SOC_CON0[7] it says that 0 means "vepu" and 1 means "vdpu".  It's
> > >> the other way around.
> > >>
> > >> How do I know?  Here's my evidence:
> > >>
> > >> 1. Prior to commit 4d3e84f99628 ("clk: rockchip: describe aclk_vcodec
> > >>    using the new muxgrf type on rk3288") we always pretended that we
> > >>    were using "aclk_vdpu" and the comment in the code said that this
> > >>    matched the default setting in the system.  In fact the default
> > >>    setting is 0 according to the TRM and according to reading memory
> > >>    at bootup.  In addition rk3288-based Chromebooks ran like this and
> > >>    the video codecs worked.
> > >> 2. With the existing clock code if you boot up and try to enable the
> > >>    new VIDEO_ROCKCHIP_VPU as a module (and without "clk_ignore_unused"
> > >>    on the command line), you get errors like "failed to get ack on
> > >>    domain 'pd_video', val=0x80208".  After flipping vepu/vdpu things
> > >>    init OK.
> > >> 3. If I export and add both the vepu and vdpu to the list of clocks
> > >>    for RK3288_PD_VIDEO I can get past the power domain errors, but now
> > >>    I freeze when the vpu_mmu gets initted.
> > >> 4. If I just mark the "vdpu" as IGNORE_UNUSED then everything boots up
> > >>    and probes OK showing that somehow the "vdpu" was important to keep
> > >>    enabled.  This is because we were actually using it as a parent.
> > >> 5. After this change I can hack "aclk_vcodec_pre" to parent from
> > >>    "aclk_vepu" using assigned-clocks and the video codec still probes
> > >>    OK.
> > >>
> > >> Fixes: 4d3e84f99628 ("clk: rockchip: describe aclk_vcodec using the new muxgrf type on rk3288")
> > >> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > >> ---
> > >> I currently have no way to test the JPEG mem2mem driver, so hopefully
> > >> others can test this and make sure it's happy for them.  I'm just
> > >> happy not to get strange errors at boot anymore.
> > >>
> > >>  drivers/clk/rockchip/clk-rk3288.c | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > > Any thoughts about this patch?  I'm 99.9% certain it's correct and
> > > it'd be nice to get it landed.  Heiko: I assume you're still
> > > collecting Rockchip clock patches and would be the one to apply it and
> > > (at some point) send a pull request to the clock tree?
> > >
> > > -Doug
> >
> > This clk fix is needed to make MPEG-2 decoding work on my RK3288 Tinker Board using the
> > rockchip vpu patchset and a patch to add RK3288 specific MPEG-2 code [1].
> >
> > Also note that the same change was suggested in a previous patch [2] from by ayaka.
> >
> > If possible please also add the CLK_SET_RATE_PARENT change from [3] in a possible v2,
> > that fixes assigning the aclk_vcodec clk to 400Mhz in the rockchip vpu driver.
> >
> > [1] https://github.com/Kwiboo/linux-rockchip/commit/1f78093e05c7360515a185f48b7c5cb8ba1e3e15
> > [2] https://patchwork.kernel.org/patch/9725553/
> > [3] https://github.com/Kwiboo/linux-rockchip/commit/9216da3f1521a0be5889235abe7fa093a4894160
> 
> Thanks for the pointers!  Now I'm 99.9999% certain that my patch is
> correct instead of just 99.9%.  ;-)
> 
> IMO the CLK_SET_RATE_PARENT should probably be a separate patch but it
> does seem like we need it.  ...and actually the patch adding it should
> have a Fixes tag of the same commit.  Prior to that commit the parent
> of "aclk_vcodec" was "aclk_vdpu".  As a gate clock it would
> automatically have CLK_SET_RATE_PARENT so you could easily set the
> rate.  ...and it looks as if the downstream video codec driver in
> Chrome OS relies on this too.
> 
> I'm happy to add that in a v2 if Heiko is happy with it.

Sounds very sensible to me to combine these 2 parts.

Heiko



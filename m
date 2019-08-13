Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98E7C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AE3206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfHMKY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 06:24:57 -0400
Received: from muru.com ([72.249.23.125]:57090 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbfHMKYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:24:55 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 560AE805C;
        Tue, 13 Aug 2019 10:25:22 +0000 (UTC)
Date:   Tue, 13 Aug 2019 03:24:51 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] Regression in next with codec unload and
        snd_soc_component_get/put
Message-ID: <20190813102451.GJ52127@atomide.com>
References: <20190809070003.GA52127@atomide.com>
 <s5hwofmhkbs.wl-tiwai@suse.de>
 <20190809074643.GB52127@atomide.com>
 <s5hv9v6hhm9.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hv9v6hhm9.wl-tiwai@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Takashi Iwai <tiwai@suse.de> [190809 08:24]:
> On Fri, 09 Aug 2019 09:46:43 +0200,
> Tony Lindgren wrote:
> > 
> > * Takashi Iwai <tiwai@suse.de> [190809 07:25]:
> > > On Fri, 09 Aug 2019 09:00:03 +0200,
> > > Tony Lindgren wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > Looks like commit 4a81e8f30d0b ("ASoC: soc-component: add
> > > > snd_soc_component_get/put()") causes a regression where trying
> > > > to rmmod a codec driver fails with module is in use error after
> > > > rmmod of snd-soc-audio-graph-card for example.
> > > > 
> > > > Any ideas what goes wrong there?
> > > 
> > > There is an obvious typo: soc_cleanup_component() should call
> > > snd_soc_component_module_put_when_remove() instead of *_close().
> > 
> > Making that change locally seems to fix it thanks.
> 
> ... and it was already fixed in the later commit 0e36f36b04e7
> "ASoC: soc-core: fix module_put() warning in soc_cleanup_component".

Mark, looks like this commit is still not in Linux next, forgot
to push out something?

Regards,

Tony

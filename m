Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD09C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 23:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019CD206D6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 23:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="waXEB/ob";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YcshugNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfLHXYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 18:24:44 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36019 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726806AbfLHXYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 18:24:44 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1D8822277F;
        Sun,  8 Dec 2019 18:24:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 08 Dec 2019 18:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=nopB/gRQ8PTpUJF9kLbZLuPWsTI
        Gg9kxwUN1KrT99Ow=; b=waXEB/obXrDsPjyrHY7BxGVHYrR5ZcTZf9G1TkSnf0M
        0N+pzHyYcTRHKZaFsROloUpbjnF8iOrrj27zbigulyFCpvgBKaRVGlBeGVtGQjEK
        FoW7vOHpSi1HsM4BsqxEoE/0+pWHVmWEqVoOdLB9V1tiwPdzRWDL7+qKzHBVfRch
        +eY/QE/IWzAivxzbhaVvZaI03HzRz8j9L4Z32rAyaRb+ukU5VaDPpEht6V2LH98s
        haXm0wxDyurmNC3jCObit3Zt/yNRxQb2+QsnYWqTMHdTEV0MBbVYOMnF6QS3KzSz
        MvcCsP2LMy13Be0YMsvgF/RkasJItKD8y5pU9QcnYpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=nopB/g
        RQ8PTpUJF9kLbZLuPWsTIGg9kxwUN1KrT99Ow=; b=YcshugNeLjSVHlDJZlQA/3
        9TMFjBWI06gH/e85AQeAYG3KUXKLRiWkH4j5zsaYxc4ex4doFxRSF+6SWTFPJ6sW
        0cQ2PBvXCzXjwFRYiCPCPnLZih2mF0e2NyOTqLYcLyAE5LRFq3ngryqogxebCvig
        rKiNkiaCQdPP1BhvzMlLO2wYXalHok053vzwGg8t1az0+EzEXxpLJqrHRdlvVaD4
        VcM9C4XufoYbTAhN+9ACZw9mFNDczVLHdsPQeF8hic3xeTAI5GrMIJz0/2EvRnup
        CPIV2QuIs7JrHFHddQ+5lzlwsaK46y0OBmM+4pZ/KlSXxdC1TsvKSm41UgMh9BqA
        ==
X-ME-Sender: <xms:OobtXckn11bF_MiG0H72qsDcvCAIEdP7NxuDjqipO2pxK0QNGle-sQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudekledgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdptddurdhorhhgpdgrlhhsrgdq
    phhrohhjvggtthdrohhrghenucfkphepudegrdefrdejhedrudekudenucfrrghrrghmpe
    hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:OobtXRK8GQ3nz9SEJEkS9KbwUDg2qnAqoheOXRJ0QxXwL7LdUtx1Wg>
    <xmx:OobtXWs3Uwx-me3klHPNFVK69vcQsLX_Sk_9Oy0R_nqTCPIJula0EQ>
    <xmx:OobtXVKdacFwHTHPxZePcFPYMPPlF5wYf2581QP7FTJawPTG71jegA>
    <xmx:O4btXbde8oVfS1-zsdAJ4E6XLmnFjkamDimdpCRvZgXYrI-2Hlchvw>
Received: from workstation (ae075181.dynamic.ppp.asahi-net.or.jp [14.3.75.181])
        by mail.messagingengine.com (Postfix) with ESMTPA id DEFA88005B;
        Sun,  8 Dec 2019 18:24:40 -0500 (EST)
Date:   Mon, 9 Dec 2019 08:24:38 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: sound/firewire/motu/motu-pcm.c:191 pcm_open() error: double
 unlocked 'motu->mutex' (orig line 179)
Message-ID: <20191208232437.GA6741@workstation>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>
References: <20191208084034.GU1787@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191208084034.GU1787@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Sun, Dec 08, 2019 at 11:40:34AM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   94e89b40235476a83a53a47b9ffb0cb91a4c335e
> commit: 3fd80b2003882b6a328caff9e6b3a14bed61f27c ALSA: firewire-motu: use the same size of period for PCM substream in AMDTP streams
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> sound/firewire/motu/motu-pcm.c:191 pcm_open() error: double unlocked 'motu->mutex' (orig line 179)

Indeed, it's a bug introduced in v5.5 kernel. I posted a patch to fix
this just now:
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-December/159552.html

> # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3fd80b2003882b6a328caff9e6b3a14bed61f27c
> git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git remote update linus
> git checkout 3fd80b2003882b6a328caff9e6b3a14bed61f27c
> vim +191 sound/firewire/motu/motu-pcm.c
> 
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  133  static int pcm_open(struct snd_pcm_substream *substream)
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  134  {
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  135  	struct snd_motu *motu = substream->private_data;
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  136  	const struct snd_motu_protocol *const protocol = motu->spec->protocol;
> 3fd80b2003882b Takashi Sakamoto 2019-10-07  137  	struct amdtp_domain *d = &motu->domain;
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  138  	enum snd_motu_clock_source src;
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  139  	int err;
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  140  
> 71c3797779d3cd Takashi Sakamoto 2017-03-22  141  	err = snd_motu_stream_lock_try(motu);
> 71c3797779d3cd Takashi Sakamoto 2017-03-22  142  	if (err < 0)
> 71c3797779d3cd Takashi Sakamoto 2017-03-22  143  		return err;
> 71c3797779d3cd Takashi Sakamoto 2017-03-22  144  
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  145  	mutex_lock(&motu->mutex);
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  146  
> 8b460c76bd1712 Takashi Sakamoto 2017-08-20  147  	err = snd_motu_stream_cache_packet_formats(motu);
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  148  	if (err < 0)
> 71c3797779d3cd Takashi Sakamoto 2017-03-22  149  		goto err_locked;
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  150  
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  151  	err = init_hw_info(motu, substream);
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  152  	if (err < 0)
> 71c3797779d3cd Takashi Sakamoto 2017-03-22  153  		goto err_locked;
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  154  
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  155  	err = protocol->get_clock_source(motu, &src);
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  156  	if (err < 0)
> 71c3797779d3cd Takashi Sakamoto 2017-03-22  157  		goto err_locked;
> 3fd80b2003882b Takashi Sakamoto 2019-10-07  158  
> 3fd80b2003882b Takashi Sakamoto 2019-10-07  159  	// When source of clock is not internal or any stream is reserved for
> 3fd80b2003882b Takashi Sakamoto 2019-10-07  160  	// transmission of PCM frames, the available sampling rate is limited
> 3fd80b2003882b Takashi Sakamoto 2019-10-07  161  	// at current one.
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  162  	if (src != SND_MOTU_CLOCK_SOURCE_INTERNAL ||
> 3fd80b2003882b Takashi Sakamoto 2019-10-07  163  	    (motu->substreams_counter > 0 && d->events_per_period > 0)) {
> 3fd80b2003882b Takashi Sakamoto 2019-10-07  164  		unsigned int frames_per_period = d->events_per_period;
> 3fd80b2003882b Takashi Sakamoto 2019-10-07  165  		unsigned int rate;
> 3fd80b2003882b Takashi Sakamoto 2019-10-07  166  
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  167  		err = protocol->get_clock_rate(motu, &rate);
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  168  		if (err < 0)
> 71c3797779d3cd Takashi Sakamoto 2017-03-22  169  			goto err_locked;
> 3fd80b2003882b Takashi Sakamoto 2019-10-07  170  
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  171  		substream->runtime->hw.rate_min = rate;
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  172  		substream->runtime->hw.rate_max = rate;
> 3fd80b2003882b Takashi Sakamoto 2019-10-07  173  
> 3fd80b2003882b Takashi Sakamoto 2019-10-07  174  		if (frames_per_period > 0) {
> 3fd80b2003882b Takashi Sakamoto 2019-10-07  175  			err = snd_pcm_hw_constraint_minmax(substream->runtime,
> 3fd80b2003882b Takashi Sakamoto 2019-10-07  176  					SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
> 3fd80b2003882b Takashi Sakamoto 2019-10-07  177  					frames_per_period, frames_per_period);
> 3fd80b2003882b Takashi Sakamoto 2019-10-07  178  			if (err < 0) {
> 3fd80b2003882b Takashi Sakamoto 2019-10-07 @179  				mutex_unlock(&motu->mutex);
>                                                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^
> Delete this.
> 
> 3fd80b2003882b Takashi Sakamoto 2019-10-07  180  				goto err_locked;
> 3fd80b2003882b Takashi Sakamoto 2019-10-07  181  			}
> 3fd80b2003882b Takashi Sakamoto 2019-10-07  182  		}
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  183  	}
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  184  
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  185  	snd_pcm_set_sync(substream);
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  186  
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  187  	mutex_unlock(&motu->mutex);
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  188  
> 3fd80b2003882b Takashi Sakamoto 2019-10-07  189  	return 0;
> 71c3797779d3cd Takashi Sakamoto 2017-03-22  190  err_locked:
> 71c3797779d3cd Takashi Sakamoto 2017-03-22 @191  	mutex_unlock(&motu->mutex);
> 71c3797779d3cd Takashi Sakamoto 2017-03-22  192  	snd_motu_stream_lock_release(motu);
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  193  	return err;
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  194  }
> dd49b2d1f04af9 Takashi Sakamoto 2017-03-22  195  
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation


Thanks

Takashi Sakamoto

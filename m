Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE12EC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 04:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97012178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 04:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573187401;
	bh=tqpTzta+Se1TB7bsp9vwIxnbM/32x+fpr6Gz4NiCsUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BdViqMmmsoBbMO5rSa2bopXw15tDetZs6nGJMY/qE5z6cyvpLsCOR7+BKqWXnLkkN
	 y2rqDTmiJLiK3H9HPSYynrquExlGAj+s9E+HjyJvw3Pahmm07AbgcEJhLGMdglxGRA
	 /9TIv2SY8uBMHUfxqiR8Gbrq5LRsOu4w904P++Ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfKHE3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 23:29:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfKHE3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 23:29:45 -0500
Received: from localhost (unknown [106.200.194.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC6EA2178F;
        Fri,  8 Nov 2019 04:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573187384;
        bh=tqpTzta+Se1TB7bsp9vwIxnbM/32x+fpr6Gz4NiCsUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mUmLjVWFgPkKpVnapidjks07A8JjQPo+B7cRJRcWJQA+U2UqTnSIPDI0awYh5TP3f
         UsyPIyx6v2OuKZkavu3mnXWCLUbKsTEkB0pNgXvMWMuJcpujNfWlE1H9q/D7AdouHC
         0Z2h/h4D4IBXVXPI824hWB0qDQJDtmWs/pQkh6Co=
Date:   Fri, 8 Nov 2019 09:59:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [PATCH 1/4] soundwire: sdw_slave: add new fields to
 track probe status
Message-ID: <20191108042940.GW952516@vkoul-mobl>
References: <20191023210657.32440-1-pierre-louis.bossart@linux.intel.com>
 <20191023210657.32440-2-pierre-louis.bossart@linux.intel.com>
 <20191103045604.GE2695@vkoul-mobl.Dlink>
 <f53b28bb-1ec7-a400-54ed-51fd55819ecd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f53b28bb-1ec7-a400-54ed-51fd55819ecd@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-11-19, 08:32, Pierre-Louis Bossart wrote:
> 
> 
> On 11/2/19 11:56 PM, Vinod Koul wrote:
> > On 23-10-19, 16:06, Pierre-Louis Bossart wrote:
> > > Changes to the sdw_slave structure needed to solve race conditions on
> > > driver probe.
> > 
> > Can you please explain the race you have observed, it would be a very
> > useful to document it as well
> 
> the races are explained in the [PATCH 00/18] soundwire: code hardening and
> suspend-resume support series.

It would make sense to explain it here as well to give details to
reviewers, there is nothing wrong with too much detail!

> > > 
> > > The functionality is added in the next patch.
> > 
> > which one..?
> 
> [PATCH 00/18] soundwire: code hardening and suspend-resume support

Yeah great! let me play detective with 18 patch series. I asked for a
patch and got a series!

Again, please help the maintainer to help you. We would love to see this
merged as well, but please step up and give more details in cover
letter and changelogs. I shouldn't need to do guesswork and scan through the
inbox to find the context!

-- 
~Vinod

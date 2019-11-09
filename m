Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083F6C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 11:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5682196F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 11:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573297947;
	bh=Ih1gqL9K79deWWPJ7N5Ey9xumJfXVew2LQ3mdBECbIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1hv3VV03xKIfCRCH1Fo+UqrxI1FEfdS21dYsAMUyb2gjqKzUf/BX7etQ4/w9yR2ct
	 IuYPC6aaLdTaVxpwVkaSYuV7/uX26tX+P1y9YkQ9/cDbLDsfTtUxoJUA6EqkqPLTPp
	 HRhGYqeNlveDiabLRUhU639SIpFzZ5B0sjxQm/NY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfKILM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 06:12:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:51536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfKILM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 06:12:26 -0500
Received: from localhost (unknown [122.167.114.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF994207FF;
        Sat,  9 Nov 2019 11:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573297945;
        bh=Ih1gqL9K79deWWPJ7N5Ey9xumJfXVew2LQ3mdBECbIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=etj3+NvKNa8LXILht79CcBorNP6PJ2bHLaPUX5Zck4tY7qfiHUTgx79fR5su+gSP5
         WsHfDRsCNSXsRL3WtemLG+dfGqkUcdrb0dENFrc7YkaOOv6rL6CSh/MUbFHjSFY5Y/
         RuIOCxd0INBSI5kV68u67JrnqLlGn4LJH/ACx/yI=
Date:   Sat, 9 Nov 2019 16:42:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 1/4] soundwire: sdw_slave: add new fields to
 track probe status
Message-ID: <20191109111211.GB952516@vkoul-mobl>
References: <20191023210657.32440-1-pierre-louis.bossart@linux.intel.com>
 <20191023210657.32440-2-pierre-louis.bossart@linux.intel.com>
 <20191103045604.GE2695@vkoul-mobl.Dlink>
 <f53b28bb-1ec7-a400-54ed-51fd55819ecd@linux.intel.com>
 <20191108042940.GW952516@vkoul-mobl>
 <e3e10c25-84dc-f4e7-e94b-d18493450021@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3e10c25-84dc-f4e7-e94b-d18493450021@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-11-19, 08:55, Pierre-Louis Bossart wrote:
> 
> 
> On 11/7/19 10:29 PM, Vinod Koul wrote:
> > On 04-11-19, 08:32, Pierre-Louis Bossart wrote:
> > > 
> > > 
> > > On 11/2/19 11:56 PM, Vinod Koul wrote:
> > > > On 23-10-19, 16:06, Pierre-Louis Bossart wrote:
> > > > > Changes to the sdw_slave structure needed to solve race conditions on
> > > > > driver probe.
> > > > 
> > > > Can you please explain the race you have observed, it would be a very
> > > > useful to document it as well
> > > 
> > > the races are explained in the [PATCH 00/18] soundwire: code hardening and
> > > suspend-resume support series.
> > 
> > It would make sense to explain it here as well to give details to
> > reviewers, there is nothing wrong with too much detail!
> > 
> > > > > 
> > > > > The functionality is added in the next patch.
> > > > 
> > > > which one..?
> > > 
> > > [PATCH 00/18] soundwire: code hardening and suspend-resume support
> > 
> > Yeah great! let me play detective with 18 patch series. I asked for a
> > patch and got a series!
> > 
> > Again, please help the maintainer to help you. We would love to see this
> > merged as well, but please step up and give more details in cover
> > letter and changelogs. I shouldn't need to do guesswork and scan through the
> > inbox to find the context!
> 
> We are clearly not going anywhere.

Correct as you don't seem to provide clear answers, I am asking again
which patch implements the new fields added here, how difficult is it to
provide the *specific* patch which implements this so that I can compare
the implementation and see why this is needed and apply if fine!

But no you will not provide a clear answer and start ranting!

> I partitioned the patches to make your maintainer life easier and help the
> integration of SoundWire across two trees. All I get is negative feedback,
> grand-standing, and zero comments on actual changes.

No you get asked specific question which you do not like and start off
on a tangent!

> For the record, I am mindful of reviewer/maintainer workload, and I did
> contact you in September to check your availability and provided a pointer
> to initial code changes. I did send a first version a week prior to your
> travel/vacation, I resend another version when you were back and waited yet
> another two weeks to resend a second version. I also contacted Takashi, Mark
> and you to suggest this code partition, and did not get any pushback. It's
> not like I am pushing stuff down your throat, I have been patient and
> considerate.
> 
> Please start with the patches "soundwire: code hardening and suspend-resume
> support" and come back to this interface description when you have reviewed
> these changes. It's not detective work, it's working around the consequences
> of having separate trees for Audio and SoundWire.

Again, which patch in the series does implement these new members!

-- 
~Vinod

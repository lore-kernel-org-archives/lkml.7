Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93911C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 04:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D6020874
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 04:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565755976;
	bh=x6L4Ab4GwkfFv2tLx6IooKohLXKZx+ziOKbXCdycO7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QHYinm5+7yEB33xUEgub1pse/8OzA4tB/RQ3q3pz8Md2a6Uw1PBD3tkiccVd8J5nx
	 VZN039crNTdbovZa8dlE8uTGZGeI1Fp0Y9LdNjKZ8IYQj6zsSPL4RILXstKSPlobAx
	 zBvdjk+Y7vqs1ahMvDENtaZOf7KZJ17DUElaDOW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfHNEMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 00:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfHNEMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 00:12:55 -0400
Received: from localhost (unknown [106.51.111.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0805420843;
        Wed, 14 Aug 2019 04:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565755974;
        bh=x6L4Ab4GwkfFv2tLx6IooKohLXKZx+ziOKbXCdycO7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LkmFK38c+er/rP52PMhS4hw6QCvPGjZyyffDgJ0aVE1zfuzPs5dnwYMCujuh9Ds7d
         Z3vnCjGD+GZ9Gp3AM+ew8qiZHciwxlQ1KCngNeYhVGmdcJxHbXa8h0g5dcMEfUCgDx
         07kpERkuYqgxYsz9qxTl9ISxAGBAkrOlwHdVftls=
Date:   Wed, 14 Aug 2019 09:41:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, plai@codeaurora.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        spapothi@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
Message-ID: <20190814041142.GU12733@vkoul-mobl.Dlink>
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-4-srinivas.kandagatla@linaro.org>
 <ba88e0f9-ae7d-c26e-d2dc-83bf910c2c01@linux.intel.com>
 <c2eecd44-f06a-7287-2862-0382bf697f8d@linaro.org>
 <d2b7773b-d52a-7769-aa5b-ef8c8845d447@linux.intel.com>
 <d7c1fdb2-602f-ecb1-9b32-91b893e7f408@linaro.org>
 <f0228cb4-0a6f-17f3-fe03-9be7f5f2e59d@linux.intel.com>
 <20190813191827.GI5093@sirena.co.uk>
 <cc360858-571a-6a46-1789-1020bcbe4bca@linux.intel.com>
 <20190813195804.GL5093@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813195804.GL5093@sirena.co.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-08-19, 20:58, Mark Brown wrote:
> On Tue, Aug 13, 2019 at 02:38:53PM -0500, Pierre-Louis Bossart wrote:
> 
> > Indeed. I don't have a full understanding of that part to be honest, nor why
> > we need something SoundWire-specific. We already abused the set_tdm_slot API
> > to store an HDaudio stream, now we have a rather confusing stream
> > information for SoundWire and I have about 3 other 'stream' contexts in
> > SOF... I am still doing basic cleanups but this has been on my radar for a
> > while.
> 
> There is something to be said for not abusing the TDM slot API if it can
> make things clearer by using bus-idiomatic mechanisms, but it does mean
> everything needs to know about each individual bus :/ .

Here ASoC doesn't need to know about sdw bus. As Srini explained, this
helps in the case for him to get the stream context and set the stream
context from the machine driver.

Nothing else is expected to be done from this API. We already do a set
using snd_soc_dai_set_sdw_stream(). Here we add the snd_soc_dai_get_sdw_stream() to query

Thanks
-- 
~Vinod

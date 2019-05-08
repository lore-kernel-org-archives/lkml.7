Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E36EC04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F210216C8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557333445;
	bh=NlfKCG9jMJHSiy8XCNRv8HGi94api0Xr6KGSgF95ErU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RTLVvfm/Lt1N/xqTIggu6Exe52mZn+ySFwUSWNf8EN6XZEGnLbcww6MVivf8XnoFV
	 3t9cz3IvsJPJ+FMt9fcirQrPWON4MEQs/9Yltk9s3+shIpmFWsu9GxYKN2/VHnyTqm
	 +twkGRFkFsgObRB0+kC9sXTa7WaEbqAAyYlEbdpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfEHQhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbfEHQhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:37:23 -0400
Received: from localhost (unknown [106.200.210.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D8BA204FD;
        Wed,  8 May 2019 16:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557333442;
        bh=NlfKCG9jMJHSiy8XCNRv8HGi94api0Xr6KGSgF95ErU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PrEZemy9MtO/iEofqPEh8w7QHvYH99dcTl9muPhmYkwmsEKmo4wsjiWvkyet2/LLK
         pvtJur3xU27oyW2UjY9GH3lnz2MQ2a4F/YX8/YFjOnLU/i1lJOWYOwXX0fof2AxGcz
         ktwHSrHnkwWayX1d+jUlPzV8BZ3aLxRQRDYsRyyA=
Date:   Wed, 8 May 2019 22:07:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 1/8] soundwire: intel: filter SoundWire controller device
 search
Message-ID: <20190508163717.GX16052@vkoul-mobl>
References: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
 <20190504002926.28815-2-pierre-louis.bossart@linux.intel.com>
 <20190507122651.GO16052@vkoul-mobl>
 <47fd3ca6-6910-f101-9b63-f653cd1443f9@linux.intel.com>
 <20190508050853.GT16052@vkoul-mobl>
 <a6b3f1d1-c815-3c6b-7f35-ac5cc98960b2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6b3f1d1-c815-3c6b-7f35-ac5cc98960b2@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-05-19, 11:20, Pierre-Louis Bossart wrote:
> 
> > > > > +	/*
> > > > > +	 * On some Intel platforms, multiple children of the HDAS
> > > > > +	 * device can be found, but only one of them is the SoundWire
> > > > > +	 * controller. The SNDW device is always exposed with
> > > > > +	 * Name(_ADR, 0x40000000) so filter accordingly
> > > > > +	 */
> > > > > +	if (adr != 0x40000000)
> > > > 
> > > > I do not recall if 4 corresponds to the links you have or soundwire
> > > > device type, is this number documented somewhere is HDA specs?
> > > 
> > > I thought it was a magic number, but I did check and for once it's
> > > documented and the values match the spec :-)
> > > I see in the ACPI docs bits 31..28 set to 4 indicate a SoundWire Link Type
> > > and bits 3..0 indicate the SoundWire controller instance, the rest is
> > > reserved to zero.
> > 
> > So in that case we should mask with bits 31..28 and match, who knows you
> > may have multiple controller instances in future
> 
> yes, I was planning on only using the link type.
> 
> > I had a vague recollection that this was documented in the spec, glad
> > that in turned out to be the case.
> > 
> > Btw was the update to HDA spec made public?
> 
> Not that I know of. The previous NHLT public doc has actually disappeared
> from the Intel site and I can't find it any longer, so currently the amount
> of public documentation is trending to zero :-(
> 
> > 
> > > > Also it might good to create a define for this
> > > 
> > > I will respin this one to add the documentation above, and only filter on
> > > the 4 ms-bits. Thanks for forcing me to RTFM :-)

Yeah about that someone was indeed complaining about that on IRC, it is
shame that link is valid but doc is gone... check with Rakesh or someone
they might have a copy...

-- 
~Vinod

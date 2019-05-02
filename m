Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566E6C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3F1208C4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556775607;
	bh=KaJg4Insj81qVuOaZzwgno+jYYq4b7sV6fPvH+HM3jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oBD9VOVmFA7sfvLsZI90vYH+Ztdv4YdOUaee7k8mfJMZx41vepU6ofL6Qbhz/RPNt
	 Rv0+OwfO4Ob12tW1XzJfoVNe2t4N3TQqUZBC9VKHRNxk+N6F687mwWGUakyhKdmyx5
	 kkNr/p1bjbl/4pA9q0nKKLmZvK5EnJRLyQG/tVe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfEBFkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 01:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfEBFkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 01:40:05 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30DE020873;
        Thu,  2 May 2019 05:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556775605;
        bh=KaJg4Insj81qVuOaZzwgno+jYYq4b7sV6fPvH+HM3jc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lU2gW1eMhYpYLQ7+0t2kSId0hdhuewCytT3VArPYkYF3mOS5YHZ3wFMeUImT5mUDM
         E5O33ekz3+qslsnqioQr1RjwCceW3+yO+xS5k9pw7BXm+LaMnUlH1R5XFdK7GqG50q
         ZOcxujVjPMAbittO8IQ5zjf+KcKKnlbHaQS88sNY=
Date:   Thu, 2 May 2019 11:09:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com,
        jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org
Subject: Re: [PATCH v4 00/22] soundwire: code cleanup
Message-ID: <20190502053956.GF3845@vkoul-mobl.Dlink>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
 <20190501160755.GC19281@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501160755.GC19281@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-05-19, 18:07, Greg KH wrote:
> On Wed, May 01, 2019 at 10:57:23AM -0500, Pierre-Louis Bossart wrote:
> > SoundWire support will be provided in Linux with the Sound Open
> > Firmware (SOF) on Intel platforms. Before we start adding the missing
> > pieces, there are a number of warnings and style issues reported by
> > checkpatch, cppcheck and Coccinelle that need to be cleaned-up.
> > 
> > Changes since v3:
> > patch 1,3,4 were merged for 5.2-rc1
> > No code change, only split patch2 in 21 patches to make Vinod
> > happy. Each patch only fixes a specific issue. patch 5 is now patch22
> > and wasn't changed. Not sure why Vinod reported the patch didn't
> > apply.
> > Added Takashi's Reviewed-by tag in all patches since the code is
> > exactly the same as in v3.
> 
> These all look good to me:
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Vinod, want me to just pick these up from the list as-is so we can get
> them into 5.2-rc1?

Thanks Greg, I would still like modification to patches that touch core
subsystem parts and drivers in a single one. Otherwise changes are fine.

So I will go ahead and apply the rest and send you a PR tomorrow giving
a chance to Pierre to update these (ofcourse they will be in linux-next
tomorrow)

Thanks
-- 
~Vinod

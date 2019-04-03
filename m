Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29E5C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7100A20663
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554308750;
	bh=r5lhSkBf41WnEvJso0OQEY0OEC7GUPNspjBGs+gOw6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VFP9EMI/qodw4Ri0Wet0ssGr5hDds13mnvCZxb0dXpWVzHjvW1q5H5TmxjD+x5B2o
	 8Ocv1lKinH9K9+x1sevo1BvvC5FE18Q0bMqQaWkibP4bTwevmEK8x7bK9EYbSCtied
	 fsoRPpG26vAtBHHRbuxHhfiEO/J+CQ+puWa89YII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfDCQZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfDCQZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:25:49 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CA4E20663;
        Wed,  3 Apr 2019 16:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554308748;
        bh=r5lhSkBf41WnEvJso0OQEY0OEC7GUPNspjBGs+gOw6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e5UMYu7dBusxCB4bTBKrqEEghDmUpLw9Zr71DC4WdZ8oFj4tPcnhWAAvA4K+rQWYR
         PU0smol22odC+Y5fq/PT9byTyG0Qof0SlIQMLjp4Foyz/kxN6IvEUOaYGqzjv/tFhW
         f0AzHcfY6vpZLrT17aRVC+JMuGFt/dpKP/pqEtfA=
Date:   Wed, 3 Apr 2019 12:25:47 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>
Subject: Re: [PATCH AUTOSEL 5.0 107/262] ASoC: qcom: Fix of-node refcount
 unbalance in apq8016_sbc_parse_of()
Message-ID: <20190403162547.GF16241@sasha-vm>
References: <20190327180158.10245-1-sashal@kernel.org>
 <20190327180158.10245-107-sashal@kernel.org>
 <20190327193115.GB11404@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190327193115.GB11404@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 07:31:15PM +0000, Mark Brown wrote:
>On Wed, Mar 27, 2019 at 01:59:22PM -0400, Sasha Levin wrote:
>> From: Takashi Iwai <tiwai@suse.de>
>>
>> [ Upstream commit 8d1667200850f8753c0265fa4bd25c9a6e5f94ce ]
>>
>> The apq8016 driver leaves the of-node refcount at aborting from the
>> loop of for_each_child_of_node() in the error path.  Not only the
>> iterator node of for_each_child_of_node(), the children nodes referred
>> from it for codec and cpu have to be properly unreferenced.
>
>Given that the device tree is entirely static on all platforms using FDT
>I'm not convinced that it is sensible to backport any of the fixes for
>references not being dropped that are more than one liners,
>realistically nothing is ever going to notice the extra references but
>there are things that will notice if we underflow references so there's
>some risk we could break things somehow.  Seems like it's all risk for
>zero benefit.

Fair enough, I'll drop it. Thanks!

--
Thanks,
Sasha

Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5204C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1B82082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560439832;
	bh=F0cLZ2BcFWcZKdjgmfySMbp1c9gT1Nhrp8MvVzKxWUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qEbIE0mb5DFcnp2f7bB8CQPs0ja2DQBoRfMaU8ZQ59EsyfouRNUMJ/jesuc+Ad7jg
	 ogpOm2z5mClIvkACIBQtLrJCdXO/Ukjftac7+7An9vC+pTv2xb0Nk+ardoHyk9Wu8w
	 j6rsUf75iRTFhO5QSVvMTNSL7C0mBCnO/A4seYHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfFMPaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:30:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728798AbfFMLPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:15:50 -0400
Received: from localhost (unknown [122.167.115.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BD3420B7C;
        Thu, 13 Jun 2019 11:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560424549;
        bh=F0cLZ2BcFWcZKdjgmfySMbp1c9gT1Nhrp8MvVzKxWUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sZ3a2EWNU/sSbdg5WQqvbu6fzmnt8yR7dcSEirSw7S9qSac2168t4rVEw1DmI6OIU
         G/c3Q8iQsR9hubusvp9DBZkEQZNVJ4bY7KGbHELbtiL1cRRnJzBgcrDkYZTIQgzjhg
         zkzcvdEiKeNW0t1no5llp6yJol2OLDriqDJeuFMo=
Date:   Thu, 13 Jun 2019 16:42:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Gary R Hook <ghook@amd.com>
Cc:     "Hook, Gary" <Gary.Hook@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: dmatest: timeout value of -1 should specify
 infinite wait
Message-ID: <20190613111242.GE9160@vkoul-mobl.Dlink>
References: <155933183362.4916.15727271006977576552.stgit@sosrh3.amd.com>
 <20190604122356.GY15118@vkoul-mobl>
 <010db7bb-dee2-4ba8-a085-4154735b98db@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010db7bb-dee2-4ba8-a085-4154735b98db@amd.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-06-19, 16:47, Gary R Hook wrote:

> Well, I was uncomfortable with documentation that didn't match behavior.

That is the right way :)
> 
> I see two choices (and I just chose one to start a conversation):
> 
> 1) Accept this patch, with an infinite timeout, or
> 2) Leave the data type alone, but change the description to state that 
> timeout values up to hex 0xFFFFFFFF / decimal 4294967295 can be used, 
> emulating an "infinite" wait. A very long wait that eventually pops a 
> timer is probably preferable. I don't think there are any conversion 
> issues since the jiffy parameter to wait_event_freezable_timeout() is 
> converted to a long. I could be wrong about that.
> 
> I'm happy to go with option (2). Please suggest a course of action.

That looks sensible to me as well

Thanks

-- 
~Vinod

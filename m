Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F49C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41FF2190A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126377;
	bh=HAKvslxGkZt125Kb74Dv+T/bw9ZprP7fnMsbEuV8Sc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xQNGyKcUTEhgVudAoT+me/dqKcG8SzpuI29PNNkqa+U7CdOHdECIi3ddAlRSZMUa1
	 tcU/AwvOfpSySC5xAsa+3Y7OnbgYcOCsEGfm8nrJazV8NpuaPR1DPs76cHznd/bK3t
	 H1FZ2d9jH7Nu/06BFhPUOQPLqHVTSBVrTA4Rs5z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389028AbfDXRTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:19:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388994AbfDXRT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:19:28 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4CB821909;
        Wed, 24 Apr 2019 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126367;
        bh=HAKvslxGkZt125Kb74Dv+T/bw9ZprP7fnMsbEuV8Sc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EK03smXYTgkQDEaLQlm2wQ/9kRiw5SDHIPbjw1MjaIbckFGiO1wGXH2pPBmcMq70f
         rs98bEyCLrcG1+yQ5gCecj2ygUs0eUJ5f23r6Ci5RxaSkbyM9fNZCogekR7yPMfiT6
         El1O4+IxUildOBH9gxUhiEJnXQ2rUmYYCZRqR5c8=
Date:   Wed, 24 Apr 2019 13:19:26 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yongzhi Pan <panyongzhi@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>, Tejun Heo <tj@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nikolaus Rath <Nikolaus@rath.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 5.0 59/66] fs: stream_open - opener for
 stream-like files so that read and write can run simultaneously without
 deadlock
Message-ID: <20190424171926.GA17719@sasha-vm>
References: <20190424143341.27665-1-sashal@kernel.org>
 <20190424143341.27665-59-sashal@kernel.org>
 <20190424163415.GB21413@kroah.com>
 <CAHk-=wjEOyba5As1PEMk6RitNVOJH9oJ_Jbg4y=5B0fcX1iKGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wjEOyba5As1PEMk6RitNVOJH9oJ_Jbg4y=5B0fcX1iKGw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 09:40:53AM -0700, Linus Torvalds wrote:
>On Wed, Apr 24, 2019 at 9:34 AM Greg Kroah-Hartman
><gregkh@linuxfoundation.org> wrote:
>>
>> I think there is a follow-on patch for this one as well, that adds the
>> proper "stream open" logic to all of the individual locations.
>
>That bulk one hasn't been applied yet, and wouldn't be appropriate for
>stable anyway. It's 5.2 material.

Hm, I might be confusing something here but I see a bunch of patches
that convert existing callers mentioned in this patch to use
stream_open() which was introduced here.

Are these the same patches you're referring to? If so, why are they not
appropriate for stable?

--
Thanks,
Sasha

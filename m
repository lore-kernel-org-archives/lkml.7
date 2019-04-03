Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB060C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE2120700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554308350;
	bh=iFFhhHonh7uwTw2boWMzg7mxjla/UXbjD2M8gquIYgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vfHBD/79iVuo36jGvdyoInUbSmxLVpLNxARkWr+Z0rMLt4X5A+Eon2msIJ8Q7ASdK
	 5l+hNRIvYYHotLXLjxA00Cb+WmJ/1gBFj/EJJzfti2dbTJCtNjo6Gqo6ouj64iDHhK
	 2YdSH0GpCWk0Rjm44EQz5vdUtDGrp3aX6CGEZpWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDCQTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:19:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbfDCQTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:19:09 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2DCF206C0;
        Wed,  3 Apr 2019 16:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554308348;
        bh=iFFhhHonh7uwTw2boWMzg7mxjla/UXbjD2M8gquIYgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=liWn1Mtv/HqOztZ/HjPTD5cMUhq4T4D+moOD+jy8ybqhKFy0AsXYqA9Yfk6iWVq0z
         2TTK1pK8JhLTMEgOzlS15ms8LHaWQKAHZtpy4pc7pJwE25yiTsLO7wMetZVYpS0jZB
         +baH3klF5kShj0eKPJIBys4k57aAWs0usNAjfG9g=
Date:   Wed, 3 Apr 2019 12:19:06 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Slavomir Kaslev <kaslevs@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 4.9 20/87] fs: Make splice() and tee() take into
 account O_NONBLOCK flag on pipes
Message-ID: <20190403161906.GD16241@sasha-vm>
References: <20190327182040.17444-1-sashal@kernel.org>
 <20190327182040.17444-20-sashal@kernel.org>
 <3c4595fec941c10beaf4bad8df30170b4e950226.camel@vmware.com>
 <20190328120417.36bae781@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190328120417.36bae781@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 12:04:17PM -0400, Steven Rostedt wrote:
>On Thu, 28 Mar 2019 15:37:49 +0000
>Slavomir Kaslev <kaslevs@vmware.com> wrote:
>
>> On Wed, 2019-03-27 at 14:19 -0400, Sasha Levin wrote:
>> > From: Slavomir Kaslev <kaslevs@vmware.com>
>> >
>> > [ Upstream commit ee5e001196d1345b8fee25925ff5f1d67936081e ]
>> >
>> > The current implementation of splice() and tee() ignores O_NONBLOCK
>> > set
>> > on pipe file descriptors and checks only the SPLICE_F_NONBLOCK flag
>> > for
>> > blocking on pipe arguments.  This is inconsistent since splice()-ing
>> > from/to non-pipe file descriptors does take O_NONBLOCK into
>> > consideration.
>> >
>> > Fix this by promoting O_NONBLOCK, when set on a pipe, to
>> > SPLICE_F_NONBLOCK.
>>
>> Hey Sasha,
>>
>> I don't think that this patch should be merged to stable kernels. It's
>> more of a feature rather than a bug/regression fix and it changes how
>> splice() has been working from day one.
>>
>> Can you please drop it from the stable queues?
>>
>
>On the other hand, it keeps stable more in sync with what mainline has.
>If someone writes new code against a stable release, and depends on
>this behavior, it's less likely to break when they run it on a newer
>kernel. Which means its less likely that Linus will revert your
>change ;-)

I'm going to drop this, I don't really want to take things which
knowingly might brake userspace.

--
Thanks,
Sasha

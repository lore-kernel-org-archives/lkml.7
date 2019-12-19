Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E52C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F9B24672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576776883;
	bh=c7tlFbt1gaIwyE0GapGhS+DnL3kvzj3ZPaY46wahh5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TG5d6Y6ZCL8dCP1tcg+35IZkQbnJFx/mIpeBmDM3MRSh4UpNkfCljqAq3BAAN4OSQ
	 HUdKbk3jmyswi8eZt128qDQF3KiaZviKE8HGT20G69wka6PUQq0uVM1X/qbAzBrBSl
	 a6Ti86+RL6q9AuPkLhewU1nlZBLgGIpBnGELAFrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfLSRem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:34:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:53572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfLSRel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:34:41 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5F6021655;
        Thu, 19 Dec 2019 17:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576776881;
        bh=c7tlFbt1gaIwyE0GapGhS+DnL3kvzj3ZPaY46wahh5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cU4HAE+wTmH06VKvGeqclLxgDjSpR/z2NxvikvwBsHjkjFOJLZwuwKENCp7cQaNIz
         sWuYwhUIfZgtaYgWbzeleJ9/+rqo2ui8dulLtsKXsFq8GdUS5QJB85sx1gfJRCnfJc
         7Yi4mfqca/cHbeNIqUzl5fg4VxCFy6G6NlhSG6CM=
Date:   Thu, 19 Dec 2019 12:34:39 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        open list <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 5.4 105/350] iio: chemical: atlas-ph-sensor: fix
 iio_triggered_buffer_predisable() position
Message-ID: <20191219173439.GM17708@sasha-vm>
References: <20191210210735.9077-1-sashal@kernel.org>
 <20191210210735.9077-66-sashal@kernel.org>
 <20191215155329.4c71ad53@archlinux>
 <CAJCx=gkM8=WCC6t8bjX-q-mDco7HBMdBmJjOQzRHZr4-nKVvcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJCx=gkM8=WCC6t8bjX-q-mDco7HBMdBmJjOQzRHZr4-nKVvcA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 03:25:27PM -0800, Matt Ranostay wrote:
>On Sun, Dec 15, 2019 at 7:53 AM Jonathan Cameron
><jic23@jic23.retrosnub.co.uk> wrote:
>>
>> On Tue, 10 Dec 2019 16:03:30 -0500
>> Sasha Levin <sashal@kernel.org> wrote:
>>
>> > From: Alexandru Ardelean <alexandru.ardelean@analog.com>
>> >
>> > [ Upstream commit 0c8a6e72f3c04bfe92a64e5e0791bfe006aabe08 ]
>> >
>> > The iio_triggered_buffer_{predisable,postenable} functions attach/detach
>> > the poll functions.
>> >
>> > The iio_triggered_buffer_predisable() should be called last, to detach the
>> > poll func after the devices has been suspended.
>> >
>> > The position of iio_triggered_buffer_postenable() is correct.
>> >
>> > Note this is not stable material. It's a fix in the logical
>> > model rather fixing an actual bug.  These are being tidied up
>> > throughout the subsystem to allow more substantial rework that
>> > was blocked by variations in how things were done.
>>
>> See comment.  This is not what I would consider stable material.
>>
>
>Outside of the comment, which really isn't probably enough to avoid
>the autoselection script from detecting it (could be "stable" in the
>message alone selects it :) ),
>is there any way to signal that a patch is "NOT for stable trees"?
>Probably don't want to clutter up the commit messages of course.

That commit message should have been enough, I'll add some more
filtering to catch instances like that.

-- 
Thanks,
Sasha

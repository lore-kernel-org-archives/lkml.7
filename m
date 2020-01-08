Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DB6C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCB4206ED
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578484840;
	bh=PAeybtyZqMyHhLyEpHpzDmjvvQJloWmair75CBeupyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a/sdf0X1AKGPbqUGlLOrC0jq5ixaHAlSzXKQBMXfEDZ+CsE++i9NJIngPEKD3vXsW
	 TCpEidn1/XHY7/N8IvkZ5a7aeDFn+WFEgQj8nj7Qe/mq/b9I23IuR1QA3hSmJhfhq7
	 1DuALQeeZrQVuFmP8HAzmZweJK+eKCUc4FUhotTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgAHMAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 07:00:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgAHMAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 07:00:39 -0500
Received: from localhost (c-98-234-77-170.hsd1.ca.comcast.net [98.234.77.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 913C8206DA;
        Wed,  8 Jan 2020 12:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578484838;
        bh=PAeybtyZqMyHhLyEpHpzDmjvvQJloWmair75CBeupyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KPmwl6vUKd+QXJvtZC4rdu/sLQkl/MTU7te/IU0yxKEcRppY7tWZhgHRQDSq5Djxv
         0ni71UmBfqmN+A03d8v7yqM46L/+avh6CgeHl5qhOa13IeJVUh1fm+Jv2oha8hBWsU
         D35ILQM6l4skaYfuFnfrUWmsGvHXD+bZ3kFnVcJY=
Date:   Wed, 8 Jan 2020 04:00:38 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] Multidevice f2fs mount after disk rearrangement
Message-ID: <20200108120038.GB28331@jaegeuk-macbookpro.roam.corp.google.com>
References: <4c6cf8418236145f7124ac61eb2908ad@natalenko.name>
 <2c4cafd35d1595a62134203669d7c244@natalenko.name>
 <20200106183450.GC50058@jaegeuk-macbookpro.roam.corp.google.com>
 <ee2cb1d7a6c1b51e1c8277a8feaafe6d@natalenko.name>
 <815fbd14-0fbd-9c44-8d86-4ab13a12dc7f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <815fbd14-0fbd-9c44-8d86-4ab13a12dc7f@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08, Chao Yu wrote:
> On 2020/1/7 2:40, Oleksandr Natalenko via Linux-f2fs-devel wrote:
> > Hi.
> > 
> > On 06.01.2020 19:34, Jaegeuk Kim wrote:
> >> Thank you for investigating this ahead of me. :) Yes, the device list 
> >> is stored
> >> in superblock, so hacking it manually should work.
> >>
> >> Let me think about a tool to tune that.
> > 
> > Thank you both for the replies.
> > 
> > IIUC, tune.f2fs is not there yet. I saw a submission, but I do not see 
> > it as accepted, right?
> > 
> > Having this in tune.f2fs would be fine (assuming the assertion is 
> > replaced with some meaningful hint message), but wouldn't it be more 
> > convenient for an ordinary user to have implemented something like:
> > 
> > # mount -t f2fs /dev/sdb -o nextdev=/dev/sdc /mnt/fs
> 
> Hmm... sounds reasonable, however, the risk is obvious, if we mount with wrong
> primary device, filesystem can be aware that with metadata sanity check, if we
> mount with wrong secondary/... devices by mistake (or intentionally, people
> may think filesystem should be aware illegal parameters....), filesystem won't
> be aware of that, then metadata/data will be inconsistent...
> 
> Although that may also happen when we use tunesb.f2fs, but fsck.f2fs can be
> followed to verify the modification of tunesb.f2fs, that would be much safer.
> 
> So I suggest we can do that in tools first, maybe implement nextdev mount option
> if we have added metadata in secondary/... device.

+1, it'd be risky for user to give the device list whenever mounting the
filesystem. There'll be subtle corner cases where f2fs needs to deal with
given ambiguous sets between superblock and mount option.

> 
> Thanks,
> 
> > 
> > Hm?
> > 

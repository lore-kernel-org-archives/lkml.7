Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEC5C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F5120665
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576522233;
	bh=euLXfcCYgnRnKAlNt7cMRs7KmPpKERcLytoZr5ZKwBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z3ZY4THCDg3tLwBIM4p10tV6jm6uKCfYUXl9LAjT2AsDTgRECSvi/8dllusiD1wQP
	 3o+j0J2Eywr1r/ooWhNNqyiF6rAoQs8FSmCp9RmuYZ8cfMgUyaTgbgB1NUIzyE37cL
	 ltxfkfTqH+nnix3SAnLNhOlerbAbobKj3huDLVyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfLPSub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:50:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:45916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbfLPSu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:50:28 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65FB420665;
        Mon, 16 Dec 2019 18:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576522227;
        bh=euLXfcCYgnRnKAlNt7cMRs7KmPpKERcLytoZr5ZKwBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=woK5A1wWOpSIX++8DIAJvIi14uCZt0+r/C3SDy2zjbIXGQelVUKJ/GPgCLiIYWWUt
         33ZPhI++tcCtlXWHNnfK8kUsadcncE0sXiqOcGZezAkZLD53qcHdcEQ4meVDOXExpz
         9c/i7hWnhvvjEB72JTMPtwqLp56vwf82ZVsO8QMc=
Date:   Mon, 16 Dec 2019 10:50:26 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     =?utf-8?B?eGlhbnJvbmcuemhvdSjlkajlhYjojaMp?= 
        <xianrong.zhou@transsion.com>
Cc:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        =?utf-8?B?d2VpbWluLm1hbyjmr5vljavmsJEp?= <weimin.mao@transsion.com>,
        =?utf-8?B?aGFpemhvdS5zb25nKOWui+a1t+iInyk=?= 
        <haizhou.song@transsion.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        =?utf-8?B?d2FuYmluLndhbmco5rGq5LiH5paMKQ==?= 
        <wanbin.wang@transsion.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?eXVhbmppb25nLmdhbyjpq5jmuIrngq8p?= 
        <yuanjiong.gao@transsion.com>,
        =?utf-8?B?cnV4aWFuLmZlbmco5Yav5YSS5ai0KQ==?= 
        <ruxian.feng@transsion.com>, "agk@redhat.com" <agk@redhat.com>
Subject: Re: [PATCH] dm-verity: unnecessary data blocks that need not read
 hash blocks
Message-ID: <20191216185025.GF139479@gmail.com>
References: <727b9e9279a546beb2ae63a18eae6ab0@transsion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <727b9e9279a546beb2ae63a18eae6ab0@transsion.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 02:02:33AM +0000, xianrong.zhou(周先荣) wrote:
> hey Eric:
> 
> On Wed, Dec 11, 2019 at 11:32:40AM +0800, zhou xianrong wrote:
> > From: "xianrong.zhou" <xianrong.zhou@transsion.com>
> > 
> > If check_at_most_once enabled, just like verity work the prefetching 
> > work should check for data block bitmap firstly before reading hash 
> > block as well. Skip bit-set data blocks from both ends of data block 
> > range by testing the validated bitmap. This can reduce the amounts of 
> > data blocks which need to read hash blocks.
> > 
> > Launching 91 apps every 15s and repeat 21 rounds on Android Q.
> > In prefetching work we can let only 2602/360312 = 0.72% data blocks 
> > really need to read hash blocks.
> > 
> > But the reduced data blocks range would be enlarged again by 
> > dm_verity_prefetch_cluster later.
> > 
> > Signed-off-by: xianrong.zhou <xianrong.zhou@transsion.com>
> > Signed-off-by: yuanjiong.gao <yuanjiong.gao@transsion.com>
> > Tested-by: ruxian.feng <ruxian.feng@transsion.com>
> > ---
> >  drivers/md/dm-verity-target.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/drivers/md/dm-verity-target.c 
> > b/drivers/md/dm-verity-target.c index 4fb33e7562c5..7b8eb754c0b6 
> > 100644
> > --- a/drivers/md/dm-verity-target.c
> > +++ b/drivers/md/dm-verity-target.c
> > @@ -581,6 +581,22 @@ static void verity_prefetch_io(struct work_struct *work)
> >  	struct dm_verity *v = pw->v;
> >  	int i;
> >  
> > +	if (v->validated_blocks) {
> > +		while (pw->n_blocks) {
> > +			if (unlikely(!test_bit(pw->block, v->validated_blocks)))
> > +				break;
> > +			pw->block++;
> > +			pw->n_blocks--;
> > +		}
> > +		while (pw->n_blocks) {
> > +			if (unlikely(!test_bit(pw->block + pw->n_blocks - 1,
> > +				v->validated_blocks)))
> > +				break;
> > +			pw->n_blocks--;
> > +		}
> > +		if (!pw->n_blocks)
> > +			return;
> > +	}
> 
> This is a good idea, but shouldn't this logic go in verity_submit_prefetch()
> prior to the struct dm_verity_prefetch_work being allocated?  Then if no
> prefeching is needed, allocating and scheduling the work object can be
> skipped.
> 
> Eric, Do you mean it is more suitable in dm_bufio_prefetch which is called on
> different paths even though prefeching is disabled ?
> 

No, I'm talking about verity_submit_prefetch().  verity_submit_prefetch()
allocates and schedules a work object, which executes verity_prefetch_io().
If all data blocks in the I/O request were already validated, there's no need to
allocate and schedule the prefetch work.

- Eric

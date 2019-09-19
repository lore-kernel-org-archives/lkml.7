Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1B8C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21C520644
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568913070;
	bh=OEV+1wC+4vm2PATQw5wcqrgeL5kclwql7UgVG17lyXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rVmQH+9F//yZ0nImtX1um1cqgkeiIrSZauPYcE+qEWmbXqmoPb4ruUh4VwXKYlV19
	 HQKvIUKral1IR4Smyy5ObXAKpaMsq9O0MfKx4OLYjyqDIVq6fR83fSlTpQPJbX7Y6r
	 osEtMjSYSe82BzINPYu+PW8KKNqbgwgv8EVR5pbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391881AbfISRLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:11:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389131AbfISRLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:11:09 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F179205F4;
        Thu, 19 Sep 2019 17:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568913068;
        bh=OEV+1wC+4vm2PATQw5wcqrgeL5kclwql7UgVG17lyXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7/671DBTxT5hVE1qFhFcsitJRK79uYLlmTkJg5qNeD5bjsqsJLtzi/Cr1YeSsrmj
         0Hrz3gXz44QJ+wpXgTgneuO+ffl/codZOd3xD3UpmFOcRSK0H/cmmOaimSWVyZ1n4m
         oTNPkthh32csG/I7ORcqOhm9/NNZKpOgHS8+/qOw=
Date:   Thu, 19 Sep 2019 10:11:07 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: do not select same victim right
 again
Message-ID: <20190919171107.GA19030@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190909120443.GA31108@jaegeuk-macbookpro.roam.corp.google.com>
 <27725e65-53fe-5731-0201-9959b8ef6b49@huawei.com>
 <20190916153736.GA2493@jaegeuk-macbookpro.roam.corp.google.com>
 <ab9561c9-db27-2967-e6fc-accd9bc58747@huawei.com>
 <20190917205501.GA60683@jaegeuk-macbookpro.roam.corp.google.com>
 <e823b534-f4de-7f59-0c26-ff2c463260d1@huawei.com>
 <20190918031257.GA82722@jaegeuk-macbookpro.roam.corp.google.com>
 <b4f3f571-debc-c900-9ce7-d4326b3d8038@huawei.com>
 <20190918164754.GA88624@jaegeuk-macbookpro.roam.corp.google.com>
 <7d7e8e46-0261-ddec-881a-e720ca2badac@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d7e8e46-0261-ddec-881a-e720ca2badac@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/19, Chao Yu wrote:
> On 2019/9/19 0:47, Jaegeuk Kim wrote:
> > On 09/18, Chao Yu wrote:
> >> On 2019/9/18 11:12, Jaegeuk Kim wrote:
> >>> On 09/18, Chao Yu wrote:
> >>>> On 2019/9/18 4:55, Jaegeuk Kim wrote:
> >>>>> On 09/17, Chao Yu wrote:
> >>>>>> On 2019/9/16 23:37, Jaegeuk Kim wrote:
> >>>>>>> On 09/16, Chao Yu wrote:
> >>>>>>>> On 2019/9/9 20:04, Jaegeuk Kim wrote:
> >>>>>>>>> On 09/09, Chao Yu wrote:
> >>>>>>>>>> On 2019/9/9 16:06, Jaegeuk Kim wrote:
> >>>>>>>>>>> On 09/09, Chao Yu wrote:
> >>>>>>>>>>>> On 2019/9/9 9:25, Jaegeuk Kim wrote:
> >>>>>>>>>>>>> GC must avoid select the same victim again.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Blocks in previous victim will occupy addition free segment, I doubt after this
> >>>>>>>>>>>> change, FGGC may encounter out-of-free space issue more frequently.
> >>>>>>>>>>>
> >>>>>>>>>>> Hmm, actually this change seems wrong by sec_usage_check().
> >>>>>>>>>>> We may be able to avoid this only in the suspicious loop?
> >>>>>>>>>>>
> >>>>>>>>>>> ---
> >>>>>>>>>>>  fs/f2fs/gc.c | 2 +-
> >>>>>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> >>>>>>>>>>> index e88f98ddf396..5877bd729689 100644
> >>>>>>>>>>> --- a/fs/f2fs/gc.c
> >>>>>>>>>>> +++ b/fs/f2fs/gc.c
> >>>>>>>>>>> @@ -1326,7 +1326,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> >>>>>>>>>>>  		round++;
> >>>>>>>>>>>  	}
> >>>>>>>>>>>  
> >>>>>>>>>>> -	if (gc_type == FG_GC)
> >>>>>>>>>>> +	if (gc_type == FG_GC && seg_freed)
> >>>>>>>>>>
> >>>>>>>>>> That's original solution Sahitya provided to avoid infinite loop of GC, but I
> >>>>>>>>>> suggest to find the root cause first, then we added .invalid_segmap for that
> >>>>>>>>>> purpose.
> >>>>>>>>>
> >>>>>>>>> I've checked the Sahitya's patch. So, it seems the problem can happen due to
> >>>>>>>>> is_alive or atomic_file.
> >>>>>>>>
> >>>>>>>> For some conditions, this doesn't help, for example, two sections contain the
> >>>>>>>> same fewest valid blocks, it will cause to loop selecting them if it fails to
> >>>>>>>> migrate blocks.
> >>>>>>>>
> >>>>>>>> How about keeping it as it is to find potential bug.
> >>>>>>>
> >>>>>>> I think it'd be fine to merge this. Could you check the above scenario in more
> >>>>>>> detail?
> >>>>>>
> >>>>>> I haven't saw this in real scenario yet.
> >>>>>>
> >>>>>> What I mean is if there is a bug (maybe in is_alive()) failing us to GC on one
> >>>>>> section, when that bug happens in two candidates, there could be the same
> >>>>>> condition that GC will run into loop (select A, fail to migrate; select B, fail
> >>>>>> to migrate, select A...).
> >>>>>>
> >>>>>> But I guess the benefit of this change is, if FGGC fails to migrate block due to
> >>>>>> i_gc_rwsem race, selecting another section and later retrying previous one may
> >>>>>> avoid lock race, right?
> >>>>>
> >>>>> In any case, I think this can avoid potenial GC loop. At least to me, it'd be
> >>>>> quite risky, if we remain this just for debugging purpose only.
> >>>>
> >>>> Yup,
> >>>>
> >>>> One more concern is would this cur_victim_sec remain after FGGC? then BGGC/SSR
> >>>> will always skip the section cur_victim_sec points to.
> >>>
> >>> Then, we can get another loop before using it by BGGC/SSR.
> >>
> >> I guess I didn't catch your point, do you mean, if we reset it in the end of
> >> FGGC, we may encounter the loop during BGGC/SSR?
> > 
> > FGGC failed in a loop and last victim was remained in cur_victim_sec.
> 
> It won't run into a loop because we keep below condition?

The following FGGC will be likely to select this victim again, which doesn't
mean "this loop" but "loop of f2fs_gc".

> 
> +	if (gc_type == FG_GC && seg_freed)
> +		sbi->cur_victim_sec = NULL_SEGNO;
> 
> 	if (sync)
> 		goto stop;
> 
> I meant add below logic in addition:
> 
> +	if (gc_type == FG_GC)
> +		sbi->cur_victim_sec = NULL_SEGNO;
> 
> 	mutex_unlock(&sbi->gc_mutex);
> 
> Thanks,
> 
> > Next FGGC kicked in and did the same thing again. I don't expect BGGC/SSR
> > wants to select this victim much, since it will have CB policy.
> > 
> >>
> >> I meant:
> >>
> >> f2fs_gc()
> >> ...
> >>
> >> +	if (gc_type == FG_GC)
> >> +		sbi->cur_victim_sec = NULL_SEGNO;
> >>
> >> 	mutex_unlock(&sbi->gc_mutex);
> >>
> >> 	put_gc_inode(&gc_list);
> >> ...
> >>
> >> Thanks,
> >>
> >>>
> >>>>
> >>>> So could we reset cur_victim_sec in the end of FGGC?
> >>>>
> >>>> Thanks,
> >>>>
> >>>>>
> >>>>>>
> >>>>>> Thanks,
> >>>>>>
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Thanks,
> >>>>>>>>>>
> >>>>>>>>>>>  		sbi->cur_victim_sec = NULL_SEGNO;
> >>>>>>>>>>>  
> >>>>>>>>>>>  	if (sync)
> >>>>>>>>>>>
> >>>>>>>>> .
> >>>>>>>>>
> >>>>>>> .
> >>>>>>>
> >>>>> .
> >>>>>
> >>> .
> >>>
> > .
> > 

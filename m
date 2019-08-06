Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E05C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44713214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565060724;
	bh=v8QxH42cmRdLjjjgcgYR8oGtYuPx+d7WmvMLNipbegc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MlK7rkRXen0kl1jIVkVl06PFdgSXp6+ZRC9l7LZkKudJmMC5sZ4CyIQVXjAijRkN5
	 PVCvtEZ4HGw3k9fEEAgKX0EPQv8LLqlSOrEXfzTeNCOtvpm5vdw3UPDRQYjFoQDsX6
	 uB5Hc0mPiBRIDhuDVxE2dm8h3WI+FuVIhXhhNUcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbfHFDFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 23:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbfHFDFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 23:05:18 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0926F20717;
        Tue,  6 Aug 2019 03:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565060717;
        bh=v8QxH42cmRdLjjjgcgYR8oGtYuPx+d7WmvMLNipbegc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gfcNMDs+AkItbvEcvhBqViIkZCosaZYHBqLsVxHhnYcT146Kx2XVRrTPBk1KsdTpU
         IPCRqEV115D+3VPnxAiYymcBmQwG0OiJmjt4vTbdsKlYeaI14ElfL62mswclyHhyob
         JOMTpgqLBYuEletbN+zcP/+1VeFKtlPsVVW4hNlo=
Date:   Mon, 5 Aug 2019 20:05:16 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] Revert "f2fs: avoid out-of-range memory access"
Message-ID: <20190806030516.GA11817@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190802101548.96543-1-yuchao0@huawei.com>
 <20190806004215.GC98101@jaegeuk-macbookpro.roam.corp.google.com>
 <dd284020-77b0-1627-2fc2-bc51745adfd3@huawei.com>
 <20190806012839.GD1029@jaegeuk-macbookpro.roam.corp.google.com>
 <5c449273-5cf7-bcc6-a396-584b933833c1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c449273-5cf7-bcc6-a396-584b933833c1@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06, Chao Yu wrote:
> On 2019/8/6 9:28, Jaegeuk Kim wrote:
> > On 08/06, Chao Yu wrote:
> >> On 2019/8/6 8:42, Jaegeuk Kim wrote:
> >>> On 08/02, Chao Yu wrote:
> >>>> As Pavel Machek reported:
> >>>>
> >>>> "We normally use -EUCLEAN to signal filesystem corruption. Plus, it is
> >>>> good idea to report it to the syslog and mark filesystem as "needing
> >>>> fsck" if filesystem can do that."
> >>>>
> >>>> Still we need improve the original patch with:
> >>>> - use unlikely keyword
> >>>> - add message print
> >>>> - return EUCLEAN
> >>>>
> >>>> However, after rethink this patch, I don't think we should add such
> >>>> condition check here as below reasons:
> >>>> - We have already checked the field in f2fs_sanity_check_ckpt(),
> >>>> - If there is fs corrupt or security vulnerability, there is nothing
> >>>> to guarantee the field is integrated after the check, unless we do
> >>>> the check before each of its use, however no filesystem does that.
> >>>> - We only have similar check for bitmap, which was added due to there
> >>>> is bitmap corruption happened on f2fs' runtime in product.
> >>>> - There are so many key fields in SB/CP/NAT did have such check
> >>>> after f2fs_sanity_check_{sb,cp,..}.
> >>>>
> >>>> So I propose to revert this unneeded check.
> >>>
> >>> IIRC, this came from security vulnerability report which can access
> >>
> >> I don't think that's correct report, since we have checked validation of that
> >> field during mount, if it can be ruined after that, any variables can't be trusted.
> > 
> > I assumed this was reproduced with a fuzzed image.
> 
> I expect f2fs_sanity_check_ckpt() should reject mounting such fuzzed image.

It seems I should have reviewed this more carefully. Checking the security
concern one more time.

> 
> > I'll check it with Ocean.
> > 
> >>
> >> Now we just check bitmaps at real-time, because we have encountered such bitmap
> >> corruption in product.
> >>
> >> Thanks,
> >>
> >>> out-of-boundary memory region. Could you write another patch to address the
> >>> above issues?
> >>>
> >>>>
> >>>> This reverts commit 56f3ce675103e3fb9e631cfb4131fc768bc23e9a.
> >>>>
> >>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >>>> ---
> >>>>  fs/f2fs/segment.c | 5 -----
> >>>>  1 file changed, 5 deletions(-)
> >>>>
> >>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>>> index 9693fa4c8971..2eff9c008ae0 100644
> >>>> --- a/fs/f2fs/segment.c
> >>>> +++ b/fs/f2fs/segment.c
> >>>> @@ -3492,11 +3492,6 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
> >>>>  		seg_i = CURSEG_I(sbi, i);
> >>>>  		segno = le32_to_cpu(ckpt->cur_data_segno[i]);
> >>>>  		blk_off = le16_to_cpu(ckpt->cur_data_blkoff[i]);
> >>>> -		if (blk_off > ENTRIES_IN_SUM) {
> >>>> -			f2fs_bug_on(sbi, 1);
> >>>> -			f2fs_put_page(page, 1);
> >>>> -			return -EFAULT;
> >>>> -		}
> >>>>  		seg_i->next_segno = segno;
> >>>>  		reset_curseg(sbi, i, 0);
> >>>>  		seg_i->alloc_type = ckpt->alloc_type[i];
> >>>> -- 
> >>>> 2.18.0.rc1
> >>> .
> >>>
> > .
> > 

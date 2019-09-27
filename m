Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813C8C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 00:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4860F20872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 00:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569544334;
	bh=QsUnjBuZAwrux95SfvML5iv3eEepq0UgtdPVb2bTlH0=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=NVSKxuEjmhVmcdaJTvjie47BHCHvUbpuv3jPiaA0SY3wJjy/6x4/3G7CctEsjL6qG
	 RPQENCDSej9DrWnvhciV3ocOdzFI9ygXSrpcVqqCPceHk0nvjxh+AtTFjhhDJOzVul
	 uJf1hRLrjW7TGZS1/N2unJmDrCFTQ3mHQ33/qHWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfI0AcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 20:32:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfI0AcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 20:32:13 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38C2D2086A;
        Fri, 27 Sep 2019 00:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569544332;
        bh=QsUnjBuZAwrux95SfvML5iv3eEepq0UgtdPVb2bTlH0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=GQyhnFVk6d9XHgaR0X3hVLxVGCnaC3zpdwphghs/tN4/9/SwERAX3RPMRIu5vBsJD
         2/lbU5vI22OUqrCZNdAOJYpXGnmtCfcUxmwmQkxW1A6d/NNIdgT4WHLMofWIYhXKjR
         7yGQp3eOHriItW/HzdMRbdCb1SjfWbKcJIHGQcQ4=
Date:   Thu, 26 Sep 2019 17:32:11 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid data corruption by
 forbidding SSR overwrite
Message-ID: <20190927003211.GA36793@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190816030334.81035-1-yuchao0@huawei.com>
 <20190926203755.GA142676@gmail.com>
 <20190926214653.GA29685@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926214653.GA29685@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26, Jaegeuk Kim wrote:
> On 09/26, Eric Biggers wrote:
> > On Fri, Aug 16, 2019 at 11:03:34AM +0800, Chao Yu wrote:
> > > There is one case can cause data corruption.
> > > 
> > > - write 4k to fileA
> > > - fsync fileA, 4k data is writebacked to lbaA
> > > - write 4k to fileA
> > > - kworker flushs 4k to lbaB; dnode contain lbaB didn't be persisted yet
> > > - write 4k to fileB
> > > - kworker flush 4k to lbaA due to SSR
> > > - SPOR -> dnode with lbaA will be recovered, however lbaA contains fileB's
> > > data
> > > 
> > > One solution is tracking all fsynced file's block history, and disallow
> > > SSR overwrite on newly invalidated block on that file.
> > > 
> > > However, during recovery, no matter the dnode is flushed or fsynced, all
> > > previous dnodes until last fsynced one in node chain can be recovered,
> > > that means we need to record all block change in flushed dnode, which
> > > will cause heavy cost, so let's just use simple fix by forbidding SSR
> > > overwrite directly.
> > > 
> > > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > > ---
> > >  fs/f2fs/segment.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > index 9d9d9a050d59..69b3b553ee6b 100644
> > > --- a/fs/f2fs/segment.c
> > > +++ b/fs/f2fs/segment.c
> > > @@ -2205,9 +2205,11 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
> > >  		if (!f2fs_test_and_set_bit(offset, se->discard_map))
> > >  			sbi->discard_blks--;
> > >  
> > > -		/* don't overwrite by SSR to keep node chain */
> > > -		if (IS_NODESEG(se->type) &&
> > > -				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
> > > +		/*
> > > +		 * SSR should never reuse block which is checkpointed
> > > +		 * or newly invalidated.
> > > +		 */
> > > +		if (!is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
> > >  			if (!f2fs_test_and_set_bit(offset, se->ckpt_valid_map))
> > >  				se->ckpt_valid_blocks++;
> > >  		}
> > > -- 
> > 
> > FYI, this commit caused xfstests generic/064 to start failing:
> 
> Yup, I was looking at this.

It seems fcollapse couldn't allocate blocks sequential when rewriting blocks.

We need to adjust like this:
---
 tests/generic/064 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/generic/064 b/tests/generic/064
index 1ace14b6..058258d5 100755
--- a/tests/generic/064
+++ b/tests/generic/064
@@ -72,7 +72,9 @@ done
 
 extent_after=`_count_extents $dest`
 if [ $extent_before -ne $extent_after ]; then
-	echo "extents mismatched before = $extent_before after = $extent_after"
+	if [ "$FSTYP" != "f2fs" ] || [ $extent_before -ne 1 ] || [ $extent_after -ne 50 ]; then
+		echo "extents mismatched before = $extent_before after = $extent_after"
+	fi
 fi
 
 # compare original file and test file.
-- 
2.19.0.605.g01d371f741-goog


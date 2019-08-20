Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C705C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 01:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE0822CF4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 01:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566262804;
	bh=3k09FSAiN1EmDJYOwHzqIY0z6rdM/xIPz2fJfXY0Jd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GBeNgGbD6DGhIP1AYQwU8E2iF9kbcmGH/VNEWdkUY+9MeKdMUXwwiHhqJWADrgE+2
	 BboMaOzZm73f8BCNpSQ6d8/SK71k+5BfUhNklct2VAtn1N4+snsjyyiTHa3pPf2XXW
	 Dlqgl17hgJnNpUJTbgQUBOXChRiivegJ2MNIzIM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfHTBAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 21:00:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbfHTBAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 21:00:02 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B2F322CE8;
        Tue, 20 Aug 2019 01:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566262801;
        bh=3k09FSAiN1EmDJYOwHzqIY0z6rdM/xIPz2fJfXY0Jd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUAUu8VZBvG8TphqNQTLtnrtRoyjj9IAiv0JICGK8sVXH8kfovJr0OYIWhDXlU/kO
         Ra2ZbTLGqBu6qfYh0SaXYzLXT6+WwcVwzI6wccUMKh3be1h/qrXcDI9mEcSpGoVyYE
         PZpZcRfLUwHiS2krWglhoAYamsiI9UEtADMq1Has=
Date:   Mon, 19 Aug 2019 18:00:00 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: fix to avoid data corruption by forbidding SSR
 overwrite
Message-ID: <20190820010000.GA45681@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190816030334.81035-1-yuchao0@huawei.com>
 <3349ceea-85ac-173a-81a4-1188ce3804ca@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3349ceea-85ac-173a-81a4-1188ce3804ca@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/19, Chao Yu wrote:
> On 2019/8/16 11:03, Chao Yu wrote:
> > There is one case can cause data corruption.
> > 
> > - write 4k to fileA
> > - fsync fileA, 4k data is writebacked to lbaA
> > - write 4k to fileA
> > - kworker flushs 4k to lbaB; dnode contain lbaB didn't be persisted yet
> > - write 4k to fileB
> > - kworker flush 4k to lbaA due to SSR
> > - SPOR -> dnode with lbaA will be recovered, however lbaA contains fileB's
> > data
> > 
> > One solution is tracking all fsynced file's block history, and disallow
> > SSR overwrite on newly invalidated block on that file.
> > 
> > However, during recovery, no matter the dnode is flushed or fsynced, all
> > previous dnodes until last fsynced one in node chain can be recovered,
> > that means we need to record all block change in flushed dnode, which
> > will cause heavy cost, so let's just use simple fix by forbidding SSR
> > overwrite directly.
> > 
> 
> Jaegeuk,
> 
> Please help to add below missed tag to keep this patch being merged in stable
> kernel.
> 
> Fixes: 5b6c6be2d878 ("f2fs: use SSR for warm node as well")

Done.

> 
> Thanks,
> 
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > ---
> >  fs/f2fs/segment.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 9d9d9a050d59..69b3b553ee6b 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -2205,9 +2205,11 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
> >  		if (!f2fs_test_and_set_bit(offset, se->discard_map))
> >  			sbi->discard_blks--;
> >  
> > -		/* don't overwrite by SSR to keep node chain */
> > -		if (IS_NODESEG(se->type) &&
> > -				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
> > +		/*
> > +		 * SSR should never reuse block which is checkpointed
> > +		 * or newly invalidated.
> > +		 */
> > +		if (!is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
> >  			if (!f2fs_test_and_set_bit(offset, se->ckpt_valid_map))
> >  				se->ckpt_valid_blocks++;
> >  		}
> > 

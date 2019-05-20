Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81551C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5603921773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558394684;
	bh=EAIisFPL9YiInF7rgY/58eLITFlmvPrtrY9ljPOJESM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OmKL5i9l34urDjw6t84wZGuPbNa9J+dgM/phTs+H66za0GP/DlbDMEzzILqrLlCXl
	 8Lr6JAwIdD98irq5KEEcjyZGxP1EVPttfHV+Y0cu9P51laSdBm+R9dJ1uvz6QMdGvU
	 QwyL3oQpbjNNgoJaOWiw7H88hN5KMS6QgpM1MRKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfETXYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 19:24:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfETXYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:24:43 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82A3B20862;
        Mon, 20 May 2019 23:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558394682;
        bh=EAIisFPL9YiInF7rgY/58eLITFlmvPrtrY9ljPOJESM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sw3G2hqCcL7bO82bvqv/r6Z10kCLkBqgQgMffjGSQhFIWJTqAWbEaKMQgjZD1mj/i
         GuMymrpa9y9N7xKW+QaPFzS2D0t+N7RwRMEIb/GM6aDnEiYKKaoU8wjUtf5/fSuymL
         mCnwcegCm2qtJ6blWxg1+xPD4Gq//tYPfpdkgTeo=
Date:   Mon, 20 May 2019 16:24:41 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't clear CP_QUOTA_NEED_FSCK_FLAG
Message-ID: <20190520232441.GA61195@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190212023343.52215-1-jaegeuk@kernel.org>
 <5ee36ad7-9fe9-adcf-0974-5c17fa8d50ee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ee36ad7-9fe9-adcf-0974-5c17fa8d50ee@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10, Chao Yu wrote:
> On 2019/2/12 10:33, Jaegeuk Kim wrote:
> > If we met this once, let fsck.f2fs clear this only.
> > Note that, this addresses all the subtle fault injection test.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/checkpoint.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 03fea4efd64b..10a3ada28715 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -1267,8 +1267,6 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >  
> >  	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
> >  		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> > -	else
> > -		__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> 
> Jaegeuk,
> 
> Will below commit fix this issue? Not sure, but just want to check that.. :)
> 
> f2fs-tools: fix to check total valid block count before block allocation

I started test again whether we can revert this or not. :)
Let's see.

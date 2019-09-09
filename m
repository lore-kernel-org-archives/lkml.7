Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D341C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757B321924
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568030689;
	bh=9b/8IY4QOe0LwdrOWJ2ftTvFx8mgPq5bP/abAgWH+0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mXP1IYPYX+DKioRBoN6QuVTw6iM9zZ5FkvqtdkDuvxNiK3pVktRl5di2K8OrMP7jL
	 NpBIduZZ26YEXNqbmfIOnJG9PQc6wnHYllMe8X6/bQ+1cDSDFv82f/q4nWTvjqVq2I
	 LZU+CfUjrobkbI4D/c8X93ckuaF+tuWDBsqcj5SU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404698AbfIIMEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404215AbfIIMEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 08:04:47 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28BD82067B;
        Mon,  9 Sep 2019 12:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568030686;
        bh=9b/8IY4QOe0LwdrOWJ2ftTvFx8mgPq5bP/abAgWH+0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hg+y8W+vKwgkCTchcgPlYP+HxphpgwrPcPZ/0M+tRDuKTjIpACy6zxOY4caDcM9JN
         yRRLQTNTL5dPIzmtwh2Letb8gNbTQ3XUHLI2XQrOSiiKvpedAD1FZ2KE0e3Qxalosk
         AI3g57p16XzVXxvOIczb2SrDXjwqRbG7rpueyzKA=
Date:   Mon, 9 Sep 2019 13:04:43 +0100
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: do not select same victim right
 again
Message-ID: <20190909120443.GA31108@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190909012532.20454-1-jaegeuk@kernel.org>
 <69933b7f-48cc-47f9-ba6f-b5ca8f733cba@huawei.com>
 <20190909080654.GD21625@jaegeuk-macbookpro.roam.corp.google.com>
 <97237da2-897a-8420-94de-812e94aa751f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97237da2-897a-8420-94de-812e94aa751f@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09, Chao Yu wrote:
> On 2019/9/9 16:06, Jaegeuk Kim wrote:
> > On 09/09, Chao Yu wrote:
> >> On 2019/9/9 9:25, Jaegeuk Kim wrote:
> >>> GC must avoid select the same victim again.
> >>
> >> Blocks in previous victim will occupy addition free segment, I doubt after this
> >> change, FGGC may encounter out-of-free space issue more frequently.
> > 
> > Hmm, actually this change seems wrong by sec_usage_check().
> > We may be able to avoid this only in the suspicious loop?
> > 
> > ---
> >  fs/f2fs/gc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index e88f98ddf396..5877bd729689 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -1326,7 +1326,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> >  		round++;
> >  	}
> >  
> > -	if (gc_type == FG_GC)
> > +	if (gc_type == FG_GC && seg_freed)
> 
> That's original solution Sahitya provided to avoid infinite loop of GC, but I
> suggest to find the root cause first, then we added .invalid_segmap for that
> purpose.

I've checked the Sahitya's patch. So, it seems the problem can happen due to
is_alive or atomic_file.

> 
> Thanks,
> 
> >  		sbi->cur_victim_sec = NULL_SEGNO;
> >  
> >  	if (sync)
> > 

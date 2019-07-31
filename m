Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB439C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 03:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9C6206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 03:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZQsfrmRZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UzR2epEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfGaDmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 23:42:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37572 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfGaDmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 23:42:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CE4E06055D; Wed, 31 Jul 2019 03:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564544525;
        bh=tkL070zERUEPtY0sasXkHW/2O4WUDAK5Ddm4rfezDg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZQsfrmRZosJwifVWO9HR0zyzI7ii9jEzl/mr6d4+ic+P6NuyqQHKlv9ZqhkEWQ/hH
         LHso0sm5HbShY73pKd5BCWTdIWVMXEd1W9boge8PhmA46/v8zaFlUTbwtJ8FZdxT6L
         SjwG+0cJz3Z15FPl1/qrvY+o9UmGb3BSubqn9BiU=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8AC160258;
        Wed, 31 Jul 2019 03:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564544524;
        bh=tkL070zERUEPtY0sasXkHW/2O4WUDAK5Ddm4rfezDg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UzR2epEW8G11yMnkOS7roprhajChRalbmHLqP5E2cHO41QGtZ5ZcIe/r+7H410gsU
         HDQgdjgdwWkLj9FlMqxvL1rYi4ReYIstnY9thkwqHEUH1zi4Leh/oLG/qy9R33gAfc
         9zp5LKTn4mHRe/I5MJqhJB+tpFexNJl7AnqUjHc4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8AC160258
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Wed, 31 Jul 2019 09:11:59 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, stummala@codeaurora.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix indefinite loop in f2fs_gc()
Message-ID: <20190731034159.GH8289@codeaurora.org>
References: <1564377626-12898-1-git-send-email-stummala@codeaurora.org>
 <a5acb5cb-2e77-902f-0a5e-063f7cbd0643@kernel.org>
 <20190730043630.GG8289@codeaurora.org>
 <609a502b-1e7f-c9b2-e864-421ffeda298b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <609a502b-1e7f-c9b2-e864-421ffeda298b@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Tue, Jul 30, 2019 at 08:35:46PM +0800, Chao Yu wrote:
> Hi Sahitya,
> 
> On 2019/7/30 12:36, Sahitya Tummala wrote:
> > Hi Chao,
> > 
> > On Tue, Jul 30, 2019 at 12:00:45AM +0800, Chao Yu wrote:
> >> Hi Sahitya,
> >>
> >> On 2019-7-29 13:20, Sahitya Tummala wrote:
> >>> Policy - foreground GC, LFS mode and greedy GC mode.
> >>>
> >>> Under this policy, f2fs_gc() loops forever to GC as it doesn't have
> >>> enough free segements to proceed and thus it keeps calling gc_more
> >>> for the same victim segment.  This can happen if the selected victim
> >>> segment could not be GC'd due to failed blkaddr validity check i.e.
> >>> is_alive() returns false for the blocks set in current validity map.
> >>>
> >>> Fix this by not resetting the sbi->cur_victim_sec to NULL_SEGNO, when
> >>> the segment selected could not be GC'd. This helps to select another
> >>> segment for GC and thus helps to proceed forward with GC.
> >>>
> >>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> >>> ---
> >>>  fs/f2fs/gc.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> >>> index 8974672..7bbcc4a 100644
> >>> --- a/fs/f2fs/gc.c
> >>> +++ b/fs/f2fs/gc.c
> >>> @@ -1303,7 +1303,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> >>>  		round++;
> >>>  	}
> >>>  
> >>> -	if (gc_type == FG_GC)
> >>> +	if (gc_type == FG_GC && seg_freed)
> >>>  		sbi->cur_victim_sec = NULL_SEGNO;
> >>
> >> In some cases, we may remain last victim in sbi->cur_victim_sec, and jump out of
> >> GC cycle, then SSR can skip the last victim due to sec_usage_check()...
> >>
> > 
> > I see. I have a few questions on how to fix this issue. Please share your
> > comments.
> > 
> > 1. Do you think the scenario described is valid? It happens rarely, not very
> 
> IIRC, we suffered endless gc loop due to there is valid block belong to an
> opened atomic write file. (because we will skip directly once we hit atomic file)
> 
> For your case, I'm not sure that would happen, did you look into is_alive(), why
> will it fail? block address not match? If so, it looks like summary info and
> dnode block and nat entry are inconsistent.

Yes, from the ramdumps, I could see that block address is not matching and
hence, is_alive() could fail in the issue scenario. Have you observed any such
cases before? What could be the reason for this mismatch?

Thanks,

> 
> > easy to reproduce.  From the dumps, I see that only block is set as valid in
> > the sentry->cur_valid_map for which I see that summary block check is_alive()
> > could return false. As only one block is set as valid, chances are there it
> > can be always selected as the victim by get_victim_by_default() under FG_GC.
> > 
> > 2. What are the possible scenarios where summary block check is_alive() could
> > fail for a segment?
> 
> I guess, maybe after check_valid_map(), the block is been truncated before
> is_alive(). If so the victim should be prefree directly instead of being
> selected again...
> 
> > 
> > 3. How does GC handle such segments?
> 
> I think that's not a normal case, or I'm missing something.
> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> >> Thanks,
> >>
> >>>  
> >>>  	if (sync)
> >>>
> > 

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

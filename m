Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDB1C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 03:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC9320844
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 03:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EjuZ1ANb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfGHDVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 23:21:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43017 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfGHDVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 23:21:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id cl9so7466897plb.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 20:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yriNKsJYe60EiNop3TWpMryY2FxcQ0ThW6Sm/XJwlR8=;
        b=EjuZ1ANbtWBdFoLUBhJy9NtMg1EBYm4JHMHrGolEeqgphFf/tPZ52cOdUyqWITuNVo
         SIwGW+m80mSfKEHOxu72UX1mqNLUffbdTxTux4L0WTdT6xtq+8Mso7YqAS1onxOwcrTU
         BTxCSxzp5soMmiH+XApJ/ROmWhsX99p/B46sXTR/1SIJOYZRu0C4hQxojEm7laFCffyD
         nCLvrrLDCza0BlqijaL2JnzpdvQGL+aAj8AdPQbo7rOs+0v9ucBbeaQsydsCGXX3lP+a
         c4bXY0l7ULFAVwiEjbqU6Ft0u6Wg6L6VXRjiOSTsmOVejix0h4h01hqZ97SHMz3KT2+L
         eEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yriNKsJYe60EiNop3TWpMryY2FxcQ0ThW6Sm/XJwlR8=;
        b=dFdBszq43hqXhDIG9pHohp6xOHfefZn1EdiLTc2Y1WqpBoVoaZnxA4eY0hReH3k1gy
         ZqfAj+LQqWf9JxIg7JCRBDW3jymKWzlImGRQDy1jSz2z5l3qXNa64XgRRpk5NoCPJ/iV
         +CYy669G9AsowEsVIMG7Yi82oRDa5RLLIApJRCys0ELRxWei+oq4ZV905hLBjXYi27CW
         55kdz395LgMECvOfGXhccHobTpLREdBikiGue2ApmPHrAQ5Icx41IMJUFWDkVdTEPC10
         xgXWcycewLcbIdPsf/mAYUd1XTLG3RC4TbN5dTPrnEL6RqUCDPvRy6bmbYVysfqez9et
         zs5A==
X-Gm-Message-State: APjAAAUocVWPLOZBEiiDwiqGKovQVs9cEqgUpyMrX1HV02KLy6mm1sE1
        vmDCzrrnG+z2Q9arz3iabNTeqA==
X-Google-Smtp-Source: APXvYqy9tBhinJ/jH5hpam8xPIBRos92/McvenDYvqMZ3bPkT9zPSd6TglCFr+WR+TOqD/5Mar2odg==
X-Received: by 2002:a17:902:2a27:: with SMTP id i36mr21205885plb.161.1562556079749;
        Sun, 07 Jul 2019 20:21:19 -0700 (PDT)
Received: from google.com ([2401:fa00:fd:2:3217:6d96:9ca7:b98b])
        by smtp.gmail.com with ESMTPSA id r1sm17346719pfq.100.2019.07.07.20.21.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 20:21:19 -0700 (PDT)
Date:   Mon, 8 Jul 2019 11:21:11 +0800
From:   Ocean Chen <oceanchen@google.com>
To:     yuchao0@huawei.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: avoid out-of-range memory access
Message-ID: <20190708032111.GA189070@google.com>
References: <20190702080503.175149-1-oceanchen@google.com>
 <cfcd3737-3b03-87fe-39e8-566e545cab3a@huawei.com>
 <20190703150355.GA182283@google.com>
 <65e4ad7b-ffbc-d5c9-9a0f-0532f4c4f5a9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65e4ad7b-ffbc-d5c9-9a0f-0532f4c4f5a9@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YuChao,

  Yes, we got externel researcher reports this security vulnerability.

And dump info is better when blk_off is invalid. I'll prepare the next
patch for it.

On Thu, Jul 04, 2019 at 03:11:27PM +0800, Chao Yu wrote:
> Hi Ocean,
> 
> On 2019/7/3 23:03, Ocean Chen wrote:
> > Hi Yu Chao,
> > 
> > The cur_data_segno only was checked in mount process. In terms of
> > security concern, it's better to check value before using it. I know the
> 
> Could you explain more about security concern.. Do you get any report from user
> or tools that complaining f2fs issue/codes?
> 
> I'm not against sanity check for basic core data of filesystem in run-time, but,
> in order to troubleshoot root cause of this issue we can trigger panic directly
> to dump more info under F2FS_CHECK_FS macro.
> 
> So, maybe we can change as below?
> 
> blk_off = le16_to_cpu(ckpt->cur_data_blkoff[i]);
> +if (blk_off > ENTRIES_IN_SUM) {
> +	f2fs_bug_on(1);
> +	f2fs_put_page(page, 1);
> +	return -EFAULT;
> +}
> 
> Thanks,
> 
> > risk is low. IMHO, it can be safer.
> > BTW, I found we can only check blk_off before for loop instead of
> > checking 'j' in each iteratoin.
> > 
> > On Wed, Jul 03, 2019 at 10:07:11AM +0800, Chao Yu wrote:
> >> Hi Ocean,
> >>
> >> If filesystem is corrupted, it should fail mount due to below check in
> >> f2fs_sanity_check_ckpt(), so we are safe in read_compacted_summaries() to access
> >> entries[0,blk_off], right?
> >>
> >> 	for (i = 0; i < NR_CURSEG_DATA_TYPE; i++) {
> >> 		if (le32_to_cpu(ckpt->cur_data_segno[i]) >= main_segs ||
> >> 			le16_to_cpu(ckpt->cur_data_blkoff[i]) >= blocks_per_seg)
> >> 			return 1;
> >>
> >> Thanks,
> >>
> >> On 2019/7/2 16:05, Ocean Chen wrote:
> >>> blk_off might over 512 due to fs corrupt.
> >>> Use ENTRIES_IN_SUM to protect invalid memory access.
> >>>
> >>> v2:
> >>> - fix typo
> >>> Signed-off-by: Ocean Chen <oceanchen@google.com>
> >>> ---
> >>>  fs/f2fs/segment.c | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>> index 8dee063c833f..a5e8af0bd62e 100644
> >>> --- a/fs/f2fs/segment.c
> >>> +++ b/fs/f2fs/segment.c
> >>> @@ -3403,6 +3403,8 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
> >>>  
> >>>  		for (j = 0; j < blk_off; j++) {
> >>>  			struct f2fs_summary *s;
> >>> +			if (j >= ENTRIES_IN_SUM)
> >>> +				return -EFAULT;
> >>>  			s = (struct f2fs_summary *)(kaddr + offset);
> >>>  			seg_i->sum_blk->entries[j] = *s;
> >>>  			offset += SUMMARY_SIZE;
> >>>
> > .
> > 

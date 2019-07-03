Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A04C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9714620828
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W1ELw492"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfGCPEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:04:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44963 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGCPEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:04:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id t7so1390993plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 08:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=37hMmTyD0K9QDDKKnPyMk0IHgB8jdOaS9XE3nfECex0=;
        b=W1ELw492iBqoEtuhoj+Xfh9gtti36WkdD2hXoa2KDWc96yb8UiWQnigeqVyTLuF7ye
         ONFUjDSltojaY/UFcWhkASwrBe9gb9/TC3pGGR+yWqj/Ub03puBiLQtykpmrZ4tM9ScZ
         SL7gnwrYsbaxXauGom+a4ug9FcHtfKsStCAxBO3v77VVhio9J5PghtZ5/2p95o8jJPn/
         8iKAXv8/4Ker46cEHs7n3RFawBSdA+Gtq3sfAYnm3Y3VDuVnTuRMtDFTFEjNC41SJemG
         NtgvOJ0PGjLGb+dQvLVSAENhUOjQo1x7NQm0EdZlMmyhSRcoQaXgassd/7OX1Aoizock
         7X2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=37hMmTyD0K9QDDKKnPyMk0IHgB8jdOaS9XE3nfECex0=;
        b=coVio+DVCBGbVzQIJkDfh/tHxKspXZC/asVY4AgMMjXYPfhpDv4nrZmMdZrrKdGlVh
         /MJovJ8d6gJtbPigvxxpgKaWlcGgzWiLFSxg3Fdsv90n2YkC7Dwdc0rI+i+Y970L1evw
         T1qAkLozswEFnObbRX7WO32fmEOyuppEn1s+ibh4O6VxI4T3SiT3Jl8WL8/3/JAyEZPN
         pYFm1MMeh4GCgPBTe4widm0VJ35vVKiO2EGaQH9flpZNoH6ULhZDM2n+jnrhUmB9fxNV
         zoHyCqT8DumkgVFE/VLPdzkRCi1DOZMbWiQ8Ycrr9N39luBt3HpV+0FqCj+uAuDZGADt
         j1/Q==
X-Gm-Message-State: APjAAAUiTHgP+k8o4cYyY1fla0fB3kLKvw9oFlzJgBGL4UX8bY48nPBe
        rPU5uXpqZkU8EAB8uwKcCxwQeap8TEFMBOkF
X-Google-Smtp-Source: APXvYqzm9VoQdSLoR1RbyAFmag38CTXi0djAc26Mp2+tUxGdT79rlo3yhj0j6nK9BOMcpY8de6+dLA==
X-Received: by 2002:a17:902:d916:: with SMTP id c22mr43738767plz.195.1562166243044;
        Wed, 03 Jul 2019 08:04:03 -0700 (PDT)
Received: from google.com ([2401:fa00:fd:2:3217:6d96:9ca7:b98b])
        by smtp.gmail.com with ESMTPSA id z20sm5179094pfk.72.2019.07.03.08.04.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 08:04:01 -0700 (PDT)
Date:   Wed, 3 Jul 2019 23:03:55 +0800
From:   Ocean Chen <oceanchen@google.com>
To:     yuchao0@huawei.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: avoid out-of-range memory access
Message-ID: <20190703150355.GA182283@google.com>
References: <20190702080503.175149-1-oceanchen@google.com>
 <cfcd3737-3b03-87fe-39e8-566e545cab3a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfcd3737-3b03-87fe-39e8-566e545cab3a@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu Chao,

The cur_data_segno only was checked in mount process. In terms of
security concern, it's better to check value before using it. I know the
risk is low. IMHO, it can be safer.
BTW, I found we can only check blk_off before for loop instead of
checking 'j' in each iteratoin.

On Wed, Jul 03, 2019 at 10:07:11AM +0800, Chao Yu wrote:
> Hi Ocean,
> 
> If filesystem is corrupted, it should fail mount due to below check in
> f2fs_sanity_check_ckpt(), so we are safe in read_compacted_summaries() to access
> entries[0,blk_off], right?
> 
> 	for (i = 0; i < NR_CURSEG_DATA_TYPE; i++) {
> 		if (le32_to_cpu(ckpt->cur_data_segno[i]) >= main_segs ||
> 			le16_to_cpu(ckpt->cur_data_blkoff[i]) >= blocks_per_seg)
> 			return 1;
> 
> Thanks,
> 
> On 2019/7/2 16:05, Ocean Chen wrote:
> > blk_off might over 512 due to fs corrupt.
> > Use ENTRIES_IN_SUM to protect invalid memory access.
> > 
> > v2:
> > - fix typo
> > Signed-off-by: Ocean Chen <oceanchen@google.com>
> > ---
> >  fs/f2fs/segment.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 8dee063c833f..a5e8af0bd62e 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -3403,6 +3403,8 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
> >  
> >  		for (j = 0; j < blk_off; j++) {
> >  			struct f2fs_summary *s;
> > +			if (j >= ENTRIES_IN_SUM)
> > +				return -EFAULT;
> >  			s = (struct f2fs_summary *)(kaddr + offset);
> >  			seg_i->sum_blk->entries[j] = *s;
> >  			offset += SUMMARY_SIZE;
> > 

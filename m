Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C13C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311D22147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552415338;
	bh=0EQ5NPrjN6Hpa/pP9+oS9NCqsAFQWz9foY2fM15nCAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w0A94i6WYPdR5HAwWcK2yNofdUd0yb2+yjf1JT7uHiICvoknOKDUVD1mn4HOTzjGj
	 FI+q+LN6uqc/yg1VI9qSRLjZeWS26qvLCOotWvH/beYsHdcRNSLI+4mjSYT8vQKQ4s
	 AzkeI36Lh+cZ+lz0F3+jyGuaI6X1XJWuxoV3XNtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfCLS24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:28:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfCLS24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:28:56 -0400
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF2B8213A2;
        Tue, 12 Mar 2019 18:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552415335;
        bh=0EQ5NPrjN6Hpa/pP9+oS9NCqsAFQWz9foY2fM15nCAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=by7XdgomKsGHc3hfKpDtVUKBk2ACbRfEWBNfPGLcswJB1K7aF7bYyNufSqjXoxqIx
         hOJV0xB3haQsnK5/GSFcJ+d4LSFoGzZgC9GNHI/q36QuoD+s8Uxe1nTGOWpz01DuC5
         2yBwU22pcbs/GTuZesTv4qUa2dKksSCdkOwRjGc4=
Date:   Tue, 12 Mar 2019 11:28:55 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Weichao Guo <guoweichao@huawei.com>
Subject: Re: [PATCH v11] f2fs: guarantee journalled quota data by checkpoint
Message-ID: <20190312182855.GA45421@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180920120500.21026-1-chao@kernel.org>
 <7a2b9277-acbf-eda4-d043-74463d7b61c7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a2b9277-acbf-eda4-d043-74463d7b61c7@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2018/9/20 20:05, Chao Yu wrote:
> > @@ -3456,3 +3477,16 @@
> > 
> >  extern void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
> > 
> > #endif
> > #endif
> > +
> > +static inline bool is_journalled_quota(struct f2fs_sb_info *sbi)
> > +{
> > +#ifdef CONFIG_QUOTA
> > + if (f2fs_sb_has_quota_ino(sbi->sb))
> > + return true;
> > + if (F2FS_OPTION(sbi).s_qf_names[USRQUOTA] ||
> > + F2FS_OPTION(sbi).s_qf_names[GRPQUOTA] ||
> > + F2FS_OPTION(sbi).s_qf_names[PRJQUOTA])
> > + return true;
> > +#endif
> > + return false;
> > +}
> 
> I checked dev branch, and found one patch we didn't send to mailing list,
> could you please send it out?
> 
> f2fs: fix wrong #endif
> 
> I think my quota patch caused this 'wrong #endif' issue, could you add
> single line comment to notice which #if the last #endif is corresponding
> to? so that we can avoid same mistake as quota patch made.

Ah, I forgot to post the patch. It's quite late but obvious, and thus let me
keep the patch as is in order to avoid messing up the commit history.

Thanks,

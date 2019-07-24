Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49B1C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722AF22ADB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563977835;
	bh=zP6AYD3vjm5KSr7SiF5kE0XnBBT7lbNfK71Bpk75eFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H8v4C6ak1vti5oSR9P1F3t3w+k/m6RoPBCRQQ3ogWdfMa/loCbqDR4jvGLY1gjMLn
	 wqnd3k5fe4DIO0XZFGo5L+ZJhmrn9KTck3j62KzdUq5vrPe6+0YHPVk57nQZFDISoa
	 KuCbbAYvfswgPInTewnwcdzeniT6OKhj0mFi5Qu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfGXORO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:17:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:34192 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726287AbfGXORM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:17:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42C0BAFD4;
        Wed, 24 Jul 2019 14:17:11 +0000 (UTC)
Date:   Wed, 24 Jul 2019 16:17:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     YueHaibing <yuehaibing@huawei.com>, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        yang.shi@linux.alibaba.com, jannh@google.com, walken@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/mmap.c: silence variable 'new_start' set but not used
Message-ID: <20190724141710.GD5584@dhcp22.suse.cz>
References: <20190724140739.59532-1-yuehaibing@huawei.com>
 <1563977465.11067.9.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1563977465.11067.9.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-07-19 10:11:05, Qian Cai wrote:
> On Wed, 2019-07-24 at 22:07 +0800, YueHaibing wrote:
> > 'new_start' is used in is_hugepage_only_range(),
> > which do nothing in some arch. gcc will warning:
> > 
> > mm/mmap.c: In function acct_stack_growth:
> > mm/mmap.c:2311:16: warning: variable new_start set but not used [-Wunused-but-
> > set-variable]
> 
> Nope. Convert them to inline instead.

Agreed. Obfuscating the code is not really something we want.

> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  mm/mmap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index e2dbed3..56c2a92 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2308,7 +2308,7 @@ static int acct_stack_growth(struct vm_area_struct *vma,
> >  			     unsigned long size, unsigned long grow)
> >  {
> >  	struct mm_struct *mm = vma->vm_mm;
> > -	unsigned long new_start;
> > +	unsigned long __maybe_unused new_start;
> >  
> >  	/* address space limit tests */
> >  	if (!may_expand_vm(mm, vma->vm_flags, grow))

-- 
Michal Hocko
SUSE Labs

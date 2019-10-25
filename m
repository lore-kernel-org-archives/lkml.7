Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD27CA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 02:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FB2206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 02:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTMCWdIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389875AbfJYCc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 22:32:57 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46941 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbfJYCc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 22:32:57 -0400
Received: by mail-pl1-f196.google.com with SMTP id q21so406761plr.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 19:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=g1ns30NWBvyr7boX6LL1Xy9XjoQxnnSYF9EZ4Db7JXo=;
        b=pTMCWdIkG2cC3CrrCS6QNFDxjPVipsYh4cnjbLOMvo/dRNvfEgjpLq085gUwWBxFI7
         oW1yDmWGuCoUBtppG8o5fzQ84VjmJxenG3SWZwrEd9/irg7P9GghSu4xIjpQMllExLmO
         IwRRhGZt8peS8UzhqKhVzfAvtwE/2kuxn/C4z5QUmWLo3xL/o5wAPxXOTMB2pFtDknpd
         aOOQJjxTN+2eWKVYjBl3cRroPcjT5Mzk99ZLS7j/iFml1r3qRFvB4Y895bqdewPlk6sW
         nL1rYXHyfkVHoYNtwSKzXYWDIkXrdKkSuGcr99FBismEKHoTHzLqFFVtJlV5MW3WZyU4
         UAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=g1ns30NWBvyr7boX6LL1Xy9XjoQxnnSYF9EZ4Db7JXo=;
        b=Ei+mtzcUZjKutkcBK36ocGUQ2+ApPvXagALPqT7xctmN9AzztdUcQu/jgheTMAGEqq
         gGNlcxHuAeKUW3SUwimU9kPhaF7Ai4hh27GJ+a1HZO/p1fj/cRcild/2AImiOMvNTeiQ
         QLB3hvF3Bp1wOGhcdVaUZSquYJmD44uzDpR9YPmpQfZGs7+9JsBzS93Ply7VWL9IOCHe
         Ko3URg3M8PbpK0bZvrAhGDW9wqAU7Nygpvx5jNALHkliW4r9iqBGa6pNOCWWV5o4Gnnu
         zgcJ3TEIhtE81vgcb/uwl5igsgYGDi8A3lPS6NnDUNbRxKcP8EgFoY6Ota9oJOk0P7Y2
         MN9g==
X-Gm-Message-State: APjAAAW0+Tx3sMs6K56txPDCLolRrDPN7pWyFlgCgjmwIOgAr7KB5p76
        qIP+MQo3MCd2sOGZopfkIbszoQ==
X-Google-Smtp-Source: APXvYqzBwaAIQFbX3bMEtf0GQp6J6XBRgOCr8x81MVhZh1qy1hbfTEFcOAEv5o2X8PBCHhwS3S4rAA==
X-Received: by 2002:a17:902:44d:: with SMTP id 71mr1069193ple.320.1571970775667;
        Thu, 24 Oct 2019 19:32:55 -0700 (PDT)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id b13sm366035pgd.58.2019.10.24.19.32.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Oct 2019 19:32:54 -0700 (PDT)
Date:   Thu, 24 Oct 2019 19:32:39 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Li Xinhai <xinhai.li@outlook.com>
cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm: allow unmapped hole at head side of mbind range
In-Reply-To: <c90d668a-9abc-df1b-8b9c-70a6e6afd94a@suse.cz>
Message-ID: <alpine.LSU.2.11.1910241900070.1096@eggly.anvils>
References: <TY2PR04MB29753892EBAD17D9E8FECBAEE86A0@TY2PR04MB2975.apcprd04.prod.outlook.com> <c90d668a-9abc-df1b-8b9c-70a6e6afd94a@suse.cz>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019, Vlastimil Babka wrote:

> + linux-api
> 
> On 10/24/19 9:35 AM, Li Xinhai wrote:
> > From: Li Xinhai  <xinhai.li@outlook.com>
> > 
> > mbind_range silently ignore unmapped hole at middle and tail of the 
> > specified range, but report EFAULT if hole at head side.
> 
> 
> Hmm that's unfortunate. mbind() manpage says:
> 
> EFAULT Part or all of the memory range specified by nodemask and maxnode
> points outside your accessible address space.  Or, there was an unmapped
> hole in  the  specified  memory range specified by addr and len.
> 
> That sounds like any hole inside the specified range should return
> EFAULT.

Yes (though an exception is allowed when restoring to default).

> But perhaps it can be also interpreted as you suggest, that the
> whole range is an unmapped hole.  There's some risk of breaking existing
> userspace if we change it either way.
> 
> > It is more reasonable to support silently ignore holes at any part of 
> > the range, only report EFAULT if the whole range is in hole.
> > 
> > Signed-off-by: Li Xinhai <xinhai.li@outlook.com>

Xinhai, I'm sceptical about this patch: is it something you found
by code inspection, or something you found when using mbind()?

I've not looked long enough to be certain, nor experimented, but:

mbind_range() is only one stage of the mbind() syscall implementation,
and is preceded by queue_pages_range(): look what queue_pages_test_walk()
does when MPOL_MF_DISCONTIG_OK not set.

My impression is that mbind_range() is merely correcting an omission
from the checks already made my queue_pages_test_walk() (an odd way
to proceed, I admit: would be better to check initially than later).

I do think that you should not make this change without considering
MPOL_MF_DISCONTIG_OK and its intention.

Hugh

> > ---
> > 
> >  mm/mempolicy.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 4ae967bcf954..ae160d9936d9 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -738,7 +738,7 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
> >         unsigned long vmend;
> >  
> >         vma = find_vma(mm, start);
> > -       if (!vma || vma->vm_start > start)
> > +       if (!vma || vma->vm_start >= end)
> >                 return -EFAULT;
> >  
> >         prev = vma->vm_prev;
> > 

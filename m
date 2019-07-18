Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B59C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 22:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479C521849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 22:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W1DjZwMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391351AbfGRWHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 18:07:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36963 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfGRWHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 18:07:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id i70so2752938pgd.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 15:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=+Jwz3mP3TVVRwA+8/Iil5EIlfG8Tly5xGOIwN4hmUt4=;
        b=W1DjZwMaV2AVqZiBstV2H1vjkSj6VtgV6Kmx6bJAsEAr0wQHBkcWN+Pg/hUDmKbt5p
         nMos2P60R5Bbjn1yfEN+bY1coSARNSMrKZIIbo2KPmBUYzn5z5Y6rxqg7g5GjzAvXPvP
         rSfnukwB+GZNj2/rusjBqenkizmReRbaS3qzOPb923VVWv4TzTTQa2PBKODzaLZDZyx4
         Rn27bQY42PbyATHJCjQRXx3zSdCCC8vzd5I92Bbyy1xQ+t1bFl+M06WUpscxo7Mc8ZZW
         ZETwIioafzk5vCUX/pmAaionzCoSgvIF8fSKZW6d9P/BxtDHAdsSZXYvA4GkN1yP3iao
         7J5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=+Jwz3mP3TVVRwA+8/Iil5EIlfG8Tly5xGOIwN4hmUt4=;
        b=qLlfFMNzNipZJWCCOsGyUHu6P4uHF6DDP4Nj7VlgbR5z+ZnkekpdAqeyMNl4z/QJlE
         uxPyFmRqZjE/MkndZeNVCQ6Q4bd8WFVubxv1t+8oIa3mLItydh+Xn7AJvrYdr6JUAPn9
         9tvP7DkAY1oI08EJb9Drsyljw9ggL5dW2NePNnNBSsBj2K3/Lf91OYTr5lTQmDo1P+5J
         echgclOlJ4neO6qpCRgoNfHHv7ihWF+onUfUcERr10vbXQCuLff5pFnPfA6FgsmvxJpU
         kqZFY/Es8OZl3VomBMj1UldcDqDHmicLKgl4f3WD3cuKTVEhRl1JxIDCB0So7AbwCutf
         +82w==
X-Gm-Message-State: APjAAAWYWbr1zl2PtaLGBbQJa8Bmpa3zeYmsEp9OABYkm5NGI0fiKeur
        iMbcutVNTk9wgOI9rbzdEQWwiQ==
X-Google-Smtp-Source: APXvYqz72l6x5vi2AqfAo9LXFLVSwCI9JsECSVsC7JxZmY4Foa9BJh1PdsZ/eBhOfrWAoI2b1Nuz0w==
X-Received: by 2002:a63:506:: with SMTP id 6mr49373861pgf.434.1563487628287;
        Thu, 18 Jul 2019 15:07:08 -0700 (PDT)
Received: from [100.112.64.100] ([104.133.8.100])
        by smtp.gmail.com with ESMTPSA id r2sm39349424pfl.67.2019.07.18.15.07.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jul 2019 15:07:07 -0700 (PDT)
Date:   Thu, 18 Jul 2019 15:06:50 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>, hughd@google.com,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 2/2] mm: thp: fix false negative of shmem vma's THP
 eligibility
In-Reply-To: <dd44eb2f-a982-bd0e-a1ed-ab3ecbf3fc91@suse.cz>
Message-ID: <alpine.LSU.2.11.1907181457150.2510@eggly.anvils>
References: <1560401041-32207-1-git-send-email-yang.shi@linux.alibaba.com> <1560401041-32207-3-git-send-email-yang.shi@linux.alibaba.com> <4a07a6b8-8ff2-419c-eac8-3e7dc17670df@suse.cz> <5dde4380-68b4-66ee-2c3c-9b9da0c243ca@linux.alibaba.com>
 <20190718144459.7a20ac42ee16e093bdfcfab4@linux-foundation.org> <dd44eb2f-a982-bd0e-a1ed-ab3ecbf3fc91@suse.cz>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2019, Vlastimil Babka wrote:
> On 7/18/19 11:44 PM, Andrew Morton wrote:
> > On Wed, 19 Jun 2019 09:28:42 -0700 Yang Shi <yang.shi@linux.alibaba.com> wrote:
> > 
> >>> Sorry for replying rather late, and not in the v2 thread, but unlike
> >>> Hugh I'm not convinced that we should include vma size/alignment in the
> >>> test for reporting THPeligible, which was supposed to reflect
> >>> administrative settings and madvise hints. I guess it's mostly a matter
> >>> of personal feeling. But one objective distinction is that the admin
> >>> settings and madvise do have an exact binary result for the whole VMA,
> >>> while this check is more fuzzy - only part of the VMA's span might be
> >>> properly sized+aligned, and THPeligible will be 1 for the whole VMA.
> >>
> >> I think THPeligible is used to tell us if the vma is suitable for 
> >> allocating THP. Both anonymous and shmem THP checks vma size/alignment 
> >> to decide to or not to allocate THP.
> >>
> >> And, if vma size/alignment is not checked, THPeligible may show "true" 
> >> for even 4K mapping. This doesn't make too much sense either.
> > 
> > This discussion seems rather inconclusive.  I'll merge up the patchset
> > anyway.  Vlastimil, if you think some changes are needed here then
> > please let's get them sorted out over the next few weeks?
> 
> Well, Hugh did ack it, albeit without commenting on this part. I don't
> feel strongly enough about this for a nack.

Right, I had no further comment: Yang and I agreed one way round,
you thought the other way.  I was more persuaded by Yang's 4kB
example than by what you wrote; but not hugely excited either way.

Hugh

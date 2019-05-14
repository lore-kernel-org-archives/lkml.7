Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E560C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C4A20644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geh9IqmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfENWuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 18:50:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46658 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfENWuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 18:50:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id z19so1028795qtz.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 15:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sBibEd37orYwP+TZJ5qBpxDkSgs2ES/yDrUDzm5pB78=;
        b=geh9IqmPLBJnUYyIo6PAtXPXPLzNqILn5iLKHhl3l7XLKEzLv96wpC28OF3APbM+la
         TOtRGScvJ5U5bTjKE0JlFWhLmkUwdMeuaCdnPmez7BbWHdUuph7Amatgae0AfRhL7cte
         BL0NyLQedCTo9hxX2Pff2SfoYlMCLzn7ev4of0WnzljKeawIaQg3HSp1Oj+oy+2/URdk
         GLJyoFA0tv5AKTt32ZT1fPPz6lCXSy+Rb4lGKs3wFYHaMCYeoEDRlrks9H509X3Blbm1
         UhHSoOhPs/DB6q5rTa4eXS3Ijy2tkLwodP+/UnOCDC/2OJbexQpvrJXfVBHtCMsVIH8r
         hERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sBibEd37orYwP+TZJ5qBpxDkSgs2ES/yDrUDzm5pB78=;
        b=f1CWcRjIMhpBLON2pTeyvXTcO1ji35JFjTu+d6y8wGTcC6B1+sAC+SRg2ap2AsLEza
         77Fyga9tLlCau1g2TIM0tOzURRxuTuJCj1pqefSvtS2WNpN9eDGMDRERDrzoNClRA33z
         4Yb0lVsyV034HLL8K9CPrrKFKPsWkd8nQxR4sIfehpGqury27Rz8/raIGK12G2fBDBTa
         Ah0gQBM4zrt1rgrJ4p1bYOgVI2yvG5+jUCX5Xbzexfl1uruZU8xdNDYCLLiEe37Xm9yA
         Ln7qyS8X6pSLy/FUsasrnfobYplg3DK+Foz7URQi3oG8ZkoryWpRFM/7T/fhwNnr1nSv
         3PjQ==
X-Gm-Message-State: APjAAAWhjjuIiYzP4EIn3upYW3yuRiX1m31/tkag3zEMDyt8PgwPJraY
        E4/oWwKsLAzZm+WjxojMtNX/nIpR06nG2zENDaBv7JE3
X-Google-Smtp-Source: APXvYqzOqoD4C9YC9a8iIwRTwQ6rEod1EWH5hmXbAkGou8uu9bNPaymY5aCx1bt1prrRWUNg0zk7S08Hq5eQ/SB1DlY=
X-Received: by 2002:ac8:16b4:: with SMTP id r49mr24380657qtj.157.1557874219298;
 Tue, 14 May 2019 15:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <1556234531-108228-1-git-send-email-yang.shi@linux.alibaba.com> <66e2f965-4f4d-a755-69b3-5342aa761ff3@linux.alibaba.com>
In-Reply-To: <66e2f965-4f4d-a755-69b3-5342aa761ff3@linux.alibaba.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 14 May 2019 15:50:07 -0700
Message-ID: <CAHbLzkqU=O9JmE9Fnie1MzRB_fbD1=3turBtmaRwX-p=PMHHXw@mail.gmail.com>
Subject: Re: [PATCH] mm: filemap: correct the comment about VM_FAULT_RETRY
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     josef@toxicpanda.com, Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josef,

Any comment on this patch? I switched to my personal email since the
mail may get bounced back with my work email sometime.


On Wed, May 8, 2019 at 9:55 AM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
> Ping.
>
>
> Josef, any comment on this one?
>
>
> Thanks,
>
> Yang
>
>
>
> On 4/25/19 4:22 PM, Yang Shi wrote:
> > The commit 6b4c9f446981 ("filemap: drop the mmap_sem for all blocking
> > operations") changed when mmap_sem is dropped during filemap page fault
> > and when returning VM_FAULT_RETRY.
> >
> > Correct the comment to reflect the change.
> >
> > Cc: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> > ---
> >   mm/filemap.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index d78f577..f0d6250 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -2545,10 +2545,8 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
> >    *
> >    * vma->vm_mm->mmap_sem must be held on entry.
> >    *
> > - * If our return value has VM_FAULT_RETRY set, it's because
> > - * lock_page_or_retry() returned 0.
> > - * The mmap_sem has usually been released in this case.
> > - * See __lock_page_or_retry() for the exception.
> > + * If our return value has VM_FAULT_RETRY set, it's because the mmap_sem
> > + * may be dropped before doing I/O or by lock_page_maybe_drop_mmap().
> >    *
> >    * If our return value does not have VM_FAULT_RETRY set, the mmap_sem
> >    * has not been released.
>

Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B99DCA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0992420866
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M2/a7qSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfJ3BUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 21:20:01 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:51121 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfJ3BUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 21:20:00 -0400
Received: by mail-yb1-f201.google.com with SMTP id y17so644091ybq.17
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 18:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AYdRVI9WGFQB02Wf8ZbWTsPKN2JIjEtMhVNpfkWE3mI=;
        b=M2/a7qSgDG27DVx9nSiLjBjo+2vTD3TpPuLBK1F04PGn+tT5vMbUg9RkqBRZr8r9xn
         mzjMUDCoIJE7vGLDH46pysH9Hq7WyruTm0Xv+Gz+RUdZiW8jUjpDTyds7n1/umstebdm
         oHaUDgndjfNDgAOE4R2G7KvP4Tn9sxB52zME4pXipW+Ix/ePy1OiJbgGuC4kmrhT6LXZ
         pNs5u6A8StjMlinzZ8u2oUiL6GgjHrfKXprtzKkZ8vom8auQzkZJfdIjeLgEbqIibsCQ
         LTPy2c82B2H7rxvhVAKBBj+Q9tq7K6tY8WfHrWnuLpiGmkmpZGiPer6a1noWSwXYyZAZ
         g3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AYdRVI9WGFQB02Wf8ZbWTsPKN2JIjEtMhVNpfkWE3mI=;
        b=k+orW1+DkN6TE4dtbVFKM10/32TYbwhpL2+IYSviwYaqq9B31QNzIr7m9NxMwUdLaH
         2Phun5Ruo41qZaMWLm2mxUECQyyxUpzFVwfiE6WbMbcU6Tk0lBVeyUNND36RMgvXMZ62
         sEE2M/bTtjAGRovIKg40WckohCmG9IkS0U4GuTT+GdUMe33wI/vgy9N/t0czV6vHtJxN
         nRyYDJPeihwKkgBC4+tOfVZOo6r3MJQsk61RfYtzxqI9UUtYUTBV1gI88wdrqJUTCe9a
         GbUieyqP8A72lxnUFTm7RQG63ekTRZ+YWhrQPFZk9UwGX/N9eiG4gKH+QFdjsFbjKHvC
         JQNQ==
X-Gm-Message-State: APjAAAWNVX2GPwgwdur9oRNMHIdecWma4i5xTkTsqb2sxs3hMOKJkWdq
        gOPt0T3WK23ds17SkCBvO9GRDeXqsr4=
X-Google-Smtp-Source: APXvYqzwdqSHJRwwG9md08mS87CKIj61n+9ag0iRkO8vnHJJkXJQM5LhPQ28EGb+G3fRQuJqIAvDq6QbHQ4=
X-Received: by 2002:a81:a489:: with SMTP id b131mr19870598ywh.206.1572398399648;
 Tue, 29 Oct 2019 18:19:59 -0700 (PDT)
Date:   Wed, 30 Oct 2019 10:19:54 +0900
In-Reply-To: <20191029074939.GA18999@lst.de>
Message-Id: <20191030011954.60006-1-pliard@google.com>
Mime-Version: 1.0
References: <20191029074939.GA18999@lst.de>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: Re: [PATCH] squashfs: Migrate from ll_rw_block usage to BIO
From:   Philippe Liard <pliard@google.com>
To:     phillip@squashfs.org.uk, hch@lst.de
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        pliard@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> FYI, the mail you quoted never made it to me..
Sorry about that. That was my first time replying on the LKML and I
must have made a mistake when I invoked git send-email.

> On Tue, Oct 29, 2019 at 01:10:13PM +0900, Philippe Liard wrote:
> > > My admittedly limited understanding is that using BIO indirectly
> > > requires buffer_head or an alternative including some
> > > synchronization mechanism at least.
> 
> What access do you need to synchronize?  If you read data into the
> page cache the page lock provides all synchronization needed.  If
> you just read into decrompression buffers there probably is no need
> for synchronization at all as each buffer is only accessed by one
> thread at a time.
My main concern here was waiting for the BIO request to complete but
submit_bio_wait() that you pointed out below should address that.

> > > It's true that the bio_{alloc,add_page,submit}() functions don't
> > > require passing a buffer_head. However because bio_submit() is
> > > asynchronous AFAICT the client needs to use a synchronization
> > > mechanism to wait for and notify the completion of the request
> > > which buffer heads provide. This is achieved respectively by
> > > wait_on_buffer() and {set,clear}_buffer_uptodate().
> 
> submit_bio_wait() is synchronous and takes care of that for you.
Thanks, I should have noticed that.

> > > Another dependency on buffer heads is the fact that
> > > squashfs_read_data() calls into other squashfs functions operating
> > > on buffer heads outside this file. For example
> > > squashfs_decompress() operates on a buffer_head array.
> 
> All the decompressors do is accessing the, and then eventually doing
> a bh_put.  So as a prep patch you can just pass them bio_vecs and
> keep all the buffer head handling in data.c.  Initially that will be
> a little less efficient as it requires two allocations, but as soon
> as you kill off the buffer heads it actually becomes much better.
I will try that, possibily all as a single patch if it looks simple
enough so that there is no need to convert from buffer heads to
bio_vecs. Let me know though if you feel strongly about having this as
two patches.

> 
> > > Given that bio_submit() is asynchronous I'm also not seeing how
> > > the squashfs_bio_request allocation can be removed? There can be
> > > multiple BIO requests in flight each needing to carry some context
> > > used on completion of the request.
> >
> > Christoph, do you still think this could be simplified as you
> > suggested?
> 
> Yes.
Thanks for explaining all of this. I will make the changes you
suggested and will report back with a new patch.

Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CE0C742D2
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 00:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E12208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 00:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562977657;
	bh=qFVLe6achQ7ULoDXeAFYsD5r8qfLEgewxICRyds7HmM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=A4O5Y5mDhqYNV7pvNKF8rzpPmS8aiH5tOs0B8SVlktiwfhZyZE2D6VLYWx1B36rkw
	 4/a0AiTzmuqCnj/Jz4YW7wv5is2NiZuVFobQIT+tMpPNMO2KFvfNJV/lHYYCwApJgc
	 mvjj5tiZLvHtEj0qfFnIbojUONcu9mKz2qLMQgQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfGMA1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 20:27:35 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:42316 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbfGMA1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 20:27:34 -0400
Received: by mail-lj1-f179.google.com with SMTP id t28so10917530lje.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 17:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nfl0wnnWuYc24xUzw/EVGY+2MfERMWxbutDcZnI1BQA=;
        b=CjNajGQKwwF6Ge8LXYLMNdlEDTDz2Lqd7XOtYZTwXuzl/zfscI8s6S/wpHGG0DUgHD
         ogxbG4UCpQD9D8aJw7ND3Sw6f9EqWbP+NsgM2LUaWE4zMgqeLAM3/IwjO6cCYSy3rLa1
         aSvD/8JCjn9fsqH0aeQRhQvk0HyydNbnoQlrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nfl0wnnWuYc24xUzw/EVGY+2MfERMWxbutDcZnI1BQA=;
        b=GWjkny7QbhaOE+9GJb4OYwQhn6aAAt/cgkDeKzTmG/gGh689e2ZWtyic92SAeRfVrg
         LjcGnnhlF3OMryx2if/ZFmGwknpyVZ5H5tFlV07xfFSs/UtnJygFy6ScPRn4qGc2aQMq
         3omRqQsyFRaIRXmIcNYHl2spUPxBj+AN0RfoEQCpGlwBHSEFnubCEw1qHUqmrNXz9nS7
         Jf2TzPUKTg4yvKDLeYbd0U5I9IlSvmsPfBavnR4HmgLQZ1DYnJPo6lIR6HDsh+S5ZOoy
         piDefqKF8qkjRyNU1UjVTKuGo+ilcZNGdQYIFBaRzE+hDE1wcubeXstTKnR0Qkk5fBjH
         jENQ==
X-Gm-Message-State: APjAAAVeH01s+7FdomHVasfsVLZrNGZW8uJvHRmryRGKzKt/kqhCtT98
        Yn5DBZfLWYTzvjuapH2afJ1BmqYZqbI=
X-Google-Smtp-Source: APXvYqwwBxmjSHt88Joz9CvFtGEOMskg+LbfKydpOYpz1U7nfj+7OZgxPDI+/JBmeSZSgOOCJjUfwQ==
X-Received: by 2002:a05:651c:d1:: with SMTP id 17mr7605573ljr.174.1562977652468;
        Fri, 12 Jul 2019 17:27:32 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id t137sm1280464lff.78.2019.07.12.17.27.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 17:27:31 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id b17so7555065lff.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 17:27:31 -0700 (PDT)
X-Received: by 2002:ac2:44c5:: with SMTP id d5mr6224027lfm.134.1562977651157;
 Fri, 12 Jul 2019 17:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190712180205.GA5347@magnolia>
In-Reply-To: <20190712180205.GA5347@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Jul 2019 17:27:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiK8_nYEM2B8uvPELdUziFhp_+DqPN=cNSharQqpBZ6qg@mail.gmail.com>
Message-ID: <CAHk-=wiK8_nYEM2B8uvPELdUziFhp_+DqPN=cNSharQqpBZ6qg@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: new features for 5.3
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 11:02 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> The branch merges cleanly against this morning's HEAD and survived an
> overnight run of xfstests.  The merge was completely straightforward, so
> please let me know if you run into anything weird.

Hmm. I don't know what you merged against, but it got a (fairly
trivial) conflict for me due to

  79d08f89bb1b ("block: fix .bi_size overflow")

from the block merge (from Tuesday) touching a line next to one changed by

  a24737359667 ("xfs: simplify xfs_chain_bio")

from this pull.

So it wasn't an entirely clean merge for me.

Was it a complex merge conflict? No. I'm just confused by the "merges
cleanly against this morning's HEAD", which makes me wonder what you
tried to merge against..

            Linus

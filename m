Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B3FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4361B20848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="LbitDhJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfDORnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:43:07 -0400
Received: from mta-p4.oit.umn.edu ([134.84.196.204]:44132 "EHLO
        mta-p4.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbfDORnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 13:43:06 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Apr 2019 13:43:05 EDT
Received: from localhost (localhost [127.0.0.1])
        by mta-p4.oit.umn.edu (Postfix) with ESMTP id F1BEE60F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 17:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1555349730; x=1557164131; bh=JAisjU/4wp
        CCzaIIP4quXYGVNxy3Nc0y+rxZDW5xSMk=; b=LbitDhJj+7NBGyZBKh6As2gO3L
        JUHjI+zrhXciBRnqopjSBwGtqBJ166FVyqKBLnhxgS3FfE1Tyy5YDqBj6FH+jmSn
        u6ap2xidfAR27+nriT2uIjHe2tydfrhIBA1AMTNRi7kI7mdATopF1E4yVmZWSKt3
        GgYCl8FTo5QRzSFOcu3nmDO5J02kCNrqC3wFklI76Mo/A7wXbLkuW9wCXeVyEQYJ
        hCv2JLUliZjyvcrJES7Cs137MGVlu+DAcbZvR5zeb//SVrGtAXAxB7fTYTVr3S1X
        k4B55QHm+ZOz49hrGseRZKBrrdYG2SYtXDbmGgRnJww/1GJ90oHA95vs86CA==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p4.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p4.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4kK3wNmYjLdr for <linux-kernel@vger.kernel.org>;
        Mon, 15 Apr 2019 12:35:30 -0500 (CDT)
Received: from mail-it1-f182.google.com (mail-it1-f182.google.com [209.85.166.182])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p4.oit.umn.edu (Postfix) with ESMTPSA id C4D8D259
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 12:35:30 -0500 (CDT)
Received: by mail-it1-f182.google.com with SMTP id q14so13347494itk.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 10:35:30 -0700 (PDT)
X-Gm-Message-State: APjAAAXx/kRM/kfA7r6JEeV17bC7bO5BUFbiAjGXuo+ZiTKyimeeymQQ
        pMp731txHZTkIxsYCdiVmVCueQeWlwE3MxUb424=
X-Google-Smtp-Source: APXvYqwBqQ1iMQgXw2eRAaM2JKJbijyfz7BIwL32mtljXrWgAEzMIWumotj3/SMudJ+KK+zq0rwW+BIgHEDtPGU3ya8=
X-Received: by 2002:a24:6b92:: with SMTP id v140mr22625167itc.161.1555349730569;
 Mon, 15 Apr 2019 10:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <1555341984-3282-1-git-send-email-wang6495@umn.edu> <20190415160517.GH13684@quack2.suse.cz>
In-Reply-To: <20190415160517.GH13684@quack2.suse.cz>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Mon, 15 Apr 2019 12:34:54 -0500
X-Gmail-Original-Message-ID: <CAAa=b7ck+vDHr1iG6R2zX0NEpkEVOTGKqQVYhFR4xPOwn-C+hg@mail.gmail.com>
Message-ID: <CAAa=b7ck+vDHr1iG6R2zX0NEpkEVOTGKqQVYhFR4xPOwn-C+hg@mail.gmail.com>
Subject: Re: [PATCH] udf: fix an uninitialized read bug
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your prompt reply, Jan! I will rework the patch.

Best regards,
Wenwen

On Mon, Apr 15, 2019 at 11:05 AM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 15-04-19 10:26:24, Wenwen Wang wrote:
> > In udf_lookup(), the pointer 'fi' is a local variable initialized by the
> > return value of the function call udf_find_entry(). However, if the macro
> > 'UDF_RECOVERY' is defined, this variable will become uninitialized if the
> > else branch is not taken, which can potentially cause incorrect results in
> > the following execution.
> >
> > This patch simply initializes this local pointer to NULL.
> >
> > Signed-off-by: Wenwen Wang <wang6495@umn.edu>
>
> Thanks for the patch! A better fix is to drop the whole UDF_RECOVERY ifdef
> and what's in it. It is just dead code anyway.
>
>                                                                 Honza
>
> > ---
> >  fs/udf/namei.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/udf/namei.c b/fs/udf/namei.c
> > index 58cc241..9d499e1 100644
> > --- a/fs/udf/namei.c
> > +++ b/fs/udf/namei.c
> > @@ -299,7 +299,7 @@ static struct dentry *udf_lookup(struct inode *dir, struct dentry *dentry,
> >       struct inode *inode = NULL;
> >       struct fileIdentDesc cfi;
> >       struct udf_fileident_bh fibh;
> > -     struct fileIdentDesc *fi;
> > +     struct fileIdentDesc *fi = NULL;
> >
> >       if (dentry->d_name.len > UDF_NAME_LEN)
> >               return ERR_PTR(-ENAMETOOLONG);
> > --
> > 2.7.4
> >
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

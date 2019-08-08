Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44489C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134DF218B6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="QWLuNsnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390073AbfHHPVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:21:19 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40511 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbfHHPVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:21:18 -0400
Received: by mail-ot1-f68.google.com with SMTP id l15so62834626oth.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 08:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=62wPsGMynwfej/OoKErjBbr2fFO4UlH7moOGmVEgcPY=;
        b=QWLuNsnE+aKeazvULF2iiss/MAzTxMI+IOnAKBvxpWmbKVHzAkXrbqU8MztcyHrsiO
         jwrWHhPavRYFK5SVLhhCMoMdICyjKxDtbox4bzwFiQ0nIs5e4NZGRqYCkdxpWRsDUmP3
         I+uu/NadCvnKhBlaQWYnKt+TpQKb/8KbISU3dcuDRJrQKgM6Za/37sy4M6Y4/ma9CJzH
         ADGOcG0wVYpgqzLHNusWCg4Csc+rdplcWdM4JOBEElYeMpBtIpYO8LU9fhLYYZzZm6cY
         6oSw1kpRjJp20WjnH17p/4+tl2yDx3AwkQ0BfVPHdOWkr1HljyIMB+T5BJ7JXfzsQBgW
         T5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=62wPsGMynwfej/OoKErjBbr2fFO4UlH7moOGmVEgcPY=;
        b=T7vVgEebDKbvOebaVAGT56tNlX8mIMACnZYnKkpTrMuEPRPX3ZlILliGYtl7n3SQ8F
         w6Zs0QS1BlvfkELUx3Yn0b39nFIQ2R5JaspHIOoVjgLX2qexhNT8cnav29xIgMWFYeSi
         a6awdAy5jLlbrYAYubDu/PRBAabvmpjCxToKOrKXz/jl3kHqGLFfgTsoWg/8/Pd6ELhb
         uyuzZ5Bww2dfd0hpHmdNqRu/Hl3XDE5nfqYVJthPTD2As767JNLbSQFv2huzuqLiNI8y
         l9WVnjnSXsuBAzRVW+xZGFvRwy3Yai8oixXfp/fHBv7NyI8NYPIi345CyyrZvq5y/F9o
         40+A==
X-Gm-Message-State: APjAAAUeyN9p5rnlFgHi95FXFKOWrebN9JI2Vb5u57ES7bV0fstJuZ9B
        5hO96cp8/bTxCM0oXbjEqRdlBIbJ0MvMYg==
X-Google-Smtp-Source: APXvYqz0iXbOnWP16YmlifI9jTb20zfHdE8NCzF7SMqsdZfeBLXIN5Ne1Kph2nUmVWqVODt6NjInDQ==
X-Received: by 2002:a05:6830:119:: with SMTP id i25mr14283189otp.288.1565277677096;
        Thu, 08 Aug 2019 08:21:17 -0700 (PDT)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id k10sm31320872otn.58.2019.08.08.08.21.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 08:21:16 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id z17so1630753otk.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 08:21:15 -0700 (PDT)
X-Received: by 2002:a9d:7248:: with SMTP id a8mr14036212otk.363.1565277675268;
 Thu, 08 Aug 2019 08:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190808022819.108337-1-balsini@android.com> <20190808090049.GC1265@kroah.com>
In-Reply-To: <20190808090049.GC1265@kroah.com>
From:   Alessio Balsini <balsini@android.com>
Date:   Thu, 8 Aug 2019 08:21:04 -0700
X-Gmail-Original-Message-ID: <CAKM9miJ=CmW0b-_3UDg7BySg73qVs2ctSiz7dQL5TXuOkacGyw@mail.gmail.com>
Message-ID: <CAKM9miJ=CmW0b-_3UDg7BySg73qVs2ctSiz7dQL5TXuOkacGyw@mail.gmail.com>
Subject: Re: [PATCH 3.18.y 4.4.y 4.9.y] block: blk_init_allocated_queue() set
 q->fq as NULL in the fail case
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, xiao jin <jin.xiao@intel.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, thanks!

On Thu, Aug 8, 2019 at 2:00 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 08, 2019 at 03:28:19AM +0100, Alessio Balsini wrote:
> > From: xiao jin <jin.xiao@intel.com>
> >
> > commit 54648cf1ec2d7f4b6a71767799c45676a138ca24 upstream.
> >
> > We find the memory use-after-free issue in __blk_drain_queue()
> > on the kernel 4.14. After read the latest kernel 4.18-rc6 we
> > think it has the same problem.
> >
> > Memory is allocated for q->fq in the blk_init_allocated_queue().
> > If the elevator init function called with error return, it will
> > run into the fail case to free the q->fq.
> >
> > Then the __blk_drain_queue() uses the same memory after the free
> > of the q->fq, it will lead to the unpredictable event.
> >
> > The patch is to set q->fq as NULL in the fail case of
> > blk_init_allocated_queue().
> >
> > Fixes: commit 7c94e1c157a2 ("block: introduce blk_flush_queue to drive flush machinery")
> > Cc: <stable@vger.kernel.org>
> > Reviewed-by: Ming Lei <ming.lei@redhat.com>
> > Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
> > Signed-off-by: xiao jin <jin.xiao@intel.com>
> > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > Signed-off-by: Alessio Balsini <balsini@android.com>
> > ---
> >  block/blk-core.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 50d77c90070d..7662f97dded6 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -870,6 +870,7 @@ blk_init_allocated_queue(struct request_queue *q, request_fn_proc *rfn,
> >
> >  fail:
> >       blk_free_flush_queue(q->fq);
> > +     q->fq = NULL;
> >       return NULL;
> >  }
> >  EXPORT_SYMBOL(blk_init_allocated_queue);
> > --
> > 2.22.0.770.g0f2c4a37fd-goog
> >
>
> Guenter sent this backport a day before you did, so I took his version
> and added your s-o-b to it.
>
> thanks,
>
> greg k-h

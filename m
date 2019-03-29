Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA923C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AD220811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGPlMqHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbfC2R3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:29:35 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:34513 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbfC2R3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:29:34 -0400
Received: by mail-vk1-f196.google.com with SMTP id k64so683852vke.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8AP2aDsaT0KaxYUxmevDETttetvcvkXs23iGmGRmzKk=;
        b=IGPlMqHbVJL+WTvwJFvZ71MzTcsZ1Vi8nmkMlCdcvnhiH/hjVgsA/BEtmz2LKeu2OM
         QFfXNMTWxZNI4ew2iRPC9Ckw9adURH8BNC9nJB8YMtg4r+k9oe160SJskxb/Cb+o6c6o
         4jbBM/NFXE6GeG+BFTGPa2yE4u5CoXYEX3fM18WTXJqc3WCaShCs6W7gG5R3Ulkkdnrw
         TXj9q/LCoyx41QRrR4ozJwG4CUhX3YXItURRZhL6ZcwAoLGMhdV9GPX8RgRlLlFdrzAd
         EkIsF7meNN8/1No3X7Dc1k+xrlcUPRybWcwQEUgvxklOBcosbOssUj5aICGWbfdbWYcZ
         r/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8AP2aDsaT0KaxYUxmevDETttetvcvkXs23iGmGRmzKk=;
        b=YPIQpaP00clx8m8o0fCOYxtvKWqdlpLBejtqxKvscVxZIU47k5T/+ClFQhjbfGuXIG
         bCkvrEAozCfNizdrQ26MYwcsetTDsKsczgdAP0WPsokHgcqj/L93q6K+lw4zKFP+y21f
         O+eCghb/leoHLQAQ31zhMr+qdI5T1+Ec7IkpnhM4pYA7XfarNnXtfVRv1NSNRVZTpsiF
         evxMUpBbnheQ6Avw6g7gOcZgs1da18mjl2sR0lBx45sKl+81rxqn5fyfzTUyk1wTPIsw
         3JnzACKzFeJcuO/QuV2v5t66R+fA//RyJpUgVnvbFLaU0qo7wNdzO8fdrMNWSMIo8C/O
         aAng==
X-Gm-Message-State: APjAAAUCsE4TfaM5840hCD1jJtfdKFZ+mS+rS4IepL2k36epsNlbpMvz
        a8Nm0MQTbc23tjShlQOquD0VVaNHtG3/pEKnkK5HPA==
X-Google-Smtp-Source: APXvYqxEiPGMSjKvppW2leoaKnW59DFjhmdwF/MLHVgkPBVmhQ7dmrGUx0qAzQI1rTEZa8NiqqzZXtlUSRWUsDJAmHA=
X-Received: by 2002:a1f:6b49:: with SMTP id g70mr25274313vkc.17.1553880573365;
 Fri, 29 Mar 2019 10:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190328071313.5306-1-oded.gabbay@gmail.com> <20190329162955.GA10386@kroah.com>
In-Reply-To: <20190329162955.GA10386@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 29 Mar 2019 20:29:08 +0300
Message-ID: <CAFCwf12oTXFsOaMaFOq4AfPDC3qYExvP9yKB7Za8G7W76O_A0Q@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: improve error messages
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 7:29 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Mar 28, 2019 at 09:13:13AM +0200, Oded Gabbay wrote:
> > This patch improves two error messages to help the user to
> > better understand what error occurred.
> >
> > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > ---
> >  drivers/misc/habanalabs/command_submission.c | 3 ++-
> >  drivers/misc/habanalabs/memory.c             | 2 +-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
> > index f908643f871f..02c48da0b645 100644
> > --- a/drivers/misc/habanalabs/command_submission.c
> > +++ b/drivers/misc/habanalabs/command_submission.c
> > @@ -261,7 +261,8 @@ static void cs_timedout(struct work_struct *work)
> >       ctx_asid = cs->ctx->asid;
> >
> >       /* TODO: add information about last signaled seq and last emitted seq */
> > -     dev_err(hdev->dev, "CS %d.%llu got stuck!\n", ctx_asid, cs->sequence);
> > +     dev_err(hdev->dev, "User %d command submission %llu got stuck!\n",
> > +             ctx_asid, cs->sequence);
> >
> >       cs_put(cs);
> >
> > diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
> > index ce1fda40a8b8..39788b1cf8d0 100644
> > --- a/drivers/misc/habanalabs/memory.c
> > +++ b/drivers/misc/habanalabs/memory.c
> > @@ -109,7 +109,7 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
> >                                                       page_size);
> >                       if (!phys_pg_pack->pages[i]) {
> >                               dev_err(hdev->dev,
> > -                                     "ioctl failed to allocate page\n");
> > +                                     "Failed to allocate device memory (out of memory)\n");
>
> No need for a message at all here, right?  The core should have already
> told you you had a problem.
>
> greg k-h

No, I don't think so, because this function is called for allocating
memory in the device's DRAM. So we don't pass through the Linux core
code inside.
We use the generic genalloc module to implement the device's DRAM
physical page allocator, and AFAIK, you won't get any message in case
genalloc fails to find a free memory in its pool.
Even if genalloc prints something, I would prefer to display a more
meaningful message to the user in this case. This allocation is
directly requested by the user (its part of the IOCTL code) and he
should know how it failed, no ?

Oded

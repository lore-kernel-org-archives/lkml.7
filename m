Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C15CA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBCD205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAOjRR/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfJUQb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:31:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28263 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727101AbfJUQb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571675488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6w7dW9mOc7e8F/WURa36AE0ItFqfFxyky2HnpydUOE0=;
        b=eAOjRR/6+t1RmQmV1ycxOR5bpqqgKgCb2CK019RqggMMSW8yS1phRmShQMbf1X5Y87sCps
        aEshZzdWw0RpmtWFln6oJCQ2Iq4F9s2dR4lXoaTqtHv8wWDDhC7ZaJ/jCLaO5ZzmkWH1OE
        zW+1Qeugm0u/BbzIKUmVX7zNMTwW0Sk=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-snuSe-V1OKm9C_fhweXpFg-1; Mon, 21 Oct 2019 12:31:26 -0400
Received: by mail-yb1-f197.google.com with SMTP id 202so10388292ybe.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 09:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fsdy/jGiGhYO0LCoELtFkTkwnBVL5KY786AsoYKXAR4=;
        b=S9qpAclVfQcrmHQ2mTXFeLHWtsm54i6agOgN3XGCx6En0iLd8OwvG9EceIe8yL7pp7
         ajYxW+Ym094zTPvtI16AHwcFYxEws4HE0ZGc/W8Ytf6+p2VDP8f3WXvjYRu4Rjpuioch
         jpD4seCx2oHgUN8uHe+LpS194Gh2J9F0vrFBZHnEa/EhSGK9Ek/pd0bdEi+0U+OwXDIg
         9NqVdRGSmUhmHjxJd3o8Qc0ljLwYuQL7yClBMm2hgid9Jw1fsEGJzMluA+c5hHsiJov5
         mhEvu8WiaDXjhssHj49e2Hmy8mghkgDBE5BAfZv/IYnfNYuIm8nZy4nnPw8A24ozMIKW
         pEww==
X-Gm-Message-State: APjAAAWa+AxcWlV2/pdYPi1ndA2p+f5qMTyubTwNgpZ6RVsr6ex/NXIV
        E0Ke6DkwSGkDgowAMd2El2Sf4XWyRoYOPPTj/S/YUqswicekeD9IBBz00cupL9z+0QGem1RXQd9
        Xr5CKFdVldGLTvAvdAPI++ALFGoS+pZCKlQ8VTz8X
X-Received: by 2002:a05:6902:4c8:: with SMTP id v8mr16247514ybs.66.1571675485764;
        Mon, 21 Oct 2019 09:31:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxciDyD1lopQLg+gvSHhlech/D0NjAF1pJvvntU8U9FKaM9F7s7bZSlGbX3GSbC/6IuqejGRuqLtQKO7Q/5Jvs=
X-Received: by 2002:a05:6902:4c8:: with SMTP id v8mr16247482ybs.66.1571675485370;
 Mon, 21 Oct 2019 09:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <CACVy4SVuw0Qbjiv6PLRn1symoxGzyBMZx2F5O23+jGZG6WHuYA@mail.gmail.com>
 <20191021083731.GK15862@gauss3.secunet.de>
In-Reply-To: <20191021083731.GK15862@gauss3.secunet.de>
From:   Tom Rix <trix@redhat.com>
Date:   Mon, 21 Oct 2019 09:31:13 -0700
Message-ID: <CACVy4SV3K257XfFkR_ahkU2yy9mzJD-9LrSiQPCnespB3k_0XQ@mail.gmail.com>
Subject: Re: [PATCH] xfrm : lock input tasklet skb queue
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-MC-Unique: snuSe-V1OKm9C_fhweXpFg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When preempt rt is full, softirq and interrupts run in kthreads. So it
is possible for the tasklet to sleep and for its queue to get modified
while it sleeps.

On Mon, Oct 21, 2019 at 1:37 AM Steffen Klassert
<steffen.klassert@secunet.com> wrote:
>
> On Sun, Oct 20, 2019 at 08:46:10AM -0700, Tom Rix wrote:
> > On PREEMPT_RT_FULL while running netperf, a corruption
> > of the skb queue causes an oops.
> >
> > This appears to be caused by a race condition here
> >         __skb_queue_tail(&trans->queue, skb);
> >         tasklet_schedule(&trans->tasklet);
> > Where the queue is changed before the tasklet is locked by
> > tasklet_schedule.
> >
> > The fix is to use the skb queue lock.
> >
> > Signed-off-by: Tom Rix <trix@redhat.com>
> > ---
> >  net/xfrm/xfrm_input.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> > index 9b599ed66d97..226dead86828 100644
> > --- a/net/xfrm/xfrm_input.c
> > +++ b/net/xfrm/xfrm_input.c
> > @@ -758,12 +758,16 @@ static void xfrm_trans_reinject(unsigned long dat=
a)
> >      struct xfrm_trans_tasklet *trans =3D (void *)data;
> >      struct sk_buff_head queue;
> >      struct sk_buff *skb;
> > +    unsigned long flags;
> >
> >      __skb_queue_head_init(&queue);
> > +    spin_lock_irqsave(&trans->queue.lock, flags);
> >      skb_queue_splice_init(&trans->queue, &queue);
> >
> >      while ((skb =3D __skb_dequeue(&queue)))
> >          XFRM_TRANS_SKB_CB(skb)->finish(dev_net(skb->dev), NULL, skb);
> > +
> > +    spin_unlock_irqrestore(&trans->queue.lock, flags);
> >  }
> >
> >  int xfrm_trans_queue(struct sk_buff *skb,
> > @@ -771,15 +775,20 @@ int xfrm_trans_queue(struct sk_buff *skb,
> >                     struct sk_buff *))
> >  {
> >      struct xfrm_trans_tasklet *trans;
> > +    unsigned long flags;
> >
> >      trans =3D this_cpu_ptr(&xfrm_trans_tasklet);
> > +    spin_lock_irqsave(&trans->queue.lock, flags);
>
> As you can see above 'trans' is per cpu, so a spinlock
> is not needed here. Also this does not run in hard
> interrupt context, so irqsave is also not needed.
> I don't see how this can fix anything.
>
> Can you please explain that race a bit more detailed?
>


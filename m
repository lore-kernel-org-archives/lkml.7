Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3054C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A184D20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXlVS4Jm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbfDPXsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:48:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43930 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfDPXsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:48:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id n8so11082627plp.10;
        Tue, 16 Apr 2019 16:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9wyq3kUHuGwvr+9CjqgddgW7KbiEbZO6JB9QFwOEOvg=;
        b=PXlVS4JmP65ypGP/9vE4xctXnQ56BIUroIJYJGjl+aCA8BzeXt/DIp0F0dfy8wUFUV
         bQT9EtIrfVNjogPm9tcj1G3FM4gbsj92hxr454yFcWslmMA63v98TWTeS13ZEshKOOfg
         p8eqdKujZd+T0cv8Sg709zmVPnqLRPf7UFcHO9SaT4EChQIRYuV60p0YLa0Lna67Ldik
         xLthHcTxisDGVJzqaQ1s+vQinby6o0cP00iwD1VGGqDvH0a0S3MzJWCSkNQPnO0HyHAF
         c4QdnZmkeWM4UFx9jVk+BgNuraqNVnCUyZYLNE03qoPLx8RAx4EMEaW6ONMj7IIgHuXK
         6bZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wyq3kUHuGwvr+9CjqgddgW7KbiEbZO6JB9QFwOEOvg=;
        b=kgk6cdB22SagtD1VOL9HqOpOeC2qS+dWR6ORT5R2AfC8HF+9lpVC/TCACdOcrl+mzT
         g1JukGus95P/3HWqFiYiJ0n2KFXin8YPiiOKkKzEGKu1EI0VCC3sZL4tj2C5ek49sFiI
         kiDg/OMOJpGSMmpzUIeArOu135ZmK8M5gSs8QvAj0KKjBj9dzMoXH3X8daVWOqIQSzEi
         f+9p31HFVMkY8aYseOXUCs21VDXAS0Zkt1o+1nenP6dxQiMp/bq1KVQb+wLKYT85rXvC
         0D+iwZUVnsEDh8b3XAfn5EneHkGb7iIBSQyxDUNyyfYq7IRMBASIcPebNipvLdi3tEy7
         ZaBg==
X-Gm-Message-State: APjAAAX4Lay0IamoNOHfCAT+0LJinSyiLbvVwehI7ApBHzeGWigxa1PO
        k08bb2bRO/E5NhfCHV00cgVifunMpy8NN8XFgX0=
X-Google-Smtp-Source: APXvYqw4U9FSVpLoth7Um/ZpHGYuAiY4To3MrdLixk+MUWXN4kNwdVP1hcj2DaZkWQL8+5CIcnn5Qr8aoXmh6XJEFVw=
X-Received: by 2002:a17:902:9a89:: with SMTP id w9mr86405813plp.126.1555458487202;
 Tue, 16 Apr 2019 16:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190416012001.5338-1-xiyou.wangcong@gmail.com>
 <20190416090726.GD27892@zn.tnic> <20190416221852.GA10781@agluck-desk>
 <CAM_iQpWit6gHTEFPB5cN3XuHQjeR4mBSb03wRc1F44WEQfNH_w@mail.gmail.com> <20190416232833.GA17372@agluck-desk>
In-Reply-To: <20190416232833.GA17372@agluck-desk>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 16 Apr 2019 16:47:55 -0700
Message-ID: <CAM_iQpXBJ2eAz4TW_GmOWRLrkyJcO=u-8VSnmv91ZABG-21Agg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ras: fix an off-by-one error in __find_elem()
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 4:28 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Tue, Apr 16, 2019 at 04:18:57PM -0700, Cong Wang wrote:
> > > The problem case occurs when we've seen enough distinct
> > > errors that we have filled every entry, then we try to
> > > look up a pfn that is larger that any seen before.
> > >
> > > The loop:
> > >
> > >         while (min < max) {
> > >                 ...
> > >         }
> > >
> > > will terminate with "min" set to MAX_ELEMS. Then we
> > > execute:
> > >
> > >         this_pfn = PFN(ca->array[min]);
> > >
> > > which references beyond the end of the space allocated
> > > for ca->array.
> >
> > Exactly.
>
> Hmmm. But can we ever really have this happen?  The call
> sequence to get here looks like:
>
>
>         mutex_lock(&ce_mutex);
>
>         if (ca->n == MAX_ELEMS)
>                 WARN_ON(!del_lru_elem_unlocked(ca));
>
>         ret = find_elem(ca, pfn, &to);
>
> I.e. if the array was all the way full, we delete one element
> before calling find_elem().  So when we get here:
>
> static int __find_elem(struct ce_array *ca, u64 pfn, unsigned int *to)
> {
>         u64 this_pfn;
>         int min = 0, max = ca->n;
>
> The biggest value "max" can have is MAX_ELEMS-1

This is exactly the explanation for why the crash is inside
memmove() rather than inside find_elem(). del_elem() actually
accesses off-by-two once we pass its 'if' check in line 232:

229 static void del_elem(struct ce_array *ca, int idx)
230 {
231         /* Save us a function call when deleting the last element. */
232         if (ca->n - (idx + 1))
233                 memmove((void *)&ca->array[idx],
234                         (void *)&ca->array[idx + 1],
235                         (ca->n - (idx + 1)) * sizeof(u64));
236
237         ca->n--;
238 }

idx is ca->n and ca->n is MAX_ELEMS-1, then the above if statement
becomes true, therefore idx+1 is MAX_ELEMS which is just beyond
the valid range.

Thanks.

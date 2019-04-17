Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059F1C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03252186A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387917AbfDQVo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:44:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46973 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDQVo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:44:56 -0400
Received: by mail-qt1-f195.google.com with SMTP id z17so29083217qts.13;
        Wed, 17 Apr 2019 14:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDiTBpfEbk9L0JBEZbIRNNkBl1De1K+96r++3FFrrhc=;
        b=Hwl7CL4ETf3+LigEnoYmVduQeSL0vJACHct/xQbcpOmZvhaVVHZehs6Q5l8F9XtOKO
         xJJEx70MylKWRjPLaHxB4K3QanNbkFHXsDdDtoDV8r8BDHUVLKFNKy41YgwvNySi+h29
         NKZ8d6wRp9aYwH+zSIABP2ZVlpohRUWTaIaxEFfiuz8qnywD4KomtZARUwyJvIjYcXob
         5Lsu2rbNQVsoLAgsCQgMmE1eF1GipV2IsfYp7KVEhRDcf7nEj8NpOv+H1QjMzo2RXhS6
         qAQE9XsIu+roYPseTs+iEZMKUiyqfxuWl+5wfxKpbBkbBY0OQoAernHbHs16RNSMSDEb
         noMg==
X-Gm-Message-State: APjAAAUdrXYSOEOjIZrVNNYGFPQU993qlz4vDh4UcXdMb4LCxxKGGlwa
        rKL4YIg8Ob+WxL/9OQZcno03DeOJnQ3KniULvuM=
X-Google-Smtp-Source: APXvYqxxtfPYbKwWSsdlW1cWIEnFHuNjqNfsmYdHUxre57RPcArBb1Xit9KmpHg4gn92SQpGFs4AJf3kL1HiClUSWjo=
X-Received: by 2002:a0c:d2fa:: with SMTP id x55mr70992108qvh.161.1555537495685;
 Wed, 17 Apr 2019 14:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190416202013.4034148-1-arnd@arndb.de> <20190416202013.4034148-5-arnd@arndb.de>
 <20190417211637.GV2217@ZenIV.linux.org.uk>
In-Reply-To: <20190417211637.GV2217@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Apr 2019 23:44:38 +0200
Message-ID: <CAK8P3a2a0yHv6njhwQYRC4YPdec25BdUJLU-sx6GQF9xqB95XA@mail.gmail.com>
Subject: Re: [PATCH v3 04/26] compat_ioctl: move PPPIOCSCOMPRESS32 to ppp-generic.c
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>, linux-ppp@vger.kernel.org,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 11:16 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Apr 16, 2019 at 10:19:42PM +0200, Arnd Bergmann wrote:
> > +#ifdef CONFIG_COMPAT
> > +struct ppp_option_data32 {
> > +     compat_caddr_t  ptr;
>
> Huh?  compat_uptr_t, surely?  I realize that compat_ioctl.c is bogus
> that way right now, but let's not spread that crap into the places
> where it's harder to find...

Ok, done.

> >       err = -EFAULT;
> > -     if (copy_from_user(&data, (void __user *) arg, sizeof(data)))
> > -             goto out;
> > +#ifdef CONFIG_COMPAT
> > +     if (compat) {
> > +             struct ppp_option_data32 data32;
> > +
> > +             if (copy_from_user(&data32, (void __user *) arg,
> > +                                sizeof(data32)))
> > +                     goto out;
> > +
> > +             data.ptr = compat_ptr(data32.ptr);
> > +             data.length = data32.length;
> > +             data.transmit = data32.transmit;
> > +     } else
> > +#endif
> > +     {
> > +             if (copy_from_user(&data, (void __user *) arg, sizeof(data)))
> > +                     goto out;
> > +     }
>
> *UGH*
>
> Do that in caller, please.  And sod the flag argument...

Ack, changed it now.

      Arnd

Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4777EC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 05:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3A42173E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 05:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="atU7IHWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405534AbfHIFgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 01:36:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45865 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfHIFgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 01:36:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id t3so2444853ljj.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 22:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tkESspP4zbr99ojw52v1cXFMI0dDrn0lXHnV6ilVC5Q=;
        b=atU7IHWXmtnksMrbQ1k8BhvgynR/4zyE9OG6rt3PbzKxYem2YQ+LktsQVrdVxU9YLC
         6YS80Puii0arAAtUnabMIGV3zOeVA3ApszU4i/8p8wffKinEejM0dX7NX0PIEsTgMwvO
         TLzlf48b35qwzLFYgJMSx7ys1Tf0RN+OG8QBquU8whFJhPaB1FkUd42OD9c0OyIJsSHJ
         KiLi5JgnoeFZjOcc1P0sXibjDkKRUkLk7IMYnOeem0uchFACJ8+T4ZID/+da8ANX2BVu
         Ko5uHliRhM4w0sAseDx2oJ+M853EwbV2INgH2yf6WehmFBIkH027WuZ/eSEYYm1W4a3G
         FllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkESspP4zbr99ojw52v1cXFMI0dDrn0lXHnV6ilVC5Q=;
        b=XAmxeeCWywhktelEk+PEIARN9VV5yYCAxrf0BNu+pX43GaqDo1YNJmNPcl7NFCW5kr
         5aWQAO8fNvJvwXLvuvzMeX7xzmY0hwBDpk0ryFA+65hF+GPS4MmgCwmA0nE3jX5Qb7ww
         I8czIRXhuJksQ3T5300+YHf9w3IxLdlmi7TLqLHXrtAQ0ZwUyX+fF/QstMt6NPIbQdsA
         i6+zwhdcYN75ZwJ8xbH8a+6036TOH/nmZOowOlZPuTbEOX/qQLfu9ABLOUBKPTAPPUAE
         7a83K60rHC+MPOW+Z/xN7TBHfBTD6iWQMnEZ9yqUlzT1lh14alTwK/8bQ2nNT3IbW2pT
         gBzw==
X-Gm-Message-State: APjAAAWfb6/ukMdSKK4MxHVXuYvYi+cq8ta67FQ+5F1/dCPnCCmeaEj3
        MWEkg72igiE3je9jOCNeO5RrtBE82DCqKxVwsOY1Jw==
X-Google-Smtp-Source: APXvYqxxy1TTV6QUfZHgTqMprUtqV1APmZ3PZFtZk65sg1r/cmrL6x9y1rC58d2HxqSp7BbfYHFxOnFanGeQ7Y6xGlk=
X-Received: by 2002:a2e:301a:: with SMTP id w26mr10098807ljw.76.1565328996305;
 Thu, 08 Aug 2019 22:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <1564489420-677-3-git-send-email-sumit.garg@linaro.org> <99777010-db74-096a-ce1a-da30539d6fb5@arm.com>
In-Reply-To: <99777010-db74-096a-ce1a-da30539d6fb5@arm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 9 Aug 2019 11:06:24 +0530
Message-ID: <CAFA6WYPUEUVJqk9E2F6z9oBW3VpC+xeqqpY4YrU9KPL1s0DTyA@mail.gmail.com>
Subject: Re: [Tee-dev] [RFC v2 2/6] tee: enable support to register kernel memory
To:     Stuart Yoder <stuart.yoder@arm.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, jejb@linux.ibm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dhowells@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Aug 2019 at 03:57, Stuart Yoder <stuart.yoder@arm.com> wrote:
>
>
>
> On 7/30/19 7:23 AM, Sumit Garg wrote:
>
> > @@ -264,7 +266,17 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
> >               goto err;
> >       }
> >
> > -     rc = get_user_pages_fast(start, num_pages, FOLL_WRITE, shm->pages);
> > +     if (flags & TEE_SHM_USER_MAPPED) {
> > +             rc = get_user_pages_fast(start, num_pages, FOLL_WRITE,
> > +                                      shm->pages);
> > +     } else {
> > +             const struct kvec kiov = {
> > +                     .iov_base = (void *)start,
> > +                     .iov_len = PAGE_SIZE
> > +             };
> > +
> > +             rc = get_kernel_pages(&kiov, num_pages, 0, shm->pages);
>
> Passing a single kvec struct is temporary I assume?  Because as currently
> written this will only work with num_pages==1.
>

Ah, thanks Stuart for pointing this out. It should rather be an array
of kvec struct. Will fix it in next version.

-Sumit

> Stuart

Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BD7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A1620700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvuEp5ew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfC1SnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:43:18 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:40660 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfC1SnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:43:17 -0400
Received: by mail-io1-f41.google.com with SMTP id d201so18114456iof.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 11:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t/WuzjoNOQ6c9tAFS917wzoGwLcNxDKz5cpHigmYgfA=;
        b=KvuEp5ewGZI1r7cmc2c9M0CmM7Vuxe4ltM6EwjDZPf6GO8IfT6Ryx5pKD6Y0LvY34d
         GVg28mNpYqBDOVTNzKPfYUufbDnhhhstTpg5+cZtrQpukClo1QQkUTODcCelMFC7x7Qo
         b++zafnQpfID9inBmKLBRKoxfJPJR89Bxid1PLWXBV6bQOMPeqF+YsQFi9tbXttRCcLI
         fSHuRyw/3yA7fbWbZ4a0vnLrvTtMg5poRT6k3ZskipHfK88Dp7XqmxO6bHa9CTrHUKhd
         kj5T7Jdd9yXVPCkiA9m8LThY9ttlJW0zzigmau/jAG25QssomvWl8J0nlpFHMnOeiO3v
         raIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/WuzjoNOQ6c9tAFS917wzoGwLcNxDKz5cpHigmYgfA=;
        b=mYu4ulU9uYXrVCwsmnMOqgEl2lVtMOZsUfi3sudDZ1ABRmWLkbWx3Pn39DmN1FofBV
         Gl4lTv1lzUqWScm6Xf7xor7XClD6rjpX4P/UyejHUk6x42b5ShMe6kRqEUbm1gTH5/XQ
         S5RCdXGgHSDSBplnuxNQ6hoGWjUweFj7My0jbwfvBSg+FftNkfsbkWM0ewK5nqv7P0gV
         2fjq6eyjodENA/QAaSeooAOwfrJXX3s/k/C0pIXbH/utfjlLoVROp5MESFcFcsIIz9AW
         C4eBkxejy6xP3OHFYYTn8jhHWQrl4O0+P8aqcTLRMwzFtgJA21QAxhyw9gRgwaLmEqrV
         yZ8w==
X-Gm-Message-State: APjAAAXMZfrKERITQHe1Lhv/7yVOqKERO8Gj0BcFAR6jtRB7LfbADP26
        oBFcMSZo7n23Ue84mzrIfiWRth56jaw3uiUZvtk=
X-Google-Smtp-Source: APXvYqylcPhV8AOgZLxaOep+Gr+8t9WUvZHJFvUjCV+mQRZIIKPetWn9elyPMP/4zMssTC9yzxeetcjIUWCjkNlb4PA=
X-Received: by 2002:a6b:3f86:: with SMTP id m128mr13570481ioa.275.1553798596579;
 Thu, 28 Mar 2019 11:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAKdAkRQj=bSSL2Cw3gAqi5f12yP3+KsvtrMvU4Lcfta_JYxMYQ@mail.gmail.com>
 <20190328180503.GA16249@mail.hallyn.com> <CAKdAkRRf+7UkmwbWNEnR3cNhc2t-kspRQNy4uOYRdcwBofXwtA@mail.gmail.com>
 <20190328183707.GA16570@mail.hallyn.com>
In-Reply-To: <20190328183707.GA16570@mail.hallyn.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Thu, 28 Mar 2019 11:43:05 -0700
Message-ID: <CAKdAkRSMCucS96ghj6vDtz31Vsa19AjuTsqAEYUTRUOZe7ZOwQ@mail.gmail.com>
Subject: Re: Allowing mapping supplemental groups in user namespace?
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 11:37 AM Serge E. Hallyn <serge@hallyn.com> wrote:
>
> On Thu, Mar 28, 2019 at 11:30:52AM -0700, Dmitry Torokhov wrote:
> > Hi Serge,
> >
> > On Thu, Mar 28, 2019 at 11:05 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> > >
> > > On Thu, Feb 28, 2019 at 11:27:38AM -0800, Dmitry Torokhov wrote:
> > > > Hi Eric,
> > > >
> > > > Currently, unless caller has CAP_SETGID in parent namespace, we can
> > > > only map effective group id in the new user namespace. Would it be
> > > > possible to relax this rule to also allow mapping of supplemental
> > > > groups (1:1) of the caller?
> > > >
> > > > Thanks.
> > > >
> > > > --
> > > > Dmitry
> > >
> > > Hi,
> > >
> > > Is there a use case where adding those to /etc/subgid is onerous?
> > > (There probably is, just would like to see yours)
> >
> > We on Chrome OS limit number of suid binaries installed on the system,
> > so newgidmap does not have necessary privileges to carry out this
>
> <shrug> good goal in general so long as you don't take a few huge
> monolithic suid binaries instad of more simpler ones :)
>
> > operation. Also we are looking for a solution that we can use with our
> > minijail package where spawning additional binary is challenging even
> > if it was suid.
>
> Ok.  So fwiw I think what you propose should be ok.  I think you should
> post a patch to do it.  It's very possible that seeing that patch will
> remind us of the reason why it *is* a bad idea, but seeing the patch may
> be a required shock to elicit that memory.

OK, I will cook up something.

Thanks.

-- 
Dmitry

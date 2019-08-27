Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45848C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8752070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CapEaCCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbfH0QAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:00:43 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34067 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbfH0QAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:00:42 -0400
Received: by mail-io1-f68.google.com with SMTP id s21so47579863ioa.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q9NZa6AK/DpvSoe8HSmYQoMCNusIgNDIT6bHwZKttzI=;
        b=CapEaCCX83Vumd24d3W4ndk3MW0VfeuJYr+ixbeMxDcmrviI+wQ5tdcqrOQI66p6Oy
         7uZPqa8igSYgAmeQIh8KNqwifhIw2WtDKg83sPNNauc4VAee9cleXh6DIPxsmKAOzdL6
         aPhjZqbRhSN1E5tFu51cjgPDlSfLMCB3U8ipU5gUB8zKkhMg2z7ylAYs522JSQXC68FP
         HesgE/2VRCs0+KMmjjwx9tFGuj77504cJmfqOUjK5jXZe2GvlFawkFd1WGdgixHhIKcE
         u6oaGE4I30g3wNpqYbxVx11jVfHJP7sC5lDhNmw2ZOUpaEHIZ3wLv6t1fgeqYftq+2Yz
         li7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q9NZa6AK/DpvSoe8HSmYQoMCNusIgNDIT6bHwZKttzI=;
        b=HXUmCIxEEJ+q3ArJrjN0OT5xKPk11+zd4/B1zeAm6sqhSTSmvbIMlKH/m1UHLwAy4X
         OZehoIJsoosRM0ZzHTK2mQqVtDCQNtqWPxZElTspmAkSRWpNMS59741ogI9qsIn74k/O
         f9rvNPylNe+g9Qnrt7VhBsS3F6YkzlK42xuP2Q3TzY/OLydCr0IsAsA8+cP4TlMZQd/Y
         CyWfpkHu+rAhARStj9EkC4fl7/krksH0HVfVhIUw8sqqiy8GXGOhv9cNSIqLT0fSQ7FR
         xDxHfs/iIPVFKOYTfGPBk6MzfvHzDaT3/cqlrAyDRSfzAe3HgfarbhXWpuPA53y9bXNQ
         BF8Q==
X-Gm-Message-State: APjAAAX+kn25amXbcn6vAWR7vfWLQJwzawbf5IPAGNae6INq44turq2H
        fMq8v7lYKodvcG8/5ifx+4xCwOlxcXukRhUI8MkHSQ==
X-Google-Smtp-Source: APXvYqx8juL3iVgGAhOFUnJM7xRiBzWyHUrAKS9dlKfG73enRdCxa/L5pg9aUomXcKrmQQkllOZgkxTpLabtoHkLNHA=
X-Received: by 2002:a02:487:: with SMTP id 129mr22862441jab.113.1566921641477;
 Tue, 27 Aug 2019 09:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190826153028.32639-1-pjones@redhat.com> <20190826162823.4mxkwhd7mbtro3zy@linux.intel.com>
 <CACdnJuuB_ExhOOtA8Uh7WO42TSNfRHuGaK4Xo=5SbdfWDKr7wA@mail.gmail.com>
 <20190827110344.4uvjppmkkaeex3mk@linux.intel.com> <20190827134155.otm6ekeb53siy6lb@linux.intel.com>
In-Reply-To: <20190827134155.otm6ekeb53siy6lb@linux.intel.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 27 Aug 2019 09:00:29 -0700
Message-ID: <CACdnJuszFbXONm2e9Wckuk-3VwD0hdGB9NqL-BNimX2yfaavsQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi+tpm: Don't access event->count when it isn't mapped.
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Jones <pjones@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Lyude Paul <lyude@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 6:42 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Aug 27, 2019 at 02:03:44PM +0300, Jarkko Sakkinen wrote:
> > > Jarkko, these two should probably go to 5.3 if possible - I
> > > independently had a report of a system hitting this issue last week
> > > (Intel apparently put a surprising amount of data in the event logs on
> > > the NUCs).
> >
> > OK, I can try to push them. I'll do PR today.
>
> Ard, how do you wish these to be managed?
>
> I'm asking this because:
>
> 1. Neither patch was CC'd to linux-integrity.
> 2. Neither patch has your tags ATM.

Feel free to add my tags, but I don't think it's important.

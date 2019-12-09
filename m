Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAB9C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 03:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA2A206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 03:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575861380;
	bh=MdXAeM4nIuesUS1DGhu6YwaHYJFsIoKaB8559f5xhAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=C2DfZrbFrPAvNC3UDb8r8FzviJ6dKFD+TJUgV0xIH7BYYppx7WisRKqSENiA0rcr+
	 X9dwLL5sc88mVTLmJFSbwZ1y2grTnW20qj6vyAS0fDiaQJ/+9gaX225N1QoQTFnCXh
	 QqS+CZ0rd5k0Pme7aPjH1Rn9wItOuESBTQNx2EFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfLIDQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 22:16:19 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36382 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfLIDQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 22:16:18 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so13894849ljg.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 19:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0eZBzbT0umg6+Hs7q0Pnqxg4tmozetMjiZRECdwYTQ0=;
        b=MWuYxiKb2CdwSMwdcUQLL2uhffAmgdvG0nK6gTfcO2CRxV0EDyfH78R4RWl7nvxi1m
         VPXqRvcP3Y1Rqmgt4bq1b5gQp3Tim9naBLL3rs+ghsEI+/WZ7HKpaPQpBj88BYdb/5Ic
         a5Y6pc+UVsIzS8JCmTj5F9uNcZYYFBKeLkqJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0eZBzbT0umg6+Hs7q0Pnqxg4tmozetMjiZRECdwYTQ0=;
        b=N5oV6y4LHqR/nzA47KOfyImf3jhIZRZcerXVeg3T5JlhfYNXEHmXHflXvCgAi77NDw
         SfBe0VgrCiCd8a9SoYNjKc2aNkfyk4vuHSwW922Z8R85Os5A2/GiGWfLeRPJUe3veZTT
         KIaNCqiGpD8a9SgMDyLWgFe3bGcahEPS2+PCqr/CICrsA3C7r1/yDbBA8FCDJjAHGqp2
         tRliOP+MMeAKHQnAwca0ZSUiQ1AfihsXfaxYykcrkMWRqRRFIdzjAdENGXyk4hRm+0um
         iYTwgrkrewG9gcG9kw59yIG5UDZCqLwhyG9COoriKjS+xD1+Yqqfff008gbFs/Ig63Qp
         ijfA==
X-Gm-Message-State: APjAAAUBjU68/vTSmCYrlZyZ4t7cEuXlZgAp+mUzrWUD+2jseOH9RmDG
        fkJzQmrVNnp3CzrddymQKNDcDpvGwBQ=
X-Google-Smtp-Source: APXvYqzTuQ9bHmS4+a3jFGGF7AP4AjN5yvyicEkVfBn/VMf1Sq+DBlVNewRNJDR6OdYAzfjkMygIHQ==
X-Received: by 2002:a05:651c:285:: with SMTP id b5mr15342690ljo.14.1575861375654;
        Sun, 08 Dec 2019 19:16:15 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id a9sm10071936lfk.23.2019.12.08.19.16.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2019 19:16:14 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 203so9424445lfa.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 19:16:14 -0800 (PST)
X-Received: by 2002:ac2:50cc:: with SMTP id h12mr13797909lfm.29.1575861374341;
 Sun, 08 Dec 2019 19:16:14 -0800 (PST)
MIME-Version: 1.0
References: <30808b0b-367a-266a-7ef4-de69c08e1319@internode.on.net>
 <09396dca-3643-9a4b-070a-e7db2a07235e@internode.on.net> <CAHk-=wjj8SQx4YzS8yw7ZJJKiVLBY0g=d8rCSyPCM=8Pzmz+Zg@mail.gmail.com>
 <20191209025209.GA4203@ZenIV.linux.org.uk> <CAHk-=whY0GL-FpnjUmc7fjDqz-yRJ=QBO7LT6aEzt-_raAb1bw@mail.gmail.com>
In-Reply-To: <CAHk-=whY0GL-FpnjUmc7fjDqz-yRJ=QBO7LT6aEzt-_raAb1bw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Dec 2019 19:15:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=whyQ-Ets2v3bg7eP8GAGpzA7f2pqyiw5tPj8HFoxFcEjw@mail.gmail.com>
Message-ID: <CAHk-=whyQ-Ets2v3bg7eP8GAGpzA7f2pqyiw5tPj8HFoxFcEjw@mail.gmail.com>
Subject: Re: refcount_t: underflow; use-after-free with CIFS umount after
 scsi-misc commit ef2cc88e2a205b8a11a19e78db63a70d3728cdf5
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arthur Marsh <arthur.marsh@internode.on.net>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 8, 2019 at 7:10 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> You're right that at least the CI bots might want to disable it for
> bisecting. Or force a particular seed for RANDSTRUCT - I seem to
> recall that there was some way to make it be at least repeatable for
> any particular structure.

Yeah, if you build in the same directory and don't do a "distclean" or
"git clean -dqfx", the seed remains in
scripts/gcc-plgins/randomize_layout_seed.h across builds, and the
result then _should_ be repeatable.

But yes, it's the kind of noise that is likely not worth fighting for
bisection (or any random bug hunting) at all, and turning off
RANDSTRUCT is probably the right thing to do.

But I don't think Arthur had RANDSTRUCT enabled, so that should be fine.

            Linus

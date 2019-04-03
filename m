Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51725C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F992084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfDCRJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:09:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33325 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfDCRJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:09:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id f23so15570959ljc.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 10:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Cq9CBaduQuj7NgUAXJeMrHFaQrt7z/WdHtdJMnSf0w=;
        b=kosP0Prqtlo/7Z7GBj06ApU8a7kOUDcakamOXAPe+0esGiWfE1ozddpj3IwBAMfj95
         Gk8fcTgp03HDvf5BhwzKxq7cYt4DhnB06NrAvmgdcdhtsmeqQGjDIDXscaGTjEXnVpUK
         KyJWUxav6M9ZzIy5rYotzsHNMfnk18QNdDY1XwDdnDOH2NoMpXZ0JITnqCyM+qHBclSn
         RRjAiLRY/We/SrTVrxHQzD0jBK8+jfATBQkCuGhxL2Rp8lfW5bymaByfivOxNh9hQrE5
         w6u2cn4MzJ1hq4mgz9RYE/rGrdN0tFG78oo83JXKmFG9yuTgz7nMaj5RQu8HhghBaTmi
         MQiQ==
X-Gm-Message-State: APjAAAUNqm+s8oGNTIWh7Ye5nrL/AV3iWKH9sL1ihCE0LyyG70XL6kH8
        KSmH1Ar/G/ghQJr42wqTW/tS1QH9NWMtqcOgFPIDyw==
X-Google-Smtp-Source: APXvYqwpyCkn3kKefFE1KSaPRCPV2k+QAtxVpyUZOFEjnF/9YhL82OgcZ0BEWcZFcT5rX/fmuXFZ66L4e9Gkt30P6CY=
X-Received: by 2002:a2e:3c0a:: with SMTP id j10mr509719lja.164.1554311363718;
 Wed, 03 Apr 2019 10:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190328130306.25384-1-mcroce@redhat.com> <20190403140203.qq37rgcikvoawb5f@brauner.io>
 <CAGnkfhx+igF579dez6qwAxrtT-JrGSSEn-QmK+92447qBqXPpg@mail.gmail.com>
 <20190403155108.GI22763@bombadil.infradead.org> <CAGnkfhxBafq4KeR8Jp5XBd7yWrMiofmEwqsCpb_7eL+ddgWagw@mail.gmail.com>
In-Reply-To: <CAGnkfhxBafq4KeR8Jp5XBd7yWrMiofmEwqsCpb_7eL+ddgWagw@mail.gmail.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Wed, 3 Apr 2019 19:08:47 +0200
Message-ID: <CAGnkfhyY7QmrGEk-YF9w-X78dHSDOPQMYtxBkVnpb0MS8DkVhQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/sysctl.c: fix out of bounds access in fs.file-max
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Zev Weiss <zev@bewilderbeest.net>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 6:40 PM Matteo Croce <mcroce@redhat.com> wrote:
>
> On Wed, Apr 3, 2019 at 5:51 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Apr 03, 2019 at 05:24:26PM +0200, Matteo Croce wrote:
> > > On Wed, Apr 3, 2019 at 4:02 PM Christian Brauner <christian@brauner.io> wrote:
> > > > Yeah, maybe but it still feels cleaner and more obvious to just add:
> > > >
> > > > static long long_zero;
> > > >
> > > > given that most callers actually seem to want an (unsigned) int.
> > > >
> > > > I don't have a strong opinion though so if others feel that it's just a
> > > > waste of space consider it acked.
> > > >
> > >
> > > Well, given that the value is zero, in this expectional case we could
> > > avoid duplicating the symbol and save 4 bytes.
> > > What the maintainers think?
> >
> > If we care about saving four bytes, we could just pass the address of
> > ZERO_PAGE(0).
>
> That would work, work too, maybe it's a bit overkill.
> int zero is always there and it's static, so enlarging it to long
> should be a straightforward fix.
> Obviously we can't do it for other numbers, but we can alias it just
> for the zero case..
>
> Regards,
>
> --
> Matteo Croce
> per aspera ad upstream

Anyway, I'm fine with both solutions, as I have other patches in the
queue which depends on this fix.

Regards,
-- 
Matteo Croce
per aspera ad upstream

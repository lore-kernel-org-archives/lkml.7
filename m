Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6A7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F40420700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfDCQko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:40:44 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41798 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfDCQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:40:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id 10so12207404lfr.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 09:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6CCS6Ad8hengQYIK+Cs6KJNOx4zF8Nw+BXALVhaDako=;
        b=mlJPeTc2jDuJpSpEPnm/GeQFtacsy4x+biA2/aEYmrIu8Yn+HM0SnFJymTWyi0l856
         z56lrIdQhZPZCoOnY2FhLCaM29wJkGwns1EZvhm91Hiz0XthFinpF5fUKFtIdGUFsXM7
         VglYbap32IE+wruB0+GVX8KeJ3Hr0XDyrmv+vvBTep2kQWPBbRwE5eNeQ6EdKrDu87jA
         NJ7btCeHCMORaMSWctH8dxRRsMRMAxmRzpcNEWpAICB2Ya5+BBS63zG1E0l2Ff7ebmZm
         8Tn8K3unp+q9AC1N5detSFjwGjyPAhz3vj8bgaEBBmQq/x+iF8SBTjWkuJSMkMzYIq1D
         ANhw==
X-Gm-Message-State: APjAAAUxKilvB79xBFIkJzc08K3wEknU2IILkXK3Kn2EcIiq/anPfOiJ
        W0wbS1qNkgsoD0YNQZxTVfxNvomvyc2a9EpemsTrOw==
X-Google-Smtp-Source: APXvYqzeKFs0m1phk5nTbqpL/DYA8AWXeIhEwJT6y1rWk1td8im/1Qr+4g5BvCyB4EM9DNfLUeq9CXUK6GwacfCt4uE=
X-Received: by 2002:a19:9145:: with SMTP id y5mr402273lfj.35.1554309641709;
 Wed, 03 Apr 2019 09:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190328130306.25384-1-mcroce@redhat.com> <20190403140203.qq37rgcikvoawb5f@brauner.io>
 <CAGnkfhx+igF579dez6qwAxrtT-JrGSSEn-QmK+92447qBqXPpg@mail.gmail.com> <20190403155108.GI22763@bombadil.infradead.org>
In-Reply-To: <20190403155108.GI22763@bombadil.infradead.org>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Wed, 3 Apr 2019 18:40:04 +0200
Message-ID: <CAGnkfhxBafq4KeR8Jp5XBd7yWrMiofmEwqsCpb_7eL+ddgWagw@mail.gmail.com>
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

On Wed, Apr 3, 2019 at 5:51 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Apr 03, 2019 at 05:24:26PM +0200, Matteo Croce wrote:
> > On Wed, Apr 3, 2019 at 4:02 PM Christian Brauner <christian@brauner.io> wrote:
> > > Yeah, maybe but it still feels cleaner and more obvious to just add:
> > >
> > > static long long_zero;
> > >
> > > given that most callers actually seem to want an (unsigned) int.
> > >
> > > I don't have a strong opinion though so if others feel that it's just a
> > > waste of space consider it acked.
> > >
> >
> > Well, given that the value is zero, in this expectional case we could
> > avoid duplicating the symbol and save 4 bytes.
> > What the maintainers think?
>
> If we care about saving four bytes, we could just pass the address of
> ZERO_PAGE(0).

That would work, work too, maybe it's a bit overkill.
int zero is always there and it's static, so enlarging it to long
should be a straightforward fix.
Obviously we can't do it for other numbers, but we can alias it just
for the zero case..

Regards,

--
Matteo Croce
per aspera ad upstream

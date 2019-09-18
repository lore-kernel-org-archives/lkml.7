Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7727DC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2169A208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Ztvd/Sqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbfIRNkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:40:41 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38445 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbfIRNkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:40:40 -0400
Received: by mail-io1-f67.google.com with SMTP id k5so16230839iol.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 06:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATuX8EIOxlpSwdyBiZYQlv1azss4zE5wSKwxCtolCdI=;
        b=Ztvd/SqnlNDBgL+KDRGV+FRvBx5glU46mX94XgrT3UH+kjAMAeFCUQUB31kfRa+cDF
         haZ0otJGgvTf/K9cJmHvRlS+hKi9MSIRMPn4RuAEfdepH4HYFKUXbZ3FRKqObTH9Uw3/
         QDH0ivFlviTUhy2mu+Crd92Eot2PvGscRg7Ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATuX8EIOxlpSwdyBiZYQlv1azss4zE5wSKwxCtolCdI=;
        b=TVIb+RmRHIAYO3YXURyAkT9Vb4pL7NuODOkGxOYq/Hfb126OuPC7CW81NfMuPQWY5H
         zJeNtTVx7DQ4x2mR7E8VgrFiDLuw/OWbZuJLWTRuhIMx5igaFmCU+ywgYStKEPCqJBQq
         xTipgS99FKYQ5ZIrP3twL87zRX2tfpAICrAMMFxJvYlr8ng5q/GQssBx0Tb8UVJdxoSu
         ijOwOgeUAcmzJC229BUy/Dzd4sm3etKoGJ7/n7+Jo+4EA4qwZ/53C1X7K8tyQ2fbWwfb
         3Zj3ON+jzjySGforps6tBXeIU0/sqQfxSm59ZV//pqYtZeC1XSOf5JFv3kwDTZt5ihD0
         OQ+w==
X-Gm-Message-State: APjAAAVBs/nLLlBynM4D+YohJpafxwFtCOEYKSoLf4BLmqYtaOY1t8WQ
        Jy8Rd6Gk9H4/viWkVHsVeHdeKnwbui9jzTAHfIIgIQ==
X-Google-Smtp-Source: APXvYqwkARifyRHf1YCC3t6qp1ghAXswoFF1Gj2kUefz8lsvcOfTKUMbWbx3+tGYozwtOMEnjHdeTY5LtlPZlydkDdE=
X-Received: by 2002:a6b:3b94:: with SMTP id i142mr5056239ioa.212.1568814039180;
 Wed, 18 Sep 2019 06:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190912141931.30819-1-mszeredi@redhat.com> <20190918084651-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190918084651-mutt-send-email-mst@kernel.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 18 Sep 2019 15:40:27 +0200
Message-ID: <CAJfpegsUEOyUsiNPMaoXCqpoF236mu=DqOvZgqqOE4x1WDLTXw@mail.gmail.com>
Subject: Re: [PATCH v6] virtio-fs: add virtiofs filesystem
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 2:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> Overall this looks ok to me. Handling full vq by a timer is really gross
> but it's correct - just terribly inefficient.

Yes.  The reason this didn't get too much attention is that it's
relatively difficult to make the queues actually fill up (which is a
good thing).

But this should definitely be one of the first things to be cleaned up...

>  I think you should add a
> MAINTAINERS entry though, we want
> virtualization@lists.linux-foundation.org Cc'd on patches.

Already done in the documentation patch (which I didn't resend, but
you should find the v5 version in your mailbox).

> With that corrected:
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> Who's going to merge this? Miklos do you want to merge it yourself?

I'll merge this since it depends on the rest of the fuse queue.

> > +     /**
> > +      * Cleanup up when fuse_iqueue is destroyed
>
> Cleanup up -> Clean up

Fixed.

> > + * virtio-fs: Virtio Filesystem
> > + * Copyright (C) 2018 Red Hat, Inc.
>
>
> 2019 at this point?

I'd consider the creation year okay for this.  These copyright notices
don't seem to be kept up to date, and don't need to, since the SOB
procedure allows for fine-grained tracking of authorship.

> > +     /* After holding mutex, make sure virtiofs device is still there.
> > +      * Though we are holding a refernce to it, drive ->remove might
>
> refernce -> reference

Fixed.

Changes, with your ack pushed to:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next

Thanks,
Miklos

Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59BFC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 17:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9513F213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554570944;
	bh=ZlaaVv3mAmT2GvTkvz2F4Ex23rbjd1bqzns4MD2dloY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=paLA1xoSbFt+I1iiUQH5kX9U5fU/SIgpu0Z3s936VEmvgYA63IhLup91M+ZGEOeUq
	 lvfkeIduUUNBrkW5KunS4Dj5pcr9pGVn812WmjT+XyVzDD/2tYlVO9ai8KsWzJppBp
	 VFqeNDjh3OWCqVvMdBvXe9wxTizg6TkLIGyyzvwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfDFRPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 13:15:43 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39486 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfDFRPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 13:15:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id l7so7797406ljg.6
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 10:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5s2Te7Pue6wztZT4iXY+yWw3ozf3l4odun3S28KUUmw=;
        b=BuIcAAH6H0T2DUi2m/wYpUrIm8JGsbAfl0GdG/jhPsfZEB/fpHIM+DS6Rz/ajd6Aby
         sCf62QOQp0sofmZLhpWiNV6vTJzeNQX3y97t/o6j4oXpTh0fRPfRKPP5LP7sHonbnP/r
         tJrWGnouWfjOy7cSJU1DQ3ux1l/wyhJo1jy2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5s2Te7Pue6wztZT4iXY+yWw3ozf3l4odun3S28KUUmw=;
        b=Bdwepb4MlcFdX0fS9MjaOcm3POH4Qb1ffobDOgdsoSfJUQywhQ1CiEkaDMhImKoZKD
         RABSdyFT7dWMTEprTyqmNkNzMB07NwJpfQQe54ax3ya1q7m/skS0Q5Uho1FS9jCyHYTq
         SEI7aymshvMNSpt9QELF5eDxsGWYH4ckOgFiZyAkERZ8Yhz+h/UilJzwVneVlqg0t6WH
         TWV6XARnacY9bnUmu99KARy1V3XM62z/PAsNScqhjNMkfDaJUmeTpdAgjUNAK/qveovl
         qKHNbPlKhZmGMbM0QYb3GK/qw9Ws7f+vba20HRoK4Y81y+X5BHUeBBcAKY7peBiBcIjT
         OIHg==
X-Gm-Message-State: APjAAAXFDVkAsr5Jf0KpdWapf6jh2hwQAQC4h+5pGFO/UmLyXliqDcib
        VzOR+3arj74o1OE0QdzJxwZG+Z0msC0=
X-Google-Smtp-Source: APXvYqy7VuZ1lWxgsfqkhKmOglRSqbMdIIUcJaXKieROFP8KicIlBKuojNSs+n7kV3S/kJtNzuV8/g==
X-Received: by 2002:a2e:8787:: with SMTP id n7mr10512191lji.31.1554570940509;
        Sat, 06 Apr 2019 10:15:40 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id v11sm5086106lfb.68.2019.04.06.10.15.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 10:15:40 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id r24so7812182ljg.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 10:15:40 -0700 (PDT)
X-Received: by 2002:a2e:90c9:: with SMTP id o9mr11147407ljg.102.1554570450612;
 Sat, 06 Apr 2019 10:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <c44fcf87d4c9d417b6cdced787091300fd45a3e4.1553637461.git.kirr@nexedi.com>
In-Reply-To: <c44fcf87d4c9d417b6cdced787091300fd45a3e4.1553637461.git.kirr@nexedi.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 Apr 2019 07:07:14 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgqgN5j1ZWnyVLqqoyU=CCWTYOko3MDyU8L_5e21KvHAg@mail.gmail.com>
Message-ID: <CAHk-=wgqgN5j1ZWnyVLqqoyU=CCWTYOko3MDyU8L_5e21KvHAg@mail.gmail.com>
Subject: Re: [PATCH 1/3] fs: stream_open - opener for stream-like files so
 that read and write can run simultaneously without deadlock
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yongzhi Pan <panyongzhi@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>, Tejun Heo <tj@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nikolaus Rath <Nikolaus@rath.org>,
        Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 12:20 PM Kirill Smelkov <kirr@nexedi.com> wrote:
>
> Commit 9c225f2655 (vfs: atomic f_pos accesses as per POSIX) added locking for
> file.f_pos access and in particular made concurrent read and write not possible
> [...]

Ok, I have applied this patch - but this patch only - as a
well-researched preparatory patch.

The actual conversion patch looks fine to me too, and I see a few
acks, but I think I'd like to see it during a merge window just
because it's large and does significant changes, while this one is
purely preparatory.

Al, comments?

One small note: please don't use lkml.org references since they tend
to be slow and flaky - use lore.kernel.org instead. Also, fix your git
config to use 12-character git hashes (best done by just removing the
explicit hash size entirely, and letting modern git shorten hashes
appropriately automatically).

                  Linus

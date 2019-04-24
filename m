Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C7EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F1821773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="euoxoL/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfDXKpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:45:03 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35093 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfDXKpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:45:02 -0400
Received: by mail-io1-f67.google.com with SMTP id r18so14546552ioh.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2j4vmluCPXtWT2JQpCJ8Cfd+BSw3gNBf010i3AeYQBs=;
        b=euoxoL/pedEWmpkAvAI3Wbrq2/FcviP148YzDHPZxahr79HEm/Zz32+u3giZZ2fkK6
         M2s2cGFgRZJ1uiQIyCSeAB0MXiJkR9RTxHLCg8MgQ7WTgan+8xWwDwUcHGdPsOP10eeY
         lR9qHUMvaOtzPFmJELl1qLzr/7XGkPQVq7l2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2j4vmluCPXtWT2JQpCJ8Cfd+BSw3gNBf010i3AeYQBs=;
        b=idcxDVEwjfQ0ljq4uB00TzvqzAml6LJtBvFQzKKqkROPe2sGv8nA3pAQ8Ygxk7dlny
         uxMfMQLfkBWeo5s5aUC94Sd0WZ9lPdghVz5il8OM9tY+Hipp756kf3QsGDLKJjOs2r1p
         UCJBda1CIbMKT0Hdy/nOBknWEFAwe7XKOBY2146VQxEwiZNzeve14+aRxH+8xsHNWT39
         1elEZC3eittPumbcgTiD6WdbqTOPgKzetSV8AP0ZhE2DkAuRrsGztgAushGnpkdpK3bj
         x7JgMTAGF/IbOkAXfGnWg1eem4k2H91NPaL018nnSe9AGDrE+30t0Fk0b3Hije7B7OqA
         jP2g==
X-Gm-Message-State: APjAAAUmuVLJCS8VkCtjxbv09fmm5pSLZA2pkTNs7LBYJ1ul5JxDglOY
        yLzdIPORd+fy49B+LE42xo8Q7G0VQVrW891kl1gPnQ==
X-Google-Smtp-Source: APXvYqwfVWyBpxnAoDodpPpkzDvjQ2TqaIlmWGyCwuUtsdaedE9CRxluRM1hsBd0X+Z6rCra8x+9ioC81qEzXTb1NeE=
X-Received: by 2002:a6b:6006:: with SMTP id r6mr7316394iog.294.1556102701913;
 Wed, 24 Apr 2019 03:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553680185.git.kirr@nexedi.com> <12f7d0d98555ee0d174d04bb47644f65c07f035a.1553680185.git.kirr@nexedi.com>
In-Reply-To: <12f7d0d98555ee0d174d04bb47644f65c07f035a.1553680185.git.kirr@nexedi.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 24 Apr 2019 12:44:50 +0200
Message-ID: <CAJfpegv0NvcsD9gh3aN+ngzsLqbNWUc73ZPN1qHox_14eN9Pqg@mail.gmail.com>
Subject: Re: [RESEND4, PATCH 1/2] fuse: retrieve: cap requested size to
 negotiated max_write
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jakob Unterwurzacher <jakobunt@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 11:15 AM Kirill Smelkov <kirr@nexedi.com> wrote:
>
> FUSE filesystem server and kernel client negotiate during initialization
> phase, what should be the maximum write size the client will ever issue.
> Correspondingly the filesystem server then queues sys_read calls to read
> requests with buffer capacity large enough to carry request header
> + that max_write bytes. A filesystem server is free to set its max_write
> in anywhere in the range between [1=C2=B7page, fc->max_pages=C2=B7page]. =
In
> particular go-fuse[2] sets max_write by default as 64K, wheres default
> fc->max_pages corresponds to 128K. Libfuse also allows users to
> configure max_write, but by default presets it to possible maximum.
>
> If max_write is < fc->max_pages=C2=B7page, and in NOTIFY_RETRIEVE handler=
 we
> allow to retrieve more than max_write bytes, corresponding prepared
> NOTIFY_REPLY will be thrown away by fuse_dev_do_read, because the
> filesystem server, in full correspondence with server/client contract,
> will be only queuing sys_read with ~max_write buffer capacity, and
> fuse_dev_do_read throws away requests that cannot fit into server
> request buffer. In turn the filesystem server could get stuck waiting
> indefinitely for NOTIFY_REPLY since NOTIFY_RETRIEVE handler returned OK
> which is understood by clients as that NOTIFY_REPLY was queued and will
> be sent back.
>
> -> Cap requested size to negotiate max_write to avoid the problem.
> This aligns with the way NOTIFY_RETRIEVE handler works, which already
> unconditionally caps requested retrieve size to fuse_conn->max_pages.
> This way it should not hurt NOTIFY_RETRIEVE semantic if we return less
> data than was originally requested.
>
> Please see [1] for context where the problem of stuck filesystem was hit
> for real, how the situation was traced and for more involving patch that
> did not make it into the tree.
>
> [1] https://marc.info/?l=3Dlinux-fsdevel&m=3D155057023600853&w=3D2
> [2] https://github.com/hanwen/go-fuse
>
> Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
> Cc: Han-Wen Nienhuys <hanwen@google.com>
> Cc: Jakob Unterwurzacher <jakobunt@gmail.com>
> Cc: <stable@vger.kernel.org> # v2.6.36+
> ---
>  fs/fuse/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 8a63e52785e9..38e94bc43053 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1749,7 +1749,7 @@ static int fuse_retrieve(struct fuse_conn *fc, stru=
ct inode *inode,
>         offset =3D outarg->offset & ~PAGE_MASK;
>         file_size =3D i_size_read(inode);
>
> -       num =3D outarg->size;
> +       num =3D min(outarg->size, fc->max_write);

This is wrong: the max_size limited num is overwritten if constrained
by file size.

Also the patch is whitespace damaged.

Thanks,
Miklos

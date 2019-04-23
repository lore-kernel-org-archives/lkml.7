Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9E1C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFBE20645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHSRLaM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfDWI1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:27:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33617 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWI1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:27:38 -0400
Received: by mail-io1-f68.google.com with SMTP id u12so1275329iop.0;
        Tue, 23 Apr 2019 01:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CNbIImTYyg/CNsNHBJ7fygvu/1OPcPfdcMzPNCLn1b8=;
        b=aHSRLaM5DEAJOEjk+lTeYmJ1MqFRsHoNBqC/DtJEzZnCTEsNNopeRbQyx/37Iwi7yb
         qmaL6vEbMylDKAD9Ve97o5G10yp36gRHoHjgk52BZQ+S25r7QvN7cIqU0fME+z8baQfC
         ltkvUe3mTvUqcxEvs3zkZjSWy0PCif8ydntoL4hwAjrdUNlJHERIAHpKAuqoh4uqhPDk
         WrImW4ZvU3Ortqgwnd14S7Ul09/Mba1bn4dm0mS2kPYQfff6NwCnJ233MmMgZi5QjYS/
         vSBGFFFqntPYc1y9Wq5EURIjNuqkQFaArvqGiMkfcuWATt/LxQNwHNdWsjRIY6o+PCep
         Mm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CNbIImTYyg/CNsNHBJ7fygvu/1OPcPfdcMzPNCLn1b8=;
        b=BFrm2A50EeNyHYIQeeJRBUebbB1tzpdCDGLTotuvY/ZdfUPxlj9b/vfhsr5JgmYRXm
         Tb8OtkklD+5GiBJU66CQrKDWpAUUck0Meoqhut2d6v6vNOwWPQD6Z4iNM2t6dNEl7OlA
         H78D0GLscEAvZRMlJ5ICv80uYdLSPEbl9Dup7k4+oWSSG9P7X3vTup9WL/JlYwsuguCH
         QXKF58g3Kn07vFAK3ic1GKK6rCFUkFHCpAa0+RMdx7+khi+MECmXjUk7qmKscMlIpKtL
         Vs5TqkpghZi1CdSNzoi6WSfacByvcA/hyHyKbfNMbuWGAvLD6bn46EQCzcpoTKSvmE1m
         Hbeg==
X-Gm-Message-State: APjAAAW8vGpTUxJ2NqEGH8SolCDVki4guVA1KLN6UlNoxukUD4sigElA
        2Ufr6drpnz9Jf5Bg3TBR4mnO0+e8D5r60+61A3FBkqs5rq0=
X-Google-Smtp-Source: APXvYqy/Xwl5lHta8DJ7Tyf3EI9FXTsse542bPVJzz3lgVeaakdpB9i9H5KvKtKvomoQFxf2RxyUfsmL/FkCbHS+OsA=
X-Received: by 2002:a6b:cf0f:: with SMTP id o15mr9886010ioa.5.1556008057551;
 Tue, 23 Apr 2019 01:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190422194516.11634-1-sashal@kernel.org> <20190422194516.11634-48-sashal@kernel.org>
In-Reply-To: <20190422194516.11634-48-sashal@kernel.org>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 23 Apr 2019 10:27:34 +0200
Message-ID: <CAOi1vP9qzUZOO5Mv2+eoFH9Xn2Kvxf_1EiDJsFuDHLZS1843+w@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 48/68] libceph: fix breakage caused by
 multipage bvecs
To:     Sasha Levin <sashal@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Ceph Development <ceph-devel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 9:46 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Ilya Dryomov <idryomov@gmail.com>
>
> [ Upstream commit 187df76325af5d9e12ae9daec1510307797e54f0 ]
>
> A bvec can now consist of multiple physically contiguous pages.
> This means that bvec_iter_advance() can move to a different page while
> staying in the same bvec (i.e. ->bi_bvec_done != 0).
>
> The messenger works in terms of segments which can now be defined as
> the smaller of a bvec and a page.  The "more bytes to process in this
> segment" condition holds only if bvec_iter_advance() leaves us in the
> same bvec _and_ in the same page.  On next bvec (possibly in the same
> page) and on next page (possibly in the same bvec) we may need to set
> ->last_piece.
>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
> ---
>  net/ceph/messenger.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index f7d7f32ac673..ef5216206bdf 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -870,6 +870,7 @@ static bool ceph_msg_data_bio_advance(struct ceph_msg_data_cursor *cursor,
>                                         size_t bytes)
>  {
>         struct ceph_bio_iter *it = &cursor->bio_iter;
> +       struct page *page = bio_iter_page(it->bio, it->iter);
>
>         BUG_ON(bytes > cursor->resid);
>         BUG_ON(bytes > bio_iter_len(it->bio, it->iter));
> @@ -881,7 +882,8 @@ static bool ceph_msg_data_bio_advance(struct ceph_msg_data_cursor *cursor,
>                 return false;   /* no more data */
>         }
>
> -       if (!bytes || (it->iter.bi_size && it->iter.bi_bvec_done))
> +       if (!bytes || (it->iter.bi_size && it->iter.bi_bvec_done &&
> +                      page == bio_iter_page(it->bio, it->iter)))
>                 return false;   /* more bytes to process in this segment */
>
>         if (!it->iter.bi_size) {
> @@ -929,6 +931,7 @@ static bool ceph_msg_data_bvecs_advance(struct ceph_msg_data_cursor *cursor,
>                                         size_t bytes)
>  {
>         struct bio_vec *bvecs = cursor->data->bvec_pos.bvecs;
> +       struct page *page = bvec_iter_page(bvecs, cursor->bvec_iter);
>
>         BUG_ON(bytes > cursor->resid);
>         BUG_ON(bytes > bvec_iter_len(bvecs, cursor->bvec_iter));
> @@ -940,7 +943,8 @@ static bool ceph_msg_data_bvecs_advance(struct ceph_msg_data_cursor *cursor,
>                 return false;   /* no more data */
>         }
>
> -       if (!bytes || cursor->bvec_iter.bi_bvec_done)
> +       if (!bytes || (cursor->bvec_iter.bi_bvec_done &&
> +                      page == bvec_iter_page(bvecs, cursor->bvec_iter)))
>                 return false;   /* more bytes to process in this segment */
>
>         BUG_ON(cursor->last_piece);

Hi Sasha,

This shouldn't be needed.  Multipage bvecs code is new in 5.1 (commit
07173c3ec276 ("block: enable multipage bvecs")), this commit just fixed
the fall out.

Thanks,

                Ilya

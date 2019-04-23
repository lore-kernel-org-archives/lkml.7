Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC5BC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6E220645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuBIkpxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfDWI3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:29:02 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35671 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWI3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:29:00 -0400
Received: by mail-it1-f194.google.com with SMTP id w15so22420608itc.0;
        Tue, 23 Apr 2019 01:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gNYp5B3WW49wZuSSd+AU4UVnQVS79h4V7MG01aCk1c4=;
        b=BuBIkpxDnqhVJQGHtHsevkVcisx8RJSEdl3bpUqmj9luxaikK6hvXmmbttnMEWmrZ/
         BW2x7ne3jfVbZgtzkn1N3GIVELGJ/3XB1nWojR+h3w7D8wrVzDrkSZ1zwoT/s36CFxo+
         RhIWH2MHdf2bwXXp31WRrE8fbiQ4I2HrjvSQMpxxA4RaqC4vn9/wpxRdtzekIdz/zGup
         UP7i09Pt/cUBlcecq3NkxTYi1qkC+M5XY89dac/u6qcm1DGgt1kbBPbCAIqElT6/BTnU
         HnZBAN4PHEaqKjWHh7v9PJA1N1fcAR9BHSf0OsBRtkF46+MdV3dZzxnadWZS7O1S3gXr
         VusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gNYp5B3WW49wZuSSd+AU4UVnQVS79h4V7MG01aCk1c4=;
        b=dZNRwpb++/FTy3Kby+rnfqgRJ1MIXAaD+WCalN1opBzMrLsDS3Er7JhEvmOM9bwYic
         jKRNUjnLEa34vG0Qq3U0gks5/eqIuF4TfEUr5QRagmaDqWGaqb8twvOIYsXsp6ZUcR+5
         M/1Bk6rAT+t8YRI1gPvinudjZ/1Ah16745Cql1hNDCZUmFyNnUjI66yT7bVIw8uITh+U
         7OZmyB0///gr1W1bMZlLaKqbD/GQX1Gn97hGE58we22MoweOMzJD+faryVXgNW0yIFPt
         yWsq2dFBdvX/eyHEXrCm9KYQ8G2+RV8aUKS1UFfAaME0uqL0P6lT08iDx+D6PO5iU6ar
         OMGg==
X-Gm-Message-State: APjAAAWZfTQL8FJJId+rcUSY9KBLg8YwN6YxCQnvu9IYwtp+7l9hBHti
        uwHSWZvPB21TGBKrVCKhflC4tfmAQwU3Kw4zFnU=
X-Google-Smtp-Source: APXvYqzLDCMUCv6ZvlQ0I9CVUZt9W66tc9GWIZDk1Mun3mpum1TYnPYBmKPnhwPaaahn0GMdUcIHk6lNrNJ60EsoHH4=
X-Received: by 2002:a02:c4cf:: with SMTP id h15mr16634119jaj.96.1556008139688;
 Tue, 23 Apr 2019 01:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190422194205.10404-1-sashal@kernel.org> <20190422194205.10404-61-sashal@kernel.org>
In-Reply-To: <20190422194205.10404-61-sashal@kernel.org>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 23 Apr 2019 10:28:56 +0200
Message-ID: <CAOi1vP8Q=bH9uXVi=35PKpE0T=MNpRViaBJWPMYfD6_pfC8xRw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.0 61/98] libceph: fix breakage caused by
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

On Mon, Apr 22, 2019 at 9:44 PM Sasha Levin <sashal@kernel.org> wrote:
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
> index 7e71b0df1fbc..3083988ce729 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -840,6 +840,7 @@ static bool ceph_msg_data_bio_advance(struct ceph_msg_data_cursor *cursor,
>                                         size_t bytes)
>  {
>         struct ceph_bio_iter *it = &cursor->bio_iter;
> +       struct page *page = bio_iter_page(it->bio, it->iter);
>
>         BUG_ON(bytes > cursor->resid);
>         BUG_ON(bytes > bio_iter_len(it->bio, it->iter));
> @@ -851,7 +852,8 @@ static bool ceph_msg_data_bio_advance(struct ceph_msg_data_cursor *cursor,
>                 return false;   /* no more data */
>         }
>
> -       if (!bytes || (it->iter.bi_size && it->iter.bi_bvec_done))
> +       if (!bytes || (it->iter.bi_size && it->iter.bi_bvec_done &&
> +                      page == bio_iter_page(it->bio, it->iter)))
>                 return false;   /* more bytes to process in this segment */
>
>         if (!it->iter.bi_size) {
> @@ -899,6 +901,7 @@ static bool ceph_msg_data_bvecs_advance(struct ceph_msg_data_cursor *cursor,
>                                         size_t bytes)
>  {
>         struct bio_vec *bvecs = cursor->data->bvec_pos.bvecs;
> +       struct page *page = bvec_iter_page(bvecs, cursor->bvec_iter);
>
>         BUG_ON(bytes > cursor->resid);
>         BUG_ON(bytes > bvec_iter_len(bvecs, cursor->bvec_iter));
> @@ -910,7 +913,8 @@ static bool ceph_msg_data_bvecs_advance(struct ceph_msg_data_cursor *cursor,
>                 return false;   /* no more data */
>         }
>
> -       if (!bytes || cursor->bvec_iter.bi_bvec_done)
> +       if (!bytes || (cursor->bvec_iter.bi_bvec_done &&
> +                      page == bvec_iter_page(bvecs, cursor->bvec_iter)))
>                 return false;   /* more bytes to process in this segment */
>
>         BUG_ON(cursor->last_piece);

Same here, shouldn't be needed.

Thanks,

                Ilya

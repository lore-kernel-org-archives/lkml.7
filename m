Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DDAC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1040B20815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="Y0mXezBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfEPQGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:06:43 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40965 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfEPQGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:06:42 -0400
Received: by mail-yb1-f194.google.com with SMTP id a13so1450825ybl.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CHWyz1LU+xHA4Q1ska4TffuV2AfB2TvrKTO3gR0GbGE=;
        b=Y0mXezBZVxIxseokZsbxqalDY+MaBWbgOOboidAQf5Pma6GdOx6ZZxVHR30++t/Y7q
         P4kua8WZMlbWVIE1t/ywUPS4L/qmMs+NyeEkbC5QIECT0cXdsBYd+UxeuKIbXXG6cx+1
         GY+oD0njrg6/P9nBGOCHBvBWGQRZfp5OOeFqsacn0cJDfuCyPZFJ3UECh54jrCIETv2A
         ebwlOHH7So5wen48Z0j33UczjRMSJT+kNffsRx55e6kC/3la9syO+SwhKOvdhx2DrBqo
         x1GWHEYxpzdmhD2PZmvHYLIkmozTXQny5F7/UQOE1XrIru48Nw44/P9PWTS4gBKhljp5
         3dsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHWyz1LU+xHA4Q1ska4TffuV2AfB2TvrKTO3gR0GbGE=;
        b=cXQOmoeXCuAgTpawe2lim+jWXV+SpPALdaYs2wUO8khTYr232OdGimUuMEHSjkWeiD
         zwAa3NAFg7CCOcRQzIX5hOzj//+SXiNonkiPpUrW/VsKcDcJFIYbhSgD1Ga0LO8ExGR2
         nC/KxiV3WWaRdrvpFyJv4goXROabiw54xbU9x9g1CXu1tvgIC1WY++0/o2pNifOV2Mub
         tP0BPejqc9paNiOymi7cTB9zgcrvOdPkd4vy34rgZ5nRHmI6Z2+ok0/V+G9ACMoh738h
         r9EsI5kcCzoBQz5vi8sNpkZ5GkZ/qNdNE2IV825iOSoCtoFjDRjGjwtXJ0+Esplx5hzV
         TCDA==
X-Gm-Message-State: APjAAAUj8AtgS0Pa2ycUzR0CqXkI1VbTvzhHyn6BFT6szhcQ+nYEUA/h
        KOtlXqqezGeANmu1hFGTT9rX8jH9szSieK0Twy0ddQ==
X-Google-Smtp-Source: APXvYqwTwUep44gjhL50pdhBMWRKO6w6XgfCToc9A83ssp6llyoXZB/UrsVDxWm82O0MyBEOv0DQEWDkOmlNKpI2j8A=
X-Received: by 2002:a25:26c7:: with SMTP id m190mr22880219ybm.486.1558022802021;
 Thu, 16 May 2019 09:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190511132700.4862-1-colin.king@canonical.com>
In-Reply-To: <20190511132700.4862-1-colin.king@canonical.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Thu, 16 May 2019 12:06:31 -0400
Message-ID: <CAOg9mSQt42NQu-3nwZOCGOPx45y7G8aaiDaVe4SwotGnD9iY1A@mail.gmail.com>
Subject: Re: [PATCH] orangefs: remove redundant assignment to variable buffer_index
To:     Colin King <colin.king@canonical.com>
Cc:     Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin...

Thanks for the patch. Before I initialized buffer_index, Dan Williams sent
in a warning that a particular error path could try to use ibuffer_index
uninitialized. I could induce the problem he described with one
of the xfstests resulting in a crashed kernel. I will try to refactor
the code to fix the problem some other way than initializing
buffer_index in the declaration.

-Mike

On Sat, May 11, 2019 at 9:27 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable buffer_index is being initialized however this is never
> read and later it is being reassigned to a new value. The initialization
> is redundant and hence can be removed.
>
> Addresses-Coverity: ("Unused Value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/orangefs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
> index a35c17017210..80f06ee794c5 100644
> --- a/fs/orangefs/file.c
> +++ b/fs/orangefs/file.c
> @@ -52,7 +52,7 @@ ssize_t wait_for_direct_io(enum ORANGEFS_io_type type, struct inode *inode,
>         struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
>         struct orangefs_khandle *handle = &orangefs_inode->refn.khandle;
>         struct orangefs_kernel_op_s *new_op = NULL;
> -       int buffer_index = -1;
> +       int buffer_index;
>         ssize_t ret;
>         size_t copy_amount;
>
> --
> 2.20.1
>

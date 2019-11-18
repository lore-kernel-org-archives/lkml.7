Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ABCC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E9E2186D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iPNrBghv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKRRjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:39:05 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38695 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfKRRjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:39:05 -0500
Received: by mail-ed1-f65.google.com with SMTP id s10so14343664edi.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 09:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wwy7y1a6q/DuAvJKNf/i3hevC3KWqafGydm34BlW9lE=;
        b=iPNrBghv59Zs8dDX8Xz9bhEBRWgibTBZWXihskroBECqP/sEwdJ6WgRmPmFVDKT0S8
         y2jkd991PONOD9wU8fUMCdZMwJhIHvI/cmQQJT37eN2UgMCfSVjbL5EVkcz1rbcAfxz8
         qfkZGYgdcJ7wv673TYNQfofZYRDGP4zoZadY6Eg5XwxOTMvhvPVqGzYe716AwaNYwWtR
         3j1Q03SmWJ+MhxHwi7MYaosE2D1v6GLGODfgD9GAPI4LmJJyJT5lqU6rFY7sVjvDIq1+
         4OR4wAWEaWw7Tfmx2FblvHroNIxCEHmxj0HtlgmdouzWKMbv1EpWrhwNXoVHe5vs+xQ1
         3DHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wwy7y1a6q/DuAvJKNf/i3hevC3KWqafGydm34BlW9lE=;
        b=ITYVBKFZaMAFrmKM9yZ9IPYGpBV5Qlj1de0n+/Oxtm9rJL4KXjZNFL+T3vF1NkRtFR
         S3AwJvg/Qg977PVnTz9lAjRayQ/lGUzRuGiGc/N4fLbeZA9eZd3JOs5+hXYsbIC/EedA
         504yNNI+PqnDHxJhpUzZ0rSYDlL9qJpH31hv1TtvubN9L5D1KL5iy4CF1K1MNXzzhl+g
         7g7lM5YopCHp432ezziRY/6rH9PNQ/NZ8+jSACXLLUb5ZhjMTvg3FFli/eJGC5hZprhE
         QDmZuqmKLUHFEmoMxr5dkNs1ewzfvZdGmuydcm1P0FdFTaq3Viau15FAPe6w2Xd/Mgqq
         8j3A==
X-Gm-Message-State: APjAAAVc0KzpuIGI5n6HPWd9+oi7COF+SohTBCp8y1Q5QbUR8hc2tS2r
        epYkwMV4FxHnDxYCuZf7eH+H15+ldMOTE1kxAoyOFA==
X-Google-Smtp-Source: APXvYqxhqeJRdUmC8N6VoZ8p/rHkoYIm1VNdzTaP9BU/3q7mXDVI7F4KpAAS8GbGgAVSgvqFOqMqz+pAp1Tx2gzpvwI=
X-Received: by 2002:a17:906:7c4e:: with SMTP id g14mr27917513ejp.150.1574098743309;
 Mon, 18 Nov 2019 09:39:03 -0800 (PST)
MIME-Version: 1.0
References: <20191115201225.92888-1-lrizzo@google.com> <20191116.131058.1856199123293908506.davem@davemloft.net>
 <59ebfae8-ac93-75a1-7a60-2bb3820a9a79@mellanox.com> <20191117.102949.1712366954266607838.davem@davemloft.net>
In-Reply-To: <20191117.102949.1712366954266607838.davem@davemloft.net>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Mon, 18 Nov 2019 09:38:52 -0800
Message-ID: <CAMOZA0LWNaK+bwDvUchRdB3enz=Dw4jUDCAY-6e0ty=iT6pytw@mail.gmail.com>
Subject: Re: [PATCH] net/mlx4_en: fix mlx4 ethtool -N insertion
To:     David Miller <davem@davemloft.net>
Cc:     tariqt@mellanox.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2019 at 10:29 AM David Miller <davem@davemloft.net> wrote:
>
> From: Tariq Toukan <tariqt@mellanox.com>
> Date: Sun, 17 Nov 2019 14:46:50 +0000
>
> >
> >
> > On 11/16/2019 11:10 PM, David Miller wrote:
> >> From: Luigi Rizzo <lrizzo@google.com>
> >> Date: Fri, 15 Nov 2019 12:12:25 -0800
> >>
> >>> ethtool expects ETHTOOL_GRXCLSRLALL to set ethtool_rxnfc->data with the
> >>> total number of entries in the rx classifier table.  Surprisingly, mlx4
> >>> is missing this part (in principle ethtool could still move forward and
> >>> try the insert).
> >>>
> >>> Tested: compiled and run command:
> >>>     phh13:~# ethtool -N eth1 flow-type udp4  queue 4
> >>>     Added rule with ID 255
> >>>
> >>> Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> >>> Change-Id: I18a72f08dfcfb6b9f6aa80fbc12d58553e1fda76
> >>
> >> Luigi, _always_ CC: the appropriate maintainer when making changes to the
> >> kernel, as per the top-level MAINTAINERS file.
> >>
> >> Tariq et al., please review.
> >>
> >
> > Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
>
> Applied and queued up for -stable, with Change-Id: removed.


Thank you all, apologies for mistakes.

cheers
luigi

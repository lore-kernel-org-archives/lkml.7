Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4824BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19D82075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="g+182DMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732846AbfC0A1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:27:46 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35494 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732137AbfC0A1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:27:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id s39so6950085edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 17:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YDqu+Ouv/jl8NEtNJ0T0hvBn+9NllYh3HrlwRLOokxM=;
        b=g+182DMR7q0J5PKKhrHzD/BXtbW/CX/xwuEH7+blEmSyjP8xSokuQDYFGeushH1yKV
         Hzn2WmbL5vQw4dC5bYW1Mrhl8/UkIGFQSwqWWDH7SA/dZra5HGZUx+mXqDwP4ySMzNkg
         1+VjJ2S9hyNyHgT11xxT5tL2Y8eRm85CRunUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDqu+Ouv/jl8NEtNJ0T0hvBn+9NllYh3HrlwRLOokxM=;
        b=jEcR/Bt8vn5fYlHCfsZUcTqdOUI8BKjiA8dpEC5D/ngS34wcRnFx/TpKGJIoA8uDJi
         kPd7EvhtMXuuDHcherV2ENsbOTSvGLf5D1BU2Ls2vzDSglvjRCAEZ8E2euUqJRXIop69
         IykyTRmy5kYLiCnnzKMJhlhLj7rS3jfy1Ivl5fpnDHuhrCHROQcaL0FrF2X4F31w3dm3
         FpXIdt78z+KakG4z0Ez+NQHc/lNgaezLHg9NZROFv5kmuJOGsn+0PzFiM9NYBFsY1Bw2
         S8qBdyngGH70TbHJEoxTF3Wo4CIeTO2ZuvJySfypotc8VpQIU9N/pG01z/490ScXKzRC
         hflg==
X-Gm-Message-State: APjAAAXgSNjncJpLcOW3mlZVRoFATv60+zwm2iH/pUlLoDzJmZ1qPYeG
        PpF+GRSxMpBn34OA4rc6XnViiZQgDxWl9xhlZVDW4g==
X-Google-Smtp-Source: APXvYqwNFmecKSk12hehg6JJcPTXGoWTdnxt8d1FMDNYtODzL9PIbK+DgJGBTaJRT8o9fY8XOrXIAXv7MivWJsNt6Zw=
X-Received: by 2002:a17:906:48c7:: with SMTP id d7mr19074902ejt.225.1553646000143;
 Tue, 26 Mar 2019 17:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190325195303.GA20629@hari-Inspiron-1545>
In-Reply-To: <20190325195303.GA20629@hari-Inspiron-1545>
From:   Roopa Prabhu <roopa@cumulusnetworks.com>
Date:   Tue, 26 Mar 2019 17:19:48 -0700
Message-ID: <CAJieiUgwikFOcgyk-zht+Z_D8rqjpbcVGVFunzv=nNoxVrKcvg@mail.gmail.com>
Subject: Re: [PATCH] trace: events: fix error directive in argument list
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 12:53 PM Hariprasad Kelam
<hariprasad.kelam@gmail.com> wrote:
>
> This patch fixes below spare errors.
>
> Sparse error:
> make C=2 CF=-D__CHECK_ENDIAN__ M=net/core
> ./include/trace/events/neigh.h:73:1: error: directive in argument list
> ./include/trace/events/neigh.h:78:1: error: directive in argument list
> ./include/trace/events/neigh.h:150:1: error: directive in argument list
> ./include/trace/events/neigh.h:155:1: error: directive in argument list
>
> Changes below two lines to signle line to avoid sparse error
>  #if IS_ENABLED(CONFIG_IPV6)
>                if (n->tbl->family == AF_INET6) {
> to if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)
>
> and removes reassigning pin6 pointer when IPV6 is enabled
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

Acked-by: Roopa Prabhu <roopa@cumulusnetworks.com>

Thanks!

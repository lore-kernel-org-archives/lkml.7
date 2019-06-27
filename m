Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78036C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415F42086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TARbsryt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfF0N5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:57:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36256 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfF0N5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 09:57:45 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so4958334ioh.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 06:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/XyALr5qJRsJTMcLA/D+aC0kMlYtWn91PnkhNGpSRtM=;
        b=TARbsryt5eoK7wH3/0VoLs9AjeUYpobcuF4ODQ+DWtG18hc32alo/6Fha/qPWCQJ0Y
         sxRqw3LuY+1e07fKhS95PEi8W2l8/O0QD6WyURMMD+oXr+UC7saUgs7XRKFuOMnu9yYH
         xg+qMr2R497swI7SAV8IrKb8C/nFt40C2XvvHhPOUXYpSwjUZ5AgZtypX/oJ86SMSJBE
         m7VFnuhaG05hHX8r9soUjDtuh+zdTJ/gJqXhOlMv9WI4NJjcf/tMQFIkOi0iRRJlMpP8
         muIFOfLXPS1NMgj9J8vPWEpLB2zqF8wh/OhAtkDeVEWBWXy/TGGF9ta6nbT6xZaeKre/
         9Img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/XyALr5qJRsJTMcLA/D+aC0kMlYtWn91PnkhNGpSRtM=;
        b=ijMWFO7wH/02/ohtemj6Ulfy7JUXUbvZvE4D5Y6qbSlO3kqacNprKuoWXFuhaWDH7B
         36D8k8IFtFKUSGtk0F4lDiqnbBml29kPAZSuYy/pl5BY0vIYQPwdXNl4ajQ2O9wWIR4Q
         U+yqJORwKb6BfpEw+qrmDCTZ280o3NyyJ8+PTucuaDm3cLZI+ZSAp4iSN4Na8GlLLB3V
         FOvvcSTLfk5Orr0TT1hadAEn1CCgsRo+rb0BliJCSKKP06XSzFYWKh3trmGCJGdVNUw0
         hKENC7/lIiQ1jXmKde9fkS8CYx9M+r/iXqVB21wXjwGw/TJN8imchtk6PnBZ/HYPSwR0
         RtzQ==
X-Gm-Message-State: APjAAAVY/s6715AoKbbo/hdgFrdy3WRYTihY+7Uv/PxH8xvinfoXJY2J
        hQa4/m/IMUrANVMg5cRRGi+fdOPzcXtwGII1JMc=
X-Google-Smtp-Source: APXvYqyE7mm8EAZx9kCmIftM3PSFefXChkPMObDwk0LccEKSxDMufjhyaxWFITvm9tFc8tln6uJLGaUPqyZt9Oo3gNY=
X-Received: by 2002:a02:7420:: with SMTP id o32mr4850594jac.117.1561643865009;
 Thu, 27 Jun 2019 06:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <1561604670-11476-1-git-send-email-yang.bin18@zte.com.cn>
In-Reply-To: <1561604670-11476-1-git-send-email-yang.bin18@zte.com.cn>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Thu, 27 Jun 2019 15:57:33 +0200
Message-ID: <CAHpGcM+6p_TtHh=YSa1Mxyjr+w+V5_8RR2TgnN-s5TbbHjGhng@mail.gmail.com>
Subject: Re: [PATCH] sub sd_rgrps When clear rgrp
To:     Yang Bin <yang.bin18@zte.com.cn>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wang.yi59@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang Bin,

Am Do., 27. Juni 2019 um 05:08 Uhr schrieb Yang Bin <yang.bin18@zte.com.cn>:
> From: " Yang Bin "<yang.bin18@zte.com.cn>
>
> When clear rgrp,sub sd_rgrps after erased from rindex_tree

this patch isn't incorrect, but all it does it ensure that sd_rgrps
reaches zero before we destroy a struct gfs2_sbd. However, sd_rgrps is
only ever used when a filesystem is active, and while that is the
case, it can never decrease. It will grow when the filesystem is grown
though.

So what are you trying to achieve with this patch?

> Signed-off-by: Yang Bin <yang.bin18@zte.com.cn>
> ---
>  fs/gfs2/rgrp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
> index 15d6e32..a4b2e83
> --- a/fs/gfs2/rgrp.c
> +++ b/fs/gfs2/rgrp.c
> @@ -730,6 +730,7 @@ void gfs2_clear_rgrpd(struct gfs2_sbd *sdp)
>                 gl = rgd->rd_gl;
>
>                 rb_erase(n, &sdp->sd_rindex_tree);
> +               sdp->sd_rgrps--;
>
>                 if (gl) {
>                         glock_clear_object(gl, rgd);
> --
> 1.8.3.1
>

Thanks,
Andreas

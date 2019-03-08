Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A91C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C347A20675
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9o221zk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfCHANq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:13:46 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34288 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfCHANp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 19:13:45 -0500
Received: by mail-pg1-f196.google.com with SMTP id i130so12596002pgd.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 16:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6gecIuSBE8qyocxJuQRfc49X3ESIkgsWlcYLg8y3Fw=;
        b=M9o221zk8jL1gbNClqI+UMqU7kYB+Fn8as7RBYuS0CyMmAn+xhbC4RD6Lt/9C/OXqc
         AU4rfDi9nipBkfvWPSE+oPqZ2IpcqMD5S4d6n0k9oMnCbpg2oddm+85gAOOxe/qTGFD8
         lVX6mPbrh+Rs1RSSozswh+WK8vi9N/l5zjTd/i4jocP7JLTMvzyH7F7G3yHbRQTQR6rR
         G1X+Lg6jNLtMy337D7sz+WglVyQPI6Zsv9wEMIvRlztCdLgDlu6l9sOewXaUE4tf1y2N
         4+4BAzuwql058GUR1SokvL0yRMs6GQ8R8F7gVP6VSWwHChsDa+LGge/9EVvsxDZME3rA
         auIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6gecIuSBE8qyocxJuQRfc49X3ESIkgsWlcYLg8y3Fw=;
        b=EXwsCzJYR4cuc5LPhEKtrqstCToMWp6WJECGkUYMUM3F484fmCLR1gFFRbIRXkG9fq
         2h5oVHvh10IaJ7u/uOiiO2F/EcsPbuUgciC9edgELz1KNaf6NRrPMpOgVJnBDT66DbQI
         FAed1c/HGw5uNgumPi1FJ5QMWSBGvgt9GywDYw8wm9O60+2usrbCCxPafSVdR0nykkYB
         mUljLnmYRwMUNTXEIxM7PTGEKUUWhj7MIS0HwfPF8k1RUQprPuheMw/yQEOQz+YjqR81
         E931s+E4ayMhK44EDCa1+8WnFz6OyuPVt3IZjoNNO7ZH3lG8Se86lRLXdwdVSxUqAy3F
         g5TQ==
X-Gm-Message-State: APjAAAXDTYtDZRo2EseUKQSheLbSL1Pegi1G5AsZ52ccAIPArbdRoBdZ
        Riuj3eLVKeh3JgEbbm7athb5GKxdftNak7yTOFhfL9ATtVI=
X-Google-Smtp-Source: APXvYqyvWJwsuPme9HBFgLAOidQvbZEWctNHIIyAar97bTin/NfuESN+Qt6mFGQm4igqYHoDHHoVJydcAqESjXs2kq8=
X-Received: by 2002:a62:e704:: with SMTP id s4mr15410819pfh.94.1552004024414;
 Thu, 07 Mar 2019 16:13:44 -0800 (PST)
MIME-Version: 1.0
References: <20190307232933.10145-1-natechancellor@gmail.com>
In-Reply-To: <20190307232933.10145-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Mar 2019 16:13:33 -0800
Message-ID: <CAKwvOdnT8Xnq0a495h7-18qAB+5eb9Lw+oKfGef7BErGfXFYUg@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: sun: Zero initialize class in default case
 in niu_add_ethtool_tcam_entry
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 3:29 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> drivers/net/ethernet/sun/niu.c:7466:5: warning: variable 'class' is used
> uninitialized whenever switch default is taken
> [-Wsometimes-uninitialized]
>
> The default case can never happen because i can only be 0 to 3
> (NIU_L3_PROG_CLS is defined as 4). To make this clear to Clang,
> just zero initialize class in the default case (use the macro
> CLASS_CODE_UNRECOG to make it clear this shouldn't happen).

Good choice. Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/403
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/net/ethernet/sun/niu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
> index d84501441edd..6f99437a6962 100644
> --- a/drivers/net/ethernet/sun/niu.c
> +++ b/drivers/net/ethernet/sun/niu.c
> @@ -7464,6 +7464,7 @@ static int niu_add_ethtool_tcam_entry(struct niu *np,
>                                         class = CLASS_CODE_USER_PROG4;
>                                         break;
>                                 default:
> +                                       class = CLASS_CODE_UNRECOG;
>                                         break;
>                                 }
>                                 ret = tcam_user_ip_class_set(np, class, 0,
> --
> 2.21.0
>


-- 
Thanks,
~Nick Desaulniers

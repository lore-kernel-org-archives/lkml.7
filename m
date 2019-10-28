Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1C8CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6472721721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bDLCentm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbfJ1T1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 15:27:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41377 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730396AbfJ1T1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 15:27:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id l3so7567249pgr.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 12:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WqHCy8DtjPPIsAYYwN6cddepz+7TDeAcpTy8zrFF7IQ=;
        b=bDLCentmnuEHqH3hQW3JtHp5cSv4F42ngi+Qr7oStV5fL6IcVxLesG7BQYQmCGlkfe
         qJMetoy6O/ZJtwv+YNAMd7ux4qBDA13u+bm4jvJa0fxt1HJuze4Mium3f5B2O7cuSMfd
         gy3+YvIHkT9NPMy9WyyyEf0WobwII0YXK2F94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WqHCy8DtjPPIsAYYwN6cddepz+7TDeAcpTy8zrFF7IQ=;
        b=Sdpg4K/YyPESYyyVxONHnT4IafDjkifTxghBMV/JEs5pW+/m9sZ7d/B0UCZw1GdqI5
         RgSAH8LiiGT7H3VO4zSWTtlkDY+6ofXVocaY1BWeMeNCjahdzUPxJ62rVoJuE3iKTSSH
         cBsqlSyHs9cvP64gNNDYnJQF1S2RMmD62DFeivb5ql6NWYzPicFts4IkUPrLiyrfADKq
         PlF2t7QfNuSgCphKc13W0CdxZFS41pxLW+v/aE2zBvgHLv1heqyNQhZ4xhJ3HnDuna9U
         cadX+RnGlYfSV4o7Fbh587M5I1vJ+0T7m4xislCHwYQZyAM6x/xlzCPobbM0Ai6O1Kff
         1c+Q==
X-Gm-Message-State: APjAAAUdAWikiI1ySx+Lmm1VkwV/0wN+fobtXZfRgzQEefFpIUQXKbLp
        82y4TqnfiPxkKLut870ZPUIaKPzhCKE=
X-Google-Smtp-Source: APXvYqzCe2WjejDHIo++4O42aN3hB1zjlCJdav/oflx/tWeVoFHWPekfZERqZqdQ9DtW7G8nccnX6w==
X-Received: by 2002:a63:b60b:: with SMTP id j11mr11149592pgf.116.1572290862686;
        Mon, 28 Oct 2019 12:27:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s23sm11427332pgh.21.2019.10.28.12.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 12:27:41 -0700 (PDT)
Date:   Mon, 28 Oct 2019 12:27:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, luto@amacapital.net
Subject: Re: [PATCH] seccomp: rework define for
 SECCOMP_USER_NOTIF_FLAG_CONTINUE
Message-ID: <201910281227.5A580CD@keescook>
References: <20191024212539.4059-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024212539.4059-1-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 11:25:39PM +0200, Christian Brauner wrote:
> Switch from BIT(0) to (1UL << 0).
> First, there are already two different forms used in the header, so there's
> no need to add a third. Second, the BIT() macros is kernel internal and
> afaict not actually exposed to userspace. Maybe there's some magic there
> I'm missing but it definitely causes issues when compiling a program that
> tries to use SECCOMP_USER_NOTIF_FLAG_CONTINUE. It currently fails in the
> following way:
> 
> 	# github.com/lxc/lxd/lxd
> 	/usr/bin/ld: $WORK/b001/_x003.o: in function
> 	`__do_user_notification_continue':
> 	lxd/main_checkfeature.go:240: undefined reference to `BIT'
> 	collect2: error: ld returned 1 exit status
> 
> Switching to (1UL << 0) should prevent that and is more in line what is
> already done in the rest of the header.

Hmpf. I thought those were already exported into the UAPI. Ah well.
Thanks! Applied.

-Kees

> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  include/uapi/linux/seccomp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> index 61fbbb7c1ee9..9099972200cd 100644
> --- a/include/uapi/linux/seccomp.h
> +++ b/include/uapi/linux/seccomp.h
> @@ -102,7 +102,7 @@ struct seccomp_notif {
>   * SECCOMP_USER_NOTIF_FLAG_CONTINUE. Note that SECCOMP_RET_USER_NOTIF can
>   * equally be overriden by SECCOMP_USER_NOTIF_FLAG_CONTINUE.
>   */
> -#define SECCOMP_USER_NOTIF_FLAG_CONTINUE BIT(0)
> +#define SECCOMP_USER_NOTIF_FLAG_CONTINUE (1UL << 0)
>  
>  struct seccomp_notif_resp {
>  	__u64 id;
> -- 
> 2.23.0
> 

-- 
Kees Cook

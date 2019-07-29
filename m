Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22462C41514
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D3B206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IwVnGfXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfG2QYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:24:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46574 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbfG2QYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:24:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id c3so5154515pfa.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hfu708o/mVgXoKaiBjfu2KmWx5O5JJDKePJXiIrhEfE=;
        b=IwVnGfXVwYw5/ml78DM05Lc3bvqXArkV7u+TuWjeF7i5Cf8f1BT64SqqDwOW4Uq+f6
         TOAf8hjXnVS/Bb1DCAadVxB8Dvcqhv7RcW0L9QaFT5apGyzltdF6UKsmtV2c86TMtatx
         71SBpHd25E+BFsaaryC6RivxCDMsG2h9H/tZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hfu708o/mVgXoKaiBjfu2KmWx5O5JJDKePJXiIrhEfE=;
        b=l4RRxXGVKqyLbuo9CDwO68CN02azrp+CSqAKLl+0/Rt645Mu4gkQ4w8QSOhtfE2FYg
         vzAfd8IBqVGqx8jAoNIUhG/5VsQVwg6kKAYMnIZHDRXeK0KyHD5etEFzsT75rPTVekfT
         Y4xbki7e/6keEMm79IGWWJazxqBS1z8Ser18FEyzEDTldc5v6IK/7QZ/Ol8w9/J765Ct
         FNrUeIgZnEEsoVk5Q2+fbvDoPbyHmnhgN1vr3RrRKiIF1dI2LeBPDVnTtzJTqukM8i6U
         V+ME/e+dX0nJ154Lm4jJoqXt6ag/Jdc9Mc4cCGczUpylgZAowJc+nOjAbr3Hn/mjRmi1
         C29A==
X-Gm-Message-State: APjAAAVdGakPKFgMprZGqrXvfT1a6yhTzFwnGwDegWccmduTrZ6F7/oZ
        3Phkoquv+jj1+z1R+28LfTXyzQ==
X-Google-Smtp-Source: APXvYqwAoRvAhdUXojTIgBig4nmSf3S5NGMOETUJCjvvpRJ6/GyY1tEOtnEXi14EwYnQzLGkUHqBKA==
X-Received: by 2002:a62:7a8a:: with SMTP id v132mr37390223pfc.103.1564417480398;
        Mon, 29 Jul 2019 09:24:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 65sm64996154pgf.30.2019.07.29.09.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 09:24:39 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:24:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, oleg@redhat.com,
        torvalds@linux-foundation.org, arnd@arndb.de,
        ebiederm@xmission.com, joel@joelfernandes.org, tglx@linutronix.de,
        tj@kernel.org, dhowells@redhat.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, kernel-team@android.com
Subject: Re: [PATCH v3 1/2] pidfd: add P_PIDFD to waitid()
Message-ID: <201907290915.8B421306D@keescook>
References: <20190727222229.6516-1-christian@brauner.io>
 <20190727222229.6516-2-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727222229.6516-2-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 12:22:29AM +0200, Christian Brauner wrote:
> diff --git a/kernel/exit.c b/kernel/exit.c
> index a75b6a7f458a..64bb6893a37d 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1552,6 +1552,23 @@ static long do_wait(struct wait_opts *wo)
>  	return retval;
>  }
>  
> +static struct pid *pidfd_get_pid(unsigned int fd)
> +{
> +	struct fd f;
> +	struct pid *pid;
> +
> +	f = fdget(fd);
> +	if (!f.file)
> +		return ERR_PTR(-EBADF);
> +
> +	pid = pidfd_pid(f.file);
> +	if (!IS_ERR(pid))
> +		get_pid(pid);
> +
> +	fdput(f);
> +	return pid;
> +}
> +
>  static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
>  			  int options, struct rusage *ru)
>  {
> @@ -1574,19 +1591,29 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
>  		type = PIDTYPE_PID;
>  		if (upid <= 0)
>  			return -EINVAL;
> +
> +		pid = find_get_pid(upid);
>  		break;
>  	case P_PGID:
>  		type = PIDTYPE_PGID;
>  		if (upid <= 0)
>  			return -EINVAL;
> +
> +		pid = find_get_pid(upid);
> +		break;
> +	case P_PIDFD:
> +		type = PIDTYPE_PID;
> +		if (upid < 0)
> +			return -EINVAL;
> +
> +		pid = pidfd_get_pid(upid);
> +		if (IS_ERR(pid))
> +			return PTR_ERR(pid);

I spent some time convincing myself that this early bail out was
correct. It seems this path is only reachable in the EBADF case, so that
makes sense. The other failure modes in this switch all give a NULL pid
so that the final do_wait() returns ECHILD. So, as long as that's
intentional (which I think it is), this all looks fine. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

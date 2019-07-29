Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FE6C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597B7206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="M8NG4S2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfG2Qab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:30:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46077 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfG2Qaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:30:30 -0400
Received: by mail-io1-f66.google.com with SMTP id g20so121355275ioc.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+gzxQ1amGLjMFB5E07agK4fzVRqjFnh1FNoqJj1CdRE=;
        b=M8NG4S2PH/gszkul25OY1fcWbX2BnVaOYvZHVXvuGcDZSdiBBoaVDKrFCVSabT+FLg
         arM65PkdRQP0fFDhD8ovNvi4iV8J6y2DHAG704jwLt9adzCEXuzOXn4n0V+T/otxRtas
         avpmAu0n16IvYcMXB81W7t3VKgXmQgtoPUTGLMhwKWqiacf9RHIykvYPxXJ9fj9jJ3VH
         okV4v/0HBvI1QRaDMyuzNYHOwR8ABHIXnH7RnjUQCd8tThgSyhod59TyN0P+SkaLGjAr
         7yyBvCzcPEaImvsXSxmZqhQbdfuaQJW/Tv3yhpR4hf85vuNMRz2A986gNxg6rWkGUX0Z
         b69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+gzxQ1amGLjMFB5E07agK4fzVRqjFnh1FNoqJj1CdRE=;
        b=gh0RQRpJ/jDBoED5Y+hy2xO36+dD8qzRaOi3qKnHnIJ7JnLnUUmzKoV9N9B9yhGblw
         pxNedXdZzABKJKO/geykPUO4tWT7TCIv+pJekP18O4hiYEbUXdsDdmf7gxOG44QUN8NB
         90sdWMcVX/HV9cNaq0CJSoP4CCFFxQyz+0oW3ZoRQ5kp4fRLM35v6ivuzTyABmCGx8e9
         /HZ+ob7AR/H64vOmA3lzZp718O3l2RbH9z1IrutjXba+05CS6ddtMA3R1dAzSlOcZV+O
         /4GW5jiIPdMbfYoGMDLb8UAt8s4EqXadXUB3aJchHFmTDlZ/zmt3dMcBkbG+Tdko2O1J
         fxiQ==
X-Gm-Message-State: APjAAAWB1B8Wmv6W2iE2+OMWoCcNmFdXP7m2tN9wgkMNWRSPFXFd3f/A
        b5wowhAXeF/YAQW7bw5QWEs=
X-Google-Smtp-Source: APXvYqzb/8KWjUnh6FhXiBLI4YaHXUfTNDs/wUUO30D4k+n3LUQA01dG1RLiOC77dzkC9lg+j9kJRA==
X-Received: by 2002:a02:bb05:: with SMTP id y5mr1741821jan.93.1564417828671;
        Mon, 29 Jul 2019 09:30:28 -0700 (PDT)
Received: from brauner.io ([162.223.5.124])
        by smtp.gmail.com with ESMTPSA id k5sm65133943ioj.47.2019.07.29.09.30.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 09:30:28 -0700 (PDT)
Date:   Mon, 29 Jul 2019 18:30:27 +0200
From:   Christian Brauner <christian@brauner.io>
To:     oleg@redhat.com, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, tj@kernel.org, tglx@linutronix.de,
        prsood@codeaurora.org, avagin@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] exit: make setting exit_state consistent
Message-ID: <20190729163025.4jc6d4nkdcdhve2k@brauner.io>
References: <20190729162757.22694-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190729162757.22694-1-christian@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 06:27:57PM +0200, Christian Brauner wrote:
> Since commit [1] we unconditionally set exit_state to EXIT_ZOMBIE before
> calling into do_notify_parent(). This was done to eliminate a race when
> querying exit_state in do_notify_pidfd().
> Back then we decided to do the absolute minimal thing to fix this and
> not touch the rest of the exit_notify() function where exit_state is
> set.
> Since this fix has not caused any issues change the setting of
> exit_state to EXIT_DEAD in the autoreap case to account for the fact hat
> exit_state is set to EXIT_ZOMBIE unconditionally. This fix was planned
> but also explicitly requested in [2] and makes the whole code more
> consistent.
> 
> /* References */
> [1]: b191d6491be6 ("pidfd: fix a poll race when setting exit_state")
> [2]: https://lore.kernel.org/lkml/CAHk-=wigcxGFR2szue4wavJtH5cYTTeNES=toUBVGsmX0rzX+g@mail.gmail.com
> 
> Signed-off-by: Christian Brauner <christian@brauner.io>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>

I plan on sending this together with a few other fixes later. (Assuming
the change here is correct of course.)

Christian

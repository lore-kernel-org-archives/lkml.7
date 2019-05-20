Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741C2C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AC72173C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j1R3pnfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfETVuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:50:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46117 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfETVuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:50:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id r18so7313656pls.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 14:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AjggmU90pDPJr60wE2nNAnEDRr3oK/LD2TBSCV+YnF4=;
        b=j1R3pnfz3VcFlZcJ5FRFu0iye2uGUG1wVoYLoBjZ94+h3WvE/NVpedepLX5XSiBqWu
         8T6tR4NPquHftfOo1osxWquMw/h+AlkZ6vHPPmcKmWRB9D24eE3/2hawA76PHUMqd1GH
         idEB7QIqNGB6FV4TPY8zNnH8YTPOrb2FnvOVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AjggmU90pDPJr60wE2nNAnEDRr3oK/LD2TBSCV+YnF4=;
        b=maSh2zBtHnDj7u9LQb4BSgEQP3NVuXoH/vwlH96MwAX4MixW11Z/ZZLVjz4bVUigpu
         UhMJ71F4TtQhWDzz4DzoxCl/xGFjUjb5oNBIhhm8M0rDXRrQOjEkMPIvTv1yQDwJKNfG
         JTaA5seBJaWDBVT+CcKHDjLZkffhrgB1wsbF+Lm4PHdD/2LQNXnFaTJGy7H6SI5JHNzj
         inXFUm457fx38DC4FqLDu417GkUVjXIaN6C/NeHj0drHU3X6wn/t53DJXG5NX+PGyfpd
         v9eJTv2OIRER/Z4eyhbj9c6kLfgJ68TnR6E5Y2+rB2SWrdyhnxvpwdl74lmouM6j6Njj
         jGRA==
X-Gm-Message-State: APjAAAW2czSSVNajUbrRicGtuwQa+0l992/6DpCyT3duCE9ToayHajpw
        ZZIkED+PC+YmoLvxTLS9lr7r1N7N5AI=
X-Google-Smtp-Source: APXvYqwkO/MxVX4k6hJVbuRvCLVJ6hWVXqWke/9oTdO2/sUrJRHJBfNZFPkq64H0g6SD6MZz+J/3og==
X-Received: by 2002:a17:902:bd06:: with SMTP id p6mr4630769pls.112.1558389005535;
        Mon, 20 May 2019 14:50:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a11sm11573602pff.128.2019.05.20.14.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 14:50:04 -0700 (PDT)
Date:   Mon, 20 May 2019 14:50:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     shuah <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] firmware: Add support for loading compressed files
Message-ID: <201905201446.B1CE073E@keescook>
References: <20190520092647.8622-1-tiwai@suse.de>
 <20190520093929.GB15326@kroah.com>
 <s5hwoil5gwm.wl-tiwai@suse.de>
 <s5h7ealb1d3.wl-tiwai@suse.de>
 <s5ho93xqenb.wl-tiwai@suse.de>
 <5a3a0649-ece0-c3e3-3ebb-9d8d19d9499f@kernel.org>
 <s5h36l980f6.wl-tiwai@suse.de>
 <s5hwoil6jgd.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hwoil6jgd.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 08:59:14PM +0200, Takashi Iwai wrote:
> So the problem is obvious: the commit above adjusts the stdout to be
> unbuffered via stdbuf, hence each invocation like
>   echo -n abc > /sys/....
> 
> would become writes of "a", "b" and "c", instead of "abc".
> 
> Although we can work around it in each test unit, I'm afraid that
> enforcing the unbuffered stdio is too fragile for scripts like the
> above case.

Oh this is nasty. Looks like stdbuf overrides all child processes too...
yeah, that's very broken. Let me try to see if I can find an
alternative.

Shuah, in the meantime, if you want a fix to restore test behavior,
but regress output flushing, this will work:

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index eff3ee303d0d..a529c19240fc 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -27,11 +27,11 @@ tap_prefix()
 # If stdbuf is unavailable, we must fall back to line-at-a-time piping.
 tap_unbuffer()
 {
-	if ! which stdbuf >/dev/null ; then
+	#if ! which asdfstdbuf >/dev/null ; then
 		"$@"
-	else
-		stdbuf -i0 -o0 -e0 "$@"
-	fi
+	#else
+	#	stdbuf -i0 -o0 -e0 "$@"
+	#fi
 }
 
 run_one()

Some tests will no longer show their output until they're entirely done,
but at least no test pass/fail results should regress.

I'll keep looking at solutions...

-- 
Kees Cook

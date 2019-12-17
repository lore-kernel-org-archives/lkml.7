Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B19C2D0D1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 05:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6542072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 05:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fl0v2lo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfLQFMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 00:12:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41288 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfLQFMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 00:12:37 -0500
Received: by mail-pl1-f194.google.com with SMTP id bd4so5522002plb.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 21:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q8uq0G/0a7n6wpCfthraliInM8bWXiLfDNBWtuDMtJ8=;
        b=Fl0v2lo28eToo5OfamdynpU3VUKelWk576MTDeGbgaSOPoSF2oP2NxvPiIVhkqlZOr
         BpXQcvAl9FcaDO0W3hxow/LxKBn42CFXGVcqL0CpCkE2B97xXAn5IdEF0c/1u1tLoj1K
         8UXxO1U3y6FSZTdkb/w2FvSSqRrKmDH5oXOHifjDJMzTwvZC4Nv4s1fj4kwc4p6PaGlL
         ig2WtwUSRnJeYgM/FkBfxu7095yTFvrIeCWV3wTci61MDNOdSl+Blv1oY0FZphxNk8TL
         vkHCEAiG4dHcY5/QVvlaSAIaFCAbO5ryV3f2FmrcV9LsfALEZsq7Nhp7hruvOO9U3DQs
         tJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q8uq0G/0a7n6wpCfthraliInM8bWXiLfDNBWtuDMtJ8=;
        b=JzR25eGcpaaggpGffcLtaqauc7KT5ZtBlNvxx5xkzjZA6LpozFgaoj8FpbOD8dwb98
         5NJsPTwTZ9T6v0DCbBBdvqVo/DZKC6w0S0HwBUR2SKyyNek+AtNnXUnU1qCUuU6SHd9G
         yYdyup2tzgBc1XyUIypD1KNuPjtB5VuzlBBenZXqP1Ns/FgZa+224GdK0LdqM0RqYkij
         s1evllzLP8UpmulclzBNSY4ZYJXByYSC+YyFV06FqnaK6mHHwuFBhMYFglm+rJKwbx9q
         ZR7sdNgpkkzmPcsqr09BzagQAb52PkPiPK6scv7334z1dWExj5KSK/93aEIAERjDXVvF
         u4Mg==
X-Gm-Message-State: APjAAAXNvOe6Kt2aMwAbJLPHb7a63paJGaNQZslKnN1xGw9UT3FMEpWD
        FCuBDnzLgYAfbhgurKZ3e9c=
X-Google-Smtp-Source: APXvYqy3lSJKhLaFlrkVPcy3/Kqv3W5CFnC949J5w5xHpyX1wYGi6RcSMBAP13o4qK5uFE3FiiAr0w==
X-Received: by 2002:a17:902:b083:: with SMTP id p3mr20066966plr.141.1576559557194;
        Mon, 16 Dec 2019 21:12:37 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id 16sm24569625pfh.182.2019.12.16.21.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 21:12:36 -0800 (PST)
Date:   Tue, 17 Dec 2019 14:12:34 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] kconfig: Add kernel config option for fuzz testing.
Message-ID: <20191217051234.GA54407@google.com>
References: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (19/12/16 18:59), Tetsuo Handa wrote:
[..]
> +++ b/kernel/printk/printk.c
> @@ -1198,6 +1198,14 @@ MODULE_PARM_DESC(ignore_loglevel,
>  
>  static bool suppress_message_printing(int level)
>  {
> +#ifdef CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING
> +	/*
> +	 * Changing console_loglevel causes "no output". But ignoring
> +	 * console_loglevel is easier than preventing change of
> +	 * console_loglevel.
> +	 */
> +	return (level >= CONSOLE_LOGLEVEL_DEFAULT && !ignore_loglevel);
> +#endif
>  	return (level >= console_loglevel && !ignore_loglevel);
>  }

Can you fuzz test with `ignore_loglevel'?

	-ss

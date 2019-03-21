Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0894AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40D7218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lHxGhzfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfCUQih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:38:37 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:32817 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfCUQig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:38:36 -0400
Received: by mail-ua1-f65.google.com with SMTP id g8so2150191uaj.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+d3slal8RHgIemuwqv1bVmF4kYmq9tX4rl6CabK5V6Y=;
        b=lHxGhzfVl2+5ASLfawc/0YRK1Tz2G1mgf1RsZ6UjNJo2tGsTYGb1GGulfi5jKNp24C
         PZNywgkSnmRKOWRsxZaJAFzF73Yskgmsy606W6Cq4BRZjyP1qx2FW85ouhe0oFIxeEto
         zsKSMlAk5EMoxE6t0obr4B20G/mdBqwrZ5HVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+d3slal8RHgIemuwqv1bVmF4kYmq9tX4rl6CabK5V6Y=;
        b=N8V8eDPxwcA5jjvciLbI8zrrLcgXQYXSrCP79G3a/ZapN75qW96ucJNH+gcv8bK4uY
         UpxEPSr/bZk5oVXPrxqMAbt8eGNK3M2vW9xNt8KEsAV6OR1BxIviR6nYssm6L7LfYS7A
         I4Vzqz1ggm+3vOVLs/5UPsfnnT7iNMi6wRYE/b1fIQiRl1wZIqSaTlZPNjdqs+2ChzJR
         W2Pa4gcB4AyM0B0cafIX4eOvUSjWFI1eZ/Iwh9Xg/TVNKik3pYLQMdKbcNNqVk6adsVy
         MyqRvV6BrAB0Q4kSK+ACb8kvt80t6VpEk28DQh/zOBdm2QtYtoodkeSzfkj8PeJA2mUc
         yPrA==
X-Gm-Message-State: APjAAAVv+fC29Ola2N9DRrkFEhD/9D4dHtV4FDfC9nIPY3OujTRz/plR
        LZ0vzm2pDrOwUP28ZhTgzU8Lcy71NvOjPA==
X-Google-Smtp-Source: APXvYqxAwAaQ+NGI4BkYwVLblb/Xbyj742Tu4uKrfd1eVEuGvt55MEzdlG6+UHyvwLUYQ7ekjnFMZQ==
X-Received: by 2002:ab0:2886:: with SMTP id s6mr2337285uap.93.1553186314762;
        Thu, 21 Mar 2019 09:38:34 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id w68sm3585081vkw.9.2019.03.21.09.38.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 09:38:32 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id r21so2117937uan.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:38:32 -0700 (PDT)
X-Received: by 2002:ab0:72c2:: with SMTP id g2mr2464248uap.112.1553186311977;
 Thu, 21 Mar 2019 09:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190315110555.0807d015@cakuba.netronome.com> <20190315120105.5541ad46@cakuba.netronome.com>
 <20190315165440.53b9db3c@cakuba.netronome.com> <CAGXu5jKHRPuaALQcPXvpDeuVgZR+EeRqo9Qj4j3kYatb3HUSSA@mail.gmail.com>
 <CAGXu5jL-e7bDEXfpUuT-HyFarR-8T0djXChR0cuzTwFQPQ0tOw@mail.gmail.com>
 <f23d0fad-dc72-0e53-cac6-31abfd12a050@I-love.SAKURA.ne.jp>
 <bee1a774-461a-2535-a640-bbe65291e909@schaufler-ca.com> <2bf23acd-22c4-a260-7648-845887a409d5@i-love.sakura.ne.jp>
In-Reply-To: <2bf23acd-22c4-a260-7648-845887a409d5@i-love.sakura.ne.jp>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 21 Mar 2019 09:38:20 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKj-Pq4krHmKd__4MoXBe1FK399cDZnSxdPigZo78tPfA@mail.gmail.com>
Message-ID: <CAGXu5jKj-Pq4krHmKd__4MoXBe1FK399cDZnSxdPigZo78tPfA@mail.gmail.com>
Subject: Re: mount.nfs: Protocol error after upgrade to linux/master
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 3:56 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Since Kees Cook seems to be busy now, here is my version...
>
> From 885553e4793d9af2d4e9e99c7d137b0ec7b5f8ad Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Tue, 19 Mar 2019 19:52:31 +0900
> Subject: [PATCH] LSM: Revive CONFIG_DEFAULT_SECURITY_* for "make oldconfig"
>
> Commit 70b62c25665f636c ("LoadPin: Initialize as ordered LSM") removed
> CONFIG_DEFAULT_SECURITY_{SELINUX,SMACK,TOMOYO,APPARMOR,DAC} from
> security/Kconfig and changed CONFIG_LSM to provide a fixed ordering as a
> default value. That commit expected that existing users (upgrading from
> Linux 5.0 and earlier) will edit CONFIG_LSM value in accordance with
> their CONFIG_DEFAULT_SECURITY_* choice in their old kernel configs. But
> since users might forget to edit CONFIG_LSM value, this patch revives
> the choice (only for providing the default value for CONFIG_LSM) in order
> to make sure that CONFIG_LSM reflects CONFIG_DEFAULT_SECURITY_* from their
> old kernel configs.
>
> Reported-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  security/Kconfig | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/security/Kconfig b/security/Kconfig
> index 1d6463f..743e594 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -239,9 +239,43 @@ source "security/safesetid/Kconfig"
>
>  source "security/integrity/Kconfig"
>
> +choice
> +       prompt "Default security module [superseded by 'Ordered list of enabled LSMs' below]"
> +       default DEFAULT_SECURITY_SELINUX if SECURITY_SELINUX
> +       default DEFAULT_SECURITY_SMACK if SECURITY_SMACK
> +       default DEFAULT_SECURITY_TOMOYO if SECURITY_TOMOYO
> +       default DEFAULT_SECURITY_APPARMOR if SECURITY_APPARMOR
> +       default DEFAULT_SECURITY_DAC
> +
> +       help
> +         This choice is there only for converting CONFIG_DEFAULT_SECURITY in old
> +         kernel config to CONFIG_LSM in new kernel config. Don't change this choice
> +         unless you are creating a fresh kernel config, for this choice will be
> +         ignored after CONFIG_LSM is once defined.
> +
> +       config DEFAULT_SECURITY_SELINUX
> +               bool "SELinux" if SECURITY_SELINUX=y
> +
> +       config DEFAULT_SECURITY_SMACK
> +               bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
> +
> +       config DEFAULT_SECURITY_TOMOYO
> +               bool "TOMOYO" if SECURITY_TOMOYO=y
> +
> +       config DEFAULT_SECURITY_APPARMOR
> +               bool "AppArmor" if SECURITY_APPARMOR=y
> +       config DEFAULT_SECURITY_DAC
> +               bool "Unix Discretionary Access Controls"
> +
> +endchoice
> +
>  config LSM
>         string "Ordered list of enabled LSMs"
> -       default "yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
> +       default "yama,loadpin,safesetid,integrity,selinux" if DEFAULT_SECURITY_SELINUX
> +       default "yama,loadpin,safesetid,integrity,smack" if DEFAULT_SECURITY_SMACK
> +       default "yama,loadpin,safesetid,integrity,tomoyo" if DEFAULT_SECURITY_TOMOYO
> +       default "yama,loadpin,safesetid,integrity,apparmor" if DEFAULT_SECURITY_APPARMOR
> +       default "yama,loadpin,safesetid,integrity"
>         help
>           A comma-separated list of LSMs, in initialization order.
>           Any LSMs left off this list will be ignored. This can be

This is mostly good. I'd like to keep the other LSMs listed though
(similar to what I had originally) so that if a legacy-major doesn't
initialize, later ones will be. I want to remove the concept of
"major" LSMs. The only thing that should matter is init order...

-Kees

> --
> 1.8.3.1
>
>


-- 
Kees Cook

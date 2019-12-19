Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA88C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AAF42467F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buXANuNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfLSJee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 04:34:34 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43395 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfLSJed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 04:34:33 -0500
Received: by mail-io1-f68.google.com with SMTP id n21so3488589ioo.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 01:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2HLiTZyq2ry6lkSzS6juCxX02zdatIbwE2mWkvw/+rA=;
        b=buXANuNlddOr++ALAul32L5kVHvOuPykOoo8QK8diTIaq3ZGfeVA1eobbo3zkCrWIX
         KFVTnoxm70MdhJwgx9y2rFJ4DIJUmKfRtcnom3xiw8dzvDDpPBD1V+kk7xxBK+WqDJzl
         eOcPw+VinJ72WYH57+21f5HTFSyZC8ww9FCz1hqAuS6oCEwaOVGSGEuqWvntr6Gy+GLB
         OEPrvqTiv9yNpXgFEt5lrZT099ibBHQeENT2VYPKDFaomVa3VQ/079YNfqyiVzSZ5kij
         7G0MnN3dKFbTpN1Wym3y/5ErZbhPtgccCegNiP/gw7+bjc36s7sL95cr0/r8h1lXyp69
         /Rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2HLiTZyq2ry6lkSzS6juCxX02zdatIbwE2mWkvw/+rA=;
        b=uQClR4lLNSjSyeXQ6CoNhKE0K2kprPIyprceVXxROJeILJFt5G+3XbeDmeWp41sN7o
         qx+YI5fKMSJ5X2a4PLHU1o5ceQykKcr6dSXqIDzm/A0fnJ+hZo2kiZTPbvd5oUdoyL6S
         UOZS0tyjQpjyB+SAxBxy1VbY+0144Pxn23qJ8WeoY/FQnqesF8W00eqNHCecKcwdPn+X
         KzthQEcJO5PBgbKlYBBP3/GAGbAi77zwR7XGxuM2WA9bFcykzeFnSX/ZdTUL0KDqyIrg
         7wtYTaTfIr7FmaFIO7BZGopvD8OPSxI8zKF2GoZqxvfsAie3wE+Ro50xIB1UoIpWywZ1
         LuwQ==
X-Gm-Message-State: APjAAAUYSA9bXnl1nipLJOSku38cshNE3m9V4QQmkSi6GTdSD4xBl2UL
        LLFE8IiNSut/T1Rt6KtuBhvPjGH8ll+TjwkoLys=
X-Google-Smtp-Source: APXvYqysY7GkuI7DYduHYELAl17kAbs3Q3bYQBUzGqkNaLKqkTZNoKcxCWF3qGFHcfiVBE8VJ/9rrreJfcOmoPBq1YM=
X-Received: by 2002:a02:780f:: with SMTP id p15mr6262268jac.91.1576748072645;
 Thu, 19 Dec 2019 01:34:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac0:9191:0:0:0:0:0 with HTTP; Thu, 19 Dec 2019 01:34:32
 -0800 (PST)
In-Reply-To: <20191219070836.GA496264@light.dominikbrodowski.net>
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
 <20191217051751.7998-1-youling257@gmail.com> <20191217064254.GB3247@light.dominikbrodowski.net>
 <CAOzgRdZR0bO14fyOk5jLBUkWwgsf7fx41JMQr-Hr6nss1KSmLw@mail.gmail.com>
 <CAHk-=whN00UTq76bDT-WXm72VhttLv8tcchqEkcUoGXt38XXRg@mail.gmail.com>
 <CAOzgRdaRDnd3gi0QO-b_2Nm4RXf_+UJ+Ec1Ne0=cx00fKpZN8g@mail.gmail.com> <20191219070836.GA496264@light.dominikbrodowski.net>
From:   youling 257 <youling257@gmail.com>
Date:   Thu, 19 Dec 2019 17:34:32 +0800
Message-ID: <CAOzgRdYknEe0hmK3OfbF1gLbmxBD77eCoDif3=8OicJ8YwE1Lg@mail.gmail.com>
Subject: Re: [PATCH 4/5] init: unify opening /dev/console as stdin/stdout/stderr
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test this patch not work, still has system/bin/sh warning.
ls -al /proc/1/fd
total 0
dr-x------ 2 root root  0 2019-12-19 17:19  [1;34m. [0m
dr-xr-xr-x 9 root root  0 2019-12-19 17:19  [1;34m.. [0m
lrwx------ 1 root root 64 2019-12-19 17:19  [1;36m0 [0m ->
 [1;31m/android/sys/fs/selinux/null [0m
lrwx------ 1 root root 64 2019-12-19 17:19  [1;36m1 [0m ->
 [1;31m/android/sys/fs/selinux/null [0m
lrwx------ 1 root root 64 2019-12-19 17:19  [1;36m10 [0m ->
 [1;31msocket:[12337] [0m
l-wx------ 1 root root 64 2019-12-19 17:19  [1;36m11 [0m ->
 [1;31m/android/dev/pmsg0 [0m
lrwx------ 1 root root 64 2019-12-19 17:19  [1;36m2 [0m ->
 [1;31m/android/sys/fs/selinux/null [0m
l-wx------ 1 root root 64 2019-12-19 17:19  [1;36m3 [0m ->
 [1;31m/android/dev/__kmsg__ (deleted) [0m
lrwx------ 1 root root 64 2019-12-19 17:19  [1;36m4 [0m ->
 [1;31manon_inode:[eventpoll] [0m
lrwx------ 1 root root 64 2019-12-19 17:19  [1;36m5 [0m ->
 [1;31msocket:[857] [0m
lrwx------ 1 root root 64 2019-12-19 17:19  [1;36m6 [0m ->
 [1;31msocket:[858] [0m
lrwx------ 1 root root 64 2019-12-19 17:19  [1;36m7 [0m ->
 [1;31msocket:[859] [0m
lrwx------ 1 root root 64 2019-12-19 17:19  [1;36m9 [0m ->
 [1;31msocket:[10698] [0m

Revert "fs: remove ksys_dup()", no the system/bin/sh warning.
ls -al /proc/1/fd
total 0
dr-x------ 2 root root  0 2019-12-19 17:28  [1;34m. [0m
dr-xr-xr-x 9 root root  0 2019-12-19 17:28  [1;34m.. [0m
lrwx------ 1 root root 64 2019-12-19 17:28  [1;36m0 [0m ->
 [1;31m/android/sys/fs/selinux/null [0m
lrwx------ 1 root root 64 2019-12-19 17:28  [1;36m1 [0m ->
 [1;31m/android/sys/fs/selinux/null [0m
lrwx------ 1 root root 64 2019-12-19 17:28  [1;36m10 [0m ->
 [1;31msocket:[12506] [0m
l-wx------ 1 root root 64 2019-12-19 17:28  [1;36m11 [0m ->
 [1;31m/android/dev/pmsg0 [0m
lrwx------ 1 root root 64 2019-12-19 17:28  [1;36m2 [0m ->
 [1;31m/android/sys/fs/selinux/null [0m
l-wx------ 1 root root 64 2019-12-19 17:28  [1;36m3 [0m ->
 [1;31m/android/dev/__kmsg__ (deleted) [0m
lrwx------ 1 root root 64 2019-12-19 17:28  [1;36m4 [0m ->
 [1;31manon_inode:[eventpoll] [0m
lrwx------ 1 root root 64 2019-12-19 17:28  [1;36m5 [0m ->
 [1;31msocket:[1957] [0m
lrwx------ 1 root root 64 2019-12-19 17:28  [1;36m6 [0m ->
 [1;31msocket:[1958] [0m
lrwx------ 1 root root 64 2019-12-19 17:28  [1;36m7 [0m ->
 [1;31msocket:[1959] [0m
lrwx------ 1 root root 64 2019-12-19 17:28  [1;36m9 [0m ->
 [1;31msocket:[2040] [0m

2019-12-19 15:08 GMT+08:00, Dominik Brodowski <linux@dominikbrodowski.net>:
> On Thu, Dec 19, 2019 at 05:50:19AM +0800, youling 257 wrote:
>> 2019-12-18 5:14 GMT+08:00, Linus Torvalds
>> <torvalds@linux-foundation.org>:
>> > This should be fixed by 2d3145f8d280 ("early init: fix error handling
>> > when opening /dev/console")
>>
>> this fix no help for me.
>>
>> > I'm not sure what you did to trigger that bug, but it was a bug.
>>
>> alt+f1, type bash command,
>> bash: cannot set terminal process group (-1): Inappropriate ioctl for
>> device
>> bash: no job control in this shell
>
> Could you test this patch, please? And if it does not work: What is the
> content of /proc/1/fd/ and /proc/1/fdinfo/* for the working and non-working
> case? That are the only changes visible to userspace...
>
> Thanks,
> 	Dominik
>
> diff --git a/init/main.c b/init/main.c
> index 1ecfd43ed464..8886530e9dec 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1162,7 +1162,7 @@ void console_on_rootfs(void)
>  	unsigned int i;
>
>  	/* Open /dev/console in kernelspace, this should never fail */
> -	file = filp_open("/dev/console", O_RDWR, 0);
> +	file = filp_open("/dev/console", force_o_largefile() ? O_LARGEFILE |
> O_RDWR : O_RDWR, 0);
>  	if (IS_ERR(file))
>  		goto err_out;
>
>

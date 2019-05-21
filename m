Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ED8C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3BF208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="UUsV50XW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfEUNj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 09:39:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35311 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbfEUNj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:39:57 -0400
Received: by mail-lf1-f67.google.com with SMTP id c17so13160192lfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 06:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DGZ7ZHyxHghlyk00GjOL+Su8tQVyBxRwxWt505Mwkr8=;
        b=UUsV50XWdVARTWvdiywE4LnO/Bgl22uVqIvj5DiL4yTqSSX691QJuUM5FH7mGHFNYk
         Q0+0Bk1dY9Y5jYUMp6VxvQCJ668wo7gKKnk7wKdAbO6uXmyxdHg1D3dyjo/e1Z67HVYz
         ek1VF3gFyvtiDXkBXE/5DNTwuCl20PqPvKDr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DGZ7ZHyxHghlyk00GjOL+Su8tQVyBxRwxWt505Mwkr8=;
        b=t8aGu7jKNXCDQXG0Urx9ku5lwt2ekjbfamE1MCEHwEJEKHvy4RsHVL4LJ33RG7Yq8W
         ofoJgP2cLxdhwwzk8fFHf57aBOPEGB4YxT62I+ydFVxk5XA3MdRneCmmLGVc7Eb+0mWt
         JOlv+Qi+EFiT4vdWMIoKvgHQJiM/7GgEXreLa0F7thBlTCJ8zd+MgNHWfxFF/CFbNLyZ
         HTdAbmAoqbR9v8Zejf8fZtUBNahq+0GnxmQy+H7vPSzbwgG49erL1ZXnirI23appMMsz
         jCWTGuvYl/nH6X4GatoG7ezH0m7Ju7jeALaf2hR7xY+Qupka6Sq/2kL2jFfIuG8NEbPW
         lnyw==
X-Gm-Message-State: APjAAAUxMI6Os6XaIwgkfX/BTB/iUeURVbg+imh0KP5ytTC1eI1qGr4z
        f3udLSIlsXmnHG0+ezTnWR1K1w==
X-Google-Smtp-Source: APXvYqy9VOBSFXKLfNL+Ppcf03Ojn4u3dT2Srf4sf8eVcsyswZbIav8iH9LKu3NFIr4da9Rx00Vw+w==
X-Received: by 2002:ac2:5490:: with SMTP id t16mr2238952lfk.154.1558445996105;
        Tue, 21 May 2019 06:39:56 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r26sm4706723lfa.62.2019.05.21.06.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 06:39:55 -0700 (PDT)
Subject: Re: [PATCH 1/2] open: add close_range()
To:     Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20190521113448.20654-1-christian@brauner.io>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <82d34133-e174-efc3-48ed-332304028595@rasmusvillemoes.dk>
Date:   Tue, 21 May 2019 15:39:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521113448.20654-1-christian@brauner.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2019 13.34, Christian Brauner wrote:

> The performance is striking. For good measure, comparing the following
> simple close_all_fds() userspace implementation that is essentially just
> glibc's version in [6]:
> 
> static int close_all_fds(void)
> {
>         DIR *dir;
>         struct dirent *direntp;
> 
>         dir = opendir("/proc/self/fd");
>         if (!dir)
>                 return -1;
> 
>         while ((direntp = readdir(dir))) {
>                 int fd;
>                 if (strcmp(direntp->d_name, ".") == 0)
>                         continue;
>                 if (strcmp(direntp->d_name, "..") == 0)
>                         continue;
>                 fd = atoi(direntp->d_name);
>                 if (fd == 0 || fd == 1 || fd == 2)
>                         continue;
>                 close(fd);
>         }
> 
>         closedir(dir); /* cannot fail */
>         return 0;
> }

Before anybody copy-pastes this, please note that it lacks a check for
fd == dirfd(dir). If all of /proc/self/fd is returned in the first
getdents() syscall one won't notice, but...

Rasmus

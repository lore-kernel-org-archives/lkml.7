Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3478BC48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0380F20665
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562539312;
	bh=vJ7Qn+j2hhXSdU8BuJa8Y5zIAOybLlimg8RXXTfPC4g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RR1MSvIyl68kLHxnYs/yVMo9b5DgOCt8HlFo5RrZ6WGiAIndVUCpJZNckBi7NNqPK
	 y6h/ccJRqBnODIPmczd+f3doN1yGZUFdRiyIeUxpL9sREBXkNbT/sUp6pyjjmydGq2
	 8eDJCpn9J2rI1Qpcyx/6sMg1uv4Nm9ZE+UI6IZ5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfGGWlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 18:41:50 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45855 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfGGWlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 18:41:50 -0400
Received: by mail-lf1-f65.google.com with SMTP id u10so9540784lfm.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 15:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WcsLGMUFQAhJlOvMra+sDFTnfJhyurYZj32MYfKitAE=;
        b=d1zDU5FEtUUjct83eyU6qfw3BEHwcpclDyV7DCNUYSglTpf1MCajLuQoKGKi4jJVVS
         dYxWNlNhJM/pVgTqRYTsXVbEPAK3/A0UYNj8BhpeLmjA3O2f50q/ZhmZ4AVjPA7HJm9w
         Lxic1Zrh0kVkBYTgX7gtZybpTIW/Tx2J0/wRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WcsLGMUFQAhJlOvMra+sDFTnfJhyurYZj32MYfKitAE=;
        b=hwetH8FPrNWElZ0dR3E63tG+AqMWt9ngUG1sG50F5VXwh752O3O61RNjZszDfvLMhi
         rhXjExLHLaUOrRD0r1ZCW8npjuWxjSYMPbjl7WHRwCZMFhx6vylTfGygvNNZQ7OvId5v
         S4i7vYYu465Cf71f8n8zvAb5jIIyr8tZ8RG6ffgJISrOXyGfLfQVcWZ/mM42bZmB4FBG
         Kn15F9YbgM49WVVlQWj1QRrFjATM/qM/lPpuaW+HrRMkPrFr5xr7zVk7Htm8Yeq4SSbU
         jWplJshoFXt53g2FusbXx1PhQgxfHhw4B10FZqb7KDmKAwZ2JcuWjBTVBzfCo2fGGDaq
         Fx7Q==
X-Gm-Message-State: APjAAAXidohXpSFAfjpUzkzEZnbz7VTksaswaqbrc+PjDW+Bad7C0wzE
        xL2iW2wDVaOqUwKODcAWMnFVVGJkDf0=
X-Google-Smtp-Source: APXvYqz3K/tyTTZ758SIakS14WlL/E1U+7eWzC3VrbfFTQit0zyCCybnnvSMYQYXr0mMVudXxoZf+A==
X-Received: by 2002:a19:f711:: with SMTP id z17mr522898lfe.4.1562539307564;
        Sun, 07 Jul 2019 15:41:47 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id b11sm3234313ljf.8.2019.07.07.15.41.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:41:46 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id x3so3639566lfc.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 15:41:46 -0700 (PDT)
X-Received: by 2002:ac2:4565:: with SMTP id k5mr7060354lfm.170.1562539306171;
 Sun, 07 Jul 2019 15:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190706001612.GM17978@ZenIV.linux.org.uk> <20190706002236.26113-1-viro@ZenIV.linux.org.uk>
 <20190706002236.26113-4-viro@ZenIV.linux.org.uk> <CAHk-=wgB5NN=N9Z4Y26CTSr1EchMfXbuFvVU4rcKaNca9qVkiA@mail.gmail.com>
 <20190707214042.GS17978@ZenIV.linux.org.uk>
In-Reply-To: <20190707214042.GS17978@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Jul 2019 15:41:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=iuSja-aib7z4bgivbJWuVcKf1Yd8Cdx-2nos3Fnmqw@mail.gmail.com>
Message-ID: <CAHk-=wh=iuSja-aib7z4bgivbJWuVcKf1Yd8Cdx-2nos3Fnmqw@mail.gmail.com>
Subject: Re: [PATCH 4/6] make struct mountpoint bear the dentry reference to
 mountpoint, not struct mount
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 7, 2019 at 2:40 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> It is namespace_sem.  Of all put_mountpoint() callers only the one
> from mntput_no_expire() (disposing of stuck MNT_LOCKed children)
> is not under namespace_sem;
>
>                 list_for_each_entry_safe(p, tmp, &mnt->mnt_mounts,  mnt_child) {
> -                       umount_mnt(p);
> +                       umount_mnt(p, &list);
>                 }
> in mntput_no_expire() passes a local list to umount_mnt() (which passes it
> to put_mountpoint()).

Ahh. Ok. This would be better with a comment. Maybe a separate helper
function with that comment and the special case of passing in NULL (or
maybe not pass in NULL at all, but pass in ex_mountpoints?).

Different locking requirements depending on argument values is very
confusing and easily overlooked..

                Linus

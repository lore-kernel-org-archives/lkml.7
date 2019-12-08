Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3420EC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 21:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38882053B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 21:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575840931;
	bh=0T/mlW/i2N19yYI9RVNnLWFG29nhURWFEw1LcscPGkk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dUTrfN9got52bWq+x4J/A0R7fiePnrredQCTMMin6bNgKph3cuLpJh5LBIPq6ajjF
	 Y1QmYw4OdF9qu3ZvOHNqE563MZtRaa3D39QwIy9qXWwno1Kv2gGmtIteKXcu8f9sDx
	 wEu4Trm8o1eMAQImcvSgxEt6fzpufDR4ehiYwqkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLHVf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 16:35:29 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:47048 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfLHVf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 16:35:28 -0500
Received: by mail-lf1-f65.google.com with SMTP id f15so8291942lfl.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 13:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uSATXKDDmvR07T7kUi8rHi7RN+bAfLLpofRbY4BLnYc=;
        b=QDp02WtOAAN8JLUWqKZ1RMBdvq52AFxQlA60k5ue1vPtqtI974JZyKwoY75VqFwxG5
         wUDgZAaIsmJW7fwWatKJDfq6JFa//u0FMI769Ck5v6nuPBk6RQObsYioypzjwB8qy/O7
         ieejU5X44533UrSnW+Luvu+jyOKat8deoXhas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uSATXKDDmvR07T7kUi8rHi7RN+bAfLLpofRbY4BLnYc=;
        b=F3KGhe37R2h4hjmPwcMc1bqHOTyY3TPjyNtqfIWRkYXKbsMVIZBimVTfTQsxjcn/ub
         XFuAJsTRhX5+9cUWj01oAmUUE71Yw2JGFHAcPBBrYFconjwsqfIBME1EgzrvbIY7xiMt
         nvystLORrd8MT0RzxqWXhNBZ6pgITrpLi42nBoOLHMP+7JdoGDgCUSQX/BK8QUv3JsZh
         vg6QGd6N2f4THbQgRTGjW6C3L0FJJg7C24QsR+EshEhsS9ICdntRhupcd56CoiZCvwdV
         y6OHSrMzHYcnyy4yxjJOESNWRkw35NF9laMFk0BAGmqfOr9z/14N8KrH3egQj+XRoUyZ
         opVg==
X-Gm-Message-State: APjAAAXFG1vFOLMAhoglm3ho9eDh8qJ6fR6wwBAger7euiKuxUL1F9IW
        0s8UIpvCX6A9Gsa74UJzZT5/gzlZwRY=
X-Google-Smtp-Source: APXvYqyiOKjfFcp1trUUUgOmaWvtp0nO9vmj6q19+/M1loVP/q9bm5J8EyejZCuNVJjPcPQQy2wuSA==
X-Received: by 2002:ac2:424d:: with SMTP id m13mr13255965lfl.13.1575840925863;
        Sun, 08 Dec 2019 13:35:25 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id c12sm7623854lfp.58.2019.12.08.13.35.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2019 13:35:25 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id e10so13339749ljj.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 13:35:24 -0800 (PST)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr10154411ljj.97.1575840924390;
 Sun, 08 Dec 2019 13:35:24 -0800 (PST)
MIME-Version: 1.0
References: <20191208.012032.1258816267132319518.davem@redhat.com>
In-Reply-To: <20191208.012032.1258816267132319518.davem@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Dec 2019 13:35:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=widRc30Mcec8EwqxuMFr+dAFpM4gJjdVOKWJog4T60qKA@mail.gmail.com>
Message-ID: <CAHk-=widRc30Mcec8EwqxuMFr+dAFpM4gJjdVOKWJog4T60qKA@mail.gmail.com>
Subject: Re: [GIT] Networking
To:     David Miller <davem@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 8, 2019 at 1:20 AM David Miller <davem@redhat.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git

Grr,

This introduces a new warning for me:

    drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c: In function
=E2=80=98mlx5e_tc_tun_create_header_ipv6=E2=80=99:
    drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c:332:20:
warning: =E2=80=98n=E2=80=99 may be used uninitialized in this function
[-Wmaybe-uninitialized]
      332 |  struct neighbour *n;
          |                    ^

which is very annoying.

The cause is commit 6c8991f41546 ("net: ipv6_stub: use
ip6_dst_lookup_flow instead of ip6_dst_lookup") which changed
mlx5e_route_lookup_ipv6() to use ipv6_dst_lookup_flow() which returns
an error pointer, so it then does

        if (IS_ERR(dst))
                return PTR_ERR(dst);

instead of

        if (ret < 0)
                return ret;

in the old code.

And that then means that the caller, which does

        err =3D mlx5e_route_lookup_ipv6(priv, mirred_dev, &out_dev, &route_=
dev,
                                      &fl6, &n, &ttl);
        if (err)
                return err;

and now gcc no longer sees that 'n' is always initialized when 'err'
is zero. Because gcc apparently thinks that the

        if (IS_ERR(dst))
                return PTR_ERR(dst);

thing can result in a zero return value (I guess the cast from a
64-bit pointer to an 'int' is where it thinks "ok, that cast might
lose high bits and become zero even when the original was tested to
have a range where that will not happen).

Anyway - the code is not buggy, but the new warning is simply not
acceptable. We keep the build warning free even if it's gcc not being
clever enough to see that "if it's uninitialized, we never get to the
location where it's used".

I don't know what the networking pattern for this is, but I did this
in the merge

--      struct neighbour *n;
++      struct neighbour *n =3D NULL;

and I'm not happy about having gotten a pull request that has this
kind of shit in it, especially since it was _known_ shit.

It could have been that people had compilers that didn't see this
problem. But no.

I see that Stephen Rothwell reported it four days ago, and David seems
to have even answered it.

And yet that warning was still there in the pull request.

WTF?

David, this is not acceptable.  You don't introduce new warnings in the tre=
e.

It doesn't matter one whit whether the warning is a false positive. A
false positive warning will then be the cause of ignoring subsequent
real warnings, which makes false positive warnings completely
unacceptable.

Fix your mindset, and stop sending me garbage.

                   Linus

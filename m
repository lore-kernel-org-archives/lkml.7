Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37519C388F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 22:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBC22082F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 22:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569624263;
	bh=OuaZhqFFgPZ/q8VUMdHcWlOgwDO6fQMHQcE+xVkNQNQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FGdH5GqXecQUviLhRKHPCIgrcrN1iqS52tODT0dOBARRRoKHWury4e521KUtpvKdS
	 PDc51MlTrq4GuDkdB4Ln4WzCtgt6EjnT0Jtsg4MylvS8IgnJ5hu2hMmb+B3e6oKjpC
	 FF1Mz5B4SGe2P2iH895+9+FpQZQmJCZcL6p1BFl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfI0WoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 18:44:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41838 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfI0WoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 18:44:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id f5so3970253ljg.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 15:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UwSSJy15lqLdjwLfpsk3R3EoKs3M3+DyuxlQmnhgzFY=;
        b=KG0GPEhB4yI2UkkiLVvvfUC0fe3KS87zi2YmU4FaAjPZyfFOSt+evL7Qdj12aTQif6
         P8S/6U3LDBPWEwma7vrvobooIFOgoeAQQ0h4EPIl6CUxBE3xFoWqxg88aemIuL+NC/Dh
         HazHKFOKb1ffKnkcbl6O7hxptqfzzMeeqaE0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UwSSJy15lqLdjwLfpsk3R3EoKs3M3+DyuxlQmnhgzFY=;
        b=WeGoIa+E/PzEQUmCDODABDU0LRRP+ncp701hY8IvPLD9LiW8MHz9lU324UBPide/2u
         Sl1bsM4BeTalTPg7xHj+0oyXPfYltke4oqpY2fE0DPu6QJJ1jzzgBrl0bDIULUgQbruH
         BFAdivyIXaXwqHO09+f4Fmyz63pcWJ686t/FhHJehs6vA0maNfgxCQHDX9uLUtEyMDCm
         zEwi4oSGCgJOERFySnxZK9OXrxQwOI6MFjl+gJe+m467kRBjnJG4LLbsXsW7K4C+W3lT
         0OmdMaiI69cPgl2dSEAlUTElaVXld0BCYV6cBhAIF0T2/aXNq7Be9k0PKEvOKIvZnMnh
         d2kw==
X-Gm-Message-State: APjAAAW+m2pN9fg/9LjikgiWqlIiLgYSr3hJoPfu/lg/Nd1Q6qE8GMkJ
        XbVJcJLEikA5dsMYh3BiBXuC8BMqtdk=
X-Google-Smtp-Source: APXvYqwcK2fkPA5dRXN0BM8zNrvF3h6kxT+FV8yfEWqn0VMyBh4WFkwvas9hJJZvyappwDA0+YMeuA==
X-Received: by 2002:a2e:924f:: with SMTP id v15mr4422529ljg.199.1569624259371;
        Fri, 27 Sep 2019 15:44:19 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id d28sm738766lfq.88.2019.09.27.15.44.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 15:44:18 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 7so3975211ljw.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 15:44:18 -0700 (PDT)
X-Received: by 2002:a2e:3015:: with SMTP id w21mr4513668ljw.165.1569624258157;
 Fri, 27 Sep 2019 15:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190927200838.GA2618@fieldses.org>
In-Reply-To: <20190927200838.GA2618@fieldses.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Sep 2019 15:44:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_bMxjz_T9Oa62Uyp8tKnKomtHKV9HTnuvMxrdwuTPOg@mail.gmail.com>
Message-ID: <CAHk-=wj_bMxjz_T9Oa62Uyp8tKnKomtHKV9HTnuvMxrdwuTPOg@mail.gmail.com>
Subject: Re: [GIT PULL] nfsd changes for 5.4
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 1:08 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> Please pull nfsd changes from:
>
>   git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.4

Hmm. I styarted to pull, but then realized that the description
doesn't match the content at all.

You say:

> Highlights:
>
>         - add a new knfsd file cache, so that we don't have to open and
>           close on each (NFSv2/v3) READ or WRITE.  This can speed up
>           read and write in some cases.  It also replaces our readahead
>           cache.
>         - Prevent silent data loss on write errors, by treating write
>           errors like server reboots for the purposes of write caching,
>           thus forcing clients to resend their writes.
>         - Tweak the code that allocates sessions to be more forgiving,
>           so that NFSv4.1 mounts are less likely to hang when a server
>           already has a lot of clients.
>         - Eliminate an arbitrary limit on NFSv4 ACL sizes; they should
>           now be limited only by the backend filesystem and the
>           maximum RPC size.
>         - Allow the server to enforce use of the correct kerberos
>           credentials when a client reclaims state after a reboot.
>
> And some miscellaneous smaller bugfixes and cleanup.

But then the actual code is just one single small commit:

> Dave Wysochanski (1):
>       SUNRPC: Track writers of the 'channel' file to improve cache_listeners_exist

which doesn't actually match any of the things your description says
should be there.

So I undid my pull - either the description is completely wrong, or
you tagged the wrong commit.

Please double-check,

             Linus

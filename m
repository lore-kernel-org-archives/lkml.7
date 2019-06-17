Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0497C31E5D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0618208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qf2k/45s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfFQUJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:09:14 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45709 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfFQUJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:09:13 -0400
Received: by mail-qt1-f196.google.com with SMTP id j19so12347296qtr.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 13:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Al3ctU5Ww8ocaVDWU/5q96TvOispLUizRV1CFtDfOaI=;
        b=qf2k/45sE6OZ+Gh5+DRtXE3WIuJUZT2CIDmri09NlrXYO4Btj+toXNyiwRb328WTSY
         ddqXPu9rEVhtAPxNvE0K9CDxvTTzKJ0BWWz+j79PNc/TSbO8aw+FFoHXVc4o2PKt8xNE
         +8jsRM9cZr6cLlby+GvBWV52Ce9fzKzF9u5dyTb3FEfd/G/6GPisk3ItT0GKNsFAcRDv
         Gh0rYMhi8yC4VqJZqJDfvJ4y48ZkB4H1RhwI7V5LywTJZQ9BlboK1qHYtO6lb+CyKD+8
         6fQspClujju8RzhFtk3VEotj1QcxYEPM9LEK3PBmY3sBJLGUu0IjerGPEGXV8M4h1plt
         s7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Al3ctU5Ww8ocaVDWU/5q96TvOispLUizRV1CFtDfOaI=;
        b=J+VLe+IHyliWSJh00+893WBhtlVVlXF5LjhfK1/YhhMl8Qm2RHoiXNk7BVTI7Zyxfr
         16QLG1ANnnGvef7K4PIqI4K12TadTpK0BxZTVgSrxCE8vIkZiGW+f0WpWfqz9UTZFdRa
         Wl/mP45T04Tw2dReQb9+yRU3LHvpT5tPfh3Dn+zwMr+SeaZUoJXjJ8gHFO26IBQ8w2VK
         sKGSglqSWJKLCjWLZBZA6McojRhwj6znDIo074yI24ck1cMdL8zRDoTAKdGVDx3Fkof/
         3WrxbxG76Adz0xHqBrPCHCVjViOKGVtzejUPTTUeoKfXuwBri6XRGEFdHUyYt0c1ZRAz
         v0mQ==
X-Gm-Message-State: APjAAAUtwCGcWUvHlUt0D7X19nNRAPXC3jhOZrZAhGxdb+zMKZa51fCG
        qSqIENPKMtC2czAQz7mRbIHgXDoVbAgQGM7BhWA=
X-Google-Smtp-Source: APXvYqw0XOx8hWQvkZc6V+ztD3J86tZW+NikUxFcZSuurS8j1Clx/hKHsSn2WYyavAruZHjK33NHIYroa03/SQ/r7LY=
X-Received: by 2002:a0c:b66f:: with SMTP id q47mr23211411qvf.102.1560802152622;
 Mon, 17 Jun 2019 13:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN9mYmBD-4GaaeW_NrDu+FDXLzr_6x+XNxfmFV6QkYCDg@mail.gmail.com>
 <CABXGCsNq4xTFeeLeUXBj7vXBz55aVu31W9q74r+pGM83DrPjfA@mail.gmail.com>
 <20190529180931.GI18589@dhcp22.suse.cz> <CABXGCsPrk=WJzms_H+-KuwSRqWReRTCSs-GLMDsjUG_-neYP0w@mail.gmail.com>
 <CABXGCsMjDn0VT0DmP6qeuiytce9cNBx8PywpqejiFNVhwd0UGg@mail.gmail.com> <ee245af2-a0ae-5c13-6f1f-2418f43d1812@suse.cz>
In-Reply-To: <ee245af2-a0ae-5c13-6f1f-2418f43d1812@suse.cz>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 18 Jun 2019 01:09:01 +0500
Message-ID: <CABXGCsOfQjGLEN0nAt-iPo2Ay61fDY75Deq1Xn1Ymm_UsR3n_g@mail.gmail.com>
Subject: Re: kernel BUG at mm/swap_state.c:170!
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019 at 17:17, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> That's commit "tcp: fix retrans timestamp on passive Fast Open" which is
> almost certainly not the culprit.

Yes, I seen also content of this commit.
And it looks like madness.
But I can proving that my bisect are properly created.
Here I saved all dmesg output from all bisecting steps:
https://mega.nz/#F!00wFHACA!nmaLgkkbrlt46DteERjl7Q
And only one of them ended without crash message "kernel BUG at
mm/swap_state.c:170!"
This is step5 with commit 3d21b6525cae.

I tried to cause kernel panic several times when kenel compiled from
commit 3d21b6525cae would be launched and all my attempts was be
unsuccessful.

So I can say that commit 3d21b6525cae is enough stable for me and I
now sitting on it.

> You told bisect that 5.2-rc1 is good, but it probably isn't.
> What you probably need to do is:
> git bisect good v5.1
> git bisect bad v5.2-rc2
>
> The presence of the other ext4 bug complicates the bisect, however.
> According to tytso in the thread you linked, it should be fixed by
> commit 0a944e8a6c66, while the bug was introduced by commit
> 345c0dbf3a30. So in each step of bisect, before building the kernel, you
> should cherry-pick the fix if the bug is there:
>
> git merge-base --is-ancestor 345c0dbf3a30 HEAD && git cherry-pick 0a944e8a6c66

Oh, thanks for advise. But I am used another solution.
(I applied the patch every time when bisect move to new step)

> Also in case you see a completely different problem in some bisect step, try
> 'git bisect skip' instead of guessing if it's good or bad.
> Hopefully that will lead to a better result.

If you take a look all my dmesg logs you can sure that all bad steps
ended with crash "kernel BUG at mm/swap_state.c:170!".

And yes, I look again at commit cd736d8b67fb still don't understand
how it can broke my system.

--
Best Regards,
Mike Gavrilov.

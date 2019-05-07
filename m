Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91773C04A6B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 03:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B46A206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 03:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557198851;
	bh=n1/AWwgqvLeN1r7QRiMYLxNxFxsxeh+m0zuZtk1LZSE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=M9jCE5dyBGWBcivu3aAVxGk/ew0FhdakmR2HCZcjUmspPxP/QpMJ3S2xhIX0i/Ew3
	 HniM4fWpUYLAVJ3OpGEeEFAEdlw6MPwNmQO2kgZnCpy9jzse2Sg/SFZHUKmnd4f9f2
	 vyQkZF2QUyIDZjHUCHU5Z+afRhsltRypNU5Rm4BQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfEGDOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 23:14:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36659 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfEGDOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 23:14:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id z1so691184ljb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 20:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NAywE/O6BBw64w+qckpowQka/mRy1kuf8xIOtgSlqWg=;
        b=US/fJoAPz7lzHtSZnbgRW4K5atTbEpEBP5zyP2oKurgVKd8txdmImfmaIgshMnEMAb
         xSnmMOZqhcKy1MX50lnymuCMS1McGvzRVrmFv4HQAsgfGfHLaJWK7/2yYGweA3hNu0PN
         AMs1YUN4vcefoei8JVl+AEwOV8XaK9FHWo/vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NAywE/O6BBw64w+qckpowQka/mRy1kuf8xIOtgSlqWg=;
        b=imjg9Ju9wKfQ05sbBGuSgD50thjhcP/bOwmtdk2P6NXNJMd781L8RVYz0kud0JiuTV
         /aSSSZ/vYFwPARorMKV4M1B8z5D9yt3hsQGmCkPgQbUagy5LWyEejblgIk+Kcyed+e7H
         6TN4fa9IfEqYgE9zqjKfuIluX0Zsy3FzLuhE2rc30WmKSDNQ8mosFDXX12pmbBqzdq9Y
         cyldnJOuaDW22vlYKDW+TCCLFyfBLGR1UJfcY8W4xYfB3RfTUs07K0J2kVJQleoAuS5Q
         6C8YnzG06Uaf2LIfQJGdz1IUFuJVbJsHNIf9lIUNjdiEi3Ij2pW8Ukocpnkfv1Q64pfl
         2HwA==
X-Gm-Message-State: APjAAAWoM6dLpAoTblXV/OWFemmC4rPMItAef04XrSwyeLINF/j67Thq
        OI6F3IoWCbTY6rM1/Alkm/U4mwwkjC8=
X-Google-Smtp-Source: APXvYqyywfqd8XkEw+6ZHmkVqhV/7SpGUKRSylwgSN5UqB6SZ1LPzIxo9deSR09hpkvG1jVx2u8eTg==
X-Received: by 2002:a2e:9c0a:: with SMTP id s10mr15706872lji.162.1557198847365;
        Mon, 06 May 2019 20:14:07 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id y3sm2847072lfh.12.2019.05.06.20.14.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 20:14:06 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id f23so12925945ljc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 20:14:06 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr85776ljh.22.1557198846159;
 Mon, 06 May 2019 20:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190506143301.GU14916@sirena.org.uk> <CAADWXX_MqtZ6RxS2zEVmHtKrjqigiNzdSe5qVwBVvfVU6dxJRQ@mail.gmail.com>
 <20190507021853.GY14916@sirena.org.uk> <20190507030241.GC14916@sirena.org.uk>
In-Reply-To: <20190507030241.GC14916@sirena.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 20:13:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4EJQLoMNd4ptiiZvLy8ZW49pcCy0VQwZt4xhDDqSOjw@mail.gmail.com>
Message-ID: <CAHk-=wi4EJQLoMNd4ptiiZvLy8ZW49pcCy0VQwZt4xhDDqSOjw@mail.gmail.com>
Subject: Re: [GIT PULL] spi updates for v5.2
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 8:02 PM Mark Brown <broonie@kernel.org> wrote:
>
>                    Everything I'm
> seeing is saying that Google just isn't enthusiastic about domains like
> kernel.org which is going an issue.

Well, there are other people who use kernel.org email addresses.  Ingo
Molnar, Rafael Wysocki, a couple of others.  But you're the one
getting marked as spam.

Somebody just hates you. I do end up checking my spam-box regularly,
so maybe it doesn't matter.

                 Linus

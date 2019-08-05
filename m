Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B42C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE8220880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565032301;
	bh=/Ko2Q1SbD1qIIByAbumkCbbtFWL2+JHkaTCy4HbAj2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ue1X9jyz0lgntzLeEVQ3OXOMxazZCdGutDsyNV0Gvz07RQnYBSlaMFeHrijYuAk6d
	 LUlgO5x/rD1xei2Fo2D44nI7bhF0/cNdwjoQ5LK1lkB734p/ShDb1rdR9C4uv4Q5a8
	 tM51frw6tFsOm2rWxD9PZxExkvvfowXj5+lm2x6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbfHETLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:11:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37261 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfHETLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:11:40 -0400
Received: by mail-qt1-f194.google.com with SMTP id y26so82080010qto.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 12:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DsnWSlx3jr5q2iaVPxAiT1aeyVdRVmITveSmuVom2Ws=;
        b=Vl9nO6hZJOwwx8665nep1hwtFLddiHom8hEdq8dA9UwSay1sULU8gBop6s4U4Z44yx
         3P5s8qlKecgceBu9XI+Nrvfs5QUz1Jr9bPUzWCqGH5Zi6Wee/j1uh/MnJP50QJ5ispan
         jBDOPifzBkxXut0xNCCADz98y1AvhJG503CrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DsnWSlx3jr5q2iaVPxAiT1aeyVdRVmITveSmuVom2Ws=;
        b=VocJixc5pGqtXoyZH+xrhrr+LY/SunncLxhaEYl4CfN7FfB3y0GiV38dabUfO5S2Zr
         BATVICiyqYbrtCjsno9ejJXgxDzI6LwGe2fzsK2pzyttC7qHSo2wztHxKOula/pkUumv
         eyJphx1xoFxsMEERiSZBrUVL4VOFcHElcnFKcZGSesAbiZBKgLkrxLDCAbKJpbpAAbyV
         FyBXTYiolbaIhCsOdBz8xl3i0p7vDXKEKSt3M4Xdm7esW1HfBt8ctYh+HahCkgASpz/q
         bLM6kO8M5ypXuucNufX7xyxATcFMttQN6+nVxChmoi9CDt98F3S+dryAUa15VJ//Btfu
         sBOw==
X-Gm-Message-State: APjAAAVBj6rUIEgyDX+1CBfFIaT+TVNfbMNoo1TefY0GJbVL0WblW6J1
        0CSVjrJ9659non6FJni8dpw/sQ==
X-Google-Smtp-Source: APXvYqw30JT8/RTjsZe877SpJeaDKhheXmOGH3/gttaX85QOt+7DJ+cSTgRw1JCnpwUSchuDYIWaYQ==
X-Received: by 2002:a0c:87a1:: with SMTP id 30mr114158861qvj.167.1565032299025;
        Mon, 05 Aug 2019 12:11:39 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id l80sm16775532qke.24.2019.08.05.12.11.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 12:11:37 -0700 (PDT)
Date:   Mon, 5 Aug 2019 15:11:36 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Micah Morton <mortonm@chromium.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] SafeSetID MAINTAINERS file update for v5.3
Message-ID: <20190805191136.GB4887@chatter.i7.local>
References: <CAJ-EccMXEVktpuPS5BwkGqTo++dGcpHAuSUZo7WgJhAzFByz0g@mail.gmail.com>
 <CAHk-=whZzJ8WxAeHcirUghcbeOYxmpCr+XxeS9ngH3df3+=p2Q@mail.gmail.com>
 <CAJ-EccOqmmrf2KPb7Z7NU6bF_4W1XUawLLy=pLekCyFKqusjKQ@mail.gmail.com>
 <CAHk-=wgT7Z3kCbKS9Q1rdA=OVxPL32CdBovX=eHvD2PppWCHpQ@mail.gmail.com>
 <20190805142756.GA4887@chatter.i7.local>
 <CAHk-=wgdiiBVprEVoi8+mpicGnOVNZ4Lb9YUJVskOXahO50sXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wgdiiBVprEVoi8+mpicGnOVNZ4Lb9YUJVskOXahO50sXw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 11:20:59AM -0700, Linus Torvalds wrote:
>I don't know if it's worth changing the pr-tracker-bot rules. I *do*
>think that the whole unquoted
>
>   for you to fetch changes up to [hex string]
>
>is by far the strongest single signal for a pull request, but it's not
>clear that it's worth spending a lot of CPU time looking for that
>unless you have a strong signal in the subject line.

The way we do it currently is by hooking into public-inbox where the 
email subject is in the commit log. So for us to grab all new subjects 
it's a single git call, whereas getting the message body requires a git 
call per message. This is why we pre-filter by subject, as it's a cheap 
way to avoid needing to issue hundreds of git calls looking for possible 
matches in message bodies.

>So I consider this "solved", and maybe people should just realize that
>they won't get the automated responses unless they do everything just
>right.

Would you consider recording the message-id of the pull request as part 
of the commit message? This would be a sure way for us to be able to 
catch all possible cases. In fact, this would allow me to throw out most 
of the bot logic, as it would become unnecessary. E.g. the merge commit 
would look like:

Merge tag 'foo' of git://git.kernel.org/bar

Pull foo features

 * foo
 * bar
 * baz

Link: https://lore.kernel.org/r/<message-id>


However, I suspect that getting message-ids for all your pull requests 
would significantly complicate your workflow.

-K

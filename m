Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A837C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2722054F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575917314;
	bh=muHKCaD7T6fXbAMddnaVXcC0vtPeCxDhcuEyWi76OQU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CWDrGuBLg6nTvEJfgl+uSQckKGwB6Sy38q7BQHFIVkKy6lbKtiGS1xlTchShb8T6A
	 D1rHz1IMbgLqyCm0MDwzjhD7Znumo3k/id9cMhJ93VtgkntNF5HD4rbp84jIsZKaDy
	 HiHqgMZbSAzwOp4M15JBTM9QpsS4GElWVymzFHQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLISsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:48:33 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42162 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfLISsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:48:33 -0500
Received: by mail-io1-f67.google.com with SMTP id f82so15891389ioa.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 10:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zi2mbcA3dI0Tp/DpO+thSwq2zZZGqpVehuHAqxL+i5c=;
        b=LGfA1Taelzd+PatnajvxDFPlsISUHMFnQWVwAolBrXJGwNVRpSKxeSHaFDTeMc/ptL
         hEulU4FMnI7+6PQRJEC6wn5Zz3/ecd+c9iUfpIoXAfZm1Oc+2xGPCXvHwUG6TQ5Zvy2t
         s5aLS7r1cbj7m0+O93Ae4OUPcSIPg/Nuy9b+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zi2mbcA3dI0Tp/DpO+thSwq2zZZGqpVehuHAqxL+i5c=;
        b=oore9DRr2FCuOAMRgTiHGnOYaw/hCeXN6rWpKEAcsEZPUih/epsDIH4gTMCgs+S/NQ
         LImL3oYqHldBBBnGkNM7+684uM+DPWcaUqRc4gfxVBKqGId/cdAmHOwewP132F/UDbT9
         vAy0y94+HG5fcm3/wDep1kmHoaSEkXUoXXpKsPtnouZtiAw26n3ZEDVpSS8izBd7PeYA
         shMVLgoBThY0Jc3WIdLsTROyhrkWo3SeflXnx76Ilc2VMePhzgYNQ5qN2kyqFDeQElL9
         rOyvWkvfmsikDRs6k1Tu+JGMVdO3Tl1Yv/YN/QZbhYxiOandQZgijTz3DDk3iMdBLQnA
         aGug==
X-Gm-Message-State: APjAAAW3fNir2EgtEY/V5eLBBncl05hHqfFuK65CAhgaVBgqyTcNu4Ao
        tUxkL3ePMF6P+XAbf5Q+gozxNWLpBsAbmFRPWqE2E5jUeBc=
X-Google-Smtp-Source: APXvYqylpzBA/rEOG36qxdMJP/TXW5tXH1kkcXg24MQVyc8HWod7DLw4mYvfIqk4ydMjgej/CHEZBfcOnbDj+lKD+aE=
X-Received: by 2002:a02:ce5c:: with SMTP id y28mr28638212jar.96.1575917312372;
 Mon, 09 Dec 2019 10:48:32 -0800 (PST)
MIME-Version: 1.0
References: <20191209135823.28465-1-hch@lst.de>
In-Reply-To: <20191209135823.28465-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Dec 2019 10:48:20 -0800
Message-ID: <CAADWXX9zEBT-NPCwE09D+6=8iCZ+kCmdyXoGrTKhnmYn82XEJQ@mail.gmail.com>
Subject: Re: RFC: kill off ioremap_nocache
To:     Christoph Hellwig <hch@lst.de>
Cc:     Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-mips <linux-mips@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 5:58 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Let me know what you think and if this is something acceptable for
> just after -rc1.

How many conflicts will this result in generally? I like it, but I'd
like to have some idea of whether it ends up being one of those
"really painful churn" things?

A couple of conflicts isn't an issue - they'll be trivial to fix. It's
the "this causes fifty silly conflicts" that I worry about, partly
because it then makes submaintainers inevitably do the wrong thing (ie
"I foresee an excessive amount of 'git rebase' rants next release").

Also, it looks like Google doesn't want this to happen. This whole
series was marked as spam for me.I'm not sure why, I don't see
anything odd that would trigger it, and DKIM and SPF both passed.
Maybe it's you, maybe it's Google, and maybe it's the infradead SRS
thing.

               Linus

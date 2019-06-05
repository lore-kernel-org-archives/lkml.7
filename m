Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D297DC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA372070B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559765827;
	bh=D1c0P3ohnjLxpAXK1nDgqeyd/ANTnP2rU7wbkj4VGws=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YpgC7uyB7aTbFyXnEJdDMDR7kTFGr8pKbTCXKUMEqJxWegKpfufCXGaKpvE3lxbK0
	 /h+LVurodAD0kJ26RtftrsIe5vnCIkAm9gEHvSCXlS5c6W7kyhqFa1c9czhtN4v23k
	 ptXrkUiB/bQ5TF5GIke37ZF9sczbkB1J4A9xZzNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfFEURG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:17:06 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34731 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfFEURG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:17:06 -0400
Received: by mail-lf1-f67.google.com with SMTP id y198so9575789lfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 13:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lAgnsEnKeCxY9u014rJT1VaHWqSctLHeKnZqo2hzSG8=;
        b=RG30N6aoY395YurZq4ybtnNRM9wlIxtGe/8kU8b/tgTboXtztfw9Hjjspt4Rs+ny5z
         YMl1H3wa17kRy73GosnYqgk2HhP2PBpl7z1UpnWxC3rTqCyB8vRcNnwk7iLCE5J5vKTx
         XmjM1HtA2Ml6mzEsGoV+kvNly1eZynxjS6LBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lAgnsEnKeCxY9u014rJT1VaHWqSctLHeKnZqo2hzSG8=;
        b=hlS8gfL0NyELVXIyz7YmXtqQI7K3LskccmwMJ3lFWddWhHkyXYHELYNKCbZ82VJGrP
         ANt21GHfmy12AD36jpX4vVGzWOv9fxzxT6DUYMKB7GFFJVbTteATlD8aPZZ6wELvNb43
         B9Ti7Djw2hAX5EVobuzhOaeyemK0f3sWDnFIQN/ghdgEXGFOm9uw1hIpy8NmoxMp0ZWT
         YUhnyCuK0gMfk9VkrfAJXPfxS8iAnknJHAxYxALgwAtJNvAcuFKW9fw+34ZP1LXa+3Ge
         ZH2QFTZerNgCr4XFcdqse9wDnEZPXZfZCas2+BFbZCz1kT49toHn6by2s/Egr+nD3y+I
         H7lQ==
X-Gm-Message-State: APjAAAXGJO1E5T9/wetlREs7T5ASxmNt5Llo0hdptmeHHfh0YZXjCpGz
        rm2kNjffGDzqZUrckaeAgFI7yp1s8qg=
X-Google-Smtp-Source: APXvYqwGM7h6j981ADn5752D5vAjP4eBExq8TwFlIrI2DXutWEKdwD3xNGMcyMlVlg44Yn7SEmkqzw==
X-Received: by 2002:a19:6a07:: with SMTP id u7mr18091562lfu.74.1559765824548;
        Wed, 05 Jun 2019 13:17:04 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 80sm4383770lfz.56.2019.06.05.13.17.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 13:17:03 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id a9so18656672lff.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 13:17:02 -0700 (PDT)
X-Received: by 2002:a19:ae01:: with SMTP id f1mr20922609lfc.29.1559765822588;
 Wed, 05 Jun 2019 13:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjPqcPYkiWKFc=R3+18DXqEhV+Nfbo=JWa32Xp8Nze67g@mail.gmail.com>
 <20190605134849.28108-1-jglauber@marvell.com>
In-Reply-To: <20190605134849.28108-1-jglauber@marvell.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Jun 2019 13:16:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPbMBGWiTdC3wqXMGMaCCHQ4WQh5ObB5iwa9gk-nCtzA@mail.gmail.com>
Message-ID: <CAHk-=whPbMBGWiTdC3wqXMGMaCCHQ4WQh5ObB5iwa9gk-nCtzA@mail.gmail.com>
Subject: Re: [PATCH] lockref: Limit number of cmpxchg loop retries
To:     Jan Glauber <jglauber@cavium.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        Jan Glauber <jglauber@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 6:49 AM Jan Glauber <jglauber@cavium.com> wrote:
>
> Add an upper bound to the loop to force the fallback to spinlocks
> after some time. A retry value of 100 should not impact any hardware
> that does not have this issue.
>
> With the retry limit the performance of an open-close testcase
> improved between 60-70% on ThunderX2.

Btw, did you do any kind of performance analysis across different
retry limit values?

I'm perfectly happy to just pick a random number and '100' looks fine
to me, so this is mainly out of curiosity.

                       Linus

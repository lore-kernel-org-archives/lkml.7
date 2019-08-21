Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B85C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744E822CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6B98DFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfHULUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 07:20:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43043 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfHULUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 07:20:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so1165282pld.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 04:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sj3vybXlMQvoxOUao0lktce4iPTDPPDmKNm+ajxk4V8=;
        b=I6B98DFnHujHQRvScmKkTNQY/o0aPuSa3GXtxYHjX+adoN//FqCUcVSxhNV91lcj3X
         lMy3WtpEhhxi7MCEYfUxPbJHkzc+KE24cPGttnEqcKiD8H2z33nJ0Q7BBauJf11ufcoG
         X9GpedEX3o5N+I7Epw1Tqydnkzkj3kFMFNPE1HeNC4QIQdRB3EYd9WQmDZUl1Yclisqe
         VbeUSL+fTpxFAjVuXNA/DO2aHBBy4ecq7IINPGanWffC19pBXkxu7UfMbcLjcVMRc9PB
         qCYfi9TIj5G0kkoKpUpAmizaT+mLRI024X+lDqS3lCMZBB5pEibQQpQitG1mMnlF9UOw
         q29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sj3vybXlMQvoxOUao0lktce4iPTDPPDmKNm+ajxk4V8=;
        b=BczYIoZID5d76K8Y4aSZ9MxS4IEYJIU754niq18G9GZARMQJ9C/VzyCHUjzR52hapo
         q3jcTuscGgESRlJU/DP3oAXCiN/77F4/hBCPDhTbXx7VSxE8GbptfXI2zxz2cklPYZnV
         cpwV8TxijnzBSVZpszCeDa6cIMYL8Nnw5RodUQ3GZfMMNOKFWQ6JwpFlPeuWJ6MEeyyb
         8YVnpBLuIgNM3y+SdE5/z4qTWBBC2QYoI5y3RbLGLZmlFKtZFehj6f53twxeA8hM938W
         TSj7EJkxJ8jhfS/7WBwRH8T4nB5MOXSt726faR05eWzt1qjeS9zIyOUEClK9ZGweQNCE
         WZeQ==
X-Gm-Message-State: APjAAAVj0n3k7I0sMLWicdJdrAoqDKn6rAUMYa6DpvRJF0qFvMOM+9uf
        8dZ7rVv5h3jAuFSOAb6ueM9dxCqC
X-Google-Smtp-Source: APXvYqxLiwCbAhT6RtH96Edu0QuVNZ1lhSIMtzvsvplPUfEHlZPyPQkfpkiazOsNH/utUt5+AqbYxQ==
X-Received: by 2002:a17:902:110b:: with SMTP id d11mr7155736pla.84.1566386444549;
        Wed, 21 Aug 2019 04:20:44 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id w26sm27216990pfq.100.2019.08.21.04.20.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 04:20:43 -0700 (PDT)
Date:   Wed, 21 Aug 2019 19:20:40 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] sched/fair: eliminate redundant code in sched_slice()
Message-ID: <20190821112040.GA32150@iZj6chx1xj0e0buvshuecpZ>
References: <20190816141202.GA3135@iZj6chx1xj0e0buvshuecpZ>
 <20190820135055.GR2332@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820135055.GR2332@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 03:50:55PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 16, 2019 at 10:12:02PM +0800, Peng Liu wrote:
> > Since sched_slice() is used in high frequency,
> > small change should also make sense.
> 
> An actual Changelog would also make sense; but alas.

Thanks for your time!

About the changelog, I admit that it makes little improvement to the whole,
It is a so *short* function, I also don't think it can produce any visible
improvement through any kernel test tools. But as you can see, the redundant
intermediate operation indeed exists. There's no reason to let it exist any
more - make code clear and easy to understand if possible.

Best Regards,
Liu

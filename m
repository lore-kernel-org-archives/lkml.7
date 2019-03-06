Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C35C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BCC20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551886177;
	bh=Ac940CVAV8RCwd2xa+gSn6YMyTUPrgcG1OeIjJ1YbLU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sp7kHg3043wCy0SRMCCPnEv69uunqNucU2ufI5DPThk2sHGs5x+Y6zv1YNOYIp9B4
	 87B716aHJel3al+icEG8lCPisxKmWtCxSB2If0+peOnipf0H483TonbzhlluGFhSmQ
	 Np2lzaPIbMcRSw+AUa3J8+RsZ/T6VpMeXqCTAjtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfCFP3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:29:35 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:33047 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbfCFP3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:29:35 -0500
Received: by mail-lj1-f171.google.com with SMTP id z7so11270630lji.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 07:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kGPGVtGTvvx9A3lpOP8PLA6LKxELrkN3SjSpKy5Dnbo=;
        b=K06aNX/op6Os+eaxQLtAXTT2s5VF/1bEGW1O76+78I+sIDe5+sf7ARqzkR3OW2UGNE
         eT4CTKh+TOEG/jD86+CgeBXe9qVZhBF+6g/Z0iOl/l0kGgq76N3lAFFn567D6pMgyzmP
         Pi2l7fBpTUQpLKHayIDvWa/2xea33kHaQIESo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kGPGVtGTvvx9A3lpOP8PLA6LKxELrkN3SjSpKy5Dnbo=;
        b=PF7/7kF4zBxFVEJwdp3VGJmNAmDUdgyGWqsiZ3ZLSO5Mv4Z8ETj4ADC/U1hskmo1by
         9E0MBtaXC+iZPQL79E21ZuVQJY8SaXBjwAsSFN1qFCkB1Bo2ekJgFMzy+Yp9HujgMrIG
         p6vFuCUXfQavW8BTk3A/xO+gSoUtx8R07Wm2wEBBe4zVClCeqqdMAasmG131YE8QKsLu
         X64TG9BI+IYAne0h3MucavhD6fCzL/WruKaTPxHCR1EneBNXO9oGvzP2GZiuWxXJb4XU
         fsH79dADYVPNgSTL7y1YeSrOw6rD/jHhG4huuMnBZoGHiE8ZzQEpj9PAg4snQKlp13lT
         VkOw==
X-Gm-Message-State: APjAAAVJ2o0N+58ReVaLdGCfkE4M41YWoqUIMUcuw7w+Ko/RmlUcwWVu
        9qc3d69VfO6y9rUcK9ZtUKatEbk3ros=
X-Google-Smtp-Source: APXvYqzSME76nekAMnQVdPiUma7K+TCL9mqw0KCcrRyHA/T01pYfkCgzt9uSuxgvz7T7+R2CN3DYzQ==
X-Received: by 2002:a2e:240a:: with SMTP id k10mr2774057ljk.31.1551886172751;
        Wed, 06 Mar 2019 07:29:32 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id l72sm370752lfg.75.2019.03.06.07.29.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 07:29:31 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id z25so11265049ljk.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 07:29:31 -0800 (PST)
X-Received: by 2002:a2e:9117:: with SMTP id m23mr2738620ljg.94.1551886171237;
 Wed, 06 Mar 2019 07:29:31 -0800 (PST)
MIME-Version: 1.0
References: <20190305123457.GA2839@gmail.com>
In-Reply-To: <20190305123457.GA2839@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Mar 2019 07:29:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiYtq87t3ZbGXjDfh26b4_Two0OqwyM8p=CzdR56v-_zA@mail.gmail.com>
Message-ID: <CAHk-=wiYtq87t3ZbGXjDfh26b4_Two0OqwyM8p=CzdR56v-_zA@mail.gmail.com>
Subject: Re: [GIT PULL] locking changes for v5.1
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 4:35 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> The biggest part of this tree is the new auto-generated atomics API
> wrappers by Mark Rutland.

Ugh.

I'm, not entirely happy with this, but I guess I concur that the
alternatives might be worse. Pulled,

                  Linus

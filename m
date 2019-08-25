Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE771C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0262080C
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566758351;
	bh=kDCh9mzfUrRESeYgomsEW2oqRq7sfehdToclHVlRROg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NFA5cH5CvifqK+5fpz3KmcOaqq61trG9+uVIQL/fAROUtRr13yVwEfqIQGbxQQ3MN
	 JQZXwJgMw2wrZtMWK2n/YClQPb16BbfgZIq1K0D5Lf1WGvl9Z83YLqE0r5kVM0M9yR
	 FUuwX8OEILFDwFL0T0ZTUVLS8b7WCIz9wkxkAHMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfHYSjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 14:39:10 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40387 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfHYSjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 14:39:10 -0400
Received: by mail-lf1-f65.google.com with SMTP id b17so10628032lff.7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 11:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RoUTgETkcx7Vhs/SP1yJ/Apa3oDDX3O3+yJGczQFiLg=;
        b=Yf2pg7304yDjjLPNggLMdp2l8IiEKAdtJXdj0uqfLbp/gf9ObfAkpqdpSoL+kw3JKu
         Gjl95CcMVfwlZeeEubPvjS2TFFLkBjzsluaJuZXtPetfUpnsX6lmhMPBAnVhqIrxvMjv
         qO0m4idePPcONX18tVi8SK8DqmNjN+bAYyqqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RoUTgETkcx7Vhs/SP1yJ/Apa3oDDX3O3+yJGczQFiLg=;
        b=boBEZp5w38Z3ZWPCWQOGDXQEbNx8sJxLtbynywSCfy6l78y4A5yg4ReNYqiylGI106
         WQ33zPpHEcx5SsCSMbRaBIydfMCy4qzOLcc8n5zrjATzfVZ2DxjCk13+e7LsV+9JqUeO
         vIeDEMZWczYDEzwUxcaC6zdzBNkgMRCNRlKtoPTAugJcKf5qzptili9/qgq2PdjhVVA/
         JWuviz81LriMS7HTuwhxDZgYqQT7+eyw2Mpsf6i3msOluMBn88MT8gzdkGC+aoC8Q6Rr
         eRBLQfh/mJTOtABAI56Ar4XkMc7YJRkbkBwvdA8zjxOO0PHXEFMqFIK2rf99lpz/0M0B
         uWSQ==
X-Gm-Message-State: APjAAAUO6TFbkdY47aotYCxHKIppxYxYmffZrJ+kT7ar/BBZKceBu2CO
        KsvKJHkmwqaMopo/mOZ/I5I4M4RsewI=
X-Google-Smtp-Source: APXvYqxjP5xNpZSYYN4iXP8ZIMDPOzjTtsW4WrePenlCndkkg6UJfEW+cNYdoB55PCKzZO0Jm72Lgw==
X-Received: by 2002:a19:f711:: with SMTP id z17mr8625831lfe.4.1566758347585;
        Sun, 25 Aug 2019 11:39:07 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id n187sm1677419lfa.30.2019.08.25.11.39.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2019 11:39:06 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id b17so10628014lff.7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 11:39:06 -0700 (PDT)
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr8901287lfp.61.1566758346403;
 Sun, 25 Aug 2019 11:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <156672618029.19810.8479315461492191933.tglx@nanos.tec.linutronix.de>
 <156672618029.19810.9732807383797358917.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjWPDauemCmLTKbdMYFB0UveMszZpcrwoUkJRRWKrqaTw@mail.gmail.com>
 <20190825173000.GB20639@zn.tnic> <CAHk-=wiV54LwvWcLeATZ4q7rA5Dd9kE0Lchx=k023kgxFHySNQ@mail.gmail.com>
 <20190825182922.GC20639@zn.tnic>
In-Reply-To: <20190825182922.GC20639@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Aug 2019 11:38:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhyg-MndXHZGRD+ZKMK1UrcghyLH32rqQA=YmcxV7Z0Q@mail.gmail.com>
Message-ID: <CAHk-=wjhyg-MndXHZGRD+ZKMK1UrcghyLH32rqQA=YmcxV7Z0Q@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for 5.3-rc5
To:     Borislav Petkov <bp@suse.de>
Cc:     Pu Wen <puwen@hygon.cn>, Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 11:29 AM Borislav Petkov <bp@suse.de> wrote:
>
> My lazy, sticky Sunday brain could come up only with this:

Looks reasonable, except I think this only runs at boot, right?

I _think_ the boot CPU is magical during suspend/resume, and doesn't
do the full CPU bringup.

Although I guess this would still report it for the other CPU's? I
didn't check if this gets done during CPU bringup of secondary CPU's.

               Linus

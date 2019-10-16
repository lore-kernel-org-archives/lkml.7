Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC593ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830EC21848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571268698;
	bh=A/VXXDacx1kqou9nKcw4GFqVfJ7tLFJBU2hTwpNlA5I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AXR12M2qm6pCW/8D4bTSo6a2nh2N3KN/IBiJUyDcjR7QBNb9LaLiq0XBaIg86MD0o
	 n7B0CawvZHh2CLbCaE15hs0Mv09ovQaR3fpEs/MwZ5Q/UFZiAQLHLvHASQGJATc8DP
	 RzFb+DNSU1ht+YmkgigqOrqkSGrYJw6q324psVG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395469AbfJPXbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 19:31:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391320AbfJPXbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:31:37 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDAED21848
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 23:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571268696;
        bh=A/VXXDacx1kqou9nKcw4GFqVfJ7tLFJBU2hTwpNlA5I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dlspdCHU4LVIcAl2JPk400LYQA5S+LGk7Svch78fix1ZXCXq0LV1GnbJVhx/1maLg
         euO+Fup7/lpvRgZE+lDJG1MaE1ru4gSfEOt1c19gNxyScHuL4kT1Hea1lzrpbuKo3q
         PEdmC20NvGxNP5Msq2ziP+8CHpGBYlIFirTalLTg=
Received: by mail-wm1-f49.google.com with SMTP id 7so547968wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 16:31:35 -0700 (PDT)
X-Gm-Message-State: APjAAAUirlTzv7ItfzJ824F44fR1bg05ZTun8Vl1DBzd+NOEzQFRAOWJ
        unj/lxahDlwGsuxvtmba5JYTx0dKd18h+EChrqE=
X-Google-Smtp-Source: APXvYqzSBdJDlHGHj8485OYT1LMO8jDZplpDh6E5wbK61+sx45sTIorAXDjQ6YVUdCRXR4Mjeg4Q27c2e7ZW7GipVew=
X-Received: by 2002:a05:600c:2387:: with SMTP id m7mr141611wma.137.1571268694414;
 Wed, 16 Oct 2019 16:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191015191821.11479-1-bigeasy@linutronix.de> <20191015191821.11479-7-bigeasy@linutronix.de>
 <CAJF2gTSVxgc5kw22dfotoHF91HxyTKC4ETYLTskEfyn3rf=kCw@mail.gmail.com> <20191016073905.yv4xqoovrdrnrbp7@linutronix.de>
In-Reply-To: <20191016073905.yv4xqoovrdrnrbp7@linutronix.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 17 Oct 2019 07:31:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTXNK9sOXWLKAOXghzS7EYwYgJ21AR7+Q=Do-xKnNMn2Q@mail.gmail.com>
Message-ID: <CAJF2gTTXNK9sOXWLKAOXghzS7EYwYgJ21AR7+Q=Do-xKnNMn2Q@mail.gmail.com>
Subject: Re: [PATCH 06/34] csky: Use CONFIG_PREEMPTION
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx for explanation.

Acked-by: Guo Ren <guoren@kernel.org>

On Wed, Oct 16, 2019 at 3:39 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2019-10-16 07:29:34 [+0800], Guo Ren wrote:
> > Could CONFIG_PREEMPT_RT be supported in csky ? Any arch backend porting ?
>
> It could. HIGH_RES_TIMERS is useful and IRQ_FORCED_THREADING is
> required. You already have PREEMPT(ION) which is good. Then you would
> have to try and my guess would be that some of spinlock_t vs
> raw_spinlock_t could require changes but we should have lockdep support
> for that which would make things easier.
>
> Sebastian



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

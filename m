Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF26C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 18:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA875208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 18:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="a3Z6UDbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfDTSr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 14:47:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46062 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbfDTSr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 14:47:58 -0400
Received: from zn.tnic (p200300EC2F112E005004D8DB0C93AF00.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:5004:d8db:c93:af00])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8EE981EC014A;
        Sat, 20 Apr 2019 20:47:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555786076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kezXqjomNvVpvnqVbYwMPJyC5R0S+PZxCDzFQMuq17A=;
        b=a3Z6UDbIJz2mBZiHIAxowGzw/Kfwqru0kM+wnt1Jkd+wagnud8oofaAJnj4OB1/hYneAC2
        dHMKZAfpj4mI/leTVa5YUc8hoXDldh7TPhLcGByo6R84pM6BKU/l46Q/7VLvxP7OEjfJc2
        tDqp7c5gLUdmqe/2KUFSKgdGqt/liPU=
Date:   Sat, 20 Apr 2019 20:47:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
Message-ID: <20190420184751.GE29704@zn.tnic>
References: <20190418220229.32133-1-tony.luck@intel.com>
 <CAM_iQpUAfiP2pitFpc-wSy4f_JQo_Wh3BQDxEsT2wwSHDPERow@mail.gmail.com>
 <20190418232910.GR27160@zn.tnic>
 <CAM_iQpVWvg-U6hzKsCPXdObiwKJhQ=BkGDDeP+p671cCWK7QFA@mail.gmail.com>
 <20190419002645.GA559@zn.tnic>
 <CAM_iQpVk564gCu_FBKvYVQjA1hGZ4YXB6ogrSFt=qZwiWen2tw@mail.gmail.com>
 <20190420091313.GA29704@zn.tnic>
 <CAM_iQpUaBOS92u7K+hzzRX5hw0Kbrp-0o0DSfLwSGBhenntVjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM_iQpUaBOS92u7K+hzzRX5hw0Kbrp-0o0DSfLwSGBhenntVjA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 11:18:46AM -0700, Cong Wang wrote:
> You didn't answer my question here, because I asked you whether
> the following change (PoC only) makes sense:

I answered it - the answer is to disable CONFIG_RAS_CEC. But let me do a
more detailed answer, maybe that'll help.

The PoC doesn't make sense.

Why?

Because if you don't return early from the notifier when the CEC has
consumed the error, you don't need the CEC at all. Ergo, you can just as
well disable it.

Because, let me paste from a couple of mails ago what the CEC is:

"CEC is something *completely* different and its purpose is to run in
the kernel and prevent users and admins from upsetting unnecessarily
with every sporadic correctable error and just because an alpha particle
flew through their DIMMs, they all start running in headless chicken
mode, trying to RMA perfectly good hardware."

IOW, when you have the CEC enabled, you don't need to log memory errors
with a userspace agent. The CEC collects them and discards them if they
don't repeat.

If they do repeat, then it offlines the page.

Without user intervention and interference.

Now, if you still want to know how many errors and where they happened
and when they happened and yadda yadda, you *disable* the CEC.

I hope this makes more sense now.

> I knew disabling it could cure the problem from the beginning, please
> save your own time by not repeating things we both already knew. :)
> 
> Once again, I still don't think it is the right answer, which is also why I
> keep finding different solutions.

This is where you come in and say "it is not the right answer
because..." and give your arguments why. I gave mine a couple of times
already. I never said this functionality is cast in stone the way it is
but there has to be a *good* *reason* why it needs to be changed. I.e.,
basic kernel deveopment. People come with ideas and they *justify* those
ideas with arguments why they're better.

> I know you disagree, but you never explain why you disagree,

You're kidding, right?

https://lkml.kernel.org/r/20190419002645.GA559@zn.tnic

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

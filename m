Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8036C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803AE222C5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573572892;
	bh=NXxQGx4xYPOgDi72pQ1e8SYBbjofmu3GeBX8uMXtDiE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1azsZHqlB3zu7HBFx5vFdFKqt1Ms1Ye9V0CMeUlPjcTl5YIoH7hIHNVtWw75kEGPS
	 BzhYwsqAWsuYMUiSMiDm9XSGB3+7qUV4UYtTCu9366VwF30y7vRqTSVvoXYET1I01u
	 IIz0f1RzAs4mXeDVx1fWHhM4MTKX5kHM/dqtiopE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfKLPev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:34:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfKLPev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:34:51 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 765EF222C5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 15:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573572890;
        bh=NXxQGx4xYPOgDi72pQ1e8SYBbjofmu3GeBX8uMXtDiE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wsZpjapYXgVFiSA9t9Efblth2NkCkJ5IrTC5WxEiG9TUBJhRfij1weVmn/b04RCvQ
         ak0Dx8FUonm7p/YrmrfS1aIXFp/5uJZAdIfCMkJpEVkh+CKDZHX34YUU/6TN3dh6Ec
         g9kTJAbXZRE6HetiDDkzgIMIz5HzzgHEVjxaGoQM=
Received: by mail-wr1-f49.google.com with SMTP id e6so19087054wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 07:34:50 -0800 (PST)
X-Gm-Message-State: APjAAAUF0qMCd1Oea0ho5IQfqiP1dTWcHIDXATDWfU4s/q7Mk4ybRi7Q
        +VE+AqxKlKqqSzSABlt4QbKnUadnTrmSEiWwhTODvA==
X-Google-Smtp-Source: APXvYqzv0fZBveLxP73FGvvJtEH9sxjCfprH44FcBrfJ/ztv9IXjf+e1+BTgvfTFFJHubzedQecifCFELt8pGow3G0Q=
X-Received: by 2002:a5d:490b:: with SMTP id x11mr23328228wrq.111.1573572888977;
 Tue, 12 Nov 2019 07:34:48 -0800 (PST)
MIME-Version: 1.0
References: <20191111220314.519933535@linutronix.de> <20191111223051.570732877@linutronix.de>
In-Reply-To: <20191111223051.570732877@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Nov 2019 07:34:38 -0800
X-Gmail-Original-Message-ID: <CALCETrWcDpoX-gkFBP8NkRyizbS+=3PcD_x6r6pXVAGoWO6-EA@mail.gmail.com>
Message-ID: <CALCETrWcDpoX-gkFBP8NkRyizbS+=3PcD_x6r6pXVAGoWO6-EA@mail.gmail.com>
Subject: Re: [patch V2 01/16] x86/ptrace: Prevent truncation of bitmap size
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 2:36 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> The active() callback of the IO bitmap regset divides the IO bitmap size by
> the word size (32/64 bit). As the I/O bitmap size is in bytes the active
> check fails for bitmap sizes of 1-3 bytes on 32bit and 1-7 bytes on 64bit.
>
> Use DIV_ROUND_UP() instead.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>

Reviewed-by: Andy Lutomirski <luto@kernel.org>

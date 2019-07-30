Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B1DC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8415B2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564517375;
	bh=owhaHAi8Q+HEfzaC8fznNFazW35t/rwFZdtzy8W8OpU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sz3ChVIOeNw/tnYn9f2tVWndAjFpWfuDiHu8GFUz2U9HoL9idBl+Nwm6Ti1GJuR6D
	 QhNvsEZeaj98c/b5l6oNExkQ4EZVlBjMiZ1q+eP1jgV/vknT0tnQOJx6SQiO7pOr7Q
	 lQUtp6jJ/vTglZFICHjfUvM+YLL4lCEA3EXne2Y8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfG3UJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 16:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfG3UJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:09:34 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C57F22089E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 20:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564517373;
        bh=owhaHAi8Q+HEfzaC8fznNFazW35t/rwFZdtzy8W8OpU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SbUIVUvERGICwyRwzMme97c6NNtZVOw6nH0CKo1Anov6gTOZ/+GwZA89o5mYv0LmB
         BjuLlrdkgXd0k0sFd+2FUyY30jhlb8p/pV3kx7jFvabreyppC31UqTcDE7PMWylldZ
         LVDN2Ndud+aPf6cjVAIkTCt8I0OE7nC0GWtBvXFo=
Received: by mail-wr1-f51.google.com with SMTP id 31so67139740wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 13:09:32 -0700 (PDT)
X-Gm-Message-State: APjAAAXI1VKPlkF3hOPNYUQzmx2hwmZifoCf6yH38O5z2MWX+HsTBplu
        M9XvGG/zRl8G0213nuz/9kdGZDO5RXUPx6sZvungqw==
X-Google-Smtp-Source: APXvYqzgab40lz1+/BiKkPmDAG4zmFHV8d0sHXwJQ99NZz81h6SDKNg/C2IKSpBGgEg8meiI0Xx98tApM9DV01WDKnw=
X-Received: by 2002:adf:cf02:: with SMTP id o2mr109678011wrj.352.1564517371335;
 Tue, 30 Jul 2019 13:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190728131251.622415456@linutronix.de> <20190728131648.786513965@linutronix.de>
 <20190729144831.GA21120@linux.intel.com> <alpine.DEB.2.21.1907301134470.1738@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907301134470.1738@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 30 Jul 2019 13:09:20 -0700
X-Gmail-Original-Message-ID: <CALCETrXmu8BtZ47AE-qo2bax9n1PyOM90yLSjkzE6rekbxv9zQ@mail.gmail.com>
Message-ID: <CALCETrXmu8BtZ47AE-qo2bax9n1PyOM90yLSjkzE6rekbxv9zQ@mail.gmail.com>
Subject: Re: [patch V2 3/5] lib/vdso/32: Provide legacy syscall fallbacks
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Bolle <pebolle@tiscali.nl>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 2:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> To address the regression which causes seccomp to deny applications the
> access to clock_gettime64() and clock_getres64() syscalls because they
> are not enabled in the existing filters.
>
> That trips over the fact that 32bit VDSOs use the new clock_gettime64() and
> clock_getres64() syscalls in the fallback path.
>
> Add a conditional to invoke the 32bit legacy fallback syscalls instead of
> the new 64bit variants. The conditional can go away once all architectures
> are converted.
>

I haven't surveyed all the architectures, but once everything is
converted, shouldn't we use the 32-bit fallback for exactly the same
set of architectures that want clock_gettime32 at all in the vdso?

--Andy

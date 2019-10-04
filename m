Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5688C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC855215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570220796;
	bh=DktC8p2WWElHxSqetvFIVQIL/iR9L/8okdeNpDsi28A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QBV7UzQM5qNbkuaxm1R/jtrhDCt0Lqz9TnmnFCgRtzI78ynfBNyoxuEKdKmiOMro8
	 Z72jdH85ZmuhmugiQjgNhaxcHMzN7mSEMGKkCOzMrYLlnT2cuG08vnjnXK2RI95FL9
	 ltBvKxs3y7qoXr3z5Z8cP/lR9Hc4cgYS1HAv6RX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388068AbfJDU0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 16:26:35 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34381 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387689AbfJDU0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 16:26:34 -0400
Received: by mail-lf1-f66.google.com with SMTP id r22so5366888lfm.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 13:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZsYBLeosgG67nHnpA9UFSWQuiStl1sE/t4aS6dfWhz0=;
        b=Cm3I98WO9VJ2gEAchiqSnXcfMomS33yaHkHBu8IWjlPGtMrH4PRP0yXEbeqQPW4Foe
         4KKAgooSz/Eo3cM3cNGdjpi632jSAX1QihEpm3jasmmntSgg4Vl8lwIorhfqt+YCfWnu
         7uBJqFj+Qs8nLZKj7IR6LVuVmdEKC7nRN9B1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZsYBLeosgG67nHnpA9UFSWQuiStl1sE/t4aS6dfWhz0=;
        b=igjA6w75a4teNdUKxr4BjiX79m0kd58n+Jf482OHyBG+o9PbryrDjbL56oj6yZpzd3
         7zpOvOA/rMRtEGCYOH9t0nExuSMUTGuk4Jjv4gwxLyejHx6tWtO7fCrOa9MD2E1f8M+9
         7R8e+ZBQyXFfC/9GHz7JZcVU3qVQh6Aw9dAmnBQdARRLhCfveC9VB9v58QEvS3njGfpP
         pWAtcpyzE2RI/E/ZUfNJSdv1mL0hTBvblqmovzHo+67Q1tf7AIhvkH6Y6Ui5jDAGaVkX
         Swwb/JQymknHHjGqkcYBIkEMugiigs1rNVuQYVc1I7F5602trdgMgiv0Hc6otGNL0Kvb
         dlrw==
X-Gm-Message-State: APjAAAWKwPqBd0+MoNcenbRgXvnEh+/jykYaP0JERCrSmzNyWe8pz+N6
        gvLXUojG0QvcMPrXBYaYww8CY/yP6j4=
X-Google-Smtp-Source: APXvYqzCnQkLIfXrePqwqKXPVQYnleLf5TuYjdUKoysx0dIOuvZwxdHwzN1v2zIRgvjrLuCziBeoWg==
X-Received: by 2002:ac2:46d0:: with SMTP id p16mr9763463lfo.190.1570220792293;
        Fri, 04 Oct 2019 13:26:32 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 202sm1492950ljf.75.2019.10.04.13.26.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 13:26:31 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id f5so7751221ljg.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 13:26:31 -0700 (PDT)
X-Received: by 2002:a2e:2bdb:: with SMTP id r88mr10689784ljr.82.1570220791008;
 Fri, 04 Oct 2019 13:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1910041036010.15827@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1910041036010.15827@viisi.sifive.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Oct 2019 13:26:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9S6PopwTdeFPybnapKwL17ux80e9mbLXNo52e4B8rHg@mail.gmail.com>
Message-ID: <CAHk-=wi9S6PopwTdeFPybnapKwL17ux80e9mbLXNo52e4B8rHg@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V updates for v5.4-rc2
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 10:36 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> - Ensure that exclusive-load reservations are terminated after system
>   call or exception handling.  This primarily affects QEMU, which does
>     not expire load reservations.

Grr. Can somebody talk sense to the RISC-V architects?

Copying the PowerPC model was broken. PowerPC has now become the
absolute worst architecture out there wrt just about any memory
ordering issues, and the exclusive reservation is just another example
of that.

ARMv8 and even alpha got this right, and clear the reservation on
return from traps/exceptions.

Why did RISC-V copy the power model? (Yeah, I realize that ARM did too
originally, but they learnt from their mistakes).

Oh well.

              Linus

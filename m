Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC7AC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98DE2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560452877;
	bh=QLdqDQmRPxVrCZYy0W6he9k6Fiy66AEvu4ykWlMqvl8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ALSlCKp4wD8TctgfMy84ApwX78J12ED6bBpu52wRumGEVAZ3FZCGyPsJlMSoBtWUF
	 FU3jGktw2lentf1Wqd2LhPgkK9drwhVVM399xdShFPi5UFm7EkqGRk5QrWREGeBvL8
	 YrKzBY42wZubboXuHviua+seJHyLyy42FHG/6M04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfFMTHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfFMTHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 15:07:55 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A1402173C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 19:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560452874;
        bh=QLdqDQmRPxVrCZYy0W6he9k6Fiy66AEvu4ykWlMqvl8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x60ZbHpp223igiSLc5q5Jj7ywt5bmr2i+DpWOt3w2VDiy6oOaYuDQuGUd3pt2pzSI
         HFExm7CghqlSXWJV1cLBsxD9UuIATWdZdRLFwqbpIpj2gJW67/yItx+gqkVZLccQKb
         52VZHWhallDLgiKJwP1WcfbYzlnm3VXZB/v8hOFw=
Received: by mail-wm1-f53.google.com with SMTP id c6so11260744wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 12:07:54 -0700 (PDT)
X-Gm-Message-State: APjAAAUxAs4lUfvA88nY/u3JKisIaOK3pnd0tdPm8u5KHR1NjHDxuUgm
        gfa1RQLGsPGohLZLJ4gYcUfAT6Rau0+2PNNknFPIRg==
X-Google-Smtp-Source: APXvYqyB56oi15p6KqGsR+j3YdT44dOp7+9anVhd6nyuR9Jr9zxwY+DcMwh0aHg4dnVuT/1cPNjKuq28mw8Me6ERQRw=
X-Received: by 2002:a1c:a942:: with SMTP id s63mr4888086wme.76.1560452872970;
 Thu, 13 Jun 2019 12:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560198181.git.luto@kernel.org> <d28856fff74a385f88c493dafb9d96d2c38d91a2.1560198181.git.luto@kernel.org>
 <201906101340.AE18F49@keescook>
In-Reply-To: <201906101340.AE18F49@keescook>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 13 Jun 2019 12:07:40 -0700
X-Gmail-Original-Message-ID: <CALCETrVOzGCN+pjgsdd+x3APsrSGJzngfGeSWvqWy=XTQj3EiA@mail.gmail.com>
Message-ID: <CALCETrVOzGCN+pjgsdd+x3APsrSGJzngfGeSWvqWy=XTQj3EiA@mail.gmail.com>
Subject: Re: [PATCH 3/5] x86/vsyscall: Document odd #PF's error code for vsyscalls
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 1:40 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 10, 2019 at 01:25:29PM -0700, Andy Lutomirski wrote:
> >  tools/testing/selftests/x86/test_vsyscall.c | 9 ++++++++-
>
> Did this hunk end up in the wrong patch? (It's not mentioned in the
> commit log and the next patch has other selftest changes...)
>

It was intentional -- you can run the improved selftest and observe
the oddity for yourself :)  I'll improve the changelog.

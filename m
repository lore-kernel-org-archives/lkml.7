Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1CEC76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7D720693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563304461;
	bh=aGlm0mNVvjuXHK6DLjdqP7J32fmUwUm4qVrm9/YuvV4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nRmDLSfAIw0ZZROioFadV0kKOpF71P0/ztbLNan1xx8LOhDqO8+5zGnQtfCiciXLY
	 MAD0KztGCC/iu2UUsoqJwRbCA+I1YfoR5xAiLb89rcGgPKGglopN/HTipS+bas0rMw
	 NQXozPKF2B4li0r4qQJEt4nY1I9AOnBHRjPu5aPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbfGPTOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 15:14:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45773 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPTOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:14:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so21036057lje.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 12:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rzi+JrWYOGsut3jRglpj5XGk5dwbip2b5zr2IEOORsQ=;
        b=NDP+AiRbqFoE4Bm5bbT/neoI5d4JAEi6PzptAWbUc53rXNNZVneAKqYHClpnBnf9HW
         tLNwRGBOa4ywIBb+yKxs/Nq5Jvc/V3ekIE62VXA2NnPUnWJBJz1u5qBjSMBZ7AKObDZc
         KEv2XwVHDbea6qyaoed63pZMua/dqh/CKoKTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzi+JrWYOGsut3jRglpj5XGk5dwbip2b5zr2IEOORsQ=;
        b=fAcjY5V2QaCnEJJlWq6+gDPkuL36wkgjImETuxxM+BvUDXvQbX9j6+TJ0jJ4oUkjQg
         +RZroWeV1PAqlZfKgh0EXXciQOJOVxK5lkt3aUqZDhl0TZFCBFN2C1VLziN9BpYhNRWi
         0Kxv/AWY1vqAUNHXpn9v3PS3qNxSYQITx1vT7IcxSjNm+RX9P48Musw3D1UKutI6OR9r
         GiLWcaqhyScH1PONj/LxoSOrucc3YjJWkkcnCBkHFFnRygB8vyELygRZ4ooMCmI28vgz
         igUsCvHSNnv9sWQx36lY4Qpu4O+52JI+4VUtQ86xgaCRYRlUgrQfsNYXDwTDLYlAEibS
         o6jg==
X-Gm-Message-State: APjAAAWaKe9q+UFWxUOysE5fmaFVQns99+VkxB7DTOZDxVtHSQCZzGqA
        3lKzmMeV6wDc8Mn9C1wg/w0vzcbvxNk=
X-Google-Smtp-Source: APXvYqxo6whTS/ieaB6JTvsoc6uJKDMymqTF/duGXalDSxoE7SzJK2HmAwjPvEXU7YZM0+rdauOOyw==
X-Received: by 2002:a2e:720b:: with SMTP id n11mr18919355ljc.213.1563304457173;
        Tue, 16 Jul 2019 12:14:17 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id t1sm3928235lji.52.2019.07.16.12.14.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 12:14:16 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id b29so7305513lfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 12:14:16 -0700 (PDT)
X-Received: by 2002:ac2:4839:: with SMTP id 25mr15611221lft.79.1563304456035;
 Tue, 16 Jul 2019 12:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccPGqp4PmRkFk505QhDKHWn-ajxS0__Nk9VS32jV_+3Y2A@mail.gmail.com>
 <CAHk-=whY1J-LFvTa8ihiPNRSv1dwxPk9ycPCEhdcjsk7c=tGAw@mail.gmail.com>
In-Reply-To: <CAHk-=whY1J-LFvTa8ihiPNRSv1dwxPk9ycPCEhdcjsk7c=tGAw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 Jul 2019 12:13:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wip4gKuWrh-1Dj-B-t5V5uGLj4NRCgHtVGJ0A9DOaDCNw@mail.gmail.com>
Message-ID: <CAHk-=wip4gKuWrh-1Dj-B-t5V5uGLj4NRCgHtVGJ0A9DOaDCNw@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for 5.3
To:     Micah Morton <mortonm@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 12:06 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  - Please use the "git pull-request" format and then add any extra
> notes you feel are necessary
>
>    Yes, your pull request is *almost* git pull-request, but you seem
> to have actively removed whitespace making it almost illegible. It's
> really hard to pick out the line that has the actual git repository
> address, because it's basically hidden inside one big blob of text.

Extra note on this: you seem to have done "git pull-request" in a wide
window, and then copied-and-pasted it into your MUA.

So the diffstat lines are also very long, and then they line-wrap and
it all looks nasty.

Avoid this by either using a file for the output (that you then edit
for your own added messages), or using a normal 80x25 terminal or
something.

I guess I should ask Junio to add a "--stat=80" to the upstream git
request-pull script.

                   Linus

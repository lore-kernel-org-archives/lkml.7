Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38428C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 05:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0822B2075E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 05:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561181324;
	bh=Khk2ryW5FGWTH1eMHzTYRZ22W8+IVPnJOwo7Gxqfnq4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=S59OhGYOKV73Om96aEQpsB4HgMCmeAQUOWoM4kTueykZZLbZqG4lUUP4fU3aTPMDy
	 VWh59kZtD/TSKlhIKNtWNqN6eEeQCmeXQ3UyqZyywgn5vPXIFS2CxSHk4Yol/z93BQ
	 kDd6eyhr39RVcoUlj8o28kQ99Yz1CkApc66Ap1C0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfFVF2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 01:28:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46938 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfFVF2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 01:28:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so7744368ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 22:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jscPo8TLw/8GX2/Wq+p93dBdKi5CEMmizRgSzaFZ+5g=;
        b=RV5hiL0gnIdMvSbv394h7m+4u2c8eEkaetFH4NBbWNQBRjNaucNmAiBGeFf7sXN6n2
         9VLRDq5PuwpICMMDIu3BH/QYgLeT/vEA1bVOkYbWvFT90VgDzbJVrfl722rVqBv1pdzn
         leQHf0hkZUsPxc/dOKiu6Xu7FWrVKhAL4HW2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jscPo8TLw/8GX2/Wq+p93dBdKi5CEMmizRgSzaFZ+5g=;
        b=XCkCDLK+HN92EPq7QjT0Ab6ekpsWwCVi0P+UjXu1DDuA/eFUwzELe5ONgW9tHibyTl
         g9FRkZDAudAaUZymguPe2BX3TqPLf89x0RLHmXp8jNDGFevRnEvOPXI+0FSpJ5ujee+u
         5jujNeCl0388A7npqDovMQvvvvJY7EwNrkQbMBXlBKMrEW2t4tJVyE2bRvAYwpt8mmBq
         LpwwlnPEMFsGFGz6/BPL4tegXlMU7cUDt6q6ASrYoEm2okpYWke65BEc/n5SjnUSzz88
         pduS0WSxCbvp4gTr0gjMXPZFr6QVAGrLGzwhYupOkpbQdslsrJBIDJBVib5KY4bQs0P6
         CcAw==
X-Gm-Message-State: APjAAAUPTYw5w2eLiq0/Lqp4Ju79RP+ADWfhkiN7xAw5ctUcP0AHLHHf
        WEuPGc0RnrMVTUjegzJalvPy5SI/yVY=
X-Google-Smtp-Source: APXvYqyOyHzB/yMaNpQCw7vSp7jULLy3Xz4/86qyvQBZEMrIAJLrniMzufmlGY91WxyGxVXx5GI7zA==
X-Received: by 2002:a2e:9a49:: with SMTP id k9mr25531772ljj.78.1561181319231;
        Fri, 21 Jun 2019 22:28:39 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id f10sm646430lfh.82.2019.06.21.22.28.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 22:28:38 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id y13so6449502lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 22:28:37 -0700 (PDT)
X-Received: by 2002:ac2:44c5:: with SMTP id d5mr21048797lfm.134.1561181317672;
 Fri, 21 Jun 2019 22:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <a624ec85-ea21-c72e-f997-06273d9b9f9e@valvesoftware.com>
 <20190621214139.GA31034@kroah.com> <CAHk-=wgXoBMWdBahuQR9e75ri6oeVBBjoVEnk0rN1QXfSKK2Eg@mail.gmail.com>
 <CANn89iL5+x3n9H9v4O6y39W=jvQs=uuXbzOvN5mBbcj0t+wdeg@mail.gmail.com>
 <CAHk-=wjZ=8VSjWuqeG6JJv4dQfK6M0Jgckq5-6=SJa25aku-vQ@mail.gmail.com>
 <CANn89iLU+NNy7QDPNLYPxNWMx5cXuhziOT7TX2uYt42uUJcNVg@mail.gmail.com> <b72599d1-b5d5-1c23-15fc-8e2f9454af05@valvesoftware.com>
In-Reply-To: <b72599d1-b5d5-1c23-15fc-8e2f9454af05@valvesoftware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Jun 2019 22:28:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZ1grLwJsGD+Fjz1_U_W47AFodBiwBX84HECUHt-guuw@mail.gmail.com>
Message-ID: <CAHk-=wjZ1grLwJsGD+Fjz1_U_W47AFodBiwBX84HECUHt-guuw@mail.gmail.com>
Subject: Re: Steam is broken on new kernels
To:     "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 6:03 PM Pierre-Loup A. Griffais
<pgriffais@valvesoftware.com> wrote:
>
> I applied Eric's path to the tip of the branch and ran that kernel and
> the bug didn't occur through several logout / login cycles, so things
> look good at first glance. I'll keep running that kernel and report back
> if anything crops up in the future, but I believe we're good, beyond
> getting distros to ship this additional fix.

Good. It's now in my tree, so we can get it quickly into stable and
then quickly to distributions.

Greg, it's commit b6653b3629e5 ("tcp: refine memory limit test in
tcp_fragment()"), and I'm building it right now and I'll push it out
in a couple of minutes assuming nothing odd is going on.

             Linus

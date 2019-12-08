Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BEDC2D0C2
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 00:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F0924677
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 00:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575766693;
	bh=yFrXn5a6Pm82r9Pyt9R5S4hEloOxaSjyGJQA955foiE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vNf08yEpTVNp3FaS2nTB1UyRs1Rezn5sEvgpCsxp9nMSuLFdJbsTzNbE1wa7TOtqU
	 Izuim/wwuWYiDzS0YNoyQAPS7ypDJ6uVA9MCL6hRDfQeJqdH1Q4AuJYRQJF1TViZcR
	 WZkR/obcbKLr/MtmBRnUTljjdkm/YRdCyg5XDI+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfLHA6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 19:58:12 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43865 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfLHA6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 19:58:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so11619846ljm.10
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 16:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pjInLVbNXJAcoeCkZ2UVa8n0Yvnc+/klAZS5TAwHv4s=;
        b=h6ddV75ipxBKXFOA9CDG/DsvE2JTK3HbVomfQE6untuDafGb0uM3UTD+kBuTeURAJr
         YaLxU9OJ6BU0yKYe4O/Q1IYMqIaS6oyUAb7OTpsABdji+FCn80FeRKA9nWv9YeQerxr2
         Ixb3YlsXil8s4tHITSEfWE+Fn1dKsFgLFg/0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pjInLVbNXJAcoeCkZ2UVa8n0Yvnc+/klAZS5TAwHv4s=;
        b=T8emoCzMR1Z6OOHeO8r+VonScq+P8AfNksjmubtSx+YoKesiEVpZ7+3XjNcMbHk5bX
         cC/NJmO/Vcc6sM8JH3BSnSRbO0AR+Z98nNsBgh/iUS1Nw2bRtBibn3KJ93r+ehYI0V2k
         3gMDTEP4JR00PLKK8/37p3c59l8IX45ASmVA+aNGZLD4LdRxyNYfQ6X9+NGZOi1fuMfG
         Kk4DYZvs7zPqwko/kIoZEdOPiKkdvh+MrPhZ1aO8hhu6XlVxstyY3JsIwzoduuL0rnB9
         2OR2aeohrfmyU1kK7yS9HCY0cDw/Mv0HXh/kZ/Wuck7NoQ79MEUL/Uyo9idxiF6jCAW7
         9ezQ==
X-Gm-Message-State: APjAAAWfF4/Qnrt0PX+p0S95EeN57+ab3rUY4Y8Szu9XThFGy1NU8zk9
        5ASDBFU5isiJeKFG/cybFSWUh4vKBC4=
X-Google-Smtp-Source: APXvYqz3Ljo5EEh69i7hPSN466FW9TM8pplKVyZhkePw7E+qKK9x/jdleztq2IPJ+nWzyUBcHtFXXQ==
X-Received: by 2002:a2e:90da:: with SMTP id o26mr12722491ljg.25.1575766689081;
        Sat, 07 Dec 2019 16:58:09 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id y72sm2309573lfa.12.2019.12.07.16.58.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 16:58:08 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id e10so11636979ljj.6
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 16:58:07 -0800 (PST)
X-Received: by 2002:a2e:241a:: with SMTP id k26mr12682848ljk.26.1575766687450;
 Sat, 07 Dec 2019 16:58:07 -0800 (PST)
MIME-Version: 1.0
References: <20191207171402.GA24017@fieldses.org> <20191207171832.GB24017@fieldses.org>
In-Reply-To: <20191207171832.GB24017@fieldses.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Dec 2019 16:57:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgiQO7PCgQ5YKbJ86TLEs8G_M6k2OtFBY5m2AcNOCcJ0g@mail.gmail.com>
Message-ID: <CAHk-=wgiQO7PCgQ5YKbJ86TLEs8G_M6k2OtFBY5m2AcNOCcJ0g@mail.gmail.com>
Subject: Re: [GIT PULL] nfsd change for 5.5
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 7, 2019 at 9:18 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> Oh, also, not included: server-to-server copy offload.  I think it's
> more or less ready, but due to some miscommunication (at least partly my
> fault), I didn't get them in my nfsd-next branch till this week.  And
> the client side (which it builds on) isn't merged yet last I checked.
> So, it seemed more prudent to back them out and wait till next time.

The cline side part should have just got merged (Trond and you both
waited until the end of the merge window for your pull requests), but
it's just as well to have the server side be done next release..

               Linus

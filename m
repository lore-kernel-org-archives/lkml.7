Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165BAC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8B82133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoUNQsLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbfEXTpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 15:45:24 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44561 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbfEXTpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 15:45:24 -0400
Received: by mail-vs1-f67.google.com with SMTP id w124so6608092vsb.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 12:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VSCpos+5H3kGeuz4/hTR2VLM2nKqyPZxFJn7Vr/MpQI=;
        b=AoUNQsLq6Nebbod6Sm11L9aen5qNZdwC5XZ8qwlFqKhwX63DBoRmtvwwZVLPL9IvXn
         5lyeHW37ecHGFEgb+/FWreU2wis4OHyURUg0liq01uuXh01ntrGFbGa8T832e0Gorrfl
         zjHaCbq3y+tFFDzDRtq+ryKPiFf+t0CuhKHk+WDqA3TYwtgX0DzPmg/wFpHQ91JDXRg7
         RvYiciBuTmBup9a/gn/3V2noY6o4ktctRPMWEZk5ne3vCTfoOvsaqLISpFR0WzpX8CRG
         l89OQYl6kXjjMh4jUSfbelHZcXy0Ju+EQfKaBfodUajnX+OfdRa5qiStAnCd40W9vLzg
         TRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VSCpos+5H3kGeuz4/hTR2VLM2nKqyPZxFJn7Vr/MpQI=;
        b=MMYsS4SVtkPKc5x7tfn3BiE0vP5VT03EoiQ5qP+L00mvy4TwqgM4yU57C7dZTKHA1f
         wxdVls1XOexB3xMekUMPLGz5AImkX9952bJRpEYH0lVQIJ3zdrDQpBX93ZjiZzXtlZuj
         8RQ9LaXZcCupBd3hXTU1DdGMUjenf8cfg+JIqEtzjI/TWpOqeffh4faQQm8gqTJhMF39
         NGlszwDALDOQBC4j8o3MtF+E+8B6GHsMZoW5VU65MYKvk8E+yG73IERh+ltkZZai4sUO
         BxRcxB5L7r3KCnMjSC1M9PJPAgp8UF5yZwMRymx6qet4ZfPIAm4hdN7mIxTXYtQUInLV
         WhMA==
X-Gm-Message-State: APjAAAVIllYHOMs6gmckk+MkSifRLZbkMxKLEsvoqLlNKCINvA05XfZx
        qaPxOO4uB9nK7u7Vn4X4F+iT/fa9mK31ordbxo2k5F54
X-Google-Smtp-Source: APXvYqw9NjKQ5dEKwrWmN1RqAqrSeJpm3eY48E5BV/gLBVxn5HAGMnXelM1zCu6GF5K/fQjnAXXYhbHcFRxRWd+Z110=
X-Received: by 2002:a67:6c07:: with SMTP id h7mr49204648vsc.228.1558727123333;
 Fri, 24 May 2019 12:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190512194136.GA12189@ogabbay-VM> <20190524183633.GA7304@kroah.com>
In-Reply-To: <20190524183633.GA7304@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 24 May 2019 22:44:58 +0300
Message-ID: <CAFCwf11-8f9jvTQd41K5=72AL49eB2NysZexBfhhDOmfGkttwA@mail.gmail.com>
Subject: Re: [git pull] habanalabs fixes for 5.2-rc1/2
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 9:36 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, May 12, 2019 at 10:41:36PM +0300, Oded Gabbay wrote:
> > Hi Greg,
> >
> > This is the pull request containing fixes for 5.2-rc1/2.
> >
> > It contains 2 fixes (1 of them for stable) and 1 change to a new IOCTL
> > that was introduced to kernel 5.2 in the previous pull requests.
> >
> > See the tag comment for more details.
> >
> > Thanks,
> > Oded
> >
> > The following changes since commit 8ea5b2abd07e2280a332bd9c1a7f4dd15b9b6c13:
> >
> >   Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2019-05-09 19:35:41 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2019-05-12
>
> Is this pull request still needed, or was it also part of the other one?
not needed, I've sent you a new one that includes this and I wrote it
in the pull request.

>
> How about fixing all of this by just sending patches?  :)
Starting of next week, all my team members are starting to send
patches individually upstream, and I really think the right way to go
is for me to apply them to my -next and -fixes branches and then I
will send it to you at the appropriate time and to the correct
branches.
I'm sorry for the confusion that was here (I sent the fixes pull too
early), but I assure you it won't happen again.
Oded

>
> thanks,
>
> greg k-h

Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F28C7618F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 19:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA2A20578
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 19:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564343016;
	bh=RdqY9z1tyK5MZOgv5nA8BXKo1Ti9XQUAofumhTWpAr4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mVKmksl88I00yhXY2K7rW8e9wDNj8eG/L15XmTSQc5zLxpb6PfG5qhMT3A31RcHZD
	 /Hf/JQpPXYY2j5iea2JOuxi+gDNMa7N0RuBrI5EQ2wNF8eymuwa7gpgqYGaYt18t1V
	 eeFWssQlxzQzcW4vcI+/MBl4ODPNJELde2n5HvAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfG1Tnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 15:43:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35836 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfG1Tnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 15:43:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id x25so56489925ljh.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 12:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LdZY3aNmVNYioQr1gNNc/nGfiwAN9OHPlb8+bVrJlls=;
        b=IkezEmSK9WZSIAKVD3LxxymLtPGFDR8fufgv0+4bjTUpVCUYUKjN5mXiZmrABu1R5b
         JIcWl6BkXHZzOpYpz0hvtoNPJusTWPeR4tDWEXYYDxZbA4hJ0vX1/utCDac8cRbLJFBE
         mhlfgM80ZboeOMY4RW4AMG8TfsFCzDPSlGk/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LdZY3aNmVNYioQr1gNNc/nGfiwAN9OHPlb8+bVrJlls=;
        b=GhuiKRPnoZvXxuV5Yx68P97IIq/IIQZsrmV5PDGYutONU5/VQwA0odOFmUMuSz9PK4
         opNLnlIM/9a55X15wjLfCeq+r7UN/XXI8ZTOi/tF4u0WF9g73Epk9+KoSIzjtyvX2bt2
         +LvyFzj35I45w7BvsDty7YmXa8JPLloKHuLMIJTSpW2GV3tryNn/57LLiKHtcDl+9uR2
         kgRZb0LWFvoPriGMdxclK8WDchf11A8xI0g+f8JprWEuzcVbb35XAXObi0t+M1OUpx7l
         h0STBX7xhVjwbeYbD7UugLCUy56zKWnXc01OYj3fIN1JI8pensZfmqB1xXXwI1RRlW3A
         79jg==
X-Gm-Message-State: APjAAAX0qgC3sm0IJcH0vYz5p4v/QhlWAD/r/RWvzcNGjdyBK46VKeE6
        z+GyGADi0lcJYRmYvfrGt/5fuSPNKBA=
X-Google-Smtp-Source: APXvYqzV8vg0irkTOUeJl6mhAFDrYocFZlcCSmhqvWY9zVvUbh5VYo5/UgKQP9JDusaMFOSL4bLU/A==
X-Received: by 2002:a2e:2b01:: with SMTP id q1mr54469701lje.27.1564343012780;
        Sun, 28 Jul 2019 12:43:32 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id y18sm12174029ljh.1.2019.07.28.12.43.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 12:43:32 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id b17so40546249lff.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 12:43:31 -0700 (PDT)
X-Received: by 2002:ac2:4565:: with SMTP id k5mr49790926lfm.170.1564343011303;
 Sun, 28 Jul 2019 12:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <201907281218.F6D2C2DD@keescook>
In-Reply-To: <201907281218.F6D2C2DD@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Jul 2019 12:43:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+1vDh2=eZExibYF9Lo0GsGxaAjxCSwpUFVURrN44cUQ@mail.gmail.com>
Message-ID: <CAHk-=wj+1vDh2=eZExibYF9Lo0GsGxaAjxCSwpUFVURrN44cUQ@mail.gmail.com>
Subject: Re: [GIT PULL] meminit fix for v5.3-rc2
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 12:21 PM Kees Cook <keescook@chromium.org> wrote:
>
> Please pull this meminit fix for v5.3-rc2.

Side noe: I find "meminit" a confusing description for the structleak
thing. When I hear it, it sounds like some generic memory
initialization thing in the VM layer (which we obviously do also
have), not the stack variable initialization.

Also, have you guys talked to gcc people about just making it a real
feature, like I think it is for clang? In particular, I still suspect
that we could/should  just make zero-filling the *default* in the long
run, and say "our C standard is that local variables are initialized
to zero, exactly the same way static variables are".

I know you posted some numbers somewhere (well, I'm pretty sure you
did) and the full stack initialization really was pretty cheap,
wasn't it?

               Linus

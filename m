Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BED0C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 03:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CAD206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 03:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575690631;
	bh=n8AidXnjky/A4JNuMfwLMIh44yi0Di/16P1CWY6x7LE=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=dy99dX9VT8UUZX8JSw+KnFTi3ScRvrFwJgHVdFsUWcRJcPJkWroZBT9VaiHBsJwmL
	 zimvv7c0RWW7QEAijIpi9e5QCiycf8HEEEL8JO1UdAUd7gml51OYEcrBVvwpzB5p5T
	 HpOjDV3reU1jTILKssYCDQLVs8Z63VpD938e8ouI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfLGDua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 22:50:30 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38086 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfLGDu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 22:50:29 -0500
Received: by mail-lj1-f195.google.com with SMTP id k8so9771446ljh.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 19:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=HEWM2qIddnPGufw5AQ6kyl6Y/Tjfdse09Yspvk/3RCI=;
        b=he2M8AdxCQFydLibVKShqyzikO8W2EI8NOK9ISS7ou9cfn0OpWBilIcQsB6NDgoNoq
         HKWi3kUP6tC/54/dKSqhFCoBdWpmni/VDi171bSieu2XDq+IZyrEDQTduR8PFfHiVvxK
         Esk5z6f8gqcxysY+UedwEvpN8S4uaS6yqV5Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=HEWM2qIddnPGufw5AQ6kyl6Y/Tjfdse09Yspvk/3RCI=;
        b=RUCvGLoOQFKEgDawdHJ8K/8PxP6i9MiFWaGDh7Ac/x/RoZk/waAYKQRU1Utd0BBKa5
         w5D1j0FkIAuj1VrdhdJOmFyWvJUln0s20VO9wVrC0aJSbR/I25X7LUp/QmK0YtXc4tLn
         CgDL47/aousSp5IjNG+6SE9UeV4roooDCfYtfLQLT2WX51NWO2SeI+6kJsHA4K4Yr9IS
         +mQO3Z4MMpZNHuDugbxXqyEKV1cJrGuPOYRWOU5hN8P6a+Ui6hixEaM5Za0e9Zr1xAxO
         90QzGMQBRyyYeZ497f/CGp9BX/BzD8i3CMECdnU+wFVl4V+cA2+bs+DleupunWFTM2wz
         d/EA==
X-Gm-Message-State: APjAAAUeoI7cOHc+hDgzZhG2MCxnNAQYEl5LplMSavBtY8QtwChGj3zb
        QP0Qe3FmXmCOy79thexEB4Kv3dhPBzI=
X-Google-Smtp-Source: APXvYqwE1ixrHdTY4o4msgBZC0FkhjkJZJHmLc5AHDaDCPmDvIcQ+WFRG0qBO0xPv4MpwIh22al+Gg==
X-Received: by 2002:a2e:85c9:: with SMTP id h9mr2177532ljj.155.1575690626688;
        Fri, 06 Dec 2019 19:50:26 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id a24sm7318990ljp.97.2019.12.06.19.50.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 19:50:25 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id a13so9758738ljm.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 19:50:25 -0800 (PST)
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr7759167ljj.148.1575690624637;
 Fri, 06 Dec 2019 19:50:24 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
In-Reply-To: <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Dec 2019 19:50:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
Message-ID: <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 1:04 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It doesn't fix my "kernel compiles go single-threaded" issue.

I ended up just bisecting it.

The "make goes slow" problem bisects down to b667b8673443 ("pipe:
Advance tail pointer inside of wait spinlock in pipe_read()").

I assume it's the added "do_wakeup = 0" (not the spinlock) that ends
up having some subtle issue.

Very strange, but there it is.

               Linus

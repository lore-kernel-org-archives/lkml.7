Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1574DC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 06:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D9F2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 06:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o9MpIU1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbfGPGPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 02:15:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44578 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfGPGPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 02:15:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so19468204wrf.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 23:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wfF5PYRhfJ6WE30ariCVYJ/UJfvMxKY98IhUE7/2ZhI=;
        b=o9MpIU1wydYJPQXcRbq1gOd6jCzANSlE6U3LfdPhCb5kVPGeM4P8BmCp0izArIhPc1
         icdRqYIHcTF3kViOSLPQjtg8dO0x5muKoE+zs3l6OzpqyFRbgisBh0UPTJXNsZaNMwoy
         7cIz6OmxuUk6iYYUUvA0lSxmSHUq6y42B2T5hmcdFPqerSpVFA2Rrb/Lgp1xQ2aBVEXA
         zUyx0ggbJb6cFLBSWySHKSr5IxHaLo8m7dadp6eLHBQlQXQIFPn8E+nW6GJw36TpBqkR
         dAaQ0ThPgkpkZwo/qWXDcK88h2uzmI++/5IAAQPzrPjaxFUq8BmgvTKSP8vnJUa6IbcU
         nlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wfF5PYRhfJ6WE30ariCVYJ/UJfvMxKY98IhUE7/2ZhI=;
        b=tcA5dbRoR25ZmSu5JXr3rSEYDIgGZL+cBN90/TQI5oyB8C42HP+TWx3syrEe+PIIWh
         i0Zb9l0ALY0Siihv6qz7cPVl8u3Fsz+AIbhi56Rrpn3d9LqzDjvGiY5Dr7tQEw14OTcz
         50tuFOfP2qpn3TeW99MkN2SB1w+OSqiE5exWv2PiMfD1GPotpeiYQzvzKutl54prwnNU
         pT9LGZwSh28RNrRCw/C0eDayc5hate8H5wgwZ9yePkAnIuDkSJwpZn7jMQESBTr5seJz
         uueSUb58ZZXOfcovcE/GQnZV+B/DY028P5OZDHIc53EpUhDoE0N5UUkfRGM4qIMuAU9O
         OZdg==
X-Gm-Message-State: APjAAAWHbCjiDQmgyggP9mjZlis62IxmnZxPmIFUBss/raaSMc0vnq/e
        PvNDyMQg28RbnCmRyZj1X3161Rbu+l4=
X-Google-Smtp-Source: APXvYqxxcdKDAWvG4MttF9teO4IqKFgUd4nMgGLtFGlfS1sBf0LPnqad69S4fpe1ADNW8enASZbzBA==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr33363614wrw.138.1563257732328;
        Mon, 15 Jul 2019 23:15:32 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id u186sm30720314wmu.26.2019.07.15.23.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jul 2019 23:15:31 -0700 (PDT)
Date:   Tue, 16 Jul 2019 07:15:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Backlight for v5.3
Message-ID: <20190716061530.GA28861@dell>
References: <20190715080009.GD4401@dell>
 <CAHk-=whhEUNpOoT-M-J-8vEdj9X3a=vGn-sZk9OwLoi_9k7-ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whhEUNpOoT-M-J-8vEdj9X3a=vGn-sZk9OwLoi_9k7-ZA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2019, Linus Torvalds wrote:

> On Mon, Jul 15, 2019 at 1:00 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.3
> 
> Hmm. No such ref exists.
> 
> I can see the "backlight-next" branch which has the right commit SHA1,
> but you normally do a signed tag, and I'd much rather merge a signed
> tag than a bare branch for linux-next.
> 
> Did you perhaps forget to push it out?

Looks like I pushed it to the wrong (mfd) tree.

Now pushed to backlight.  Thanks for your patience.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

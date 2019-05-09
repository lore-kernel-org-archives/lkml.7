Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00F0C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0847217D6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vmSxVeMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfEIVZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:25:24 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46352 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfEIVZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:25:24 -0400
Received: by mail-lf1-f67.google.com with SMTP id k18so2594431lfj.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JDkpNkYEKJnQvxxR/KDE9gY/J6U8QTbtyo6Tf3JQ1/A=;
        b=vmSxVeMDxhbFsFE0g9BwLw7dF0n9aV5z5cnkpQaamY4U6WbE2vZhv4nl7Ke3QL7XQp
         pw6tar6yAdCbVkfT+jABkc20bSx8Jly0hOeXool+2dXQ7C04yUq9A78dnD1LdBC7lEeh
         WgfS4S51kLPTH6wnEGmM8wZqEI28GhCr53xEZe6s5tsoPwfWkvwjNlaYKwoav0oB/hdE
         gb4XQrIVJ8C2BVJDTEfkHrOkqmlYmxkKKOAnM2u8JtSuuP5IfukTPBVdYfg1vskrd5+z
         2Kaz5GbRLDaj6iNqmLQsxkxeqI5N4Br2avKAKZGHGkonsFWN5l8y3n+/80jA4gv4bR2L
         lLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JDkpNkYEKJnQvxxR/KDE9gY/J6U8QTbtyo6Tf3JQ1/A=;
        b=BPy0HznsZ6wcEXLlatY1b+t9mMySI52eKfoJRUWJawtqceW5W3IfX4YbRgO9+wm0+e
         OFaNaqgk1XBmOTaiI1xEQtlSBpsEaxThNluPGsOEDSg94sw9ipPH+1P0dU7aRdPiDOuc
         kNFdPgbA4d2lus110SGayqu0vF1mGQz7EXsa18VKxiovE/WIq6ixqdiOGpo6jVd5xR8e
         NM+jidXpqO8WorIMDPgqqqmPud+Gg+VNd4sDYRjXCL4dLwJ5C50eeXBi4nUBHpnbaAnG
         Vq0u3vFizQ7Xnj/yYiiVY6JYqUZm0bo9H6CSd2TkV+e4AIhtxk8c8/wQltn1bz2KSfcu
         vB9w==
X-Gm-Message-State: APjAAAVk65GwdQFbfN9deqqvUcDI9vOIPiF/6y35e1EeBLFl5LdxVs3p
        A6yhmo18HABbipqBLQ5/GLtv6LCp67KiZxckbJ7euQ==
X-Google-Smtp-Source: APXvYqyPbGD+CvhlvWPicwOkkw+gfZYoweonGaoYEwFeD5dHSCaIBotvS5UxBf0l7aLPtf/Iv2skLSJyFrV9eP/2kAU=
X-Received: by 2002:a19:550d:: with SMTP id n13mr3708154lfe.127.1557437121545;
 Thu, 09 May 2019 14:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190507220115.90395-1-fletcherw@chromium.org>
 <20190507220115.90395-2-fletcherw@chromium.org> <20190508073623.GT14916@sirena.org.uk>
 <CAOReqxgYV3SdXot84Xa4X7=MCZdzWmb2N+jaWzjxgmdoMRx5Mw@mail.gmail.com> <20190509023247.GT14916@sirena.org.uk>
In-Reply-To: <20190509023247.GT14916@sirena.org.uk>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Thu, 9 May 2019 14:25:10 -0700
Message-ID: <CAOReqxjg=w_ZSzUoryQYE9Poz8vF3=j6-_gNu-SMpH1oEsn2bw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] ASoC: rt5677: allow multiple interrupt sources
To:     Mark Brown <broonie@kernel.org>
Cc:     Fletcher Woodruff <fletcherw@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Zhang <benzh@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown <broonie@kernel.org>
Date: Wed, May 8, 2019 at 7:33 PM
To: Curtis Malainey
Cc: Fletcher Woodruff, Linux Kernel Mailing List, Ben Zhang, Jaroslav
Kysela, Liam Girdwood, Oder Chiou, Takashi Iwai, Curtis Malainey,
<alsa-devel@alsa-project.org>

> On Wed, May 08, 2019 at 02:39:32PM -0700, Curtis Malainey wrote:
>
> > Pixelbooks (Samus Chromebook) are the only devices that use this part.
> > Realtek has confirmed this. Therefore we only have to worry about
> > breaking ourselves. That being said I agree there is likely a better
>
> And there are no other parts that are software compatible enough to
> share the same driver?
>
the rt5676 can use this driver, but from my discussions with Realtek,
Samus is the only active consumer of this driver.

> > way to handle general abstraction here. We will need the explicit irq
> > handling since I will be following these patches up with patches that
> > enable hotwording on the codec (we will be sending the firmware to
> > linux-firmware as well that is needed for the process.)
>
> OK.  Like I said it might also be clearer split into multiple patches,
> it was just really difficult to tell what was going on with the diff
> there.

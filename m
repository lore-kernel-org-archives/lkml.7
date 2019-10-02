Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC2EC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054DD21848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUAKOZ17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfJBPAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:00:32 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:35574 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfJBPAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:00:32 -0400
Received: by mail-qt1-f174.google.com with SMTP id m15so26772261qtq.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 08:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=tY5Y2O/4IVcviOo9fbj48Tix5FoinUXRG5VeR4hPRIg=;
        b=JUAKOZ17Tda2s1XkAgmxjx9ARwE7k6UqMi2mmjo+VrHNCTCE1f7F/tY+AflLOMe/1C
         vwuywhEy55UnSCGTvTe/IuJGTzPqxd1yAEvjcUA8w/pAwrvGuAqCI8Ouh5XRrS/ZhukE
         SAG+DMs5Va6lQ+6OZTT3zJiy/FbXGiEyIEN5gqHeeqCb+81vN05vu6KDlXqaX69pymcp
         S9I7+PzxT4Qe1eHe44TvCrelQLpLARQlB3F2dLb1qQnTfNaYxWM7nDsCs5/BlYo6ZjdV
         NT/rJnQ2DxgJeDGkr07/NN8gQ3Y/MVd5dko5J9z5hmHp+n/m9AcmIGSqVc7w6Q444tve
         OjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tY5Y2O/4IVcviOo9fbj48Tix5FoinUXRG5VeR4hPRIg=;
        b=h9E+fNewYqBxghDC4AcfWvazykGa4Oso+NSNWgqqk5UAfK2bzJY0AuJNXhyWXwF9aZ
         YyfUs/NuPIkRzWrKc5/oM7P1cdTK7FbrFX8OgjaY7frm0BMsc6CpXVVmOm1v+ugoOPed
         G3ChFEwV+hkvNAnUjU8KJiEjRy/9n0sQp83z5jaRmpviDwiSc8FRlyoWb46j+vlJwf1o
         oLDo7j0W1K3byvcYWLBNVPwd60TEJCdKpPRRlp/lFejUepze+U2jVAJw1LLtLDoM+FT4
         8cgOdo9iZOUTcYjXWgVWQte7KGh0Hn5Lljv2Hohr2cZLFDinVhe0rEVYv0bem9ELqo5N
         f+HA==
X-Gm-Message-State: APjAAAUQNcsLHCxogCVNBvVf6UXeZ4O190/LYdpif+VvCJYpLpVT47aL
        dDGf0Ks5HpGgoIa0WtuTB84U6l/eK9MjAbPrh5U=
X-Google-Smtp-Source: APXvYqywMu1IIuOSbdlOBGc6xKRB01j56hF5kDCWYmdlQOGdYonj4Pi1cX2e3wt3ucF/2xwNHlNFvpLvym8HU/tPQM4=
X-Received: by 2002:ac8:5448:: with SMTP id d8mr4391598qtq.287.1570028430742;
 Wed, 02 Oct 2019 08:00:30 -0700 (PDT)
MIME-Version: 1.0
From:   Matt <jackdachef@gmail.com>
Date:   Wed, 2 Oct 2019 17:01:29 +0200
Message-ID: <CAG-aW04m8oRiOA5bEhWzEX6J9hSWXHSQJJTZaG0cp7Fgpwy7Aw@mail.gmail.com>
Subject: possible audio regression for usb-audio with 5.3 kernel (5.3.1),
 sounds like variants of 8-bit audio
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

there appears to be a sound regression for plug-n-play usb-audio DACs
with 5.3 kernel.

I'm using the following one:

https://www.aliexpress.com/item/33012416525.html?spm=a2g0s.9042311.0.0.4f314c4dv3EF0p

which includes SA9023A + ES9018K2M on the chip.

When listening to parts of the Unreal Tournament 3 soundtrack the
output resembles a bit like:

https://www.youtube.com/watch?v=9gq4R6acnBQ Rush - Tom Sawyer (8-bit
NES audio render)

it immediately made me think of 8-bit audio and the NES.

First thought of misconfiguration in the kernel config but then went
back to 5.2.17-rt9 (copying the config and only enabling full
preemption) and there the output is correct and crystal clear.

For each kernel build I need to jump through a few hoops (nvidia
driver, zfsonlinux modules, luks, genkernel, etc.) so it'll take a
while to build and get it up and running.

System is:
cat /etc/lsb-release
DISTRIB_ID="Gentoo"

~amd64

gcc version 9.2.0 (Gentoo Hardened 9.2.0-r1 p2)
GNU ld (Gentoo 2.32 p2) 2.32.0

PCIe related sound doesn't seem to be affected (Xonar DX), it works
fine both on 5.3.1 and 5.2.17-rt9

Kind Regards

Matthew

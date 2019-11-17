Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6A7C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 01:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82241206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 01:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc4IjR2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfKQBBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 20:01:37 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33884 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfKQBBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 20:01:37 -0500
Received: by mail-io1-f68.google.com with SMTP id q83so14729077iod.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 17:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vAqt0FCs57kn9Ukf4LvAgXoTKM8qBPaUrRNF+376ajQ=;
        b=Rc4IjR2l0nM6Eu0SxUtXaflW2dO+G7X+lWrWL0/5sPe5OCWwK3Nc4181C718stHooB
         qh9VGwxNeTHJbRgCl+BrKeSTJm+7j34Syr6U4nMREfk1MviR10cCeYVBlggE7eAuIvlK
         wBHhENWTbKm+VemvofantvEZUKegPDwBPJINHaA7tD7FNayMa7BjM8xwyLaur3zA5Ybc
         63AI7fyuEP9WXRDCsYexQbmeOsTlleuo25X7nqaSoiy+dxptlGomlf8Lge/6igiSi6bB
         S5S6BK6kW/3gK9LvHhvb+stShgW7LUQVSm1Uqy9m+4wcsedzuOw8HpD0MpUGohx5ydsC
         +3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vAqt0FCs57kn9Ukf4LvAgXoTKM8qBPaUrRNF+376ajQ=;
        b=NTf4HBbgdp2btWw8yxc1CsZSNpM3zYDq25ozWUkVwuHGtJsF0OXLITeZQyk5FikjJU
         yQ4WX6xR30NzWexwo8qV13WAOzN/DmvBs5RpM0/HwY7gzIQUBAVTuX6c1DMySNTDZfFE
         Gb4Ru1+fZYCuXtmC+xLIgs9i7qjrRdc+SsWH3q7IFeKc6lTnHLVQ+My3sRbeYRuker2O
         YAzTDuiQbxtF7U94gM/kFYXNfg5Q2glWYRVKcPgsjVHe4J9FCs8ZZRv24uQu6TdVpPOe
         Z/GjqemA76Kh19/auiVmrr/Fz1Yy4mXWJCsjGIMjkdqM5jWpwt98COzzQ0rNbove636f
         z5ug==
X-Gm-Message-State: APjAAAXgYPAgMH2mKuIhc4Gf/n+edrSsILdQ1dlUaFmzvUFeZi+/YEWk
        BmMgWwMT4fwU1nhnpZWpbj+UdyCUH2vGMqxHUXR/sMdv
X-Google-Smtp-Source: APXvYqwQQ8GSLwLAIOoYxNo5CDVYDMr3fNpfHan4mc6rq0+MqeTvCju3i3OfLOpXo+jLKNs9ld93Le8T0jMSMBcXiz8=
X-Received: by 2002:a02:c85b:: with SMTP id r27mr7616612jao.9.1573952494720;
 Sat, 16 Nov 2019 17:01:34 -0800 (PST)
MIME-Version: 1.0
From:   Siavash Arya <siavash.arya89@gmail.com>
Date:   Sun, 17 Nov 2019 02:00:59 +0100
Message-ID: <CADuSoB_7uQ47+P2Ws7s41yOpjvcaYC9zZ89+zG=5MDDYmHSwxw@mail.gmail.com>
Subject: 
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I use any ubuntu (probably any Linux) version that is running on
a kernel that is of version 5 or higher, I have an issue where my
computer hangs completely when reading from any of my hard drives.
When this happens not even the caps lock button on my keyboard is
working anymore. I know that it happens on reading because I got help
at the freenode channels and tried a dd command that would read from
any of my 3 hard drives. I first detected the problem when I tried to
copy files. Anytime I got to copying between 2,5 GB -> 3 GB this
happened and I had to long press my hardware button to shutdown the
computer.
Today I'm not even able to run the ubuntu 18.04 installer because this
happens at "copying files" during installation. If I run the installer
live, this problem exists.
When I had ubuntu installed some days ago, I had to use grub to boot
with an older kernel version in order to copy my files to my backup
drive so that I could try to reinstall ubuntu. But I'm not able to
install ubuntu anymore so I'm using Linux Mint and I don't like it at
all compared to ubuntu so please please solve this fatal bug soon ! :)
Please let me know what you need ot know and how I can help you solve this.

Best,
Siavash

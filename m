Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E73EC43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 18:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1EA20706
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 18:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="op/RvDGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfLNSP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 13:15:29 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:40592 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfLNSP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 13:15:28 -0500
Received: by mail-il1-f194.google.com with SMTP id b15so2179440ila.7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 10:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1JfzT8WqJaE1DwnOTHtTRUi3olcE7ZXwPp5TsozCDFQ=;
        b=op/RvDGvkEwD/oxfWFE6HCLvMA5K9qjjKM/rXGvHZb1Jf3CRz7Xx0sjVQdmN9IjnLu
         jMdnumobzpGabBsk10DafXOZVPQ0tqkuLkcn5uBfy57uYA7XZMUNlwMBDyGALeEU5izk
         iS2mF9RmfnXcEoH36GHx51+PMlRJ4Q3GPc3JvzX/UDY8M0T7J3oTSnGr7XWS+jwSx46b
         WGltRLYJrpu/oT6XVj0s4xWuM4rIwfTp+Y17lWwsjusSc7sPgpz8Mu6i7MqwOhP4v/VY
         Jwot+7Q3QvdxiuXcsG+FxBEkLUPzvTQkdwm0td1MQoQzeJUHt3dEy9wOVmyJf2SaPIqy
         M+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1JfzT8WqJaE1DwnOTHtTRUi3olcE7ZXwPp5TsozCDFQ=;
        b=iYpfMIlUUJS6taBL+2OG2N+TNUPMEAiY9HXcynVUreZMkxIWvlp94jPxFbBNucx51Z
         TgFdP5DFmKvqTbdDlbxG8OklEUAKTaQ9/vZ3tE8Hvrry9NtGlzN5bp4QjfK48/YEUIwa
         V8EVTvp/KTZjpbEyZJNK332/h7yFXcveFe4fxg7DAWiDSjlWDsXpvIg1HYNdSGX7iknT
         i99SQTH8b5KiEMGLilAtaeDZKjEHMo/jqqA3G6rVS07ff3+8EP0fYBo/Wy0JOg0TpP2L
         IXUM4t2vHHqz+G+cZOFPjKkk+synIqmZIAtLiWxvFNpU29zYGmauYurjVJGu13QtK/G8
         3jJQ==
X-Gm-Message-State: APjAAAUZF8fUzvX6ZKkixhhrDiZ74w5DDMipCYS+jiEPO1P1+AeDpuB6
        c7wdPoYscktdOkf5XjK6xsNZTt/0M47OEAqOWc5+cZAd
X-Google-Smtp-Source: APXvYqzpFaa1mKLAScdkoH/yd7wwukT9DR4mBHcTffXRe1B/2SaITCHweu/gJN70+oOfbeHeUOiWjGvOgI/XLBHwo+M=
X-Received: by 2002:a92:1e06:: with SMTP id e6mr5268538ile.104.1576347328157;
 Sat, 14 Dec 2019 10:15:28 -0800 (PST)
MIME-Version: 1.0
References: <20190607182517.28266-1-tiny.windzz@gmail.com> <CAEExFWvh9HMWNKeDNhx1vqTbUB=_117qCP1TjCxEFwiYV4N_FA@mail.gmail.com>
 <4454ca6d4648a41ca6435eba24bf565625bbfd68.camel@perches.com> <c6c9bd718c4cbee34b13a0b2c9dfefeee00bada5.camel@perches.com>
In-Reply-To: <c6c9bd718c4cbee34b13a0b2c9dfefeee00bada5.camel@perches.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 15 Dec 2019 02:15:13 +0800
Message-ID: <CAEExFWsnMGtNzWuPY2gRfOTQN0awfN7p-UX6HCOKQY2F5eD7Ew@mail.gmail.com>
Subject: Re: [PATCH 1/5] random: remove unnecessary unlikely()
To:     Joe Perches <joe@perches.com>
Cc:     tytso@mit.edu, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping, again ...

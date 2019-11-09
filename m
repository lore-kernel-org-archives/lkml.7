Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E02C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 19:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F90E215EA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 19:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzQb2szx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfKITKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 14:10:12 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46427 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfKITKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 14:10:11 -0500
Received: by mail-io1-f68.google.com with SMTP id c6so9886089ioo.13;
        Sat, 09 Nov 2019 11:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m3uHaDtX3ciBcivMZkabAXv4IXjFfi/2JONmJEnyS4M=;
        b=OzQb2szxIOCMkG7rpfV7iXzqQ4zN4waKC8TIK07OVor9Nkn/w6S5TD3VPil6TGism5
         N7sxi6TFacDj8wDuXvqUKN0e/a2okRozjUaav/IZaFAFADsYQBWI9yKA3Jbz9kCavgrD
         mu7xIHK4ip6j9erJ3VRgFN53eJWqyGToD4+u2BvFhIUJixFLpx+5hKb8d6dBVne6WngW
         w380DqebBQySGHVYeDMJpAJkgX1xOD0KxLOXh0+yovMZk9BBH9/bbIe4DDdIA8STfz59
         sLeil7/LYCTR53E6bByKg5V3bGq82Yjce99r2hBDEu+4+7qkLhLnGs9xB8V09whZIYA+
         k5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3uHaDtX3ciBcivMZkabAXv4IXjFfi/2JONmJEnyS4M=;
        b=B4y82udQeWwPcjvHhe2Rx66lk1w959KLnuAJghuq9/PjXisUjwuaQyIEYFzbkUvZ8+
         xC+BDTwgZqZIVnB98g7c7Zl1gvlGsiubcWKDse/0vWK+G4EffYIYdNMGmccgksMT/bn6
         gznAQ1n/okWFfW0yGlzL7joowf+U0RsARLKMplWUe7mAdsnR2nyE+b2/6jL6Kh+lUMeo
         /zR0MYILw/gt0qTtXCuBYsgl5ke1i7y1tke7wStf9qsZishB+vh3ji5P84WLSPNgz8Fi
         i9czLbkBwYsuCIBrKJmrTGPNaQp885vJ5FGkU1oiby4vjMefeULG/aqPZVRzCR+22kh6
         Zbgw==
X-Gm-Message-State: APjAAAXQDdt5rd/YuJKnec30+gl6mE/VhJpUKO5WE4jXaSMcYIIn++FG
        /LS2IRtuE1tC4EB9GByBeCfG3FN6kNK4DEUuPVY=
X-Google-Smtp-Source: APXvYqyCcuNQztMPdKAwb9hw9bvQ+cvwApp4ySFAb9AH82h57COZOkZtMCvC2QTO/tDHbKmfFTj/6EewefH4XbTyU5o=
X-Received: by 2002:a5e:da45:: with SMTP id o5mr17159702iop.265.1573326610808;
 Sat, 09 Nov 2019 11:10:10 -0800 (PST)
MIME-Version: 1.0
References: <20191108213257.3097633-1-arnd@arndb.de> <20191108213257.3097633-4-arnd@arndb.de>
In-Reply-To: <20191108213257.3097633-4-arnd@arndb.de>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 9 Nov 2019 11:09:58 -0800
Message-ID: <CABeXuvpCejkkjT80U9pywkV6FnO5rxk4rZzpmAEnUdwmzBN0Og@mail.gmail.com>
Subject: Re: [PATCH 03/16] net: sock: use __kernel_old_timespec instead of timespec
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Florian Westphal <fw@strlen.de>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Stanislav Fomichev <sdf@google.com>,
        John Hurley <john.hurley@netronome.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Pedro Tammela <pctammela@gmail.com>,
        Linux Network Devel Mailing List <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Deepa Dinamani <deepa.kernel@gmail.com>

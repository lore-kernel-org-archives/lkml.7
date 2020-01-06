Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569F3C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 17:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA7724672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 17:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="jzrof668"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgAFRv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 12:51:59 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42659 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbgAFRv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 12:51:58 -0500
Received: by mail-io1-f66.google.com with SMTP id n11so42748349iom.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 09:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qy8kmkp8a0gmcpulrYZGNAm7gLvS5DkjoDa1dT+iaq8=;
        b=jzrof668V7p7TIEBZmcBr7HsXeQHx4Y/82FDTr/eUsL2QuB+qyXSDZPa7kUuOW4p4V
         aQDgWoEHRRaMXH2PbD5aNjNwR4/aok96ojD23mByECE8J/9RVT5Qxcx1m+Nzu+10gkjE
         SnmQYwRYzPnX9blWGY3RBLpqxH9HNLy2+U6YVhhVSoBfFvzZlepNx/ajOLI29PDltHmI
         GUn/LnnhMEFQquexorSKg8FbdHrsVah6Ucn5QZvBeqI9DkJiBJDMiXlIecF01kRGlfbz
         bmiJ6ex6i/ZJgeTsQQ9i//PmTbQha9ze3n/iSkJf1V1vwxHCqgjWmbnX7S2xll8o81aQ
         W21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qy8kmkp8a0gmcpulrYZGNAm7gLvS5DkjoDa1dT+iaq8=;
        b=VcpZ9k9T0wH/BNRnDg9NlpB7thvR4LqudD0OvaqFbKIv4xIBwYRizZH1keDoA17zA4
         MlVaeB3oY5iyCm7KrBlWDjSpHhf4HHHWVqx4Xty2ojp78TaLQw9g8XuURIU2I+uz5ZWA
         6QAE41ZP3xakLFFfxkv4xAZaIRqSAcBJ+JgVZVaK5a4AME95R6edx5umv4SeWt8KJzY/
         Bpwl0N+9G8kWmU8kzxITznySiM3A7SCDGDyOTcb1ib//5K1NlLuWvRq82pf37IQXWpND
         Cwxb0xH5fQD0JVDmC3mzVPZW/RvZVNn70yCM7ewAxYfEEuzWmUd/Q1mmq0NITVNNIygW
         G8Lg==
X-Gm-Message-State: APjAAAWuK1cEhXytWrEQo5Unnmp8Wvy30FU8j4X9ANl2w8uS1nT8sHw8
        ByWfEpf2plJfC3QPGbCFjhVqXvUmxyfnvruvr0K8KekWmm/K+g==
X-Google-Smtp-Source: APXvYqzxsugGn2yxQHaeUuSSUV2TAe/3zs6sdz/iqVons8XXpedlHaNhKZESuFkh1KRYRsPmdvlmPUWnayfpHU/1dgI=
X-Received: by 2002:a5e:9907:: with SMTP id t7mr69813324ioj.72.1578333118209;
 Mon, 06 Jan 2020 09:51:58 -0800 (PST)
MIME-Version: 1.0
References: <20191212160622.021517d3@canb.auug.org.au>
In-Reply-To: <20191212160622.021517d3@canb.auug.org.au>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 6 Jan 2020 09:51:47 -0800
Message-ID: <CAOesGMiabP7nAPYKrmP=j_8bSj-UfUSFoiD0W+kqzaBp-6J2hQ@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the rcu tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 11, 2019 at 9:06 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the rcu (I think) tree, today's linux-next build (x86_64
> allnoconfig) produced this warning:
>
> kernel/time/timer.c: In function 'schedule_timeout':
> kernel/time/timer.c:969:20: warning: 'timer.expires' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   969 |   long diff = timer->expires - expires;
>       |               ~~~~~^~~~~~~~~
>
> Introduced by (bisected to) commit
>
>   c4127fce1d02 ("timer: Use hlist_unhashed_lockless() in timer_pending()")
>
> x86_64-linux-gnu-gcc (Debian 9.2.1-21) 9.2.1 20191130

This is still there as of last night's -next. Any update on getting a
fix queued together with the offending patch?


Thanks!

-Olof

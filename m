Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ABBC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DDC2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="j3/vYyma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfF1Ddo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 23:33:44 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41421 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfF1Ddo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:33:44 -0400
Received: by mail-qk1-f194.google.com with SMTP id c11so3651231qkk.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 20:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s1RS6E5PRN57yOy1tYlbByux0wGDN3f2cPvXBUEANB4=;
        b=j3/vYymaGTY9IcV7GL0KLyubMvndda1C3iUYZ0W7l9Rp3vx498JPcHm+V8Tu9f62K7
         AevWXDphCYvjoCdVwStXWF1ZNysAQbovt5ya3UZbmERkHpXc0qKLuHLhuTUNfeim+4uZ
         zKE3k8KMtKLAxa7YO4+w8rYo9FMTk+8D8/MxuetQHwoJZLWOGiiAokkwr2kvLWrnpl67
         o+bHa6cPsnMxQlhsLgdQFXT4AWL4yP8tyZv5M4MOfGj8CSqMwJorqgOwMIv5tKR+VaId
         qxHV7+Ax2NfcB7fPSPvEzsloH0l5angQ5LoykG1rms61R+yfD+kyKF+OT7y9Gc91HcLN
         zMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s1RS6E5PRN57yOy1tYlbByux0wGDN3f2cPvXBUEANB4=;
        b=Me3PjbpsXiIJMI4EyOEGpZR2X2IjFIfffY4+hf0QwyKD8c21UKLvpANNnodrotKF60
         CaQKJYNkMmBy+LVCfc+Mjt+pv502acvcuRn7UjwjXWWaRHlJ3v86Ko37pLoaN867g7vd
         NqIpsKEYReFKmNduckNV0mOdzVjAqTG1FzHFniefov+K5YAc5FMntmhs0Uk6ACzNPJrK
         8Y4LcVc2iJFPpGRQDagS4iWi7YiDfvcSHY+rd33+9Hdpl5BMHvQZfoO/EDuDe66NN5+Q
         taUFThcBkIgSnDQYLK6NCNobefkS2TUTzT45vraWsFOzAfANWEX7IIuMeJUhO4gQbISb
         d2hw==
X-Gm-Message-State: APjAAAW1RwdtmBgxZf6n40y9iezspcBVN/+ecL7Q3rdl+TJL2h4H4BnQ
        u2I2u9g/PxonTmkcBHeFD61ajzctF0hw0CtrDUKF4Q==
X-Google-Smtp-Source: APXvYqwDEbFcf8s43hRmtYsyMp24XK0twiLhBZgp4lzqIP7N5hGiLxNNyqnLyE6boN7g/IJpnqTEmXYhR4p9fn72/Bg=
X-Received: by 2002:a37:9c88:: with SMTP id f130mr6652703qke.457.1561692822897;
 Thu, 27 Jun 2019 20:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1904031206440.1967@nanos.tec.linutronix.de>
 <20190627085419.27854-1-drake@endlessm.com> <alpine.DEB.2.21.1906271546010.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906271546010.32342@nanos.tec.linutronix.de>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 28 Jun 2019 11:33:31 +0800
Message-ID: <CAD8Lp46XnwQu4NWaXurz5ZcBs7dGb1gY=0Fy83w9EC9_V-7Oeg@mail.gmail.com>
Subject: Re: No 8254 PIT & no HPET on new Intel N3350 platforms causes kernel
 panic during early boot
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Hans de Goede <hdegoede@redhat.com>,
        david.e.box@linux.intel.com,
        Linux Upstreaming Team <linux@endlessm.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 10:07 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> Nah. That extra timer works thing is just another bandaid.
>
> What I had in mind is something like the below. That's on top of
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
>
> Be warned. It's neither compiled nor tested, so keep a fire extinguisher
> handy. If it explodes you own the pieces.

Thanks, it works, and makes sense!

I'll add a commit message and send it as a patch, just one quick
function naming question... did you mean apic_and_tsc_needs_pit() or
apic_needs_pit()? That's the only compile fix needed.

Daniel

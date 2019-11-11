Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB53C17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 03:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6174A206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 03:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOeSPNWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfKKDWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 22:22:00 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34465 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfKKDV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 22:21:59 -0500
Received: by mail-io1-f65.google.com with SMTP id q83so13021623iod.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 19:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=udsQv+N/pb8sImm3oVXMjvN8DC7yoxu7rp8gANjC+ZI=;
        b=fOeSPNWUQuqmIuXxkOnX4SnvOU9F1lJ2n0a5rpfPfLI4VvySftz2NbnkaajWQOBKTe
         Ot+czn8T/vy3lXWzebOoOoWAOYNCoJ9zNpNyI+gB1FgicDS9cjtQ0lshhgAhDeslZ8Ki
         dmKXuCCC7SzdUHLOIo+NDQjG5u9IFaVunyn0g2Eo1AFlqRlXlTd1UPzw/tZ9NBuc45CP
         rw4negqEtPAJOBxDK/rwOG7BD7gObrQZyeigXG10j+F0tjMTua88kp/Vm4jwRPDeS2K6
         hgqbHi6ahDX6Gen/SUKnH7Ia50PPVCiRK8vMF5WeNZIxQ3RtQfx/UQUhM52HctxfZ1cn
         knFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=udsQv+N/pb8sImm3oVXMjvN8DC7yoxu7rp8gANjC+ZI=;
        b=kTQtXlMMbW1dHiJHUkCKrLKkmqpCGK/D62ruKHx0kV213uvyHww2U906jwmNSAACuO
         SgSwlmDQoTFcqbSZnotU0ctfMPyQAvKVn3k/mBnhHBg9kbhC7eV7bAcHdhgEpPqa4JCM
         EhML06IRREopCVFXYBvh3hjZej5A0Cd4aIlAQutozIlUtjPWqnj0nFE/ekjoxGnGOojf
         URGY21E4nPsVGNmDNEqNg7d1aOio34XVZwsoPWsBf3QFlldvfq81H4YVyIMhk65J6oxW
         XOfsoQmuOHHeCgtbNvl6XMCtoIoiOgJd6QI9lPisSXRL1cN7ZVoNdAUUuNpdEMaabTth
         noZQ==
X-Gm-Message-State: APjAAAUGvv9Db/XHe9vl1flY+kQCZuTvcJ4sUeb20dCDxmHfPDwYhp/4
        gjGLbTrOaZYwFwHCYp3Z5xgmgl0/L/MuT8H57boF8A==
X-Google-Smtp-Source: APXvYqwqRZFBots0x7hq0WUknPcn7B1YNn618XbuZplmZKM1pbfZk6DfmP7mTrrx/86Q3qmWJpPc5QToVvJPlSSHzwM=
X-Received: by 2002:a5e:da45:: with SMTP id o5mr22758469iop.265.1573442517410;
 Sun, 10 Nov 2019 19:21:57 -0800 (PST)
MIME-Version: 1.0
References: <20191110172744.12541-1-deepa.kernel@gmail.com> <9e2e95e2-37ac-c0d6-d438-bd09ba7064bd@linux.intel.com>
In-Reply-To: <9e2e95e2-37ac-c0d6-d438-bd09ba7064bd@linux.intel.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sun, 10 Nov 2019 19:21:45 -0800
Message-ID: <CABeXuvofh-z97=iq9S7E1igbzyWwNU-MPbuCjNa_gzC3Q=L7hg@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/vt-d: Turn off translations at shutdown
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        joro@8bytes.org, David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 5:35 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Hi,
>
> On 11/11/19 1:27 AM, Deepa Dinamani wrote:
> > The intel-iommu driver assumes that the iommu state is
> > cleaned up at the start of the new kernel.
> > But, when we try to kexec boot something other than the
> > Linux kernel, the cleanup cannot be relied upon.
> > Hence, cleanup before we go down for reboot.
> >
> > Keeping the cleanup at initialization also, in case BIOS
> > leaves the IOMMU enabled.
>
> Do you mind shining more light on this statement? I can't get your point
> here. Currently iommu_shutdown() only happens for reboot, right?

In this part, I'm saying that I'm leaving intel_iommu_init() alone.
I'm not taking out disabling the iommu from intel_iommu_init(). This
will help when BIOS has enabled the IOMMU and for whatever reason, the
kernel is booting with IOMMU off.

-Deepa

Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58015C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEE921556
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="VL14gzbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbfK0VKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:10:15 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33874 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732991AbfK0VKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:10:12 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so5775824oig.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 13:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=os7f56Y+gUDNCLgmVT2ck/KLWvp8xrI20ZbRrLXpqHY=;
        b=VL14gzbv81eThmLt8Go5ka4kPU5lNvToFRq9e5gSt7T4AXz9BvYHOtxedgWl6LqjzF
         dgi+Gy1NW/3BNO/oV4l46Ten1R7thT7WxtEX239hZ7A8xcx6sA0DH0pIhwlf+LbknR4v
         mNZp94Wg5AxyrRqj3rSQlROtwkSyCTnj6ia53z4nH6sPPfc5G3Kr64dihykOFSy7vtj2
         Pwbr0VPGYdOHUIOOzK+bG1RRTTnQkhWW4q5AuYj0poXZkWvSdz1NPw6G+26yUaMGkf3N
         Ifv2chd5AOdU/UJpaG6M+ojAcTQ6Aica9MQEdQ1ptSbCGFwMMgadE4z87XUD5CMtt2VR
         h0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=os7f56Y+gUDNCLgmVT2ck/KLWvp8xrI20ZbRrLXpqHY=;
        b=QBC9BDPeEsYIvshVzp9GEqVfVGAQIWQOS5EZ4luMt5u1nuE3EJbssLnTbimTlQkR92
         a5rHBVrN4gDghIPB0ewRP4ivzQB/ohdWjXO68kTP9dFU281EcXexUXk3JVHlwrTusAAX
         Loel3sVP3TF4GcxlzoOme8A+tsbNd5++2Eco2TvBqSAgkE8eZA47oxKsl+6v4BRUjsMk
         tvhe9eQW3n6SlsAuMf5uG5An4jOX3DYTK1m8wWaw8XvL1P5qSj63cyIK8NHSC+nYK+I9
         RmGTH281QDl6QTlGblh/7/MloEo3XOV6ybBpFWGYL7fXDyQZIC+Nut9qVbNh0Z6KnGzl
         OtDQ==
X-Gm-Message-State: APjAAAV3Plmm/9rVtCniX4vM6C84owXD7MYMCihZy1t6POpCVaEbAhCO
        TcMoi6+K0/3wR/s4Wxwj+cbN+A2PSolnjM0va1Xv/GIj
X-Google-Smtp-Source: APXvYqzCl8qmibUmhhqiIABvAQWdFZDyI97CfolL6FkYpycIbLxXv03/1TCU7soUtfwt2Zr4QHuuYpeG4M7OB+wwa+k=
X-Received: by 2002:a05:6808:1da:: with SMTP id x26mr5975092oic.149.1574889011169;
 Wed, 27 Nov 2019 13:10:11 -0800 (PST)
MIME-Version: 1.0
References: <20190902143121.pjnykevzlajlcrh6@linux.intel.com>
 <CAA9_cmeLnHK4y+usQaWo72nUG3RNsripuZnS-koY4XTRC+mwJA@mail.gmail.com> <20191127205800.GA14290@linux.intel.com>
In-Reply-To: <20191127205800.GA14290@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 27 Nov 2019 13:10:00 -0800
Message-ID: <CAPcyv4jD8aod4=TSw+kfnS56rT_xqDSXYwXKoGzF=c3=1G3G-Q@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.4
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 12:58 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Nov 20, 2019 at 08:48:25PM -0800, Dan Williams wrote:
> > On Mon, Sep 2, 2019 at 7:34 AM Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > >
> > > Hi
> > >
> > > A new driver for fTPM living inside ARM TEE was added this round. In
> > > addition to that, there is three bug fixes and one clean up.
> > >
> > > /Jarkko
> > >
> > > The following changes since commit 8fb8e9e46261e0117cb3cffb6dd8bb7e08f8649b:
> > >
> > >   Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2019-08-30 09:23:45 -0700)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20190902
> > >
> > > for you to fetch changes up to e8bd417aab0c72bfb54465596b16085702ba0405:
> > >
> > >   tpm/tpm_ftpm_tee: Document fTPM TEE driver (2019-09-02 17:08:35 +0300)
> > >
> > > ----------------------------------------------------------------
> > > tpmdd updates for Linux v5.4
> > >
> > > ----------------------------------------------------------------
> > > Jarkko Sakkinen (1):
> > >       tpm: Remove a deprecated comments about implicit sysfs locking
> > >
> > > Lukas Bulwahn (1):
> > >       MAINTAINERS: fix style in KEYS-TRUSTED entry
> > >
> > > Sasha Levin (2):
> > >       tpm/tpm_ftpm_tee: A driver for firmware TPM running inside TEE
> > >       tpm/tpm_ftpm_tee: Document fTPM TEE driver
> > >
> > > Stefan Berger (2):
> > >       tpm_tis_core: Turn on the TPM before probing IRQ's
> > >       tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts
> >
> > Hi Jarrko,
> >
> > I'm replying here because I can't find the patches to reply to
> > directly from LKML.
> >
> > Commit 7f064c378e2c "tpm_tis_core: Turn on the TPM before probing
> > IRQ's" in the v5.3-stable tree caused a regression on a pre-release
> > platform with a TPM2 device. The interrupt starts screaming when the
> > driver is loaded and does not stop until the device is force unbond
> > from the driver by:
> >
> >      echo IFX0740:00 > /sys/bus/platform/drivers/tpm_tis/unbind
> >
> > I checked v5.4-rc8 and it has the same problem. I tried reverting:
> >
> > 1ea32c83c699 tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts
> > 5b359c7c4372 tpm_tis_core: Turn on the TPM before probing IRQ's
> >
> > Which silenced the screaming interrupt problem, but now the TPM is reporting:
> >
> > [    3.725131] tpm_tis IFX0740:00: 2.0 TPM (device-id 0x1B, rev-id 16)
> > [    3.725358] tpm tpm0: tpm_try_transmit: send(): error -5
> > [    3.725359] tpm tpm0: [Firmware Bug]: TPM interrupt not working,
> > polling instead
> >
> > ...at load, where it was not reporting this previously. Can you take a look?
>
> It is already in WiP:
>
> https://patchwork.kernel.org/patch/11240111/

That fix did not work for me.

>
> Stefan also sent patches that revert to changes that you described:
>
> https://patchwork.kernel.org/cover/11262363/
>
> Probably better first to fix the issue on top of master before deciding
> actions.

Revert and try again sounds good to me.

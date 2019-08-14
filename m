Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98DBC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9B82084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802403;
	bh=cXqilVKacRFXF1CHJC47PiTFUzhALt1B27Dx/pfjrGQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=U7HCp4kYocbwnoo8cZJZ4hjoQA2V6nmzGMZT5gm2V96942crwwKNteCInMsxG2yCt
	 TAl/9PbktpszqhFDpLY7Xd6N40bNRyQlHeHNye1qBQ/qxhsmy227CoK/NGoFqfxLuF
	 N7tsdZ8v60nd8zk9GdhjVSq/rbGllQmK3daqHAK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbfHNRGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:06:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44981 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbfHNRGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:06:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id e24so8774151ljg.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 10:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qmLXQ1DX4enCLG/blcVpIzNK/UzBgUaIlDbRYanVvW4=;
        b=Csf25HiuxApDjXUxMS0pWtKyfLzVjYG4VXzOleml//uHgzP+qL0YwcJqGaQuNRQpl+
         2SYQ8+b2PWgohIGByl+o5JyIcIk29Yc8tix8B3PRd7owe8Qz46sqgTFXQlaKOw2YUepA
         ZDOaJE5DMkDYDpikit2AFTUhw9j/S3D2wNmEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qmLXQ1DX4enCLG/blcVpIzNK/UzBgUaIlDbRYanVvW4=;
        b=BmSvlvynodXA151rMDSIWgg2dYkVL2HlwYvWMeftyk0W6TRb8aDnkZf7HaLImpHZa5
         k5u+fVU7LwTdTgxWQmFMaUmClQMuCh4+yHLM97uDXq8csh+y5q/upog3Jw40CmLFmA4K
         FJ+ziPmrT0kWqo9/NXHGIkj4tsvvlqyY2CAdM35JcM9RBWcHRFtdkGs3DlwcbXZLu2AR
         9/lZ6KA0iCvVM97b8ktNLygDGcNNiAHFJ6SbgMvXOoRlX82QuTWeFhHt9PuxoGlYFw9u
         vM9X8FK6+x6ZZEGPqOQ1h1qs15b472syYy80oQ8Kx/08+xOevAcHlqAqIrNZrY3Z0IJJ
         biCA==
X-Gm-Message-State: APjAAAUEnKqhOJEzYilWRKE2DBGW/VyUG1g6HZ0XJhA9PctzLO3I8NHn
        ky5O8EPVku8kxMonPKuDcpSBv9yhUTY=
X-Google-Smtp-Source: APXvYqwg5eZjU1FeBRhWalrBU3++A6LyNs+xdJIK0ekG3UKQJDeak5yDut8Tx0aVP3RD0+aCWZ+fRw==
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr403887lji.41.1565802397607;
        Wed, 14 Aug 2019 10:06:37 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id a15sm23537lfl.44.2019.08.14.10.06.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2019 10:06:36 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id x3so26094270lfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 10:06:36 -0700 (PDT)
X-Received: by 2002:ac2:4c12:: with SMTP id t18mr235524lfq.134.1565802395958;
 Wed, 14 Aug 2019 10:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
 <20190814154400.6371-1-christian.brauner@ubuntu.com> <20190814154400.6371-2-christian.brauner@ubuntu.com>
 <20190814160917.GG11595@redhat.com> <20190814161517.ldbn62mulk2pmqo5@wittgenstein>
 <20190814163443.6odsksff4jbta7be@wittgenstein> <20190814165501.GJ9017@brightrain.aerifal.cx>
In-Reply-To: <20190814165501.GJ9017@brightrain.aerifal.cx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Aug 2019 10:06:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpoeAnhscv9+fKNLLJF0tvypGPAxyzBCa0rp5hppRDRQ@mail.gmail.com>
Message-ID: <CAHk-=wgpoeAnhscv9+fKNLLJF0tvypGPAxyzBCa0rp5hppRDRQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] waitid: Add support for waiting for the current
 process group
To:     Rich Felker <dalias@libc.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Alistair Francis <alistair23@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        Palmer Dabbelt <palmer@sifive.com>, macro@wdc.com,
        Zong Li <zongbox@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 9:55 AM Rich Felker <dalias@libc.org> wrote:
>
> I don't think "downsides" sufficiently conveys that this is hard
> breakage of a requirement for waitpid.

Well, let's be honest here. Who has _ever_ seen a signal handler
changing the current process group?

In fact, the SYSV version of setpgid() takes a process ID to set it
*for somebody else*, so the signal safety is not even necessarily
relevant, since it might be racing with _another_ thread doing it
(which even the kernel side won't fix - it's just user space doing odd
things).

So yes - it's technically true that it's impossible to emulate
properly in user space.

But I doubt it makes _any_ difference what-so-ever, and glibc might as
well do something like

     ret = waitid(P_PGID, 0, ..);
     if (ret == -EINVAL) { do the emulation }

which makes it work with older kernels, and has zero downside in practice.

Hmm?

              Linus

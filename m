Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953DCC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 20:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6993221736
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 20:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrUHVKWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfK2UFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 15:05:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59637 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726926AbfK2UFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 15:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575057953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RP2PHwp5wZl3ztgeJTb35J2c98KyKZ9pDDlofVv46EI=;
        b=hrUHVKWMIHROTUGhPXm+0v868zAudvzVEXurJaR8hifulObOGO+9qc+KjZkIE5ewHMg7p3
        usJEIHYqXDz4rf8yt3yzHBMiHSLk1XL/zskhK6NN3eMSjM5uPGq5BVB//B7sup8LVlVNh+
        Vdhq1aslXHmCjzECr9NT2GZ9x2gzbNQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-gag-o1OlNwOMuEHnQhiwSw-1; Fri, 29 Nov 2019 15:05:52 -0500
Received: by mail-lf1-f72.google.com with SMTP id j16so6446259lfk.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 12:05:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zCyHxNb/EFCllk+iZMx0l93yQzrOq+uBxpToCPQHS9k=;
        b=DUqiIv6QOaYBcUj6lANGWAEN7j9e6Lm/zP6WNxsot0RenxHC13Hg8nonjYu/30O2z1
         lJQ5skj02cpxc0N+1wwgbqfVhy7NH544FY3krwqHluwxMUYIrkJZIj3YE7/C2AZD7vRN
         ITinlmZHWXevEiAHYgUiIqih0d91Vbhr6xIkl4dZkpMRtkX6TbicxaIN9XKGvwWtg+dg
         GLVU/pI1ZtQc93tTwGTIJs+HvMVHlc2GKdR3Ix5Vnskqv5DdWl8CEZLFmncmVAR3T/tx
         UCHuUg7BnlsVwZ1Lbj49FJXnqHsbu6ylGP/jXfKa2BKxqEwGcnlptFPHk9Ma4iGDDixn
         NLpQ==
X-Gm-Message-State: APjAAAXbB3hLZGNYwC6TI5Sspso0Mc3XPHRS/SzEQ8RcURbJA1KMk5Sw
        xsViQ/jPPxO8ZkHEF4L7ni33AYYZt1MBRbOR8F6BfdVnxO4V2V2gAvxxjgxXS+cZ7U8PiIWL1Sn
        sdajLEdyEKJ0eGHEFgG2xLQ0wOlrlSQKyoaOnDNYL
X-Received: by 2002:a2e:9a41:: with SMTP id k1mr12682048ljj.235.1575057949817;
        Fri, 29 Nov 2019 12:05:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqz0eILOnKMVbbahC3Rp/NyuV7+7BmZiagne10VkRMygf99/om+7iSrw3qCYWoCJXV2cv5Un/9KS0XCSQp5JswM=
X-Received: by 2002:a2e:9a41:: with SMTP id k1mr12682025ljj.235.1575057949585;
 Fri, 29 Nov 2019 12:05:49 -0800 (PST)
MIME-Version: 1.0
References: <1574972621-25750-1-git-send-email-bhsharma@redhat.com> <20191129102421.GA28322@willie-the-truck>
In-Reply-To: <20191129102421.GA28322@willie-the-truck>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Sat, 30 Nov 2019 01:35:36 +0530
Message-ID: <CACi5LpNQPw41kGsW+d0PyZaC7gSrbgwT2VxwyO5r3j83h-mkEQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Append new variables to vmcoreinfo (TCR_EL1.T1SZ
 for arm64 and MAX_PHYSMEM_BITS for all archs)
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        Boris Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>
X-MC-Unique: gag-o1OlNwOMuEHnQhiwSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Fri, Nov 29, 2019 at 3:54 PM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Nov 29, 2019 at 01:53:36AM +0530, Bhupesh Sharma wrote:
> > Changes since v4:
> > ----------------
> > - v4 can be seen here:
> >   http://lists.infradead.org/pipermail/kexec/2019-November/023961.html
> > - Addressed comments from Dave and added patches for documenting
> >   new variables appended to vmcoreinfo documentation.
> > - Added testing report shared by Akashi for PATCH 2/5.
>
> Please can you fix your mail setup? The last two times you've sent this
> series it seems to get split into two threads, which is really hard to
> track in my inbox:
>
> First thread:
>
> https://lore.kernel.org/lkml/1574972621-25750-1-git-send-email-bhsharma@r=
edhat.com/
>
> Second thread:
>
> https://lore.kernel.org/lkml/1574972716-25858-1-git-send-email-bhsharma@r=
edhat.com/

There seems to be some issue with my server's msmtp settings. I have
tried resending the v5 (see
<http://lists.infradead.org/pipermail/linux-arm-kernel/2019-November/696833=
.html>).

I hope the threading is ok this time.

Thanks for your patience.

Regards,
Bhupesh


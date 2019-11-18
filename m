Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEBAC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520EE222A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tLp0mDyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfKRUtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 15:49:01 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43402 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKRUtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 15:49:00 -0500
Received: by mail-io1-f68.google.com with SMTP id r2so15247085iot.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 12:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYUPL7LYiLpbPi62Bde1AvyYTd/DiPcC72K5qbOI79Q=;
        b=tLp0mDyhCWsmlvFSx/dRK982ALccECmnMaIW5vb4h2pOf7zB+DibalBCVnzvaEe6pj
         E5hZPEh3GaEpF0L589QNGtf3/DfzO1PfwabJrlax2XbAvL4npKCiCX7zzZbNFoU9gQzk
         +GpPwFDYiAtDOD/h8h+n4hZ/40LCsEs+H9LaiGO0swo48XE60CKxTjzemdre2YhFNOBZ
         EwXWYr5hKKP/lJ4yNVyusMRV6Hj2U0b+MGfG5+qmSnEvAEx62Z7XeLmdT7cUyW6ws4gv
         ayxGmjezQ7YfsSyKsZdakRize3JycjielCGP0IZfi4kFxE1LQpvSiPZGnaBhoHGF5nXe
         VRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYUPL7LYiLpbPi62Bde1AvyYTd/DiPcC72K5qbOI79Q=;
        b=uMvytGVbfJxYO1HdfppnZ1VyV5aWXJkS69SwC/hh3iIYintRIMeIAzo5296l1+QXki
         N21HiLa6HfuYKBwQBCirBMZa1VMK+kwTQKrUchFd/YgO/FJKfvs0qB3pCv/wxbsd4wlO
         IwJNcl9El9vxAY7ZnSKuDwlXJQVtFo50n14DJTxSfyCJvnCO+WTVsufll2uLLDQUy+OC
         9XiBTAjMrJFpEZHTBzOHEEgpWztH1RXxnCeoHbSXcQRjeaYsHDL7uFx9ngvu66YtJrn0
         HqaLI6ipdfznJv7EmLcL/IjWDQY6ouQTTmliUqMM99zo6P+r8s79LcBTts+cf+khYeWn
         55Nw==
X-Gm-Message-State: APjAAAXUDCi8kr7tpcbXNL0NNR1AkFGBSDTW/Bh4oKlVuCFipBE38xjc
        me/c380XG/0/9YL2DYKfbRX+0eQkBVoRg9BwthaNDQ==
X-Google-Smtp-Source: APXvYqwGxn84c5252LqX6hJfnqETNfYhJ9uz/KdjP2d70/w96bBvjpt32Dqlk8iAqTtojNrJFUpGf4G3NrE43KIsLDY=
X-Received: by 2002:a02:1d04:: with SMTP id 4mr15810607jaj.48.1574110139684;
 Mon, 18 Nov 2019 12:48:59 -0800 (PST)
MIME-Version: 1.0
References: <1574101067-5638-1-git-send-email-pbonzini@redhat.com> <1574101067-5638-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1574101067-5638-2-git-send-email-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 18 Nov 2019 12:48:48 -0800
Message-ID: <CALMp9eQRZv75kBiqAaugqhSLxSoiAb-1bBz3YTk-EyWb4gfBDw@mail.gmail.com>
Subject: Re: [PATCH 1/5] KVM: x86: fix presentation of TSX feature in ARCH_CAPABILITIES
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 10:17 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> KVM does not implement MSR_IA32_TSX_CTRL, so it must not be presented
> to the guests.  It is also confusing to have !ARCH_CAP_TSX_CTRL_MSR &&
> !RTM && ARCH_CAP_TAA_NO: lack of MSR_IA32_TSX_CTRL suggests TSX was not
> hidden (it actually was), yet the value says that TSX is not vulnerable
> to microarchitectural data sampling.  Fix both.
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Ignore my previous comment. I see that the functionality I want is
coming later in this series.

Reviewed-by: Jim Mattson <jmattson@google.com>

Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E93FC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9A420B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T3/gJAXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfE1SO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:14:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40081 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbfE1SOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:14:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id s19so4968018edq.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 11:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NrgcPgHYGkaYgv7K/Tp1YWUKuygAmk8ZPyKQdnHtMXo=;
        b=T3/gJAXzSCD9ylg1zjwPF62H6wUuPSS2GpBRyhduNWz1LC2jLHVRN93Q4ebs4CfPIM
         ASMkGU8jM3dbdxifPr+cEGlU1N7KgjE8NkNvFIoCq2lviEfWs6ZeYrxrFVLerX7VhKV2
         ChqB6Gr39Cyw+nxO0labgQACSdXhjmnJ36Kw96T2G107InanNTWZMZ78McjRmPgQ9oYJ
         5Nzut0vDWIdfph0sYGa+YGahu/xk88dxzDtSJ+FCGHtWfZKDydFeJOYNxwEHCvbkgfm0
         myOtABdWdGbXHLoksGcwCqDETiW26zmkHEEPkWo+M+k5y7Rph/Azitux+7x5zMrDcVg9
         QXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NrgcPgHYGkaYgv7K/Tp1YWUKuygAmk8ZPyKQdnHtMXo=;
        b=tMREKtvkTHSZDGMC2nZ0H6jX+fGmMSVr4OFinIa8JcvIRCJ5aE94Uca62TluA2314e
         LJeu5jfPOCTz68OMcn+YnK+SCi3hLsJVl8hP+SlhrHja5NUlk8Jt4Z0E0fi63r7FH8Wz
         1nVVXm3Dx0rtSt7Q1r/ZhZQ/2Ay6PqlpAC54SS3c+vZEvB3XN4xwGH0DybOLgfSO1XCg
         JJ+CQtSn3qVj0hMpatUAgVLqEq+AaxFizAxRJU4qYJ2pqlMRqEqZb8ipdHAERPT68GXY
         a7jedBVlfVpOcxDkuVkOJh68q6e3JLWMVtstq2e292vYIH57Uf7xR614DWaDHFdqUHct
         budQ==
X-Gm-Message-State: APjAAAVlCAYZypWT8aM6CwyW2+G3RykDuERZ0vvywGBnoLKnMZ97MWxB
        GEwOkxfkOzmisU+BgWYftB24w7W+dcfzuiIz/Xq8Ww==
X-Google-Smtp-Source: APXvYqzFgO874P6bYJZYu69xKIPKaNaCUI+QjzjRTExNmXTK3TI/bPou4lz2KNrfLNk12Bh1gl7jLRuPGMvixxUR+mk=
X-Received: by 2002:aa7:c391:: with SMTP id k17mr131122962edq.166.1559067263524;
 Tue, 28 May 2019 11:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAOyeoRWfPNmaWY6Lifdkdj3KPPM654vzDO+s3oduEMCJP+Asow@mail.gmail.com>
 <5CEC9667.30100@intel.com>
In-Reply-To: <5CEC9667.30100@intel.com>
From:   Eric Hankland <ehankland@google.com>
Date:   Tue, 28 May 2019 11:14:12 -0700
Message-ID: <CAOyeoRWhfyuuYdguE6Wrzd7GOdow9qRE4MZ4OKkMc5cdhDT53g@mail.gmail.com>
Subject: Re: [PATCH v1] KVM: x86: PMU Whitelist
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 6:56 PM Wei Wang <wei.w.wang@intel.com> wrote:
>
> On 05/23/2019 06:23 AM, Eric Hankland wrote:
> > - Add a VCPU ioctl that can control which events the guest can monitor.
> >
> > Signed-off-by: ehankland <ehankland@google.com>
> > ---
> > Some events can provide a guest with information about other guests or the
> > host (e.g. L3 cache stats); providing the capability to restrict access
> > to a "safe" set of events would limit the potential for the PMU to be used
> > in any side channel attacks. This change introduces a new vcpu ioctl that
> > sets an event whitelist. If the guest attempts to program a counter for
> > any unwhitelisted event, the kernel counter won't be created, so any
> > RDPMC/RDMSR will show 0 instances of that event.
>
> The general idea sounds good to me :)
>
> For the implementation, I would have the following suggestions:
>
> 1) Instead of using a whitelist, it would be better to use a blacklist to
> forbid the guest from counting any core level information. So by default,
> kvm maintains a list of those core level events, which are not supported to
> the guest.
>
> The userspace ioctl removes the related events from the blacklist to
> make them usable by the guest.
>
> 2) Use vm ioctl, instead of vcpu ioctl. The blacklist-ed events can be
> VM wide
> (unnecessary to make each CPU to maintain the same copy).
> Accordingly, put the pmu event blacklist into kvm->arch.
>
> 3) Returning 1 when the guest tries to set the evetlsel msr to count an
> event which is on the blacklist.
>
> Best,
> Wei

Thanks for the feedback. I have a couple concerns with a KVM
maintained blacklist. First, I'm worried it will be difficult to keep
such a list up to date and accurate (both coming up with the initial
list since there are so many events, and updating it whenever any new
events are published or vulnerabilities are discovered). Second, users
may want to differentiate between whole-socket and sub-socket VMs
(some events may be fine for the whole-socket case) - keeping a single
blacklist wouldn't allow for this. Let me know what you think. I'll
try implementing the other suggestions.
-Eric

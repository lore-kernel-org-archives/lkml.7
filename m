Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89BAC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D56E2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FG8b5drl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbfHOQZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:25:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33824 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731591AbfHOQZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:25:53 -0400
Received: by mail-io1-f65.google.com with SMTP id s21so293017ioa.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 09:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6grQ9ocx+IbTwjVEIDedYoYdf4O0M4fR1quq8TS70BA=;
        b=FG8b5drlg1DYNIfZgQ6q7wA0xgFXi0ISvlwrU2ezrkleGRnPhC6qzdm3SG0FXSCCVr
         4/+1jBiqIA/aBL/u4qxHoe5NMGu0WLlajJzgMMexeGB9cwiSUIbxX3AD8h9wn7HWJqyy
         nPWcuORgsACRu+FkFGvFc+Xq0N50z0kcVMdR0HIF/1ABEe2wupgfPrjwsy/1OddU/DCf
         zGf0IW7nYz9h5AupmY/Kmz5IVJRNmQI5/hil5Rxq0MDbDjzwUixSUDBB8SC6tVLnFnoy
         WKvTJnuBlqoZmkhsbbW6jTzaG8lq2oyNSIlWVAJ1F3s12sbmXRTLWmpeY4SfwWJfvhtR
         4/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6grQ9ocx+IbTwjVEIDedYoYdf4O0M4fR1quq8TS70BA=;
        b=X24Yfz86T2Puh41Y4N85FCgWHLLTh9qWFOYYUucxfBaWiYqLzFTobFfD7JBv8bB2q8
         D4WZOaVQlfCaOIWNjyzN54SbyCsmvPZn9XSPaoJxBjDHZxdydthJtqFYK4gSE7dFvQXh
         nATsEkfTfiHv1svt3TBZRz4mCQ6wmxZUrI32bNm7wGEPWhTYbYfIvGooB4R2ULe6dGO6
         IwjKh3dos3XYdBzRQX5YvaFc4L6HRGK85Bw2hKvYqKR3lGUWfQOp5r4wu5Npc9ZdMWl3
         v4WkV93HMp8CWt1pMUQyT2Y+jICa5vwxlyuXm37n3+8xxUwCzmtEBr17M1bZZaqaT5aI
         f4dA==
X-Gm-Message-State: APjAAAX5QZzgg/ZgChtRaok97ctwDTygqeH+7Apuv4BPUsg9sOQ4gY3o
        zKOkd6cLnjRFRVawB7ue5oTqNrh0e0px3s+OYxJzaw==
X-Google-Smtp-Source: APXvYqyf9+Wim/8xYX70CueSMMJFpdBB0isWORRNM9dKAVYwLKlJdkjTd7rPjPhyK/rPq/lhMRobLGD79cfX57Cw+hI=
X-Received: by 2002:a05:6638:52:: with SMTP id a18mr5943400jap.75.1565886352617;
 Thu, 15 Aug 2019 09:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190814070403.6588-1-weijiang.yang@intel.com>
 <20190814070403.6588-6-weijiang.yang@intel.com> <87a7cbapdw.fsf@vitty.brq.redhat.com>
 <20190815134329.GA11449@local-michael-cet-test>
In-Reply-To: <20190815134329.GA11449@local-michael-cet-test>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 15 Aug 2019 09:25:41 -0700
Message-ID: <CALMp9eTGXDDfVspFwFyEhagg9sdnqZqzSQhDksT0bkKzVNGSqw@mail.gmail.com>
Subject: Re: [PATCH RESEND v4 5/9] KVM: VMX: Add init/set/get functions for SPP
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        yu.c.zhang@intel.com, alazar@bitdefender.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 6:41 AM Yang Weijiang <weijiang.yang@intel.com> wrote:

> Hi, Vitaly,
> After looked into the issue and others, I feel to make SPP co-existing
> with nested VM is not good, the major reason is, L1 pages protected by
> SPP are transparent to L1 VM, if it launches L2 VM, probably the
> pages would be allocated to L2 VM, and that will bother to L1 and L2.
> Given the feature is new and I don't see nested VM can benefit
> from it right now, I would like to make SPP and nested feature mutually
> exclusive, i.e., detecting if the other part is active before activate one
> feature,what do you think of it?
> thanks!

How do you propose making the features mutually exclusive?

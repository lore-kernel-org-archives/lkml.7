Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DB4ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04602206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a4E+QR58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbfJIXJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 19:09:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34177 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732216AbfJIXJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 19:09:04 -0400
Received: by mail-io1-f65.google.com with SMTP id q1so9368157ion.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 16:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=04I6JvLL73sHkqFukHW/pBgcgyWl40dzjRVRv0SLA4s=;
        b=a4E+QR58E+fjhLkriMSlZuXXpTfzmig7l3yf2uah/stPOVL7ue7vaSFlPBFjDU4y2Y
         4lsxIcxZBActXz7U1lippdfv2lkM3Si9dLMwsonQvK3iZUk58K4droJV2UpoIzrxw6Ko
         XuLoNIEO+fz6QeGLe6xr9sZWL6zswm9j7uI5fVkfrepIr82iaBY0voVGIHkTYVwhpJWJ
         uxH73aLiqPuPe8iE33rzG1rgCBPDcy9cvMH65cNDFTXpbScmAt9YfDQurWDWL+MtEeJn
         4vBTwJeWs7Zvmuc9aO9X/8SK9RqVv8CVvGnYlsNkAHyLHuG2xshQv83viWZbO7X3Loe8
         g/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=04I6JvLL73sHkqFukHW/pBgcgyWl40dzjRVRv0SLA4s=;
        b=RYIyz8tYyhjBJhvXNQicswzrYmgr1hIl3yb4ca+t7t5dgTXZ389R9/tnamqToQJI3g
         CdRmQz7EN/JUkSsKdA2dl1yGsWXI8gJHcrIdQSd9y6I7velltDhNIIsojtyKvXjXPzkf
         GrbRUfYHYjY23fmWLx6/+0us4RCBuUWEnb9KGu9uxk5tRWpr4f3lF6RJ47iLgbyKsHZu
         fawpykBJFM4zDH1KK6dtrxXCZJ6BIFOtWQU3hrjVXsbzQ7NxPXAqDLp8iEjw+e60Tp13
         bB0kRO0BwBG+gEtR44iLzKcinU4uepoMn+qzf0X+8mcVmvTkJR/uPPOcuUZZrzKnGitT
         6xZA==
X-Gm-Message-State: APjAAAVJ10g9Z5BLOB4As9Esvi2xr5wI5pNO4cdId1S0T+jMLY9Cf6+c
        T2KXVr0wwJM56O1UBcPvOdbUWTfpwXVbVucb3oKkLLrt
X-Google-Smtp-Source: APXvYqxW2vcvVvgD7G2Iin7gSbdBs9UYvswVuxNBZHwfiUqfZY5Oo4tnhqjqG03EuGfUnOanbcOy2ZxXm7iKWKiCVyw=
X-Received: by 2002:a6b:d210:: with SMTP id q16mr6918314iob.108.1570662541892;
 Wed, 09 Oct 2019 16:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190927021927.23057-1-weijiang.yang@intel.com>
 <20190927021927.23057-5-weijiang.yang@intel.com> <CALMp9eS1V2fRcwogcEkHonvVAgfc9dU=7A4V-D0Rcoc=v82VAw@mail.gmail.com>
 <20191009064339.GC27851@local-michael-cet-test>
In-Reply-To: <20191009064339.GC27851@local-michael-cet-test>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 9 Oct 2019 16:08:50 -0700
Message-ID: <CALMp9eS+_riWYK=Zvk330YST4G_q_GfN2LfGXWz85aVnyXmsOg@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] KVM: VMX: Load Guest CET via VMCS when CET is
 enabled in Guest
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 11:41 PM Yang Weijiang <weijiang.yang@intel.com> wrote:
>
> On Wed, Oct 02, 2019 at 11:54:26AM -0700, Jim Mattson wrote:
> > On Thu, Sep 26, 2019 at 7:17 PM Yang Weijiang <weijiang.yang@intel.com> wrote:
> > > +       if (cet_on)
> > > +               vmcs_set_bits(VM_ENTRY_CONTROLS,
> > > +                             VM_ENTRY_LOAD_GUEST_CET_STATE);
> >
> > Have we ensured that this VM-entry control is supported on the platform?
> >
> If all the checks pass, is it enought to ensure the control bit supported?

I don't think so. The only way to check to see if a VM-entry control
is supported is to check the relevant VMX capability MSR.

BTW, what about the corresponding VM-exit control?

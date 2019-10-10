Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFB4C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 23:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169F920B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 23:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQSqMQwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfJJXob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 19:44:31 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45759 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfJJXoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 19:44:30 -0400
Received: by mail-io1-f67.google.com with SMTP id c25so17563650iot.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 16:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Tn2P8fhQIwWSUcG8Ny4e4ny/sLUaj89L7ixuEf482Q=;
        b=SQSqMQwOhvRWiFoM/d8fnha7YNV8lyIvctWJ7jkN5lsCe2eRcYoIjFYEY3PXVXbD0P
         EECgrtNOeQ3b2Bnb8HMiD+zFD5Ge/laomPtOWcPoT55NsodLXiCL+OAV1bnguJPvy7au
         lmV5NJH3l+5KzRSLpe4oG11fnx8/xaL5cO25g6Ew72qGMPFjCMCM72B0PnHvN1ESxQj1
         1gWpAyp59kEr3hHzPdOjCcXt5f6MLTp5xOk4LG6ACFd1y/IcErqwx4LKv7KxzvTbLHmT
         qgVtxinc8NleD/3OCtbZJYrxFVy4MI2IwDQTdDE2USgwFYO+qc9Hd8MJrZAAT+k/TCsF
         Ctsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Tn2P8fhQIwWSUcG8Ny4e4ny/sLUaj89L7ixuEf482Q=;
        b=jhfkeYDfDAoV5LIg/3sIeVNLN5zwrgGrrA/jd5xEEtkCfGAS5KywyzzMKeeYZQHaz2
         4xYZLQbFChD6n9MKRXfs8ENSMTN0BoEPZ4X9/znE3akQqUNrjj0VH53EK9f/l/aV/wBq
         UMsmEo3vK98TlTXdr1QQ8NcqA7q0eEEPJfglAk63P9U5llbmS75RN0hjnGEQE6SQLnUk
         mwFV4ykXxhdQmTEMzwvFhYmEibSbe7TMPm+jyAzw6w2fmKF2bve8f2zPnancxIFfBPhi
         CcouFJb7A5NsS/iKsKn7BEL0W9uPy1jjCFD+uXgs8J8i60nEzfRa+IuHYtvwtF7NsTvv
         TOOQ==
X-Gm-Message-State: APjAAAX323Oha7eJntpt1220JUoJU8pUEzmEECGaUf0hxZVTLZXVIRKY
        jvt4F2mjAPiECOS5UxgYjLIkWuxzj7uwUt1DXoUW1g==
X-Google-Smtp-Source: APXvYqx7b5/tihhmmawVJ+Ch5GbtCH77LKwDSvV6HW+AKJew/Ha9L+zceMxT97z9J8tyJzO/H1bBwCs1GwHAjIkZj3Q=
X-Received: by 2002:a6b:6f0a:: with SMTP id k10mr4331789ioc.118.1570751069096;
 Thu, 10 Oct 2019 16:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190927021927.23057-1-weijiang.yang@intel.com>
 <20190927021927.23057-5-weijiang.yang@intel.com> <CALMp9eS1V2fRcwogcEkHonvVAgfc9dU=7A4V-D0Rcoc=v82VAw@mail.gmail.com>
 <20191009064339.GC27851@local-michael-cet-test> <CALMp9eS+_riWYK=Zvk330YST4G_q_GfN2LfGXWz85aVnyXmsOg@mail.gmail.com>
 <20191010013027.GA1196@local-michael-cet-test.sh.intel.com>
In-Reply-To: <20191010013027.GA1196@local-michael-cet-test.sh.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 10 Oct 2019 16:44:17 -0700
Message-ID: <CALMp9eRPyyVVsWEQu_vxt7fMp9jkFcC4x3dGdMvchLVRExQ6DA@mail.gmail.com>
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

On Wed, Oct 9, 2019 at 6:28 PM Yang Weijiang <weijiang.yang@intel.com> wrote:
>
> On Wed, Oct 09, 2019 at 04:08:50PM -0700, Jim Mattson wrote:
> > On Tue, Oct 8, 2019 at 11:41 PM Yang Weijiang <weijiang.yang@intel.com> wrote:
> > >
> > > On Wed, Oct 02, 2019 at 11:54:26AM -0700, Jim Mattson wrote:
> > > > On Thu, Sep 26, 2019 at 7:17 PM Yang Weijiang <weijiang.yang@intel.com> wrote:
> > > > > +       if (cet_on)
> > > > > +               vmcs_set_bits(VM_ENTRY_CONTROLS,
> > > > > +                             VM_ENTRY_LOAD_GUEST_CET_STATE);
> > > >
> > > > Have we ensured that this VM-entry control is supported on the platform?
> > > >
> > > If all the checks pass, is it enought to ensure the control bit supported?
> >
> > I don't think so. The only way to check to see if a VM-entry control
> > is supported is to check the relevant VMX capability MSR.
> >
> It's a bit odd, there's no relevant CET bit in VMX cap. MSR, so I have
> to check like this.

Bit 52 of the IA32_VMX_ENTRY_CTLS MSR (index 484H) [and bit 52 of the
IA32_VMX_TRUE_ENTRY_CTLS MSR (index 490H), on hardware that supports
the "true" VMX capability MSRs] will be 1 if it is legal to set bit 20
of the VM-entry controls field to 1.

> > BTW, what about the corresponding VM-exit control?
> The kernel supervisor mode CET is not implemented yet, so I don't load host CET
> states on VM-exit, in future, I'll add it.

If you don't clear the supervisor mode CET state on VM-exit and the
guest has set IA32_S_CET.SH_STK_EN, doesn't that mean that
supervisor-mode shadow stacks will then be enabled on the host after
VM-exit?

Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B4FC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5A92190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rxsDhgIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfGYN0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:26:35 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45996 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfGYN0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:26:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id m23so47915628lje.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 06:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vq1nmmnAokEWi6IeeQFF/Sj1eC/PC82lAqP5SEvu0eI=;
        b=rxsDhgIXtyO7uV/fBbnWgz1a050eJfJt36cd+xIy+sc6LSML9a1bt0Oonq2Dhcq0Nn
         i9OQ0cm7OQUO7961kjhNW3cPXmjkWMo+F/+IWzwmV0zx3aIk7WqX60RSI99k8n3vHJsN
         J0IfNv75l1I6SN8MBb186ufzkSTkIBI2h/if5QfSFLoLAZ8NU1WIPiU4o8KvP7wxRCnL
         0+QqRxKpNMJ4vTrQjgSz0Z72XTSb8cqNLTf29DIUgysxxPJDw5G4Kx745P4DySPla3zp
         mvsXwRnsdPDe4zxfL9UDg6nlDdp/hQjGY2aXGL2SShlB36uScGod+oyYT1h8wWSKB2sy
         mgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vq1nmmnAokEWi6IeeQFF/Sj1eC/PC82lAqP5SEvu0eI=;
        b=isaAmPHHCDPy9BEtwkv5FJ7kOpj72L+VnxGf5a7lmCh15+8NmiwJrgbb3TLgD5wdEp
         xzbU6g+LMOAI7KOOEyI+Io5+31TbfwNlaukItc73zlUjdd6GwX7N0DVMJBMU2/Ob7Q+R
         BRN5/b7dxcBwz6YvzYeOpCohR2wLhvCpmFWsouWzyLDm0Ryoa4VspPlIJ8J92stn8vXz
         U6QywFDQs9vFd3MneN3yJtwDqVOr/77Xx376cjNqpdzyvKDsUBSt257eKTpVVO++c+gl
         hBHs4MbpOegvFCkTOMBUpcfkC37Ui5gdH/Tw6AzZEKdNVYTFcLy/GWF3Z8aUt9hX05nw
         0PWg==
X-Gm-Message-State: APjAAAVnTRkmm0Jiu7jMOInnSb0dCfKnhfU3evWTnOCNulev+nWyvkbv
        UX4stcW2z3cWMBI1wwp0tpU3BIrdd8k1RaGq39ocgw==
X-Google-Smtp-Source: APXvYqyw66/Sf84tPzZxGkwYYc6jtAysQYq8MKoYuMY/aQJzca4JUqEOIuiImP+kz3UDj00OHYOKCGgqyA5GwFzPp1g=
X-Received: by 2002:a2e:8559:: with SMTP id u25mr45784601ljj.224.1564061192579;
 Thu, 25 Jul 2019 06:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190724191735.096702571@linuxfoundation.org> <CADYN=9+WLxhmqX3JNL_s-kWSN97G=8WhD=TF=uAuKecJnKcj_Q@mail.gmail.com>
 <20190725113437.GA27429@kroah.com>
In-Reply-To: <20190725113437.GA27429@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 25 Jul 2019 18:56:20 +0530
Message-ID: <CA+G9fYugOviC4W87AMFN3EfyXhSuEWitTX7t+v4G_EbhfQgLAg@mail.gmail.com>
Subject: Re: [PATCH 5.2 000/413] 5.2.3-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Regressions (compared to build v5.2.2)
> > ------------------------------------------------------------------------
> >
> > x86:
> >   kvm-unit-tests:
> >     * vmx
> >
> >
> > TESTNAME=vmx TIMEOUT=90s ACCEL= ./x86/run x86/vmx.flat -smp 1 -cpu
> > host,+vmx -append \"-exit_monitor_from_l2_test -ept_access* -vmx_smp*
> > -vmx_vmcs_shadow_test\"
> > [  155.670748] kvm [6062]: vcpu0, guest rIP: 0x4050cb
...
> > [  158.479030] nested_vmx_exit_reflected failed vm entry 7
> > [  161.044379] set kvm_intel.dump_invalid_vmcs=1 to dump internal KVM state.
> > FAIL vmx (timeout; duration=90s)
> >
> > kernel-config: http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-corei7-64/lkft/linux-stable-rc-5.2/14/config
> > Full log: https://lkft.validation.linaro.org/scheduler/job/836289#L1597
>
> Ick.
>
> Any chance you can run 'git bisect' to find the offending patch?  Or
> just try reverting a few, you can ignore the ppc ones, so that only
> leaves you 7 different commits.

We have started 'git bisect' please allow sometime.

> Does this same test pass in 5.3-rc1?

yes.
kvm-unit-tests: vmx test getting PASS on 5.3-rc1 mainline kernel [1].

ref:
[1] https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/kvm-unit-tests/vmx

- Naresh

>
> thanks,
>
> greg k-h

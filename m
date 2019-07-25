Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189D9C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3320217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p4Ymi9d4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbfGYOF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:05:27 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39665 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfGYOF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:05:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id v85so34590514lfa.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 07:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9/jZZ/wGnP4XWWrJc72aqLii2UTG2NwmOzZLmtfRTs=;
        b=p4Ymi9d4D9XehufPPYM3MBV2tV9cdOfbvGrKviwyG9mm1Fz+1Lhj/EvtnJFkUuvb/M
         Dvp3VSClPna6uot0vw3CeRe0QVO8nHL9jDc+8gLAiiBQvM7wdLspbW75YMB0Ww/+FeoV
         riLvHNfz3XNWziFaCqafOlGiHbZ0Wt8FWFrNdGMX/6luZQ0UWqicnNQSDQiFnMYKfVMe
         Gfo+VMlNlmk4dFTfWVf6LrsMH2+X73YQu0rSqumeYwVBUYgvjR4Za1ISnUUyAb2Lv9Iw
         fPNmxkEWtnjoJ9Q6vw24BrmrLRn6qsngmwjFse3wrINa4AjDAD6y/+5ZPIpTESFFGrhh
         7Pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9/jZZ/wGnP4XWWrJc72aqLii2UTG2NwmOzZLmtfRTs=;
        b=oGUkj8SWCpPCxgnS9VE8+oUggJlRiqOinwFYXGm/uwAcwbYXfZYnoPxgbxBxRQr1W2
         ewxVfE0/nOykAfQpg3IV06NMFvVX8SceS0941G1j48Y1779H3F95H+GtHujX97XMM/fR
         nD+Ga6kVfoiL06GlZ6cNVN8HNDUwlsPhh6KPTXlMr3TCHqyHpZAz/njSCGIZVxrRy0pL
         RPpH1fc79J4dcGFNW6h57q4jWbsbusk8REcmQ93LPOykRxRJw+9h0/qJ7lcre4te8BF6
         lUlIBAZHoh7aZcHYoezGQfG4xpElVCXMD9lR7+JTwKHU1r/+VzHMhdMHPeXgL8tHI+sZ
         eY+w==
X-Gm-Message-State: APjAAAXyExoJiGybkT4OOc9UsgoEEfjEaKUXvv4AmFs3K+KsZb6C9r52
        ms1ig01HItMuiHw42MYwi0DRXWrvvKI55qA1bpmNCA==
X-Google-Smtp-Source: APXvYqw49ekawAIJPp2WQWsuoc36ITRLiJynGhiqAqMikOBa1iHIBQHs/lNKNYo3CAFkg4pZfV1Z78Uez67ejwLDOic=
X-Received: by 2002:ac2:546a:: with SMTP id e10mr42095604lfn.75.1564063525132;
 Thu, 25 Jul 2019 07:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190724191735.096702571@linuxfoundation.org> <CADYN=9+WLxhmqX3JNL_s-kWSN97G=8WhD=TF=uAuKecJnKcj_Q@mail.gmail.com>
 <20190725113437.GA27429@kroah.com> <230a5b34-d23e-8318-0b1f-d23ada7318e0@redhat.com>
In-Reply-To: <230a5b34-d23e-8318-0b1f-d23ada7318e0@redhat.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 25 Jul 2019 19:35:13 +0530
Message-ID: <CA+G9fYsWdmboyquZ=Bs3tkTwRFTzd1yuL0_EVpHOecNi4E_stA@mail.gmail.com>
Subject: Re: [PATCH 5.2 000/413] 5.2.3-stable review
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        wanpengli@tencent.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        patches@kernelci.org, sean.j.christopherson@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, jmattson@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo,

On Thu, 25 Jul 2019 at 19:17, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 25/07/19 13:34, Greg Kroah-Hartman wrote:
> > Any chance you can run 'git bisect' to find the offending patch?  Or
> > just try reverting a few, you can ignore the ppc ones, so that only
> > leaves you 7 different commits.
> >
> > Does this same test pass in 5.3-rc1?

Yes. same test pass on 5.3-rc1
kvm unit test always fetching master branch and at tip
runs the latest test code on all branches
mainline 5.3-rc1 and stable-rc-5.2 branch

>
> Anders, are you running the same kvm-unit-tests commit that passed for
> 5.2.2?  My suspicion is that your previous test didn't have this commit

No.
I see two extra test code commits for 5.2.3
Re-tested 5.2.2 with tip of kvm unit tests sources and vmx test FAILED [1].

Greg,
This investigation confirms it is a new test code failure on stable-rc 5.2.3

> since the symptoms match and the corresponding fix was made in 5.3.

Thanks for your findings.

> Paolo

- Naresh
[1] https://lkft.validation.linaro.org/scheduler/job/837811

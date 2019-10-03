Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5944DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273132086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c1OGLMY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388940AbfJCSXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 14:23:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38463 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbfJCSXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:23:34 -0400
Received: by mail-io1-f65.google.com with SMTP id u8so7825545iom.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 11:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=275AfUnj6aHBgYIbA3ON9mS0LQosy+5qsD0pGkCb32s=;
        b=c1OGLMY44+4ckwsAl/G+KpSfgRdufeD7+g8abBklf/iVHaeStNDSGUTsrYn7KivMXy
         gd7lalJgK9VamFzr9yNcORUcBx5LO1pQ2sKh6g5SI6nEq/O5eeoVknEsekuOaFOVig0P
         zYYjsvfJfiVajqgUraogcoDmK5vSur/OJYeUyg678zQ8L9Ldoj0d7EV7q0dV+FC5SQgL
         v7fWJu2DAffTqUxpZTW21k6xCZus+kt1iDjg4sFWAViYV57/B0bGZCATnzZyABpuHWln
         h1mch2xYQlBObkXEVqmbDW9F1eJ7AryfZvM1PEe18JDRWm5Xki/wDJ5ZhgQKCOf6Cvfk
         HexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=275AfUnj6aHBgYIbA3ON9mS0LQosy+5qsD0pGkCb32s=;
        b=biYGacmv34l1oJR5PsVJmrYCJBAgHVgMGXHCW6ESrA2ZWrNAPx1swZhkzcK6tuCXSf
         40RzS2zSk0qqFv6e9FU1ZAyIekJnbJJx9RNu9croSlehtlPBQQ99GNE2Sb5xI411AKmR
         7FgEKmfj/cUxhZU7v1aAnx1EAwUQsyCGos7SP91ba8HkDqnSQjPxFmDIFRVFGUDBSgpY
         1rZ6lxPc0ht5To64pqNCP+rfnmY4+mZx0EeWwMdF4mvj32P2/nyF9sKSyrD3fdcuOnk1
         I1uz+MWkrv79nawFyveOVDSvBHdq9nu/COmWqeJUc7SK/SAP4Eox3+roYtboiCkXTLVp
         PPYw==
X-Gm-Message-State: APjAAAWMU5l55Jtx1Cn5evYpF/WHZ3AHEuC6U4EIGJ7055G/XAEOfmmD
        RS4XowtHyy/ie24quY6eT/jHdpfC7Amfxa+jglVC2w==
X-Google-Smtp-Source: APXvYqz+qHo6hpknvwi0t3HRw6jBKEJsjcAIwLnUH/pYAlcuWzLA/cEliwwkK5mVPejYp8PluQHLQUxCAf9UTnBfCOA=
X-Received: by 2002:a92:5a10:: with SMTP id o16mr11756152ilb.296.1570127012953;
 Thu, 03 Oct 2019 11:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <1570097418-42233-1-git-send-email-pbonzini@redhat.com>
 <CALMp9eRFUeSB035VEC61CzAg6PY=aApjyiQoSnRydH788COL4w@mail.gmail.com> <f8e169a5-4cf6-8df7-86bb-f70a480c33ad@redhat.com>
In-Reply-To: <f8e169a5-4cf6-8df7-86bb-f70a480c33ad@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 3 Oct 2019 11:23:21 -0700
Message-ID: <CALMp9eSCB-wyLm-QYS-7gTcSeuWWCvgYL3iDEP0y6BM4cWMFag@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: omit absent pmu MSRs from MSR list
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 10:38 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 03/10/19 19:20, Jim Mattson wrote:
> > You've truncated the list I originally provided, so I think this need
> > only go to MSR_ARCH_PERFMON_PERFCTR0 + 17. Otherwise, we could lose
> > some valuable MSRs.
>
> This is v2, so it was meant to replace the patch that truncates the
> list.  But I can include the other one too, perhaps even ask the x86
> maintainers about decreasing INTEL_PMC_MAX_GENERIC to 18.

The list should definitely be truncated, since
MSR_ARCH_PERFMON_EVENTSEL0 + 18 is IA32_PERF_STATUS.

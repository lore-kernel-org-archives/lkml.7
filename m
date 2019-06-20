Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A331C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3C22085A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vrEiqVPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfFTSpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:45:08 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37063 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfFTSpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:45:07 -0400
Received: by mail-io1-f65.google.com with SMTP id e5so51252iok.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iOXxm2t3OxvRhCzI51nS1CEzvfBrrobpsZUrEz8AOHs=;
        b=vrEiqVPUFYgbkaMwO2Uc2YyLCB7Dp1hkeXflE4KqJcJ8zZ5egfPJsXtegjBuuirrZG
         KkM4e0oz/lJwl6pPmOw9rO6CBuwccsXFy9AOZR0o5mAnn8BPMqj6i+fz+vc3X+4ebQiT
         eYX54kKrn7LvU4nJddNoUCVBsmWdSTxDnFPcaPNCUfwh3wKiMgC4gV7AstQ2pwkVs531
         TrCeW8ia1QmUXgTRsDc4IISczah2I8bYlVWh6T/NKSo0P4L8a6qWZABdCVQBYxVGo98D
         Or2hz1/Jw4sGDepzMhX6W9JwdKWRxJ974GJj/yIQh9xWjUw8awMUBgKpf/QBvgGFQgX7
         m58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iOXxm2t3OxvRhCzI51nS1CEzvfBrrobpsZUrEz8AOHs=;
        b=IfxVZ0i01UgpYid2l/7xCivTOmgswTTs7KMYqqvO4qoQUPLGguq0N5Ofv2InpdDNol
         zhoKlsE54tq0UQ9I456KgB041mmP3LJuYM5CeBOx7jNhN5mkIdtHR9Or2ygj4thquzF2
         yxJ1TKBiWpOPA4x9DuuFzQ53ELDOTkHYUrOLRMSsNvPjFpmZXs5dT9NNwIrIjZ9SsfL1
         2HZ13kAZ9fw8KzWJyfUHGCffKffyvCOArCHKZEp/y3mJjrLSMGncsvhyi+o3Ng1I/jz1
         YwDF5j8qGnQcjOfiGm0fVAdIP43Sq+DE4lno75qVPA1QkWHkWOapkkQK3s0BIoJBL18f
         NYJg==
X-Gm-Message-State: APjAAAXxRxFViPPzcDsgB6IFoKiV6PWh8gYxn/CpJrwaz/5HnBae19/F
        OMRMqCd967wmSXxvhCeueEwf5waFFsqSpSOry3IEUg==
X-Google-Smtp-Source: APXvYqzFRYVCHjk35X1ouKmAUdulBO2FCgBJB35wx0KM985uS4o6OakZ4zYr+o/iHc7sTtL+9Zh4/4nvJu1AtsfQo/A=
X-Received: by 2002:a6b:6310:: with SMTP id p16mr20938246iog.118.1561056306188;
 Thu, 20 Jun 2019 11:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190620110240.25799-1-vkuznets@redhat.com> <20190620110240.25799-4-vkuznets@redhat.com>
In-Reply-To: <20190620110240.25799-4-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 20 Jun 2019 11:44:55 -0700
Message-ID: <CALMp9eQ85h58NMDh-yOYvHN6_2f2T-wu63f+yLnNbwuG+p3Uvw@mail.gmail.com>
Subject: Re: [PATCH RFC 3/5] x86: KVM: svm: clear interrupt shadow on all
 paths in skip_emulated_instruction()
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 4:02 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Regardless of the way how we skip instruction, interrupt shadow needs to be
> cleared.

This change is definitely an improvement, but the existing code seems
to assume that we never call skip_emulated_instruction on a
POP-SS/MOV-to-SS/STI. Is that enforced anywhere?

Reviewed-by: Jim Mattson <jmattson@google.com>

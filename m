Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7F2C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A35820656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W7qC76hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfFTSpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:45:49 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46176 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfFTSps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:45:48 -0400
Received: by mail-io1-f65.google.com with SMTP id i10so981639iol.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 11:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hSxoaZBOkmQZaJYH3j6SOT3eABhlSAaxFaI9XP1STUE=;
        b=W7qC76hrhQauOTxzpwZYpacR1kGn/isREGEgNVFuKJhrup3Bka80hXojC5ioJ5vEHs
         367fzE0tqcEb5OVmLcHY6In+7Y9kx4dv/HP6fdMT43vXr4lqDuLRi4QPIUBr0Af2T8zm
         WFXiOobb2Mx9cHhQ5I4KeWIygTreeEgY886JMk3jQs3LwlCdTJ1tuIKmMLHZKpkxoDcU
         8hzJTPZjEohYhagJ9x8ZTK1cnARAysCGuFgcWmWBSJboor1d1onzcgpTVaSxs8xLjToE
         wJBbjvGwWjfiL3bm69Wd4dUjS04qper6sWx71JRMJxl/VyzLMEtHPeRDZY56WwcFmLxp
         EwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hSxoaZBOkmQZaJYH3j6SOT3eABhlSAaxFaI9XP1STUE=;
        b=foE8Z5AZYNw5hbrO8oJ1hwgCFTPZpcl6Twb1Ny+uMbetxK8A9bvmiBwLT5c5mn3HWV
         XcvU8sOh+JYt99v0zQQQ8VaNGkid0s9iS1OiBovYmcj58hidHMgR3enNALeZFGQVtEx1
         bGFaa72eXQLVocWCjWF6TtxxJ2+0mxpis06eA6LVov0oXyik7GxotEJu/NEglAetKd9b
         FT5DP49OTH4owEom6XA57UMmIgAy5jGg+Se70Gv4v5yL435PeHUPy5NmtQnMLvW5Q+3S
         47aQvTGh9/6glq3C1+kWJfp6G9TjUaarWxcJgyW5v75elyQw8WTJVCeAYzyxgosSRugj
         gR6A==
X-Gm-Message-State: APjAAAXxaqmC+FHOxmbr+ZJq19ZfYBA0RwFDtGXxMxcoT82nLavhv2r8
        HkEt09yEhofRKhb0AenQqns5lIh9+6HsY+EwZu8nEXA1gWeWDA==
X-Google-Smtp-Source: APXvYqxZrwLtmE2tJmKgoglFKu3htrn3jMn2x9r1huRL2cMraHKfJd0fPXf9ONzsse4cK8tjmXFC/Z7TrRxFSd9aBs8=
X-Received: by 2002:a02:1a83:: with SMTP id 125mr27916903jai.54.1561056347525;
 Thu, 20 Jun 2019 11:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190620110240.25799-1-vkuznets@redhat.com> <20190620110240.25799-3-vkuznets@redhat.com>
In-Reply-To: <20190620110240.25799-3-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 20 Jun 2019 11:45:36 -0700
Message-ID: <CALMp9eQh3yJZbDkSj2pQ4xrq=ZJc9rBsqdL2B7nJf-_p6+R3Tg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] x86: KVM: svm: avoid flooding logs when
 skip_emulated_instruction() fails
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
> When we're unable to skip instruction with kvm_emulate_instruction() we
> will not advance RIP and most likely the guest will get stuck as
> consequitive attempts to execute the same instruction will likely result
> in the same behavior.
>
> As we're not supposed to see these messages under normal conditions, switch
> to pr_err_once().
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>

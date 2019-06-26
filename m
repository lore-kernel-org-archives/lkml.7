Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23287C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF33C20659
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561520234;
	bh=JmzGPKsmUvSdNsSmIymUCFxAhA+cTqqTboCcY+e/GPI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sRhvTViy6O1Z6aUS9RlbBO2BUBpI+3A9GDLWyL2wWjBJI4cxwFd8tpWOfmMF+KBBT
	 tntiG40z9MSVyyXv2Dwk+tGGDb2i/HFkGYGriKJbnw1OHMoSSzKAjqy+8aLK+VRl+s
	 udXCzNLho6gS1OA+XfECjp9rdq/ZBYrW75bmuxrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfFZDhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:37:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfFZDhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:37:12 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D71420659
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 03:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561520231;
        bh=JmzGPKsmUvSdNsSmIymUCFxAhA+cTqqTboCcY+e/GPI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mpIGug1BN7TkavcEanSgy9S5TtgTAZM159v3f/R0RGk2ktaFcZBiwXCLs/azsmbLf
         uUPFAtrSsYkESs/Ex05eq88JFcXbg2ESx8nqbaF8XaupoKVIi7fl+KcUqLwW38K/ma
         gTC6bPVOCj3EOyALXyVKo6/zCvdWEcp4HhF6RByI=
Received: by mail-wr1-f51.google.com with SMTP id f9so856395wre.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 20:37:11 -0700 (PDT)
X-Gm-Message-State: APjAAAXwDQ7OgcRhF6zt215anGHocojlqFUN2xc7tffxWjc4nbjAz/io
        ttmbJMugtyc0jPd9Aju4GQeA29MDqC8FALJ/nWjcjw==
X-Google-Smtp-Source: APXvYqwElpql8oD8RU81s8JM59UICeBjuSUCnq2AkPAPHmk5YrgJh6ZyasGJxpLlUDzaC8WV+AQ53SYq53YWmoIFgSg=
X-Received: by 2002:adf:f28a:: with SMTP id k10mr1277832wro.343.1561520229959;
 Tue, 25 Jun 2019 20:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190613064813.8102-1-namit@vmware.com> <20190613064813.8102-5-namit@vmware.com>
In-Reply-To: <20190613064813.8102-5-namit@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 25 Jun 2019 20:36:59 -0700
X-Gmail-Original-Message-ID: <CALCETrXyJ8y7PSqf+RmGKjM4VSLXmNEGi6K=Jzw4jmckRQECTg@mail.gmail.com>
Message-ID: <CALCETrXyJ8y7PSqf+RmGKjM4VSLXmNEGi6K=Jzw4jmckRQECTg@mail.gmail.com>
Subject: Re: [PATCH 4/9] x86/mm/tlb: Flush remote and local TLBs concurrently
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-hyperv@vger.kernel.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        kvm list <kvm@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 11:49 PM Nadav Amit <namit@vmware.com> wrote:
>
> To improve TLB shootdown performance, flush the remote and local TLBs
> concurrently. Introduce flush_tlb_multi() that does so. The current
> flush_tlb_others() interface is kept, since paravirtual interfaces need
> to be adapted first before it can be removed. This is left for future
> work. In such PV environments, TLB flushes are not performed, at this
> time, concurrently.

Would it be straightforward to have a default PV flush_tlb_multi()
that uses flush_tlb_others() under the hood?

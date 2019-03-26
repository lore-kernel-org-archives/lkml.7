Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E8EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24132075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553561051;
	bh=vFArf6P1wXYjyAT2h/qrDf+gUQQNhHrIjEXJ2Zj9kww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=a7/4NnFe1lnp7lML8RBqtBj+igbjhAaYs7j36ciXjIz9wMUaEH8N+tCl7ihIfH8Q5
	 mHBj3AWW6m7XRi08Av1yRn9j573aky4zq5NfJIykV251HEeL+zNo5n8et17hnQuSTh
	 aAkDJa4QxQXobLTAy7lGD1bs8muN8ovjw1SoRTJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbfCZAoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:44:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfCZAoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:44:08 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B57E20854
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 00:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553561047;
        bh=vFArf6P1wXYjyAT2h/qrDf+gUQQNhHrIjEXJ2Zj9kww=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WIrEHykOpF0gzLzT8dgwO/qVY0LX5+pwUwSBHEgYqxV9V3zGyskxNWIJ6r2P2G5x5
         rUHFbnA8xYAE96bLp3bgjUlN9CZQWBtNqPgXNZ/QEJQoEuqIhHFWKtnHs8mbzuIdwR
         pvZWCi1VjmiaM5WreDpqk5VQTtV6EVIHeeq/86qM=
Received: by mail-wm1-f50.google.com with SMTP id z6so1169758wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:44:07 -0700 (PDT)
X-Gm-Message-State: APjAAAX9nFXqF3HV5XjwvNhkiWOYQ6A0+vuLG2nfO8Qpo60/m/8udqDE
        aBzO/zW7KfQHaX0kvlW8nMQAIcbCmFKjZsDEtKueZA==
X-Google-Smtp-Source: APXvYqz5ha4LGormtIBPJE/2NPrXk8wq9lEsCCjYC7JbcjRyVbonpQEFVP8k1MgJ2YyWikF594CVK7t02/SMowIITOs=
X-Received: by 2002:a7b:c257:: with SMTP id b23mr12826110wmj.83.1553561046047;
 Mon, 25 Mar 2019 17:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <1552680405-5265-1-git-send-email-chang.seok.bae@intel.com>
In-Reply-To: <1552680405-5265-1-git-send-email-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 25 Mar 2019 17:43:54 -0700
X-Gmail-Original-Message-ID: <CALCETrW2zvANR7P+JW3C5zVwHEH=J4xwgZQi5M9-rccP-dqPXg@mail.gmail.com>
Message-ID: <CALCETrW2zvANR7P+JW3C5zVwHEH=J4xwgZQi5M9-rccP-dqPXg@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 00/12] x86: Enable FSGSBASE instructions
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 1:07 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> Updates from v5 [5]:
> * Drop the new tain flag (TAINT_INSECURE)
> * Cleanup copy_thread_tls(), some changelog, and unnecessary comments on
>   assembly macros
> * Rearrange some helper updates appropriately (from patch 4 to 6)

I think this stuff is in generally decent shape, but I have two big
broad comments:

What's the status of the stuff hpa was working on to make the behavior
of modify_ldt() predictable?

Can we please have a test case that explicitly exercises the way that
ptrace reads and writes the base registers?

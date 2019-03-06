Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6003EC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3032E20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551838423;
	bh=RlgfuNyTULlM/74n7jczCleTjgjKhXHQr0EmJhM7n4E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u+KBrNtfOYtQSrvavwvf2kYhWapVdDBm1xasgZM6BjkwaMdeTyi3ryadPDvoSC/FH
	 j982q4E6Ov6JUd5glDCC9IidCz9hyLUvHb8EAii7adhdUoeIrItDrMqgL7LA6MK9q1
	 Ls9X5b9aMBXVQ/NdAoaKtXwHvXYRrtQCxfb+DgWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfCFCNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 21:13:41 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35148 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCFCNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 21:13:41 -0500
Received: by mail-lf1-f66.google.com with SMTP id h6so3464939lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 18:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JDpuSMCeIvNCcidtLtsbvARRQv4a3+7l83TX/B6+7qk=;
        b=GwfZayd0suFlVhYX0r1NULMJRpJ+chlSlvTA4bG286JR3J+7Oskh68hIvPJ3AYVa/H
         +mBb9b1yJXOPkK9hilVDegWWuL1CPmhdQ8aDQ+/Oo8XMycQ0SnVPt0prkmkwe2CNaWyQ
         WEFVK/bUZaxZCORJRJYrvsIhitBvX6A4XZAzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JDpuSMCeIvNCcidtLtsbvARRQv4a3+7l83TX/B6+7qk=;
        b=VzzQEssGZ+YCYqlQR1XJM87XAXwV9DdQ+/ksEApMIDHgZkXKzGYWq/h+N4xiYXDKO7
         bo8qRE9/woh8dLRcegeziguKTbi/GB14h6xLfdHewUiQsqGfHVcmjkTlIQW0UamC9rJg
         X2zy6VavXgnECWpGm0F1Rop97iEQy/uXIpZVXzUc7aoDr+I5cZGHVzVzZaeKX78RJl3q
         N2qhfNmSrbUHKqCK/eR//5a8a29ww2jqEjUW7dbl+QS2YSq2//z0j8bqe2Eg7NsYfFHM
         7qQ4NMcaGucxsut+FEzKt60k19CgRdOCflCRCBfe0dm3SJeIK5lkny1UFK/MLIBWJEti
         LKCg==
X-Gm-Message-State: APjAAAWyevu9RZ1xDUgwqAiUBgoh4+vMRUl9ccjqlm9M3yOwLC+bOqse
        jOqyEQKX+0JBiGK4gYh+OMalp5EbPrM=
X-Google-Smtp-Source: APXvYqy5spqNkNF8dLjKMc3UowKjVoFbWQjRsIZqyQ5c1JYsg1UAjd6Vhh1oCRjmevcc/qjH28w8kg==
X-Received: by 2002:ac2:4215:: with SMTP id y21mr2647940lfh.6.1551838418850;
        Tue, 05 Mar 2019 18:13:38 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id c5sm70189lja.90.2019.03.05.18.13.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 18:13:38 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id d26so7703530lfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 18:13:37 -0800 (PST)
X-Received: by 2002:ac2:5088:: with SMTP id f8mr2398225lfm.11.1551838417314;
 Tue, 05 Mar 2019 18:13:37 -0800 (PST)
MIME-Version: 1.0
References: <20190305120301.GA93284@gmail.com>
In-Reply-To: <20190305120301.GA93284@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Mar 2019 18:13:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiM4_0ZDDAcN0nJ8TsK+MnO1ObmSH4nTvrirA5nenFTHA@mail.gmail.com>
Message-ID: <CAHk-=wiM4_0ZDDAcN0nJ8TsK+MnO1ObmSH4nTvrirA5nenFTHA@mail.gmail.com>
Subject: Re: [GIT PULL] RCU updates for v5.1
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 4:03 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> Please pull the latest core-rcu-for-linus git tree from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-for-linus

Hmm. I think this made my build time explode.

I'm bisecting, but it looks like my allmodconfig builds went from ~31
min to ~39 min with this pull.

NOTE! I'm  not saying that the kernel slowed down. Just the *build*
(with the same kernel) slowed down.

It's odd, and maybe I did something wrong, so I'll have to
double-check the numbers, but I thought I'd mention it in case
somebody goes "Ahh, I did X to the include files, so now every
compiler invocation probably sees all of xyz and that will slow things
down enormously".

            Linus

Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C52C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7ED218C3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556052339;
	bh=QH1Ccf74C1wODaYjFFKDOuW60GzJyLMShQQl2cDyaS0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=U3XQ4Fs7+YbrhBmp9qK1q9NEr1Wi0+QuYMQtYTUIFU1f7AGEXh4D7bKgK+vXPhm1r
	 0YdemVSWQrWRV4MaVQFxlbM8flTM1vqnvP8vWmsNgvp+XeVOaZj1wbXFifpXMugDHX
	 OpvsXPDOJojkMwqAa5JNnoDLSg5z/oRf2CLsGi3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfDWUpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:45:38 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36090 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfDWUpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:45:38 -0400
Received: by mail-lf1-f67.google.com with SMTP id u17so12805152lfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 13:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4RwiDLHtg2FoAGyK/PAufgM2nynusObhso/lrZU0/M=;
        b=V28sL73guQ7+QKj/iF2TG35s+5bqbNBspBTX3WETDWexggMzGL6Ns/+Ch9tzUDpMiV
         fsCX2V/sBpq/7bmUDoGL1cScwe13xsEE7/M0/syxhmtjT8MFQYcOo7aim9ueUCjv24kK
         HCIJiaRTxKzDhLBD6hAWTwcNx/GTsd0ZiWNAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4RwiDLHtg2FoAGyK/PAufgM2nynusObhso/lrZU0/M=;
        b=W/u2Ksh56/Q0fpnyriktEtZLvA/SFJF5i4YQVYVg8NNwoOtsVB/9h1N6Ku6xlE3H5x
         2+GkAbJEQ6sf1NiYC79TkcT6tcQOTQpSBLkIO7O8YuL8Df1smE0ncJAH1lmUyr8ZQqTx
         nl8F8JN0XuTd7adhRHPuxWNFjve4PMwrHAlQmrfNAeUC2/km0uepssDx7JEAFWzNTQJc
         hzzjhGw+cCJ+XjjxgPZV5ZSOt6aYIQ0f5MerpVW0iCfpeGDYOOBoRcg9KTi4aIU3KU/8
         mN22La9b7uhmXvxCXmRY5OHSZAa4qELiqmUWT1RsG5/ArxOr74+7DwegoDtfRsMfTQLH
         lO8w==
X-Gm-Message-State: APjAAAX86lQM9/d/mMgBK+IrlJ0/VGYGNemssrMABYxtBhQJDS6kLUMK
        PIDckuRI5DDmXdyvJ++CaPFm0lyVsqM=
X-Google-Smtp-Source: APXvYqxe+hXeY6gPqyuTpogF5PdI2eCcPd1fe+1yb6+EjK85nfQsQkcZsOYutBbvA0zHzS9MjEcyMA==
X-Received: by 2002:ac2:51a1:: with SMTP id f1mr7209564lfk.129.1556052335183;
        Tue, 23 Apr 2019 13:45:35 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id p76sm4491097ljb.63.2019.04.23.13.45.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 13:45:34 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id h21so14721303ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 13:45:33 -0700 (PDT)
X-Received: by 2002:a2e:9213:: with SMTP id k19mr897555ljg.118.1556052333576;
 Tue, 23 Apr 2019 13:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190419131522.GW14281@hirez.programming.kicks-ass.net>
 <57620139-92a3-4a21-56bd-5d6fff23214f@redhat.com> <7b1bfc26-6e90-bd65-ab46-08413acd80e9@redhat.com>
 <20190423141714.GO11158@hirez.programming.kicks-ass.net> <CAHk-=whnQJ9YDrkcKteNSACMJxzw1bL0RPfGQsey_9Nm7b8mnw@mail.gmail.com>
 <4f62d7f2-e5f6-500e-3e70-b1d1978f7140@redhat.com> <20190423193435.GX4038@hirez.programming.kicks-ass.net>
 <88ba7be0-9ec5-941e-1b3f-80fbe05fe3a0@redhat.com> <20190423195559.GY4038@hirez.programming.kicks-ass.net>
 <CAHk-=wgopkA+NiFCDOBcc24usK8hwL9CnQGzmv_4j8zJLGTrqA@mail.gmail.com> <20190423203512.GB4038@hirez.programming.kicks-ass.net>
In-Reply-To: <20190423203512.GB4038@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Apr 2019 13:45:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiw7dbrvnqHHw1f1GyKzn70Oi+3WJCJ85zh8X3QHsVsyA@mail.gmail.com>
Message-ID: <CAHk-=wiw7dbrvnqHHw1f1GyKzn70Oi+3WJCJ85zh8X3QHsVsyA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix preempt_enable_no_resched() abuse
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 1:35 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> That one 'funnily' doesn't actually work; cond_resched() is a no-op on
> PREEMPT=y.

Uhhuh. I "knew" that, but it's one of those bitrotting things.

Which does make your argument stronger, of course. This is way too
easy to get wrong even if you think you are being careful.

I guess it could be another thing to check for with objtool, since you
have now gotten the experience with it ;)

                   Linus

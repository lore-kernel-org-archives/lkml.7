Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EC9C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBED204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557420741;
	bh=fe//PupwdkzzzoX9lLrjzpbGaaoccKORpOtn5feu/sQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nziBZihvEW4p/3ArvIRvJ32HscNz82dKf6LkZFtu5DK/iF3dE5gEoYwNBJlpaB5wi
	 EMJDHG8u44rkTMKhnWfG7n6iDlsh7VYYfkcVBAUY406QI6eN4qaUHGw7TTnTtgrvTi
	 VzMJWz774PC6BOdGUWJm71Sk0cUWApEzcZuP1UAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfEIQwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:52:20 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35531 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfEIQwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:52:20 -0400
Received: by mail-lf1-f68.google.com with SMTP id j20so2082081lfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 09:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AhpmsrtucWguH3IXMMNnIIZguP4K9ooA7az5QKRrexA=;
        b=MRXgNsW3/X37uCKGa+XBlAXjfP6xB4Y9F4UfQSVmMyMoxN9Nl0sarbkleypiHR5nR+
         FyZcendGNNYq3dMcg9q/zgW0M7Ida8GHJxr7VbzXdkuyJ9hFMHE3fThGQx1xvL0P1Isv
         Hcc6VPJJ4XpzrX/MFfZ4raCstrAV8aX3pLS38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AhpmsrtucWguH3IXMMNnIIZguP4K9ooA7az5QKRrexA=;
        b=WNYGC0CpJkf62pPL/jwMqfQ798haW94/YGeE/L7TPoyclzP5C5alIT9kkY7RSOxpzN
         3lgeq6mk/fGcXRdFG0m1DS+MLfuGGRl6hjmUI6wjp/VZkHNOGnONZlfAlaOtJPFETpBj
         M/ZOMQKelo5RMHgGigWEkLY4KF+5hjZNv5QowGo14VgmXWxA3ineLH378uSN3PkBKfWu
         Hf1Z423fdQmHPjvaae6GrYN78AnIq3KZL1he6cN61B6SKCMemDqraTm1xdWrbgJq2rK4
         bQjcBYbudQt1ahO0BIYtAktuCTGxMm4Lw8IcEFlZKS8Mpd19R2dsPskH4ylgeM0cpUnq
         xlpQ==
X-Gm-Message-State: APjAAAXp/+vUFbbBK5DK+NrVQNSyuKM8Q+y/rGGEbQtAUK18ci6mQ067
        17rCsoapctwnaBJomrsy52qfkXCx/S0=
X-Google-Smtp-Source: APXvYqyLYwcL01FFfEL5IE5Mjq96W8mYvyOK4vzfdejPYRjzykpMWuVXm4exz0QwT4dX+RF00eQxnA==
X-Received: by 2002:ac2:5501:: with SMTP id j1mr3006101lfk.89.1557420737476;
        Thu, 09 May 2019 09:52:17 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id m5sm481353lfb.47.2019.05.09.09.52.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 09:52:16 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id k8so2611250lja.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 09:52:15 -0700 (PDT)
X-Received: by 2002:a2e:9044:: with SMTP id n4mr2928118ljg.94.1557420735319;
 Thu, 09 May 2019 09:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190318153840.906404905@infradead.org> <20190318155140.058627431@infradead.org>
 <f918ecb0b6bf43f3bf0f526084d8467b@AcuMS.aculab.com> <CAHk-=wiALN3jRuzARpwThN62iKd476Xj-uom+YnLZ4=eqcz7xQ@mail.gmail.com>
 <20190509090058.6554dc81@gandalf.local.home>
In-Reply-To: <20190509090058.6554dc81@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 May 2019 09:51:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLMXDO-_NGjgtoHxp9TRpcnykHPNWOHfXfWd9GmCu1Uw@mail.gmail.com>
Message-ID: <CAHk-=wiLMXDO-_NGjgtoHxp9TRpcnykHPNWOHfXfWd9GmCu1Uw@mail.gmail.com>
Subject: Re: [PATCH 02/25] tracing: Improve "if" macro code generation
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dvlasenk@redhat.com" <dvlasenk@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 6:01 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> This patch works. Can I get your Signed-off-by for it?

Yes. Please write some kind of comprehensible commit log for it, but

   Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

for the patch itself.

             Linus

Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BAEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85C721873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553103550;
	bh=KwbzRiWpYG4N4Y3Mzv9f3eMrUk80MQu91OjT+gLhA9I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VApU3hWi/r09rERGFQuaa7d8HdEVtEAx8jNTVMCRwu9FM73KIZFCt+Js9gJL82z2x
	 jJJ/YTTxKJr5xtzYU2H4HwGSeJchdeCoSUtOy4V4pTsU3bKTszWP3yD78Ixk+HOI3M
	 HhCyZq+WuxNq492OClmjZsoOPFoh9H96syMrhbkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfCTRjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:39:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45144 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfCTRjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:39:08 -0400
Received: by mail-lf1-f67.google.com with SMTP id 5so2512207lft.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UmHPMGBol8MJoNEZXw2NAdUNG25Tkui2y2gSKEuMHgs=;
        b=cWaJ6v8uH5MglVftWdKTU0D8ELgguFvG61OIknndG22DH7VumLk/B+ukQ0NSgDgcbu
         syzlMQfUnSXkC+JJEjYOCjcetUb52t64QYM5jlVDGdnX6DF7DfgJP1Qg0Q7+G70Gu0/w
         ytFvvD5K3ILEbZ7g9UlzqmTipoEigCVscVZho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UmHPMGBol8MJoNEZXw2NAdUNG25Tkui2y2gSKEuMHgs=;
        b=ZvWEWWzQAwe2BRj/dhBd9HyxrEkvem0jRYxsQSkd8707+tCcooinhUdwmUTuvbpS6N
         oMsPJXjtrcOkecHQOoShiWEwcrfTxiLlpHd8TT9vNbms0tpn125S8kV3Nl1vOqkVuA24
         rn+D0yidkZ5R4+xsH9/O4Uc7oJK51+AZK7xZLMY8z7wU/Qzy+sBV9cU2qalZc5JEvpDO
         9DlQEnv7jF82laBXHcuEMPHWUhNypSeEMib6HimFFXRuGGaBx/5WS/Ut+9x02nP9sk2X
         4XhAHK16ngAoHoFjasb8ickd7Zst8dw/ahhG3IaroHQMk+doe6OBLkiTO0A5mvO75PkS
         cjRg==
X-Gm-Message-State: APjAAAVH4Gi1JmqtY95SdtHFvyrka/2uT87tBUP4Q+Hb5W7jdfCiN7JF
        m2jw1aXzcI4RZ4CvZ/+8ypEO9d92qCw=
X-Google-Smtp-Source: APXvYqxeocWN+cbemyjDWhANIUS5DNILCBzfD1FWGiCmLAEL83yU/JfyJtSXB+EbrzdQIEDQSZBdQQ==
X-Received: by 2002:a19:a40b:: with SMTP id q11mr16969070lfc.33.1553103545881;
        Wed, 20 Mar 2019 10:39:05 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id v20sm431566ljv.83.2019.03.20.10.39.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 10:39:04 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id u9so2506619lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:39:04 -0700 (PDT)
X-Received: by 2002:a19:954b:: with SMTP id x72mr16642814lfd.67.1553103544127;
 Wed, 20 Mar 2019 10:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190318153840.906404905@infradead.org> <20190318155140.058627431@infradead.org>
 <f918ecb0b6bf43f3bf0f526084d8467b@AcuMS.aculab.com> <CAHk-=wiALN3jRuzARpwThN62iKd476Xj-uom+YnLZ4=eqcz7xQ@mail.gmail.com>
 <d6baf892a063449f9d69164cc52c6d8e@AcuMS.aculab.com>
In-Reply-To: <d6baf892a063449f9d69164cc52c6d8e@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Mar 2019 10:38:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgGHQABva5g3drnTZBfcuBMpaiKTtuvMkJOj5sRmjFq2g@mail.gmail.com>
Message-ID: <CAHk-=wgGHQABva5g3drnTZBfcuBMpaiKTtuvMkJOj5sRmjFq2g@mail.gmail.com>
Subject: Re: [PATCH 02/25] tracing: Improve "if" macro code generation
To:     David Laight <David.Laight@aculab.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        "dvyukov@google.com" <dvyukov@google.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 10:36 AM David Laight <David.Laight@aculab.com> wrote:
>
>
> Actually you can avoid double evaluation by doing:
>
>                 (cond) ? (______f.miss_hit[1]++, 1) : (______f.miss_hit[0]++, 0)

I don't think you looked at the patch in my attachment of the email
you replied to, did you?

That's exactly what it does, except it also gets rid of those
completely pointless and insane underscores, and makes the code more
legible in other ways too.

                 Linus

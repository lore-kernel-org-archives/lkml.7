Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4469C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8603921743
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558115968;
	bh=wligyCDB6cBWaRhqVXQqSqaWOLM1I+XoOGjFzIGqDps=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lL0DPgn5hvtkLOirnXBMi09P2f1JtsolsJkUOy4s8hfdwBqJYq53DzUiXFobvAVC1
	 NiBmftxgY4mu4ag8wHcfG9lf+LlGmFAZqLApiptd7KC0ddvKzBWQSKCmVHf9NkZ3IE
	 f4F2OnVLpypOANJ/EQ3bNGCQQFcQATusk+XjuLjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfEQR71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 13:59:27 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35971 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbfEQR71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 13:59:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id y10so5970314lfl.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 10:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rB3dNWIaqQDPGHNT19oahTEP+BWSc5q1Dug0Regx5ks=;
        b=RKf5fN9yw2LRRY7jLcfWOW9ebsu2L8Ka0aIlL6+zWMprMbvUihDj+fmUcrw3ejhnSb
         olvc33josiDhqxFEFHMMPPeFQa56MrKGqqRoWKaWs8DzBeaKCeUmMaZAEDoqWjUl4xtw
         4KsqbLtTFw4qjNNi1uiYd5IS5SnBHdpWpXdbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rB3dNWIaqQDPGHNT19oahTEP+BWSc5q1Dug0Regx5ks=;
        b=aJA8QQGxQLpYBEkqB24AkRcF1qTm3KjVOjt67fc143vvTVKEZsEZOeceY8Q0H/nRTc
         1B3DR/TuyqnAPgjRgF3gEpxvQC0O/TR+hl5fxJTcItxN30LZO6+qhtmFxyFYmSSY+xZt
         ngFnPCCagjzrbmpObb6RKHQbU8AIghDMlzvxiAYjFagJQ0CGDVdiSc4YP4mWVV9SboPl
         +f18jT8xQIUmvt6+kJ3CsUDg4nz+09zD0+zQEezEwap1zYb6WCfZBV9c++wKBgmGjwkw
         3Bxh+VQhbCqwSrUEOmOmkWKRgTeWUyRBFVTZxT3pnIIY3Rla2eFqNOQ7CzD7dc0kZbmT
         PBFw==
X-Gm-Message-State: APjAAAWsQojaR1s8aACXKYL3BcvUarbXKOx8drL/zIdNmwALMc652Byj
        1suiQVX/CnjMpOlXQqH63CGcL8P0oEQ=
X-Google-Smtp-Source: APXvYqyygs4JEJTgklHpT9uTSeu+OU+9GbKJobfYK4RucaqHU9d046PLZqURoEt7UVs1z3rlvaTnmg==
X-Received: by 2002:a19:96:: with SMTP id 144mr27705175lfa.29.1558115964444;
        Fri, 17 May 2019 10:59:24 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id u2sm1600575ljd.97.2019.05.17.10.59.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 10:59:23 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id x132so5974395lfd.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 10:59:23 -0700 (PDT)
X-Received: by 2002:a19:f501:: with SMTP id j1mr8089820lfb.156.1558115963163;
 Fri, 17 May 2019 10:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190517092502.GA22779@gmail.com>
In-Reply-To: <20190517092502.GA22779@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 May 2019 10:59:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNkOU-Ng+9_+tj4-AqJ4Q9JQpVbR4QVVAWLY68yQ62Gw@mail.gmail.com>
Message-ID: <CAHk-=wiNkOU-Ng+9_+tj4-AqJ4Q9JQpVbR4QVVAWLY68yQ62Gw@mail.gmail.com>
Subject: Re: [PATCH] tracing: silence GCC 9 array bounds warning
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 2:25 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> +       memset((char *)(iter) + offsetof(struct trace_iterator, seq), 0,
> +              sizeof(struct trace_iterator) -
> +              offsetof(struct trace_iterator, seq));

Honestly, the above is nasty.

Whenever you have to split an expression or statement over several
lines, you should ask yourself why it's so complicated.

This can be trivially rewritten as

        const unsigned int offset = offsetof(struct trace_iterator, seq);
        memset(offset + (void *)iter, 0, sizeof(*iter) - offset);

and now we have two much simpler expressions that are each much easier
to read and don't need multiple lines.

In particular using that "offset" variable means that you can
trivially see that "oh, we're starting the memset at that offset, and
we're using the 'sizeof() - offset' thing to limit the size". It's a
lot clearer to use the same trivial 'offset' thing in both the offset
and the size, than to have a more complex expression that it
duplicated twice and is not at all as visually obvious that it's the
exact same thing simply because it's bigger and more complex.

Also, the while 'offset' is a variable, any compiler will immediately
see that it's a constant value, so it's not like this will affect the
generated code at all. Unless you compile with something crazy like
'-O0', which is not a supported configuration exactly because we
expect compilers to not be terminally stupid.

So you get simpler and clearer source, with no downsides.

               Linus

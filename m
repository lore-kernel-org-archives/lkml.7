Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE53C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D7420825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3rkSbKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfDONaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:30:22 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:35005 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfDONaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:30:21 -0400
Received: by mail-ot1-f52.google.com with SMTP id m10so14424878otp.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 06:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8h7akc6WABuYvP0fi14Ch7Vu3kVcFO8o7C66TUjfmUQ=;
        b=A3rkSbKPlJiqUefePph18SPFX6fjNrzQoblx9iL7VQns6gMdbfloeBP8FEh2yc4928
         fmv6Cf82L8ReiGhreKN72At26md2n8jf8+HNHWfo3072z6nDRfHr1Xh3zTIMiW/IeD43
         Qa6POuONJ8P6HmWMZ4f/6f19O49qhjvSIYaIOptp1ailay0pRH8KH04USAgG4M8vYUa/
         yXwmyCHNXiXJB9SqokSjRB8br0fcFQ2MmoPFtsuQTKs5KpMJW7y4ccfE5Rn+P7E1LU/Q
         4Up5nv+cEawlIQ+onHcSwxNG4XlIbhmmzCe/jyw18YqiXeFuaTPyANwxMICYphM96VCY
         HQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8h7akc6WABuYvP0fi14Ch7Vu3kVcFO8o7C66TUjfmUQ=;
        b=gUcvjxMK5aTsT7CWdlTL7+EIigcQs/8ANopxXbwuo1T4rIyreJjceoAh5TFSzK6mAA
         rJkX1lSPBMDci2RCctlz3z28jN1/hz17hq6JC7V8f2Um4bbBvqIkWWNJmOGNoSpwHTR+
         tmeG6tVgHwHHT/yjx9wwEkO2dkFURQUj2rMIuR59N5D+kTABnxdv0g9TT9SkCNAZb81V
         0+79bCwDnzkxUoYYJLtMzihsgt03+SlmV6QYRBRGi0K8BBirfQqYU+N2g1zoMw1lvn5C
         PWcmXPSWN5+S+JAnyCgRhwuBDxwNHZjPw18Wr+YBYpmTIeDapKFs1WioAhVI5sccQch7
         6Qzw==
X-Gm-Message-State: APjAAAVBbR1xEQgQNyhXITZDYMgS5HXpP2qB2lMU4ssy8pyfYbUqMb7/
        nEtPeAKKeyA2ZUVl5Cbo73LVMCXWwEwYHRmU0UgjUg==
X-Google-Smtp-Source: APXvYqybruTzyMFmJh31q95s5OlKBZOS7zrt2MSL3TNjlq60UUJHdEpVVA2ucWLzP9uExBxEm1Ii457OZy0Yy8hyqTQ=
X-Received: by 2002:a05:6830:1044:: with SMTP id b4mr48626160otp.274.1555335020971;
 Mon, 15 Apr 2019 06:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <1050734985.2625.1554838340011.JavaMail.zimbra@efficios.com>
 <1933578130.3292.1554928159928.JavaMail.zimbra@efficios.com>
 <20190411164219.GE29081@fuggles.cambridge.arm.com> <1469455003.811.1555005112414.JavaMail.zimbra@efficios.com>
 <CAFEAcA849mmSds9euyvR2uLWqEeA2eedkmcq1O4pT6-S0oK8BA@mail.gmail.com> <936773156.261.1555333890988.JavaMail.zimbra@efficios.com>
In-Reply-To: <936773156.261.1555333890988.JavaMail.zimbra@efficios.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Mon, 15 Apr 2019 14:30:09 +0100
Message-ID: <CAFEAcA8YP5vvZpa_5dvv00koupsry9_3x2EB0cjvE6vtoi8sog@mail.gmail.com>
Subject: Re: rseq/arm32: choosing rseq code signature
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        carlos <carlos@redhat.com>,
        richard earnshaw <richard.earnshaw@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019 at 14:11, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Apr 11, 2019, at 3:55 PM, peter maydell peter.maydell@linaro.org wrote:
>
> > On Thu, 11 Apr 2019 at 18:51, Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>  * This translates to the following instruction pattern in the T16 instruction
> >>  * set:
> >>  *
> >>  * little endian:
> >>  * def3        udf    #243      ; 0xf3
> >>  * e7f5        b.n    <7f5>
> >>  *
> >>  * big endian:
> >>  * e7f5        b.n    <7f5>
> >>  * def3        udf    #243      ; 0xf3
> >
> > Do we really care about big-endian instruction-ordering for Thumb?
> > It requires (AIUI) either an ARMv7R CPU which implements and sets
> > SCTLR.IE to 1, or a v6-or-earlier CPU using BE32, and it's going to
> > be even rarer than normal BE8 big-endian...
>
> I don't think we care enough about it to look for a trick to
> turn the branch into something else (which would not branch away from the
> udf instruction), but considering this signature will be ABI, it's good to
> be thorough documentation-wise and cover all existing cases.

I think if you want to document it it would be helpful to
readers to make it clear that this is the ultra-rare
big-endian-instruction-order "big endian Thumb", not the only
moderately-rare little-endian-instructions-big-endian-data
"big endian Thumb".

thanks
-- PMM

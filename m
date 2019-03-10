Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3059BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 22:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07D020657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 22:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="A0r8Rd/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfCJWJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 18:09:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35683 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfCJWJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 18:09:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id g19so2441040edp.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 15:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V9zDhYXhliRw0/rcSIu/eK1G5HbIPgJ87jRAUWet8Fk=;
        b=A0r8Rd/WQqurih99BZ9RF9RnhF7SWQKdpNQvZ/fH2HzkIWXqreFHhduhr6xqW8XL7S
         JTdiLZ157dkjqq9LjPPHb0oJeG9iwaIEaCiTdzElRexy287d0L8UAzvZcKKuNhNOdw4b
         kx8/QNLN2tSIbi1kqwegXKLiSgR+iduS/pn54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V9zDhYXhliRw0/rcSIu/eK1G5HbIPgJ87jRAUWet8Fk=;
        b=Mrbit7C4TqeqLwl6LtFw+JzBEKSoFJFWoGK28s5+WbRVXOOIJTJtjcfyyHmmeKFPkS
         CpsMnMmXXHG6kVLgRJrB1tTZ7ryJhTCW2/Os2kx9Y5JQ3ZUqNDcknIcrIMW0SZUhpClN
         o6T0CdrsSRNHgvMlxW9q1R8coM4zsUZRsytZNTJSYpm9ATJP1NMy8YEjzDHc92aA9myb
         hSZ/6CV0OU4gGcEVDajMYURjzwMmtpiWKaW+DTF+yuJSMwMr5VQTIUklsx55oFyTMBqI
         0gR8kU6R0+y+IChACvBfLCva/VKWGSzMnqDxuE72ba5oIq2b/6swUyXQPgyr2vO2BGGl
         eHbA==
X-Gm-Message-State: APjAAAWZvBDpwWDz9DKNFJgW3x5957nLd60qYt/eGidshQeB6fstSYwA
        7JFJ7ZR48ayNUga4XPEmjkWV+EJwh2AxEQ==
X-Google-Smtp-Source: APXvYqyJQBD8OhkHW8AdxWvQHTVS23IYIT0PTlWSJXXqQQHzVsza9zD9bFnih8F/8yFh0bDmTRhUKg==
X-Received: by 2002:a50:af81:: with SMTP id h1mr42072853edd.243.1552255754957;
        Sun, 10 Mar 2019 15:09:14 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-117-145.cgn.fibianet.dk. [5.186.117.145])
        by smtp.gmail.com with ESMTPSA id s6sm4072547eda.90.2019.03.10.15.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 15:09:14 -0700 (PDT)
Subject: Re: [PATCH] static_assert: move before people start using it
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
References: <20190310105157.GA15039@avx2>
 <1d957ac2-3423-2471-6b7f-f6f25dd0273d@rasmusvillemoes.dk>
 <20190310213006.GA18349@avx2>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0c040ccc-e32d-253f-f764-766e5cec063f@rasmusvillemoes.dk>
Date:   Sun, 10 Mar 2019 23:09:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190310213006.GA18349@avx2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2019 22.30, Alexey Dobriyan wrote:
> and BUILD_BUG is bad). Once everything is converted to static_assert(),

That will never happen, because the two are not interchangeable
[ignoring the churn it would involve]. BUILD_BUG_ON can eat expressions
which static_assert won't (e.g. BUILD_BUG_ON(cnt - label1 != OFFSET1);,
where cnt and label1 are definitely not ICEs). Which is one of the
reasons the kernel cannot be built without optimizations.


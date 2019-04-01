Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182C6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8149206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GuoOo1Jt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfDAViN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:38:13 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40503 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfDAViL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:38:11 -0400
Received: by mail-yb1-f196.google.com with SMTP id g12so1902929ybh.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FHNIq0DAsiO68PBdakjAEu2fVLC527LLikbsrJoLlzw=;
        b=GuoOo1Jtsv8fOQjSU/DMg/+OeDJo25ir04J2M6CQzfya8Aft4/BhJ+g3al2eV213gt
         B1hP9eiO/rrCOQB08YjA8O59LoU7MJxAYJpd411bxNKw4fNfTL+yrgJemihGxl/rofQz
         sXXi6YrU2wDiR/0gV5iNzKECTfbRY4wYhzbvMikja8QmcBpjKVlcTxSG4ofOS/SqnVDG
         jQZJhWFS5Q8twQTipMBVzM7JErAXf35f5ORR60XFumwAZkRDfS9rInxT8VpG3lUtGb9V
         PqqDjtqvgnFgFXTSyDGT5yPjDqgZtWc2R6GIAyd2QKM2tIWakZ/x+VIuU1APvk2WngMu
         uvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FHNIq0DAsiO68PBdakjAEu2fVLC527LLikbsrJoLlzw=;
        b=L6TQxrbkzEpj0hQE/qL++WIIpjQLGqhGWifABzfTKWAHSTAcb5Xj6Av3upO3fRvvr0
         0RShCgq5v2c9oTBzQCQV57nNQEepdvhOOu9pe01NhUln6V+Ru5MOduuszx+gTzNJsE9k
         ZMiBkXzrB4yYZsQSX7BQVryAndinz1SGxhAtHW+lFyXWQvFR3oO40F43bZWlFGhr6wbf
         d33gr+MPIgHcsNzw21CQRY93d84jWdvaPCeTqXsW7hOuI2xE0Rq0O0YfLyZ5naVkNJXI
         jh4WZCkVLBzcE0d23VhhBWuwFrhU+CO84WQuP827AsGtI5pVVXAFhziX7M5CMu1jAjSp
         Bxxg==
X-Gm-Message-State: APjAAAWbPgKu9gtZpARkVpp2mM4GbfsogJ3354bGzefhIsvWS1HkzM9I
        2L+Oa/10+vJsU4KL32aSDA6dnf8813GQUQNbM8dIBqaa83g=
X-Google-Smtp-Source: APXvYqwv1DAqeJDxj1BR/mVOls+XWht4DhUm2eGk3cbzkXumNXi4kiC1qjGlDH+tPPXvPCfEsv5lGHYnp8KEgnRaHF8=
X-Received: by 2002:a25:5755:: with SMTP id l82mr54855357ybb.25.1554154690145;
 Mon, 01 Apr 2019 14:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190331064129.31702-1-brianvv.kernel@gmail.com> <74e3024f-6fde-a04d-4000-89c6e61acc26@iogearbox.net>
In-Reply-To: <74e3024f-6fde-a04d-4000-89c6e61acc26@iogearbox.net>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Mon, 1 Apr 2019 14:37:59 -0700
Message-ID: <CANP3RGdf9RWj82S6zCK4QnkMmoUiPRmsqyKw6xiUepNweNNQjA@mail.gmail.com>
Subject: Re: [PATCH] bpf: do not start from first bucket if elem is not found
 on a htab
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Kernel hackers <linux-kernel@vger.kernel.org>,
        Linux NetDev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This breaks BPF selftest suite unfortunately:
>
> # ./test_maps
> test_maps: test_maps.c:114: test_hashmap: Assertion `bpf_map_get_next_key(fd, &key, &next_key) == 0 && (next_key == first_key)' failed.
> Aborted
>
> Some more background, situation is a bit tricky: pre 8fe45924387b ("bpf:
> map_get_next_key to return first key on NULL") there was no reliable way
> of getting to the start of a hash table, meaning it needed an 'invalid'
> key to return the first element for starting traversal which commit fixed
> by being able to pass in NULL. So some applications might still just rely
> on e.g. key of zero bytes (if guaranteed to not be used otherwise) to do
> just that. With this patch, we'd start out from anywhere in the hash table.

sdf@ just mentioned this internally as well... I think we simply will
need to add a flags field
with at least two options/flags:
- return error if key not found
- resume from bucket instead of beginning if key not found
and while we're at it:
- return concatenated key+value instead of just key to save an
immediate lookup on the returned key

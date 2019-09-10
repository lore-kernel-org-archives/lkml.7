Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FA1C49ED8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A65021479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G8tnCttE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393770AbfIJOyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:54:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41749 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732434AbfIJOyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:54:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id a4so16750919ljk.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 07:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nuroSq5xVvvzh+v0qlo9GQuTkiKTTTkV0acBTH9xBxw=;
        b=G8tnCttE8WYXmZymod5Wpj8QXNMnObna74TmAzDI0TZHGg2UXsdPql9W2EqG5PgPF9
         Uj8nmQwOtHqqq+Hb/JwU6u9cBq+XPF1LdT3c9XeY5pJywF1a+6yAjImuknUtqsN3CKDi
         QjyKjEb0eqmMgwbAiJ1zE0I0rGN8wZtMp10w3KHe4QYYVrBZzzPQZzK/oan0gujscL4Q
         gGuiEmCbVllxpW3arvdko3OWVgmL+IHZl3bNByswiNmCSxShzFOZjBsyQHwvdvgAhzdq
         p9EQGSZeykdG0xNtNvEKE0rsHPqIxc0rb6JcgjQk5k5mVq0Zxyp44J+d+BAaQRvMVYth
         8PBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=nuroSq5xVvvzh+v0qlo9GQuTkiKTTTkV0acBTH9xBxw=;
        b=UaSUaXdO8JyOHE9GK0GebKcC03nAIAR0St/e9z1LzmP9vfuxsMpoMfuGP6qnpiZUp1
         kchQswjel5dgNyuqwiWrgSwxgqHvf2C82s0dlmfcS7TLN+4K/+kkv1dUUOVP51C1Oocc
         z0dpgYen04GaoimnqWHZj5nYzUCLfczGJ+FlT4mgm3QavNV3IwJ+4ZweY3mIbcynTILn
         egIsvm1bIcNXen4wUlR4vEvkJZ7ofyAzYW70FTFvLOo3kVUe4QrBGg6oSMSNfAi+oHaC
         sdGS/d7uCYZwi4q/uXZ5vL8vWLhTCUq23QMMv3FC5PZh0lnJSOqrKq3a4oqUsP0oSRWa
         lVVg==
X-Gm-Message-State: APjAAAUv4igEOIeOgStZybFM+7s7eIPb/NuhMgueHmUNVebOiN4EQGZC
        Egt10Hkvb9XqChZ0TTRlkIQNJQ==
X-Google-Smtp-Source: APXvYqzoL8vXP4WzF0c3Qvv+WB5KvvkzQvf2Y20elnufkVTtlnsX7iT/hT9XprVDLXcWFsF+OztVLA==
X-Received: by 2002:a2e:9081:: with SMTP id l1mr978301ljg.33.1568127244223;
        Tue, 10 Sep 2019 07:54:04 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id l9sm3853105ljg.79.2019.09.10.07.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Sep 2019 07:54:03 -0700 (PDT)
Date:   Tue, 10 Sep 2019 17:54:01 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH bpf-next 01/11] samples: bpf: makefile: fix HDR_PROBE
 "echo"
Message-ID: <20190910145359.GD3053@khorivan>
Mail-Followup-To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
 <20190910103830.20794-2-ivan.khoronzhuk@linaro.org>
 <55803f7e-a971-d71a-fcc2-76ae1cf813bf@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <55803f7e-a971-d71a-fcc2-76ae1cf813bf@cogentembedded.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 01:46:48PM +0300, Sergei Shtylyov wrote:
>Hello!
>
>On 10.09.2019 13:38, Ivan Khoronzhuk wrote:
>
>>echo should be replaced on echo -e to handle \n correctly, but instead,
>
>  s/on/with/?
s/echo/printf/ instead of s/echo/echo -e/

printf looks better.

>
>>replace it on printf as some systems can't handle echo -e.
>
>   Likewise?
Like some, better avoid ambiguity, for me it works fine - is not enough.
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html
 "A string to be written to standard output. If the first operand is
 -n, or if any of the operands contain a <backslash> character, the
 results are implementation-defined"

I can guess its Mac vs Linux, but it does mean nothing if it's defined as
implementation dependent, can be any.

>
>>Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>[...]
>
>MBR, Sergei
>

-- 
Regards,
Ivan Khoronzhuk

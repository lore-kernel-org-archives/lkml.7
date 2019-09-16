Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4212C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B17214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ne1r7/Ag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403842AbfIPVWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:22:11 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37415 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730662AbfIPVWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:22:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id c22so1362449ljj.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 14:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dkfcLQF/tIOTeeIdqJMbWZiDa2xY+OxFlDcGtEBgvPs=;
        b=Ne1r7/AgO+KtwYd1q/2KIaKaaNVBrZ4rRc78P2bYM3GwpWcUHmWOyELgVlqVdh92CK
         LkmLdMeRMT4ZBrJiyiyHc0ZpKt+umUpYPWtdUw+v0YDx+77GAJ5udCaJYqPpP0D0KGMn
         h9AKeK7WVmqBr6hcJlKcTDIOFRRqQ//NPx4cq6zUq1iS5f/8A3lY1BMe85bRO1lXPvwF
         dvjVKuY9m/Gve/Lzc1wBAS2wzlDr5v62PRKAORIO3mHrnIShq9/kA9eFhbkQYOMRsXXF
         u/Fs2whKmrqLDSKO0mOrvZn45qhzXviEKYvLiYrd8v1z4B4E71TKPwDgCvquQkz8+OsC
         I9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=dkfcLQF/tIOTeeIdqJMbWZiDa2xY+OxFlDcGtEBgvPs=;
        b=Z8IU8VtZeofD/ToA1zFUtOyXmg7Qp2As6FN+dpWiGQDmvMT1Kg1ZR9jm8Le0eQtcZ/
         DPjYUeDxk+J5HZMjdfdWplUsDTXxSscys/4/TdGao0HykcM7A50DB6rx3eQQjfDyL/3m
         ckbi1PA84KdE5LviGYFtIcMCBD4y0Q7a1fQcDy7O3IEYWY1mkEHUuU4Im5fdjU5y/CH+
         hqMPcf6GL5HTLfoK2B+b3/mtPoYVJYSBNROU0VsSm0THTn3zTTP/f1MrhiS1QmG2DztK
         NgifWuCK7MSdGObGDymbG73ECT0wslN3YCmDcyO0mQWOeUa6qoSVvemaxkm2BX9XpGf/
         TyQA==
X-Gm-Message-State: APjAAAXAMsJo6MzBc6Zm0YCd66Y8bUSfvau6M+ZJMtY1rH0W/O+f1FJ7
        DPu5LpeMUxZNwi55Tk7WqoqsEg==
X-Google-Smtp-Source: APXvYqzV76u2849Gz4AEo8493X917I7CZ3AYhQkdkfboPLmd4/iYmWUbuNaLbkPD5JsM0UV8Mt7CpA==
X-Received: by 2002:a2e:98d2:: with SMTP id s18mr4661ljj.68.1568668929218;
        Mon, 16 Sep 2019 14:22:09 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id r6sm14547ljr.77.2019.09.16.14.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Sep 2019 14:22:08 -0700 (PDT)
Date:   Tue, 17 Sep 2019 00:22:06 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH v3 bpf-next 01/14] samples: bpf: makefile: fix HDR_PROBE
 "echo"
Message-ID: <20190916212204.GA4420@khorivan>
Mail-Followup-To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        sergei.shtylyov@cogentembedded.com
References: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
 <20190916105433.11404-2-ivan.khoronzhuk@linaro.org>
 <CAEf4BzZVTjCybmDgM0VBzv_L-LHtF8LcDyyKSWJm0ZA4jtJKcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAEf4BzZVTjCybmDgM0VBzv_L-LHtF8LcDyyKSWJm0ZA4jtJKcw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 01:13:23PM -0700, Andrii Nakryiko wrote:
>On Mon, Sep 16, 2019 at 3:59 AM Ivan Khoronzhuk
><ivan.khoronzhuk@linaro.org> wrote:
>>
>> echo should be replaced with echo -e to handle '\n' correctly, but
>> instead, replace it with printf as some systems can't handle echo -e.
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> ---
>>  samples/bpf/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>> index 1d9be26b4edd..f50ca852c2a8 100644
>> --- a/samples/bpf/Makefile
>> +++ b/samples/bpf/Makefile
>> @@ -201,7 +201,7 @@ endif
>>
>>  # Don't evaluate probes and warnings if we need to run make recursively
>>  ifneq ($(src),)
>> -HDR_PROBE := $(shell echo "\#include <linux/types.h>\n struct list_head { int a; }; int main() { return 0; }" | \
>> +HDR_PROBE := $(shell printf "\#include <linux/types.h>\n struct list_head { int a; }; int main() { return 0; }" | \
>
>printf change is fine, but I'm confused about \# at the beginning of
>the string. Not sure what was the intent, but it seems like it should
>work with just #include at the beginning.

At least no warns, but looks like should work.
Will try it in next v.

>
>>         $(HOSTCC) $(KBUILD_HOSTCFLAGS) -x c - -o /dev/null 2>/dev/null && \
>>         echo okay)
>>
>> --
>> 2.17.1
>>

-- 
Regards,
Ivan Khoronzhuk

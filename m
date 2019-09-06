Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E829DC47401
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37CF206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N8apvxEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393279AbfIFXwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 19:52:14 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35477 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731868AbfIFXwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:52:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id q22so2928529ljj.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 16:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7gt+dprtIaWWWiehpVBpT9gjTU5sJKWHbohiXhkeDVw=;
        b=N8apvxEuyAMDm7IdWzHrNax6Ft6Lvj8/T5bGsnuBYBtBJ5220TDZcpKa/hGVGfOAHk
         oloaJcf7HJINFllAa8ld9Vm/vwaHXJCNdjdU3jX3LY2J83sYJMHZLqDnN/LzOpY1Wqf4
         gXWFd7YiKBxu+RyqKpqecrgh2H0RVgIVuybb9Jg2GV6XXGaYImkOrd6BhLOiByqE+pYS
         3i2TeTS9cvlSA1odIj+9mEqPiVH/fuRdT2gy+pCu4aA1pWyjAwZw+4I3F4wNPeLxZfX2
         QqmHBqKAV3MpPRe2IeOcum5xzZmiAxpUX/8nMZfJeNXM2p0zHBpMMa96l7uVfATdoEuo
         83bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=7gt+dprtIaWWWiehpVBpT9gjTU5sJKWHbohiXhkeDVw=;
        b=R25DFim4P2DYb+nim5L/lU5RiFHpr+hM1vkThR2ivsGaaAxEACDCABZR9cQim/0L+T
         60pQcl5HGwYI8eHT8FUhUcIcAd3F7b0P9uIcGyz3LzIaQZfwOJyOaX1hazC7qX4o9UD5
         phGsWCKhMJw05Q5f2nc6419WzA/CH4iiATWu/GKe24jB2Teb6paLI8ozwJyKKogoYgQ4
         /itJHjB8WiFbTRqdSq1m5WMyIL6uRkHPjGFbtYgsCFoOnFw0lwo42PyLh++FIipp0waq
         p65D9Pf2YDvYJUAurcjEFBKwslQO1s0lEzOgK0P8lNkMVIlFIWwQa6lf1UmpzhZJ/1xv
         iGyA==
X-Gm-Message-State: APjAAAWaLOf9nS8aEnxMc5VE6L9jOI0nE253wQYNtx2J0kAk+ZpUVhYS
        rS3yONVlwDkM0Hyzbpss5+yF76aRlCU=
X-Google-Smtp-Source: APXvYqzks9jN+Vc+WCVfIT3Izxu7CuU+7cTYAXJzMrP6IaIIHCaeKcyAscaFaspGG5UANI+GaQJ7fg==
X-Received: by 2002:a2e:b4db:: with SMTP id r27mr7238028ljm.110.1567813931698;
        Fri, 06 Sep 2019 16:52:11 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id t5sm1408113lfl.91.2019.09.06.16.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Sep 2019 16:52:11 -0700 (PDT)
Date:   Sat, 7 Sep 2019 02:52:08 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH bpf-next 2/8] samples: bpf: Makefile: remove target for
 native build
Message-ID: <20190906235207.GA3053@khorivan>
Mail-Followup-To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20190904212212.13052-1-ivan.khoronzhuk@linaro.org>
 <20190904212212.13052-3-ivan.khoronzhuk@linaro.org>
 <20190906233138.4d4fqdnlbikemhau@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190906233138.4d4fqdnlbikemhau@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 04:31:39PM -0700, Alexei Starovoitov wrote:
>On Thu, Sep 05, 2019 at 12:22:06AM +0300, Ivan Khoronzhuk wrote:
>> No need to set --target for native build, at least for arm, the
>> default target will be used anyway. In case of arm, for at least
>> clang 5 - 10 it causes error like:
>>
>> clang: warning: unknown platform, assuming -mfloat-abi=soft
>> LLVM ERROR: Unsupported calling convention
>> make[2]: *** [/home/root/snapshot/samples/bpf/Makefile:299:
>> /home/root/snapshot/samples/bpf/sockex1_kern.o] Error 1
>>
>> Only set to real triple helps: --target=arm-linux-gnueabihf
>> or just drop the target key to use default one. Decision to just
>> drop it and thus default target will be used (wich is native),
>> looks better.
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> ---
>>  samples/bpf/Makefile | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>> index 61b7394b811e..a2953357927e 100644
>> --- a/samples/bpf/Makefile
>> +++ b/samples/bpf/Makefile
>> @@ -197,8 +197,6 @@ BTF_PAHOLE ?= pahole
>>  ifdef CROSS_COMPILE
>>  HOSTCC = $(CROSS_COMPILE)gcc
>>  CLANG_ARCH_ARGS = --target=$(notdir $(CROSS_COMPILE:%-=%))
>> -else
>> -CLANG_ARCH_ARGS = -target $(ARCH)
>>  endif
>
>I don't follow here.
>Didn't you introduce this bug in patch 1 and now fixing it in patch 2?
>

It looks like but that's not true.
Previous patch adds target only for cross compiling,
before the patch the target was used for both, cross compiling and w/o cc.

This patch removes target only for native build (it's not cross compiling).

By fact, it's two separate significant changes.

-- 
Regards,
Ivan Khoronzhuk

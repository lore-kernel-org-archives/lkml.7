Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FACECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1149420679
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KLkB1k+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfJKJ41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 05:56:27 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44319 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfJKJ41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:56:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id q12so6579228lfc.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 02:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pWOkKXMMhlTx5AzJ2yss3zoDHNMcN+4G3JZ21wCHuz0=;
        b=KLkB1k+sZZvbTV8NTZTJ53VPzlRq+/OYW6/swdyx+bm1KkP5JJCwJt4FSMYP7nZTcN
         5cuHjBHfgws2ptAiAj5APks1aFl5032jhnf+0j7jRRRsBJAIQ9FIkdbpTNFpwoXYmEVC
         4pRgACHxmK2hiMYC2tchxAfBT1Rc3U99tB7e0V4pyvzq7G4IBD1XDloEOSrRO6Fsfmjk
         c8FPcrwk9T1bxc4+3ogtxdIDmPXdJs8mfciD53Cxypy8ifd6n+yQ+R67H8ClX14B0MBW
         0bwcfrDwPs5eZRE8ym7bT9RYZYsLmp+o3SicveJCfsFZDvdvg5Uw/qClPLwYZA+8SCUW
         TtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=pWOkKXMMhlTx5AzJ2yss3zoDHNMcN+4G3JZ21wCHuz0=;
        b=Ot42NfCj7FXpc/CW2mCLdJYuahszhl46cwQ7ZcN8vKM09TEQXbY0nUjNv6ocmTWxPZ
         35Gks8eULNHgIyvLDsrnnBbQl5TrcytIbxa9G+Me6BS5aIx8AbVuYW8vgzNB4basRXTx
         GhhCWLy8Kcy/+pmUG//wQ+UbLwLiiZcotqoHRkkVQDA0Bjm1tmfvW7qNAPo2lE3sQrKE
         1p1tMxLsTWbj7MkUhjO/fQ268KMk2w4J7+gx1q+ZOcK1QPnCPV7eVvk42NSRiiN3Wgys
         zp4GxMqoDQQyGSfkIr92n0r7e3g6pR3z+obPiZSkEin4wvXIRUfFL+gvqHe4W47vm8cw
         zcSA==
X-Gm-Message-State: APjAAAXDxysLL6JasTEO+1cDIGnMc862iRozGMdF5sEnODxNEPbPdVpG
        +Ua3or83hF3CzXMImAmfE1FPcLkTVfo=
X-Google-Smtp-Source: APXvYqxoUkQ1diZUv2vTQTPwqixqbfFJac3hH+dUfd7mp6Vs56IdYApGFTMbwT8nD3apWn/BWRjj4Q==
X-Received: by 2002:a19:2287:: with SMTP id i129mr8197729lfi.43.1570787783666;
        Fri, 11 Oct 2019 02:56:23 -0700 (PDT)
Received: from khorivan (88-201-94-178.pool.ukrtel.net. [178.94.201.88])
        by smtp.gmail.com with ESMTPSA id v1sm1836900lji.89.2019.10.11.02.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Oct 2019 02:56:23 -0700 (PDT)
Date:   Fri, 11 Oct 2019 12:56:20 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v5 bpf-next 05/15] samples/bpf: use __LINUX_ARM_ARCH__
 selector for arm
Message-ID: <20191011095619.GA3689@khorivan>
Mail-Followup-To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com, ilias.apalodimas@linaro.org
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
 <20191011002808.28206-6-ivan.khoronzhuk@linaro.org>
 <fa252372-b518-213c-b6f1-60520831e677@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fa252372-b518-213c-b6f1-60520831e677@cogentembedded.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 11:46:54AM +0300, Sergei Shtylyov wrote:
>Hello!
>
>   Sorry, didn't comment on v4...
>
>On 11.10.2019 3:27, Ivan Khoronzhuk wrote:
>
>>For arm, -D__LINUX_ARM_ARCH__=X is min version used as instruction
>>set selector and is absolutely required while parsing some parts of
>>headers. It's present in KBUILD_CFLAGS but not in autoconf.h, so let's
>>retrieve it from and add to programs cflags. In another case errors
>
>   From where? And it's program's, no?
from KBUIL_CFLAGS. it's programs.

>
>>like "SMP is not supported" for armv7 and bunch of other errors are
>>issued resulting to incorrect final object.
>>
>>Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>[...]
>
>MBR, Sergei

-- 
Regards,
Ivan Khoronzhuk

Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1F2C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A575820679
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UAFeseSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfJKJ5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 05:57:23 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45183 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfJKJ5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:57:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id q64so9160318ljb.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 02:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hp51ftF0fMacTdMbbRNDwAHtYKpjRZUEYNDQ5ofyyAk=;
        b=UAFeseSzu034KHnL5iKmG61KtCqRuzg7Hd56VJAIxJ1CI96wrcWVEJ7JKKKS2hLbdm
         N+KWkvUlhRW7lsOVGESl7+nBmGQ3CmSvM0sIMR0nr6Jc7oSuPHjAE10DG2RJlqCPQgGY
         c9Sv5GnzYsVLbQnePHapb9ck+2IDjD/HD7b3zVpUZZf2wMqYBVStjUh/A8xyk+rx4SeU
         E8/X1zyU3UIgjiOVuw7HfaKs66VxcSuF4UZ7dyU2d5WH2YdMpOKzj94ImY+DGk7XFl02
         0NNqakT+4pD1QvhBoIgYlWEjOYSRBbXHaA5EvcD4p86jI9vmT6LBKD5tlKW+YnnB/uJr
         l31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=hp51ftF0fMacTdMbbRNDwAHtYKpjRZUEYNDQ5ofyyAk=;
        b=QOmbDyP8E3dIzaIooPz3APHwyDBkVr9q3Ueb23nkxV4NGryEjl1nsERvVo9Wf8CE0r
         nIF0dzLoyEGr+wXjnzoWK6cjxr8VoOY72SA3oqjlnzDYiyO84gc3X3biKMjMZcNMed/g
         fKn/wI5z2kGn+BMgx7ii3GMHpOeJGs5LYa9zNFHuoW2jmTBiX9ljqrrOvd3UGjSr9fp3
         0mAkIWChZGndzGookjsPNbxh4ofu7ARCFu4NXShwI+Aw2BWU7z4FW8mQKxk5PNij5vlU
         EuqgPKhmZnQTXJtXmLGsyNOW0yk7kKPFDttz5JLIASUUJsbuDqmuqAwofETOfg0+ooyw
         ZFrw==
X-Gm-Message-State: APjAAAVo8xc5f3h4uy0/JIL6YZb1jodXxiNM7JYYbkTYVOuUL+BPEfw2
        xhXFSdidjhVSY+NuWpPPi05x0Q==
X-Google-Smtp-Source: APXvYqy1TBg1gVB8cIRIr7goBTo+5pg79WWTsnlzh7n433Dq6RXlNFoeA9ldACb5LDRrkUv0+sWAZg==
X-Received: by 2002:a2e:3919:: with SMTP id g25mr8650919lja.162.1570787839244;
        Fri, 11 Oct 2019 02:57:19 -0700 (PDT)
Received: from khorivan (88-201-94-178.pool.ukrtel.net. [178.94.201.88])
        by smtp.gmail.com with ESMTPSA id m17sm2384718lje.0.2019.10.11.02.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Oct 2019 02:57:18 -0700 (PDT)
Date:   Fri, 11 Oct 2019 12:57:16 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v5 bpf-next 09/15] samples/bpf: use own flags but not
 HOSTCFLAGS
Message-ID: <20191011095715.GB3689@khorivan>
Mail-Followup-To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com, ilias.apalodimas@linaro.org
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
 <20191011002808.28206-10-ivan.khoronzhuk@linaro.org>
 <99f76e2f-ed76-77e0-a470-36ae07567111@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <99f76e2f-ed76-77e0-a470-36ae07567111@cogentembedded.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 11:49:38AM +0300, Sergei Shtylyov wrote:
>   More grammar nitpicking...
>
>On 11.10.2019 3:28, Ivan Khoronzhuk wrote:
>
>>While compiling natively, the host's cflags and ldflags are equal to
>>ones used from HOSTCFLAGS and HOSTLDFLAGS. When cross compiling it
>>should have own, used for target arch. While verification, for arm,
>
>   While verifying.
While verification stage.

>
>>arm64 and x86_64 the following flags were used always:
>>
>>-Wall -O2
>>-fomit-frame-pointer
>>-Wmissing-prototypes
>>-Wstrict-prototypes
>>
>>So, add them as they were verified and used before adding
>>Makefile.target and lets omit "-fomit-frame-pointer" as were proposed
>>while review, as no sense in such optimization for samples.
>>
>>Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>[...]
>
>MBR, Sergei

-- 
Regards,
Ivan Khoronzhuk

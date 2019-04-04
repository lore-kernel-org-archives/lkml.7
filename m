Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38FFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600E620674
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KC3RZeW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfDDI3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:29:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36768 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfDDI3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:29:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so2245757wml.1;
        Thu, 04 Apr 2019 01:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6rr1Q4Juu1NOSJC4GmN+YRZy+Y34ixA1m6mRTYvKEfQ=;
        b=KC3RZeW7aj8ls/hkOARhnDkJEy5ncZIp92gWkLyYcbpBsbV8lYUioqbRPcaI0nDFNY
         8MVh0DIv/JucxeiOowzX/y6TntmEDyYK0FUa/Scdk+TqlCblKJjxxnpJLK9Ud93y4twa
         XA7SuLP5FmUlSEjO+DwJ6WGe/jFwQLN9ibNkUEw+apthCKPf1GsfeZVnwlwKLc31KEaX
         3W0hV6eK6AtTZEhNfiHB34+nLnUd9173+ibGr4I1iz+W0J3HBBIwgyNJqGvd8aX16KC1
         ygVnx7QSQqJUroUoQgDn5SOu4AFObXFY+rf+q5F2Dho2qMcJxwjITP+IJ/1ZNy2vYPn8
         ZfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6rr1Q4Juu1NOSJC4GmN+YRZy+Y34ixA1m6mRTYvKEfQ=;
        b=jD9tTz7SZTxgsFmdPsv8qhPDYXW4EB1DYs6J5NO18CyorhSZke7ksZRKGjGAsmyQEU
         A5wlb9BGFraPFmjIKsH0IIkf6DqcaOQtez9zmIrSj2hflEstVaxUelijNV5yAcrcm/02
         bNuPR537pa+wKacE9BH4lmoAQMGsuRhpwNqwacakWXkh5BZLy/zGb0Pfe5UuqDA8L+b5
         Ldmx6spWSP2qAtsnV7EzVb9Ynh+Ty+xdZ1Tq9x52LEbyQqynM36XqkpoDGOMqxXpnTas
         U//ZAOTO9qoJ+aElDOiEBbZpT4zzDAIXskg64S0CCe8KJ+sq28KTSqetif1dqjmCjTY+
         JEUg==
X-Gm-Message-State: APjAAAUMj7jZ9QUIaOQyIdvujfkopgXACcVVueqfay1qQis7cFSbqQLd
        +q532zQ6BSoQ7eCgWgp4AwxEtVR2
X-Google-Smtp-Source: APXvYqwrqBjr+KyIfDllXdGtRyt0u+8Jz8GsxNzgfTa1s+KMqJIJtWdvoJCo0U6U39KU8CJF4JdlKQ==
X-Received: by 2002:a1c:d106:: with SMTP id i6mr2926434wmg.134.1554366550361;
        Thu, 04 Apr 2019 01:29:10 -0700 (PDT)
Received: from [192.168.8.147] (133.85.136.77.rev.sfr.net. [77.136.85.133])
        by smtp.gmail.com with ESMTPSA id j64sm23149128wmb.36.2019.04.04.01.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 01:29:09 -0700 (PDT)
Subject: Re: [PATCH] bpf:sample: fix field 'lock' has incomplete type in hbm.h
To:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, netdev@vger.kernel.org, yhs@fb.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20190404081620.zx5rt2j2rjvdcglt@yubo-2>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <af74fc26-2790-d83b-5320-bd4581e00585@gmail.com>
Date:   Thu, 4 Apr 2019 01:29:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190404081620.zx5rt2j2rjvdcglt@yubo-2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/04/2019 01:16 AM, Bo YU wrote:
> When compiling sample/bpf:
> 
> samples/bpf/hbm.h:12:23: error: field ‘lock’ has incomplete type
>  struct bpf_spin_lock lock;
> 
> Fixes: 187d0738ff35(bpf: Sample HBM BPF program to limit egress bw)
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> ---

This patch makes absolutely no sense.

Please carefully read samples/bpf/README.rst



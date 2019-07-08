Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8A0C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D010C216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="guiXzaD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405029AbfGHUc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 16:32:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37053 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731895AbfGHUc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:32:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id z28so8375469ljn.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 13:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QmhLmLZUpQw51TcWj6xz/UWa7Fe+O+3V90DXK/aEFco=;
        b=guiXzaD+Q8k8J8Y2zzy+eGlckI4Qfj/1ia32W8QPEpVyDxD+5hgsVF1EBjtMcdA2s/
         5R6J5f6GgfGC+nFAbBkYPeDw/XfsFDCoboRXhsd0sXhsudSf3059LbepmLdXf+bGovGT
         qc6zCll9qpQztznsNGoUo1/z6sIst7IWs3z+Pv7nR02bMmC5DCviI65aoqFu1kzeunE8
         sJFWmex7qjLe3ziuuenXDF2zBUBKL8qpBXz1MQYcrJEwVtkCqsinEygD57Y8dbRhrT+j
         eNRMf0cE5rKvU5kEP5hfxK9mWRVAK1SjUcuMmd409q26ptgM28q5w2oyc86eWpf2IN5O
         UeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=QmhLmLZUpQw51TcWj6xz/UWa7Fe+O+3V90DXK/aEFco=;
        b=PLBQCZAdcGeUkaHJik1q08GS9yg/JdVHPun15Ny+2ze8wgbfgcRxVg6Qex5wI6ukFa
         UmycJG+TV+Awlp9um6e+lZf/tj+HWbFKZ5Mmkzw5C5B5aFI0iLvyF+VgD+TW6mCP70Jj
         pyOuWwwpWt1AYlMNsv8huZswpy81Y+iE71hJl35wiiP9CvGBRzJxgBVYGJssuTv6TTJX
         5TRz6jyaDVyF559K7XDuwZu4RIMPpAikc08ZFKiDKY2vcneWC9s1FdS9CGX3YNMVIpEB
         lclgbuKI4ZvJUrnTudJpO1yZ2rNhfUvHTTy3aqMzYNpQ5P3xwL9zL1A411zXj4YmgbCh
         L+GQ==
X-Gm-Message-State: APjAAAXQhpCnCCVHnksUxYXSI+dAJdgExPdH4OTLyo1sM0X3Qcom87tk
        y0iGQr6exOlrb96NBzZ9gas2uw==
X-Google-Smtp-Source: APXvYqwVRisXI+W1yDsrFdBvfB5lZcfxm6xx+YU6rvWYruaiHxMRpCBIx1t+9hogA9dGSL6dnfZZgQ==
X-Received: by 2002:a2e:981:: with SMTP id 123mr11792658ljj.66.1562617977232;
        Mon, 08 Jul 2019 13:32:57 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id z23sm2925562lfq.77.2019.07.08.13.32.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 13:32:56 -0700 (PDT)
Date:   Mon, 8 Jul 2019 23:32:54 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     David Miller <davem@davemloft.net>
Cc:     grygorii.strashko@ti.com, hawk@kernel.org, ast@kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        xdp-newbies@vger.kernel.org, ilias.apalodimas@linaro.org,
        netdev@vger.kernel.org, daniel@iogearbox.net,
        jakub.kicinski@netronome.com, john.fastabend@gmail.com
Subject: Re: [PATCH v8 net-next 0/5] net: ethernet: ti: cpsw: Add XDP support
Message-ID: <20190708203252.GA12580@khorivan>
Mail-Followup-To: David Miller <davem@davemloft.net>,
        grygorii.strashko@ti.com, hawk@kernel.org, ast@kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        xdp-newbies@vger.kernel.org, ilias.apalodimas@linaro.org,
        netdev@vger.kernel.org, daniel@iogearbox.net,
        jakub.kicinski@netronome.com, john.fastabend@gmail.com
References: <20190705150502.6600-1-ivan.khoronzhuk@linaro.org>
 <20190707.183146.1123763637704790378.davem@davemloft.net>
 <20190707.183511.503486832061897586.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190707.183511.503486832061897586.davem@davemloft.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2019 at 06:35:11PM -0700, David Miller wrote:
>From: David Miller <davem@davemloft.net>
>Date: Sun, 07 Jul 2019 18:31:46 -0700 (PDT)
>
>> From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> Date: Fri,  5 Jul 2019 18:04:57 +0300
>>
>>> This patchset adds XDP support for TI cpsw driver and base it on
>>> page_pool allocator. It was verified on af_xdp socket drop,
>>> af_xdp l2f, ebpf XDP_DROP, XDP_REDIRECT, XDP_PASS, XDP_TX.
>>>
>>> It was verified with following configs enabled:
>>  ...
>>
>> I'm applying this to net-next, please deal with whatever follow-ups are
>> necessary.
>
>Nevermind, you really have to fix this:
>
>drivers/net/ethernet/ti/davinci_cpdma.c: In function ‘cpdma_chan_submit_si’:
>drivers/net/ethernet/ti/davinci_cpdma.c:1047:12: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>   buffer = (u32)si->data;
>            ^
>drivers/net/ethernet/ti/davinci_cpdma.c: In function ‘cpdma_chan_idle_submit_mapped’:
>drivers/net/ethernet/ti/davinci_cpdma.c:1114:12: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>  si.data = (void *)(u32)data;
>            ^
>drivers/net/ethernet/ti/davinci_cpdma.c: In function ‘cpdma_chan_submit_mapped’:
>drivers/net/ethernet/ti/davinci_cpdma.c:1164:12: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>  si.data = (void *)(u32)data;
>            ^
Actrually that's fixed in reply v9 patch.
But, nevermind, i will send v9 for whole series.

-- 
Regards,
Ivan Khoronzhuk

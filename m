Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912A9C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5753620821
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWKRVr3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388514AbfDRJr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:47:27 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38367 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388070AbfDRJr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:47:26 -0400
Received: by mail-lj1-f193.google.com with SMTP id p14so1370822ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 02:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=l2Ztyrd4pLxRaOuJ4dVZPgRuj0T5Y7Nd0hpOUxYM8ec=;
        b=MWKRVr3wp9TNfT/CSIcURiOwdhdjOx/UtRuatKP9358lUZJ+Ii6JWlAXg2H1AiGsDz
         7RtpQ+R1Jjgt44lHcC6X4mmMdJ5sZNzihkQuxp49+DNLBwE972rVq5K+9XO/HDL1LUtD
         Mk12M34tv+cuOJlBUuNLY8UqCLaxTJr0tNSOOAb8jmKBhUVBjzBVYZMrZJWa8DUwzlNM
         zFjUVgSMSK4Q5w20W6bgd4y8A6pBJVc8xog7gm7MLtAOHrosuQmdwWxAsegtLSoIIfDe
         adCBux7ZCt18H37G/Us/XaLpdSN4lSo23tX2K84r0xXq51uiYbrXHUUqdWX0skWd8R2q
         Tnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=l2Ztyrd4pLxRaOuJ4dVZPgRuj0T5Y7Nd0hpOUxYM8ec=;
        b=ueQ0ntsip7+PkwBMCwUyIXZ3FneVKZRWwT6U1Yu6NnNXp5a0CfXzxcwOeNbYbGiYmE
         DQqAf1jBxKzRJ/pRMZTLwWpGSByrAblimHYjlQcuYyhFv++4O7PNvD1hTNW2bmFjUmI0
         A6A7vyXUIFtfacTqfYCuG+05aDlM7ExWIJPtb5ahYaYzS3c/eH2c/Jg5mrwz2dvSOf1M
         jaGWDT40/xXjF/+cb5EtmaPimu1mQ9eXICdBNghoy8gZ1BP2mpQnquKA7TABBBF1yDZj
         mnCGYsxeM2qeTw3G3Eyef/WNy64m7ayZ2TiG7SBlLf8H7R/X1QJlPqCQfzkLMa+WAhm+
         bIRQ==
X-Gm-Message-State: APjAAAU2YCDcgvvILCUyxCWPLm422CLBvdp4KLDvoa4zFJEQKHA2EJ53
        I1OdWW0QuYEbT1yWMWZjPxaXwg==
X-Google-Smtp-Source: APXvYqweDCWA6/i5/PXB8cdB9gmkH6haf1P/50z7KlVlRIQT41p0RzeuOB4Y1Rg+Y792KPmXjEw3eQ==
X-Received: by 2002:a2e:6a14:: with SMTP id f20mr52986609ljc.65.1555580843899;
        Thu, 18 Apr 2019 02:47:23 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id s16sm301334lji.61.2019.04.18.02.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 02:47:23 -0700 (PDT)
Date:   Thu, 18 Apr 2019 12:47:21 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>
Cc:     grygorii.strashko@ti.com, linux-omap@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        hawk@kernel.org, Xdp <xdp-newbies@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, aniel@iogearbox.net,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Subject: Re: [RFC PATCH 0/3] net: ethernet: ti: cpsw: Add XDP support
Message-ID: <20190418094719.GC27879@khorivan>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        grygorii.strashko@ti.com, linux-omap@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>, hawk@kernel.org,
        Xdp <xdp-newbies@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, aniel@iogearbox.net,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
References: <20190417174942.11811-1-ivan.khoronzhuk@linaro.org>
 <CAJ+HfNhzBMgQwan-x1KV48V_z0jVQgWnAD+HDxvYLyCmTxAJbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+HfNhzBMgQwan-x1KV48V_z0jVQgWnAD+HDxvYLyCmTxAJbw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 08:12:06AM +0200, Björn Töpel wrote:
>On Wed, 17 Apr 2019 at 19:51, Ivan Khoronzhuk
><ivan.khoronzhuk@linaro.org> wrote:
>>
>> This patchset is RFC adding XDP support for TI cpsw driver that is
>> based on page_pool allocator. It was verified with af_xdp sockets
>> and on xdp drop. For XDP redirect to another interface it's under
>> verification, still not sure about all cases that should be verified.
>> Also regular tests with iperf2 were done in order to verify impact on
>> regular netstack performance, compared with base commit from
>> net-next/master: 432bc230700f86801cffa5e159e05dea6229f722
>>
>> It was verified with following configs enabled:
>> CONFIG_JIT=y
>> CONFIG_BPFILTER=y
>> CONFIG_BPF_SYSCALL=y
>> CONFIG_XDP_SOCKETS=y
>> CONFIG_BPF_EVENTS=y
>> CONFIG_HAVE_EBPF_JIT=y
>> CONFIG_BPF_JIT=y
>> CONFIG_CGROUP_BPF=y
>>
>> iperf2 UDP RX summary (packet size / Mbps):
>> +--------------------------------------------------------------+
>> | pkt_size/rate | 1024 | 1500 | 1470 |  64  | 128  | 512 | 256 |
>> |---------------+------+------+------+------+------+-----+-----|
>> | base commit   | 561  | 470  | 796  |  35  | 70.1 | 281 | 140 |
>> |---------------+------+------+------+------+------+-----+-----|
>> | XDP patched   | 563  | 455  | 808  |  35  | 70.2 | 282 | 141 |
>> +--------------------------------------------------------------+
>>
>> iperf2 UDP TX summary (packet size / Mbps):
>> +--------------------------------------------------------------+
>> | pkt_size/rate | 1024 | 1500 | 1470 |  64  | 128  | 512 | 256 |
>> |---------------+------+------+------+------+------+-----+-----|
>> | base commit   | 555  | 666  | 736  | 34.5 | 70.3 | 281 | 140 |
>> |---------------+------+------+------+------+------+-----+-----|
>> | XDP patched   | 558  | 696  | 759  | 35.2 | 69.2 | 279 | 140 |
>> +--------------------------------------------------------------+
>>
>> iperf2 TCP summary (window size / Mbps):
>> +------------------------------------------------------------+
>> | window size/rate |  16  |  32  |  64  |  128 |  8   | 256  |
>> |------------------+------+------+------+------+------+------|
>> | base commit      | 753  | 887  | 931  | 932  | 676  | 932  |
>> |------------------+------+------+------+------+------+------|
>> | XDP patched      | 823  | 888  | 932  | 933  | 669  | 933  |
>> +------------------------------------------------------------+
>>
>> For af_xdp socket type verification several generic changes should be added
>> that can be seen here (rough fixes, for samples related seems like last version
>> of samples is more integrated with libbpf api, so should be rebased,
>> witch I will send as RFC separately):
>> https://github.com/ikhorn/af_xdp_stuff/tree/af_xdp_armv7
>>
>
>More XDP support, yay!
>
>As for mmap/AF_XDP on 32-bit systems; Instead of hacking the if_xdp.h,
>mmap2 should be used. Have a look at the libbpf code here [1]
I more bothering about this fast fix (not investigated deep enough):
https://github.com/ikhorn/af_xdp_stuff/commit/f77cd4faf95ad744bbf37d0ba81d0ec79c1b0d29

That's about when page_address(umem->pgs[i]) returns nothing.

>
>
>Björn
>
>[1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/tools/lib/bpf/xsk.c#n81
>
>
>> Ivan Khoronzhuk (3):
>>   net: ethernet: ti: davinci_cpdma: add dma mapped submit
>>   net: ethernet: ti: davinci_cpdma: return handler status
>>   net: ethernet: ti: cpsw: add XDP support
>>
>>  drivers/net/ethernet/ti/Kconfig         |   1 +
>>  drivers/net/ethernet/ti/cpsw.c          | 552 +++++++++++++++++++++---
>>  drivers/net/ethernet/ti/davinci_cpdma.c | 117 +++--
>>  drivers/net/ethernet/ti/davinci_cpdma.h |   6 +-
>>  drivers/net/ethernet/ti/davinci_emac.c  |  18 +-
>>  5 files changed, 591 insertions(+), 103 deletions(-)
>>
>> --
>> 2.17.1
>>

-- 
Regards,
Ivan Khoronzhuk

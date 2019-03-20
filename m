Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3366C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7C720850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="N0v1Kct3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfCTTFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:05:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50734 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfCTTFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:05:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so365426wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TroIgZLRE0sqz8nvE56EoIevjhw7nnL6S4j85a24D9E=;
        b=N0v1Kct3dlASD1WMaCYDSS+tU/O6zt/D3OH/7Y/RuMB5GfUQefM+ce29gg8U/1hWSz
         wDKRDU5jNsh7HKUd0909GqZ75GPWes5bL732FyrazmbnvFIuA/aF+Pa0E/pvpic3zzA5
         yAG/omm1SN/hlFsyMieHJUE4kE669O2kCutIrFKX3lZPlXMwDzvBZBykbDQGBLYt6kJs
         R+pjS3DYoV5neCzUJliP+OwqWgtczC8X651Kq2M2pe7UfKMYaifRI3Sb5Y4tZiZ386Xm
         6vjLZv3lMtirDgGJxWvFKqY4g3nVOLCk+P5n7VwC2Gno9oTwnKfm72Ob3L4WE2dIonHl
         maIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TroIgZLRE0sqz8nvE56EoIevjhw7nnL6S4j85a24D9E=;
        b=lgPSCuFb5tD0QdTghpx8l/Hi65PMpKYnPYIRIyQxHhXQL0vWZS+nRHZuEbJWNUuRZ8
         SRPUX6DmG73tn5rKKVZxM7Kqs0+xJjkXA6xEymkE3qLkNVDD9tuG4PKkrp7TbjeqAYBe
         eUGL9BMyc7xPOHgmI1ihoA2XyXy5U+hrF/u0mnsGuk+RAqXMeDfxmIc6ejkFBzBpPRcp
         6bzwSfuU4FF5E28tjb3Dkcf/ZJI09GM9ksLwlqjRS1SuPY65LbU0njf6n/tD5HYjl+Al
         K9U3lN3zdFq0y8XCq67+GqACHzf86B/dV/Exr7D1T4LmGWkGn66k2vmOBzhX+Te9E/Sc
         vDyQ==
X-Gm-Message-State: APjAAAXx8TqD1jgA6bm2BfqO662tQ7lb3Oq96rgM9PP+IAmxmgfcMLI7
        58b66CL8udVyD+Fkz2B145mDqg==
X-Google-Smtp-Source: APXvYqxqKjkKXabWDtRkgOksrpBh/7/q8gLOuoFxvp9NERLZBsFCB9cViOh1s90/1irDteVZVIdkcA==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr9987253wmh.74.1553108712368;
        Wed, 20 Mar 2019 12:05:12 -0700 (PDT)
Received: from [172.20.1.106] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id w8sm4154825wmc.0.2019.03.20.12.05.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 12:05:11 -0700 (PDT)
Subject: Re: [PATCH bpf-next v1 5/7] tools: bpftool: support loading map by fd
 from parent process
To:     Alban Crequy <alban.crequy@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alban@kinvolk.io, iago@kinvolk.io
References: <20190320173332.18105-1-alban@kinvolk.io>
 <20190320173332.18105-5-alban@kinvolk.io>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quentin.monnet@netronome.com; prefer-encrypt=mutual; keydata=
 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
 RHhSHGnKaQ6MfrTge5Q0h5A=
Message-ID: <3db33f2e-f75f-d217-3315-158436523974@netronome.com>
Date:   Wed, 20 Mar 2019 19:05:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190320173332.18105-5-alban@kinvolk.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019-03-20 18:33 UTC+0100 ~ Alban Crequy <alban.crequy@gmail.com>
> From: Alban Crequy <alban@kinvolk.io>
> 
> Using a file descriptor passed by the parent process enables
> applications to fork a bpftool command to inspect a map they know by
> file descriptor even when they don't support bpffs or map ids.
> 
> Documentation and bash completion updated as well.
> 
> Signed-off-by: Alban Crequy <alban@kinvolk.io>
> ---
>  tools/bpf/bpftool/Documentation/bpftool-map.rst |  8 ++++++++
>  tools/bpf/bpftool/bash-completion/bpftool       | 10 +++++-----
>  tools/bpf/bpftool/map.c                         | 13 +++++++++++++
>  3 files changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> index dfd8352fa453..658fe2fb8ecf 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> @@ -265,6 +265,14 @@ would be lost as soon as bpftool exits).
>  
>    anon_inode:bpf-map
>  
> +**# bpftool map exec pinned /sys/fs/bpf/foo fd 99 cmd -- bpftool map show fd 99**
> +
> +::
> +
> +  10: hash  name some_map  flags 0x0
> +	key 4B  value 8B  max_entries 2048  memlock 167936B
> +
> +

Could you please also update the description of the command higher in
that page, and in the interactive help?

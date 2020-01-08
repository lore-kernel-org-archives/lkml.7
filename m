Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17937C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC10620705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="TO0/+ZpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbgAHRs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:48:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42598 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgAHRs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:48:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so4314632wro.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 09:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vezZj2TeOMyTZ9Ka6PQUreocbb3g59W67BRJHCbJR/Q=;
        b=TO0/+ZpDaA5Hrd4Fcaja8zf9jm3EI9R+SZ3AK0hIfWoQ1U6ncMZKKIayioSNq7ETNJ
         P4eVnr++xzR1vrgoAElFIaW5STveIFl82fFZwEL+kemB+7PeM5X/Z69BoRVK0jV7TfTP
         3lmaptXbzGITFFoo5I+nro0cM1CBVWX3to4Ec69xW2KmsDDlr6BptQ+5WMcpV1xNSuOZ
         7ynlD0YtAdsZntGASqnuKDi4qa8sGOtGqrqjBOIZ0NB/rv7QqzY+ru+lSx9kwHpP6IZ+
         EUhgCa6/41xWAlAYNPuRjMmNqmwfjK4NkDYwKN+tJdarMtYXBjy54BrnW5oDQgpRHp93
         na6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vezZj2TeOMyTZ9Ka6PQUreocbb3g59W67BRJHCbJR/Q=;
        b=X5tDM9rbq6RKMv1TEgSBF0zZzweFMOgoHmbTzNqO1w/PM9QTKV+17XZPGz0QrJ33bi
         o6ju4DW/ZjWpTUqWjpTzoHWMBaxZQ2z4/pL+DMZ6IXQec7he15tgAVIjOUKVoCYtufaI
         ctxRaolK2ov/fre/cZ+1vR+4HtPYZP5BzfePVbOM5Hon1SIv93SK5IZVPhXMzxe/51z0
         yof7y8CQigv1vJCtLR9TBftxFNOkMxUfc36Dc9rl9v/qR/sXVIoq/UII8KjhyIyxb6L5
         +FrawejeQjdEf+gJgidZnbekNwf0affusLAEe/q3WYkxOVtn+FK4noo8vgm5fCRHWYgQ
         ocBw==
X-Gm-Message-State: APjAAAX9Ah4RfOlLSJSggtrSMzTQgDa69IfwaWitCyHJxVEZPySjy89r
        Qkx2U/hc7KBJgBZCTZ8u8aGbST2sOm/qkWhvQ8GT6YbAxx41Imvl1R2PRtJdKntV29EMY/pU4UJ
        6zyHumKBMdKhbVbXbCuNEssc0yVRAoa5CrcbMiSN5TxmMuGGKREoNgGAQP5gtO64nxTaE7xYqEp
        BqVpEQisKANzkY
X-Google-Smtp-Source: APXvYqzw9lbQhNDv0ekPMfA2EXZ3h1DPrEkds6Rhks25RKRygdYWU5oojPbcTwB2ub63C9bWqfi8zA==
X-Received: by 2002:a5d:6350:: with SMTP id b16mr6069265wrw.132.1578505703968;
        Wed, 08 Jan 2020 09:48:23 -0800 (PST)
Received: from [172.20.1.104] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id i8sm5449760wro.47.2020.01.08.09.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 09:48:23 -0800 (PST)
Subject: Re: [PATCH bpf-next v3 0/2] bpftool/libbpf: Add probe for large INSN
 limit
To:     Michal Rostecki <mrostecki@opensuse.org>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Stanislav Fomichev <sdf@google.com>,
        Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        Peter Wu <peter@lekensteyn.nl>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200108162428.25014-1-mrostecki@opensuse.org>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quentin.monnet@netronome.com; prefer-encrypt=mutual; keydata=
 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
 RHhSHGnKaQ6MfrTge5Q0h5A=
Message-ID: <01feb8cd-6e24-91d8-4c78-a489c1170965@netronome.com>
Date:   Wed, 8 Jan 2020 17:48:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200108162428.25014-1-mrostecki@opensuse.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020-01-08 17:23 UTC+0100 ~ Michal Rostecki <mrostecki@opensuse.org>
> This series implements a new BPF feature probe which checks for the
> commit c04c0d2b968a ("bpf: increase complexity limit and maximum program
> size"), which increases the maximum program size to 1M. It's based on
> the similar check in Cilium, although Cilium is already aiming to use
> bpftool checks and eventually drop all its custom checks.
> 
> Examples of outputs:
> 
> # bpftool feature probe
> [...]
> Scanning miscellaneous eBPF features...
> Large complexity limit and maximum program size (1M) is available
> 
> # bpftool feature probe macros
> [...]
> /*** eBPF misc features ***/
> #define HAVE_HAVE_LARGE_INSN_LIMIT
> 
> # bpftool feature probe -j | jq '.["misc"]'
> {
>   "have_large_insn_limit": true
> }
> 
> v1 -> v2:
> - Test for 'BPF_MAXINSNS + 1' number of total insns.
> - Remove info about current 1M limit from probe's description.
> 
> v2 -> v3:
> - Remove the "complexity" word from probe's description.

Series looks good to me, thanks!

Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>

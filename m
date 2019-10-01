Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB805ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B9121920
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PubyFd6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388001AbfJAMmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:42:17 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36889 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfJAMmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:42:16 -0400
Received: by mail-qk1-f196.google.com with SMTP id u184so11033173qkd.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lbq16WoGhTu1yJezAnvZ5ENrrt5jc03rHENNr+t1ZDI=;
        b=PubyFd6dSferaOpRRtRCKhwn2qzX7amzhaleESlChootKAf/PN3Q5Ut7JJGzSaCjQq
         GXzycc7W6lgj6zRqFimXtkNmlIdonqRxOGslFPyFcNnzCN8iJt0RyKJz0EBfi/YR/iCn
         a5/W+tRTTMgXFEWiQZzMKC98q9Ke4gHX5zuZIKSP57d20C0XgpkN4i1O2UhS2+sB+vrD
         wJKJRp+irfVEaWBgRLlCJ0wRrrG1zucKHHPMyaxKzmIPhlTQoWRjzh0jO61rkApOaFRG
         ocefxSj87kqGcTidLL1pruZJFdYoDF45W3AaV6aqrUD//wnA26fXsRAWp+rthYXxa/87
         Qurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lbq16WoGhTu1yJezAnvZ5ENrrt5jc03rHENNr+t1ZDI=;
        b=o+XdByOzJlobp97Dk25Bu+818So3eiZaJy8bHMGD0Vh9Bw1oC1sGRvBNEDlBMAVE80
         g3LFSINChCsrGwopsqq75itWeEZmjzNcnDLH+MFPCm4I7+cg3UWKuxQnuLT2zRDm+u51
         opryKIBXW81tNpxfcA9f7bJj/tg9UGH6dJoldX+SoTDRxq8kN49RGCZ8EyoEvnmDhc/2
         HYq60SN1FRA6BX3zhe7a/UNmSYGKjJIOfhRtIQ1h6OU49CNST8Hfy0Ch1mbL+ibRXo87
         ZsDQfI+8OtCHYF6p7xLfN1gDVBVoYoYjIY1Hibr4WdSfX3oyg/S3MqVph0i+wjcgs1X2
         7q8g==
X-Gm-Message-State: APjAAAWa9EHI0DFnUhnWQeNPNAnfdvvU+TX7/ODURhMzz7YpNryKZkmV
        MvhUXP7BY5Y5vvTKLIfOI8dzOJrifR+GgCaiJtywBQ==
X-Google-Smtp-Source: APXvYqzKJfU66W0nKk4yWz6PYnTgVzWYAEz0JmVSb388czWN8dRjzOJ9cxOiwdqZzn7DiuQIVWjLSfWf1ZPtaZ8obhQ=
X-Received: by 2002:a05:620a:13ce:: with SMTP id g14mr5665605qkl.199.1569933735126;
 Tue, 01 Oct 2019 05:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <201910011950.y6cyZ4Aq%lkp@intel.com>
In-Reply-To: <201910011950.y6cyZ4Aq%lkp@intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 1 Oct 2019 14:42:01 +0200
Message-ID: <CAKv+Gu9EoFmYw5Nz=mHDTjLRRnrx3OC=bjQ1pR2j2HJzoKQyyg@mail.gmail.com>
Subject: Re: arch/arm/crypto/aes-ce-core.S:467: Error: selected processor does
 not support `movw ip,:lower16:.Lcts_permute_table' in ARM mode
To:     kbuild test robot <lkp@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kbuild-all@01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2019 at 13:39, kbuild test robot <lkp@intel.com> wrote:
>
> Hi Ard,
>
> FYI, the error/warning still remains.

Should be fixed by

https://lore.kernel.org/linux-crypto/20190917085001.792-1-ard.biesheuvel@arm.com/

sent out ~2 weeks ago.


>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c
> commit: c61b1607ed4fbbf2ba7c86f29768cff44a1a88f8 crypto: arm/aes-ce - implement ciphertext stealing for XTS
> date:   3 weeks ago
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout c61b1607ed4fbbf2ba7c86f29768cff44a1a88f8
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=arm
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    arch/arm/crypto/aes-ce-core.S: Assembler messages:
> >> arch/arm/crypto/aes-ce-core.S:467: Error: selected processor does not support `movw ip,:lower16:.Lcts_permute_table' in ARM mode
> >> arch/arm/crypto/aes-ce-core.S:468: Error: selected processor does not support `movt ip,:upper16:.Lcts_permute_table' in ARM mode
>    arch/arm/crypto/aes-ce-core.S:553: Error: selected processor does not support `movw ip,:lower16:.Lcts_permute_table' in ARM mode
>    arch/arm/crypto/aes-ce-core.S:554: Error: selected processor does not support `movt ip,:upper16:.Lcts_permute_table' in ARM mode
>
> vim +467 arch/arm/crypto/aes-ce-core.S
>
>    403
>    404  ENTRY(ce_aes_xts_encrypt)
>    405          push            {r4-r6, lr}
>    406
>    407          bl              ce_aes_xts_init         @ run shared prologue
>    408          prepare_key     r2, r3
>    409          vmov            q4, q0
>    410
>    411          teq             r6, #0                  @ start of a block?
>    412          bne             .Lxtsenc4x
>    413
>    414  .Lxtsencloop4x:
>    415          next_tweak      q4, q4, q15, q10
>    416  .Lxtsenc4x:
>    417          subs            r4, r4, #64
>    418          bmi             .Lxtsenc1x
>    419          vld1.8          {q0-q1}, [r1]!          @ get 4 pt blocks
>    420          vld1.8          {q2-q3}, [r1]!
>    421          next_tweak      q5, q4, q15, q10
>    422          veor            q0, q0, q4
>    423          next_tweak      q6, q5, q15, q10
>    424          veor            q1, q1, q5
>    425          next_tweak      q7, q6, q15, q10
>    426          veor            q2, q2, q6
>    427          veor            q3, q3, q7
>    428          bl              aes_encrypt_4x
>    429          veor            q0, q0, q4
>    430          veor            q1, q1, q5
>    431          veor            q2, q2, q6
>    432          veor            q3, q3, q7
>    433          vst1.8          {q0-q1}, [r0]!          @ write 4 ct blocks
>    434          vst1.8          {q2-q3}, [r0]!
>    435          vmov            q4, q7
>    436          teq             r4, #0
>    437          beq             .Lxtsencret
>    438          b               .Lxtsencloop4x
>    439  .Lxtsenc1x:
>    440          adds            r4, r4, #64
>    441          beq             .Lxtsencout
>    442          subs            r4, r4, #16
>    443          bmi             .LxtsencctsNx
>    444  .Lxtsencloop:
>    445          vld1.8          {q0}, [r1]!
>    446  .Lxtsencctsout:
>    447          veor            q0, q0, q4
>    448          bl              aes_encrypt
>    449          veor            q0, q0, q4
>    450          teq             r4, #0
>    451          beq             .Lxtsencout
>    452          subs            r4, r4, #16
>    453          next_tweak      q4, q4, q15, q6
>    454          bmi             .Lxtsenccts
>    455          vst1.8          {q0}, [r0]!
>    456          b               .Lxtsencloop
>    457  .Lxtsencout:
>    458          vst1.8          {q0}, [r0]
>    459  .Lxtsencret:
>    460          vst1.8          {q4}, [r5]
>    461          pop             {r4-r6, pc}
>    462
>    463  .LxtsencctsNx:
>    464          vmov            q0, q3
>    465          sub             r0, r0, #16
>    466  .Lxtsenccts:
>  > 467          movw            ip, :lower16:.Lcts_permute_table
>  > 468          movt            ip, :upper16:.Lcts_permute_table
>    469
>    470          add             r1, r1, r4              @ rewind input pointer
>    471          add             r4, r4, #16             @ # bytes in final block
>    472          add             lr, ip, #32
>    473          add             ip, ip, r4
>    474          sub             lr, lr, r4
>    475          add             r4, r0, r4              @ output address of final block
>    476
>    477          vld1.8          {q1}, [r1]              @ load final partial block
>    478          vld1.8          {q2}, [ip]
>    479          vld1.8          {q3}, [lr]
>    480
>    481          vtbl.8          d4, {d0-d1}, d4
>    482          vtbl.8          d5, {d0-d1}, d5
>    483          vtbx.8          d0, {d2-d3}, d6
>    484          vtbx.8          d1, {d2-d3}, d7
>    485
>    486          vst1.8          {q2}, [r4]              @ overlapping stores
>    487          mov             r4, #0
>    488          b               .Lxtsencctsout
>    489  ENDPROC(ce_aes_xts_encrypt)
>    490
>    491
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

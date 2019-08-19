Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BCEC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B102082C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jIcYdSUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfHSIna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 04:43:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33780 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfHSIna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 04:43:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so7797480wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 01:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sp6JOe2UVBs6PLytrxxuOCrhswEeaqVUNhszYrb2k9w=;
        b=jIcYdSUCecb2h/hqtX52oMRLGd/EW3h/SFIaR/b2ltMRaY9loJSNOfbnTEifkE42n9
         b1bx4Cso0ouoo1qZCWdlxyNxF2VqvrziE08WNlHivn+zmwLd3OIWc06uNAFzjDiDNtMx
         ry9KJBiUEsy9sarx8TSV8x4IfbnvJx4cO1YWLjLxC0XGIMTpfEJru7PNkK1j7tT/Chow
         szn9e7YZWJ1gQPXBAWRg6yBFwjPktJ8Y3jOmKmHj809M53mWASMs4AeHRMwQI/BB8q/l
         0yFFtH0FrmGTaGxdTAWAb69ZBiIyz1XFbJjtuVT0U6tB5NbVl4RwHZBTsJt86fQyCSFj
         dwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sp6JOe2UVBs6PLytrxxuOCrhswEeaqVUNhszYrb2k9w=;
        b=Sujfhj1KI6sN9235DguU6MCmobVtyK7JpKPt5EyzeKhIPj27Gwzi8X0PyOGbWdxbCR
         pJw3+K26bIZXqZfULHW7j0zlFYyiAEFzgfRMYxYKzyW25LHa/FkgtBZtlLOr0U0dHUCo
         4wLB54hO6JnmlEcbn69iQZ9c0vSlKjlb+bWtuc3a5F8ApJaEihbr+H3AOaH16ILFVVbu
         aQoOKPl9r0PlzQ7jFmiEV9Djr+t+Je/4o23C1pTjhH/FCl5+ekyTBKAUa/uGw41NTAfu
         Oe18QhG3hFM92yDym2NHL54zSm6aBhmhaJgvQmniN0648R9WMpuRgWdAbgxyzXncls17
         cQ0w==
X-Gm-Message-State: APjAAAVag+qkXFpqh+aC3sm9leiD3SRTShgaW333XN7llKfXRu1DfTHv
        8XHwBhFDt9OAisnebWYye0GbtQ==
X-Google-Smtp-Source: APXvYqxDb8PeVkwCL6tuUvNTdOWkLbDqOokiYbzIrTc/Mo09U6geHqQzuP7uJFnNxGErnDlHxUSk0A==
X-Received: by 2002:a5d:4f91:: with SMTP id d17mr25585376wru.74.1566204206351;
        Mon, 19 Aug 2019 01:43:26 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r15sm25195629wrj.68.2019.08.19.01.43.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 01:43:25 -0700 (PDT)
Subject: Re: [PATCH RFC v1] clk: Fix potential NULL dereference in
 clk_fetch_parent_index()
To:     Stephen Boyd <sboyd@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <20190815223155.21384-1-martin.blumenstingl@googlemail.com>
 <20190815232951.AA402206C2@mail.kernel.org>
 <CAFBinCA1i=4Lu1xMVyASoFEDhCEn6phDb4h1s15h0ZfGRQX1kw@mail.gmail.com>
 <20190816173147.ED6022086C@mail.kernel.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <3653ea15-e223-e7f9-1871-f7c8aa84bf5d@baylibre.com>
Date:   Mon, 19 Aug 2019 10:43:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816173147.ED6022086C@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/08/2019 19:31, Stephen Boyd wrote:
> Quoting Martin Blumenstingl (2019-08-15 23:48:08)
>>>> I have seen the original crash when I was testing an MMC driver which
>>>> is not upstream yet on v5.3-rc4. I'm not sure whether this fix is
>>>> "correct" (it fixes the crash for me) or where to point the Fixes tag
>>>> to, it may be one of:
>>>> - fc0c209c147f ("clk: Allow parents to be specified without string names")
>>>> - 1a079560b145 ("clk: Cache core in clk_fetch_parent_index() without names")
>>>>
>>>> This is meant to be applied on top of v5.3-rc4.
>>>>
>>>
>>> Ah ok. I thought that strcmp() would ignore NULL arguments, but
>>> apparently not. I can apply this to clk-fixes.
>> at least ARM [0] and the generic [1] implementations don't
>>
>> I did not bisect this so do you have any suggestion for a Fixes tag? I
>> mentioned two candidates above, but I'm not sure which one to use
>> just let me know, then I'll resend with the fixes tag so you can take
>> it through clk-fixes
>>
>>
> 
> I added the fixes tag for the first one, where it was broken, i.e.
> fc0c209c147f. Thanks.
> 

For the record, this also fixes the Amlogic Meson GXBB/GXL when AO-CEC driver
is enabled :

[    7.790319] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[    7.790324] Mem abort info:
[    7.790326]   ESR = 0x96000007
[    7.790330]   Exception class = DABT (current EL), IL = 32 bits
[    7.790331]   SET = 0, FnV = 0
[    7.790333]   EA = 0, S1PTW = 0
[    7.790334] Data abort info:
[    7.790336]   ISV = 0, ISS = 0x00000007
[    7.790337]   CM = 0, WnR = 0
[    7.790341] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000364b7000
[    7.790343] [0000000000000000] pgd=00000000364f5003, pud=00000000364f6003, pmd=00000000364f7003, pte=0000000000000000
[    7.790350] Internal error: Oops: 96000007 [#1] SMP
[    7.790461] Modules linked in: ao_cec(+)
[    7.793569] CPU: 1 PID: 398 Comm: systemd-udevd Not tainted 5.3.0-rc5 #1
[    7.800199] Hardware name: Libre Computer Board AML-S905X-CC (DT)
[    7.806233] pstate: 40000005 (nZcv daif -PAN -UAO)
[    7.810985] pc : __pi_strcmp+0x1c/0x154
[    7.814775] lr : clk_fetch_parent_index.part.43+0xe4/0x120
[    7.820203] sp : ffff0000113d3770
[    7.823481] x29: ffff0000113d3770 x28: ffff00001136f000
[    7.828741] x27: 0000000000000100 x26: ffff000010130648
[    7.834012] x25: ffff000008943100 x24: 0000000000008000
[    7.839273] x23: ffff80007c15cc00 x22: ffff80007c15cd00
[    7.844525] x21: ffff80007c15ca00 x20: 0000000000000000
[    7.849791] x19: 0000000000000000 x18: 0000000000000001
[    7.855048] x17: 0000000000000000 x16: 0000000000000000
[    7.860316] x15: ffffffffffffffff x14: ffffffffffffffff
[    7.865578] x13: 0000000000000028 x12: 0101010101010101
[    7.870831] x11: 0000000000000004 x10: 0101010101010101
[    7.876092] x9 : ffffffffffffffff x8 : 7f7f7f7f7f7f7f7f
[    7.881354] x7 : 0000000000000000 x6 : 0d0d0206ebadf2e1
[    7.886615] x5 : 61722d6b06020d0d x4 : 8080808000000000
[    7.891876] x3 : 36c6f636b2d72610 x2 : 00006b32335f6f61
[    7.897137] x1 : 0000000000000000 x0 : ffff000010b147f0
[    7.902405] Call trace:
[    7.904825]  __pi_strcmp+0x1c/0x154
[    7.908269]  clk_calc_new_rates+0x208/0x260
[    7.912419]  clk_calc_new_rates+0x10c/0x260
[    7.916556]  clk_core_set_rate_nolock+0xe8/0x1e8
[    7.921129]  clk_set_rate+0x34/0xa0
[    7.924583]  meson_ao_cec_probe+0x19c/0x278 [ao_cec]
[    7.929498]  platform_drv_probe+0x50/0xa0
[    7.933461]  really_probe+0xec/0x3d0
[    7.936989]  driver_probe_device+0xdc/0x130
[    7.941128]  device_driver_attach+0x6c/0x78
[    7.945267]  __driver_attach+0x9c/0x168
[    7.949065]  bus_for_each_dev+0x70/0xc0
[    7.952860]  driver_attach+0x20/0x28
[    7.956394]  bus_add_driver+0x190/0x220
[    7.960190]  driver_register+0x60/0x110
[    7.963987]  __platform_driver_register+0x44/0x50
[    7.968646]  meson_ao_cec_driver_init+0x1c/0x1000 [ao_cec]
[    7.974079]  do_one_initcall+0x74/0x1b0
[    7.977873]  do_init_module+0x50/0x208
[    7.981581]  load_module+0x1dc4/0x2350
[    7.985288]  __se_sys_finit_module+0x9c/0xf8
[    7.989515]  __arm64_sys_finit_module+0x18/0x20
[    7.994001]  el0_svc_common.constprop.0+0x7c/0xe8
[    7.998658]  el0_svc_compat_handler+0x18/0x20
[    8.002970]  el0_svc_compat+0x8/0x10
[    8.006510] Code: 540002e1 f2400807 54000141 f8408402 (f8408423)
[    8.012543] ---[ end trace e915b8961764bcd0 ]---

Neil

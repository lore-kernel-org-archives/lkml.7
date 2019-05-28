Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A78C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA001204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="fbKiq+kY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfE1IWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:22:22 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:38518 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbfE1IWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:22:22 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 149C12E0AB2;
        Tue, 28 May 2019 11:22:20 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Km6O208DaU-MJ5Wh8eb;
        Tue, 28 May 2019 11:22:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1559031739; bh=9RhVP/yJe3HlT+a+XfRXoVOIwyNtKBtQCZV4M07FhM8=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=fbKiq+kYMUGNNRUT3UFeQRJDQHrSYk1LoUjUpPMi8wLRNtjQQ98td6rM6BAVH/Yy7
         3r6Jx1Ef0B/vUoNUeuYneIU/XMqs1kU5SSlP54xEjz38oC5K9IKLikyMtu2i3U2tsw
         1qnDONEbG+5Kcobp4ZN+l2ylGT7LFvE4FgoHwrOk=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:d877:17c:81de:6e43])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id oqjkXthzh0-MJ8qwOQG;
        Tue, 28 May 2019 11:22:19 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] scripts/decode_stacktrace.sh: prefix addr2line with
 $CROSS_COMPILE
To:     manut@mecka.net, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, marc.zyngier@arm.com,
        Manuel Traut <manut@linutronix.de>
References: <20190527083425.3763-1-manut@linutronix.de>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <4d04ac27-0217-0790-b0cc-3115fbf8f0f9@yandex-team.ru>
Date:   Tue, 28 May 2019 11:22:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190527083425.3763-1-manut@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.05.2019 11:34, Manuel Traut wrote:
> At least for ARM64 kernels compiled with the crosstoolchain from
> Debian/stretch or with the toolchain from kernel.org the line number is not
> decoded correctly by 'decode_stacktrace.sh':
> 
> $ echo "[  136.513051]  f1+0x0/0xc [kcrash]" | \
>    CROSS_COMPILE=/opt/gcc-8.1.0-nolibc/aarch64-linux/bin/aarch64-linux- \
>   ./scripts/decode_stacktrace.sh /scratch/linux-arm64/vmlinux \
>                                  /scratch/linux-arm64 \
>                                  /nfs/debian/lib/modules/4.20.0-devel
> [  136.513051] f1 (/linux/drivers/staging/kcrash/kcrash.c:68) kcrash
> 
> If addr2line from the toolchain is used the decoded line number is correct:
> 
> [  136.513051] f1 (/linux/drivers/staging/kcrash/kcrash.c:57) kcrash
> 
> Signed-off-by: Manuel Traut <manut@linutronix.de>

Acked-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>


> ---
>   scripts/decode_stacktrace.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
> index bcdd45df3f51..a7a36209a193 100755
> --- a/scripts/decode_stacktrace.sh
> +++ b/scripts/decode_stacktrace.sh
> @@ -73,7 +73,7 @@ parse_symbol() {
>   	if [[ "${cache[$module,$address]+isset}" == "isset" ]]; then
>   		local code=${cache[$module,$address]}
>   	else
> -		local code=$(addr2line -i -e "$objfile" "$address")
> +		local code=$(${CROSS_COMPILE}addr2line -i -e "$objfile" "$address")
>   		cache[$module,$address]=$code
>   	fi
>   
> 

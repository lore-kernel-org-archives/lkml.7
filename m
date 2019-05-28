Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA5AC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFF92075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="PdToWVzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfE1Iih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:38:37 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:49184 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726557AbfE1Iih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:38:37 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 00CC72E0A36;
        Tue, 28 May 2019 11:38:34 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id D1asc5P1Sz-cXTeHLVm;
        Tue, 28 May 2019 11:38:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1559032713; bh=vT8yC5oxy0dyARN2/rBSq2q0V/PEk3GcSrPeB+/0Pds=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=PdToWVzbMjtKSeBYjNnJOmgU5dAQa3z0W9VvPIZi09qTBU3dDIRoSZ7x82ga/O/q7
         xniE3MHkBqNDUHXhUvK+0LwJPfQ3R1uR0+PvRnC/oe8mPwERdNOsRPa0mA+UmRRfRc
         opwfXEQA+P3CN+JfJbjnvKBduthUesoJf2a3q1k8=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:d877:17c:81de:6e43])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id qINJcNL24f-cX8qRs3u;
        Tue, 28 May 2019 11:38:33 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] scripts/decode_stacktrace: Look for modules with
 .ko.debug extension
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org
References: <20190521234148.64060-1-drinkcat@chromium.org>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <11be5350-23db-6216-3c2b-1d8b161cac9b@yandex-team.ru>
Date:   Tue, 28 May 2019 11:38:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521234148.64060-1-drinkcat@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.2019 2:41, Nicolas Boichat wrote:
> In Chromium OS kernel builds, we split the debug information as
> .ko.debug files, and that's what decode_stacktrace.sh needs to use.
> 
> Relax objfile matching rule to allow any .ko* file to be matched.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
>   scripts/decode_stacktrace.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
> index bcdd45df3f5127a..c851c1eb16f9cf7 100755
> --- a/scripts/decode_stacktrace.sh
> +++ b/scripts/decode_stacktrace.sh
> @@ -28,7 +28,7 @@ parse_symbol() {
>   		local objfile=${modcache[$module]}
>   	else
>   		[[ $modpath == "" ]] && return
> -		local objfile=$(find "$modpath" -name $module.ko -print -quit)
> +		local objfile=$(find "$modpath" -name $module.ko* -print -quit)

Ok but should be quoted "$module.ko*" or escaped $module.ko\*

>   		[[ $objfile == "" ]] && return
>   		modcache[$module]=$objfile
>   	fi
> 

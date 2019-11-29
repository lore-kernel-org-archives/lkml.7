Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47869C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1615B24649
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TK/owDV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387451AbfK2Vkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:40:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38816 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387402AbfK2Vkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 16:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h96uA0n8w9fFxw+Ssv4jrOuxU+h8Z8yCjDe5C+8lqL4=; b=TK/owDV6bWEDOl/DwCqd0APJL
        SVltdiBh22tQcM2vQ2qPf9uWK2fzFJVsFn1Cz7xmg8fdyDUTKV/RyzvNTO1CbAyk8eIlWOn/fA1Rr
        WUDSYljDEAsp9MaRgGYXbEwcGVxQkwRvuFEdAosRX7v5EBjf+X0M725eRBVFjtM8JhVYXZGlzrQvG
        bL13yudRW3u9GpQu9c6DU8OYwSz+cVTEjms7C74CifLKQQB9HWgwXqzrQzRYk3D/kOxz2ImMeziWE
        y5De9C6+6t74vyAAbiAZ0TW9QR68HuUMuK3evWvO5/WTEcUupub5WSHRrQnYayAJGYPgKrnaA00sQ
        fhiS7eOcw==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iao0F-0001hE-FH; Fri, 29 Nov 2019 21:40:39 +0000
Subject: Re: [PATCH v2] moduleparam: fix kerneldoc
To:     Fabien Dessenne <fabien.dessenne@st.com>,
        Jessica Yu <jeyu@kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        linux-kernel@vger.kernel.org
References: <1575041952-17157-1-git-send-email-fabien.dessenne@st.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4b6a1030-d84d-b2d6-13ac-e7fa102d039d@infradead.org>
Date:   Fri, 29 Nov 2019 13:40:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1575041952-17157-1-git-send-email-fabien.dessenne@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/19 7:39 AM, Fabien Dessenne wrote:
> Document missing @args in xxx_param_cb().
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
> Changes since v1: do not replace 'lvalue' with 'value'
> ---
>  include/linux/moduleparam.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index e5c3e23..5215198 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -160,6 +160,7 @@ struct kparam_array
>   * module_param_cb - general callback for a module/cmdline parameter
>   * @name: a valid C identifier which is the parameter name.
>   * @ops: the set & get operations for this parameter.
> + * @args: args for @ops

should be @arg:

>   * @perm: visibility in sysfs.
>   *
>   * The ops can have NULL set or get functions.
> @@ -176,6 +177,7 @@ struct kparam_array
>   *                    to be evaluated before certain initcall level
>   * @name: a valid C identifier which is the parameter name.
>   * @ops: the set & get operations for this parameter.
> + * @args: args for @ops

should be @arg:

>   * @perm: visibility in sysfs.
>   *
>   * The ops can have NULL set or get functions.
> 

and @level needs to be documented here also.

I tested this patch with
$ ./scripts/kernel-doc -none -function module_param_cb include/linux/moduleparam.h

scripts/kernel-doc does not like this line:
 * <level>_param_cb - general callback for a module/cmdline parameter

It needs to match the macro name __level_param_cb.

-- 
~Randy


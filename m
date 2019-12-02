Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AADFC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D7920705
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c1SzwiXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfLBWEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 17:04:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfLBWEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 17:04:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8U/y948ajeR0AAH2Y7sV05Cx3nggVLjhqcVpsB/IVms=; b=c1SzwiXZuKDGLObdcMeHiO8JR
        Shhj6q3RW+KIZR7I419yXwWIOMcapSHVk5n17eS2pc3agGBaiTx+0b8xl/V9sBvnPhLJwv2y1F4kg
        nFsaXAhsdPoMpyX0FVCU/OxXwoo+8voEO3/agU0tXSkBTWYn1mB7YIC0ScgTbJpwrrr32xFyRLpj9
        Q+w/W5yuky2vrl+WCjrLXqf3WMusxybVrhLKKwRZ1bzqTBdHfRRYBQIg8hQ3ykwidM1zpQX+NTxFL
        Wv1mP62Mavo/eovy/7qM9QO8ARgaOdLz7e7eRgQNU+GENRWfGeuI6rBJMn+6E9ecSrpDSfbmbM1bg
        larLwaRoQ==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ibtns-0006cw-DU; Mon, 02 Dec 2019 22:04:24 +0000
Subject: Re: [PATCH v3] moduleparam: fix kerneldoc
To:     Fabien Dessenne <fabien.dessenne@st.com>,
        Jessica Yu <jeyu@kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        linux-kernel@vger.kernel.org
References: <1575277277-4435-1-git-send-email-fabien.dessenne@st.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d893c415-890c-4359-847d-a39391bfc618@infradead.org>
Date:   Mon, 2 Dec 2019 14:04:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1575277277-4435-1-git-send-email-fabien.dessenne@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/19 1:01 AM, Fabien Dessenne wrote:
> Document missing @arg in xxx_param_cb().
> Describe all parameters of module_param_[named_]unsafe() and all
> *_param_cb() to make ./scripts/kernel-doc happy.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Changes since v2: @arg not @args + fix other kernel-doc warnings
> Changes since v1: do not replace 'lvalue' with 'value'
> ---
>  include/linux/moduleparam.h | 82 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 77 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index e5c3e23..3ef917f 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -128,6 +128,9 @@ struct kparam_array
>  
>  /**
>   * module_param_unsafe - same as module_param but taints kernel
> + * @name: the variable to alter, and exposed parameter name.
> + * @type: the type of the parameter
> + * @perm: visibility in sysfs.
>   */
>  #define module_param_unsafe(name, type, perm)			\
>  	module_param_named_unsafe(name, name, type, perm)
> @@ -150,6 +153,10 @@ struct kparam_array
>  
>  /**
>   * module_param_named_unsafe - same as module_param_named but taints kernel
> + * @name: a valid C identifier which is the parameter name.
> + * @value: the actual lvalue to alter.
> + * @type: the type of the parameter
> + * @perm: visibility in sysfs.
>   */
>  #define module_param_named_unsafe(name, value, type, perm)		\
>  	param_check_##type(name, &(value));				\
> @@ -160,6 +167,7 @@ struct kparam_array
>   * module_param_cb - general callback for a module/cmdline parameter
>   * @name: a valid C identifier which is the parameter name.
>   * @ops: the set & get operations for this parameter.
> + * @arg: args for @ops
>   * @perm: visibility in sysfs.
>   *
>   * The ops can have NULL set or get functions.
> @@ -171,36 +179,96 @@ struct kparam_array
>  	__module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1,    \
>  			    KERNEL_PARAM_FL_UNSAFE)
>  
> +#define __level_param_cb(name, ops, arg, perm, level)			\
> +	__module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, level, 0)
>  /**
> - * <level>_param_cb - general callback for a module/cmdline parameter
> - *                    to be evaluated before certain initcall level
> + * core_param_cb - general callback for a module/cmdline parameter
> + *                 to be evaluated before core initcall level
>   * @name: a valid C identifier which is the parameter name.
>   * @ops: the set & get operations for this parameter.
> + * @arg: args for @ops
>   * @perm: visibility in sysfs.
>   *
>   * The ops can have NULL set or get functions.
>   */
> -#define __level_param_cb(name, ops, arg, perm, level)			\
> -	__module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, level, 0)
> -
>  #define core_param_cb(name, ops, arg, perm)		\
>  	__level_param_cb(name, ops, arg, perm, 1)
>  
> +/**
> + * postcore_param_cb - general callback for a module/cmdline parameter
> + *                     to be evaluated before postcore initcall level
> + * @name: a valid C identifier which is the parameter name.
> + * @ops: the set & get operations for this parameter.
> + * @arg: args for @ops
> + * @perm: visibility in sysfs.
> + *
> + * The ops can have NULL set or get functions.
> + */
>  #define postcore_param_cb(name, ops, arg, perm)		\
>  	__level_param_cb(name, ops, arg, perm, 2)
>  
> +/**
> + * arch_param_cb - general callback for a module/cmdline parameter
> + *                 to be evaluated before arch initcall level
> + * @name: a valid C identifier which is the parameter name.
> + * @ops: the set & get operations for this parameter.
> + * @arg: args for @ops
> + * @perm: visibility in sysfs.
> + *
> + * The ops can have NULL set or get functions.
> + */
>  #define arch_param_cb(name, ops, arg, perm)		\
>  	__level_param_cb(name, ops, arg, perm, 3)
>  
> +/**
> + * subsys_param_cb - general callback for a module/cmdline parameter
> + *                   to be evaluated before subsys initcall level
> + * @name: a valid C identifier which is the parameter name.
> + * @ops: the set & get operations for this parameter.
> + * @arg: args for @ops
> + * @perm: visibility in sysfs.
> + *
> + * The ops can have NULL set or get functions.
> + */
>  #define subsys_param_cb(name, ops, arg, perm)		\
>  	__level_param_cb(name, ops, arg, perm, 4)
>  
> +/**
> + * fs_param_cb - general callback for a module/cmdline parameter
> + *               to be evaluated before fs initcall level
> + * @name: a valid C identifier which is the parameter name.
> + * @ops: the set & get operations for this parameter.
> + * @arg: args for @ops
> + * @perm: visibility in sysfs.
> + *
> + * The ops can have NULL set or get functions.
> + */
>  #define fs_param_cb(name, ops, arg, perm)		\
>  	__level_param_cb(name, ops, arg, perm, 5)
>  
> +/**
> + * device_param_cb - general callback for a module/cmdline parameter
> + *                   to be evaluated before device initcall level
> + * @name: a valid C identifier which is the parameter name.
> + * @ops: the set & get operations for this parameter.
> + * @arg: args for @ops
> + * @perm: visibility in sysfs.
> + *
> + * The ops can have NULL set or get functions.
> + */
>  #define device_param_cb(name, ops, arg, perm)		\
>  	__level_param_cb(name, ops, arg, perm, 6)
>  
> +/**
> + * late_param_cb - general callback for a module/cmdline parameter
> + *                 to be evaluated before late initcall level
> + * @name: a valid C identifier which is the parameter name.
> + * @ops: the set & get operations for this parameter.
> + * @arg: args for @ops
> + * @perm: visibility in sysfs.
> + *
> + * The ops can have NULL set or get functions.
> + */
>  #define late_param_cb(name, ops, arg, perm)		\
>  	__level_param_cb(name, ops, arg, perm, 7)
>  
> @@ -263,6 +331,10 @@ static inline void kernel_param_unlock(struct module *mod)
>  
>  /**
>   * core_param_unsafe - same as core_param but taints kernel
> + * @name: the name of the cmdline and sysfs parameter (often the same as var)
> + * @var: the variable
> + * @type: the type of the parameter
> + * @perm: visibility in sysfs
>   */
>  #define core_param_unsafe(name, var, type, perm)		\
>  	param_check_##type(name, &(var));				\
> 


-- 
~Randy


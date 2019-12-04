Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90BFC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A21720833
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575487919;
	bh=ctu9RwlHjv4upjNSW0WkBkI6dkqaoeEKbM7GREKBB/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zRKB3tAP6Xj8FqrL0/JoYHRnW0VKrOQTTK2+9kOTfq5octcwekSDptL9P7X0fJpLD
	 WlvgyGBA/YFyxNxLsTy7UXHT1q7IgGGBCp/Xe3xqoH9SafYIq7HPK/R1a5fnp2cwFK
	 aYlXUpYVM5hqvJ9MTXScaPWw3BFt9nrGquKuoAzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfLDTb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:31:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbfLDTb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:31:57 -0500
Received: from linux-8ccs (x2f7fec9.dyn.telefonica.de [2.247.254.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EFC820409;
        Wed,  4 Dec 2019 19:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575487916;
        bh=ctu9RwlHjv4upjNSW0WkBkI6dkqaoeEKbM7GREKBB/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p7oWeY3dWzFF3f9LBOiJLOFd88G0sqZWw1uGsQCqWsl70Wryb8Te7/IVmWEMwtdVc
         WNKzIgbWUTzoLCxS5DzpH7OE4+CYBy+qDle+kCCuA9bKjBiofRyUUxkoomsxK+g0SU
         9j1AwqWUydZd7I+W+lkzDVm+FUWB2MGyDbgScuBA=
Date:   Wed, 4 Dec 2019 20:31:51 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] moduleparam: fix kerneldoc
Message-ID: <20191204193150.GA22824@linux-8ccs>
References: <1575277277-4435-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1575277277-4435-1-git-send-email-fabien.dessenne@st.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Fabien Dessenne [02/12/19 10:01 +0100]:
>Document missing @arg in xxx_param_cb().
>Describe all parameters of module_param_[named_]unsafe() and all
>*_param_cb() to make ./scripts/kernel-doc happy.
>
>Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>

Looks good, I'll apply this to modules-next after the merge window ends.

Thanks!

Jessica

>---
>Changes since v2: @arg not @args + fix other kernel-doc warnings
>Changes since v1: do not replace 'lvalue' with 'value'
>---
> include/linux/moduleparam.h | 82 ++++++++++++++++++++++++++++++++++++++++++---
> 1 file changed, 77 insertions(+), 5 deletions(-)
>
>diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
>index e5c3e23..3ef917f 100644
>--- a/include/linux/moduleparam.h
>+++ b/include/linux/moduleparam.h
>@@ -128,6 +128,9 @@ struct kparam_array
>
> /**
>  * module_param_unsafe - same as module_param but taints kernel
>+ * @name: the variable to alter, and exposed parameter name.
>+ * @type: the type of the parameter
>+ * @perm: visibility in sysfs.
>  */
> #define module_param_unsafe(name, type, perm)			\
> 	module_param_named_unsafe(name, name, type, perm)
>@@ -150,6 +153,10 @@ struct kparam_array
>
> /**
>  * module_param_named_unsafe - same as module_param_named but taints kernel
>+ * @name: a valid C identifier which is the parameter name.
>+ * @value: the actual lvalue to alter.
>+ * @type: the type of the parameter
>+ * @perm: visibility in sysfs.
>  */
> #define module_param_named_unsafe(name, value, type, perm)		\
> 	param_check_##type(name, &(value));				\
>@@ -160,6 +167,7 @@ struct kparam_array
>  * module_param_cb - general callback for a module/cmdline parameter
>  * @name: a valid C identifier which is the parameter name.
>  * @ops: the set & get operations for this parameter.
>+ * @arg: args for @ops
>  * @perm: visibility in sysfs.
>  *
>  * The ops can have NULL set or get functions.
>@@ -171,36 +179,96 @@ struct kparam_array
> 	__module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1,    \
> 			    KERNEL_PARAM_FL_UNSAFE)
>
>+#define __level_param_cb(name, ops, arg, perm, level)			\
>+	__module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, level, 0)
> /**
>- * <level>_param_cb - general callback for a module/cmdline parameter
>- *                    to be evaluated before certain initcall level
>+ * core_param_cb - general callback for a module/cmdline parameter
>+ *                 to be evaluated before core initcall level
>  * @name: a valid C identifier which is the parameter name.
>  * @ops: the set & get operations for this parameter.
>+ * @arg: args for @ops
>  * @perm: visibility in sysfs.
>  *
>  * The ops can have NULL set or get functions.
>  */
>-#define __level_param_cb(name, ops, arg, perm, level)			\
>-	__module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, level, 0)
>-
> #define core_param_cb(name, ops, arg, perm)		\
> 	__level_param_cb(name, ops, arg, perm, 1)
>
>+/**
>+ * postcore_param_cb - general callback for a module/cmdline parameter
>+ *                     to be evaluated before postcore initcall level
>+ * @name: a valid C identifier which is the parameter name.
>+ * @ops: the set & get operations for this parameter.
>+ * @arg: args for @ops
>+ * @perm: visibility in sysfs.
>+ *
>+ * The ops can have NULL set or get functions.
>+ */
> #define postcore_param_cb(name, ops, arg, perm)		\
> 	__level_param_cb(name, ops, arg, perm, 2)
>
>+/**
>+ * arch_param_cb - general callback for a module/cmdline parameter
>+ *                 to be evaluated before arch initcall level
>+ * @name: a valid C identifier which is the parameter name.
>+ * @ops: the set & get operations for this parameter.
>+ * @arg: args for @ops
>+ * @perm: visibility in sysfs.
>+ *
>+ * The ops can have NULL set or get functions.
>+ */
> #define arch_param_cb(name, ops, arg, perm)		\
> 	__level_param_cb(name, ops, arg, perm, 3)
>
>+/**
>+ * subsys_param_cb - general callback for a module/cmdline parameter
>+ *                   to be evaluated before subsys initcall level
>+ * @name: a valid C identifier which is the parameter name.
>+ * @ops: the set & get operations for this parameter.
>+ * @arg: args for @ops
>+ * @perm: visibility in sysfs.
>+ *
>+ * The ops can have NULL set or get functions.
>+ */
> #define subsys_param_cb(name, ops, arg, perm)		\
> 	__level_param_cb(name, ops, arg, perm, 4)
>
>+/**
>+ * fs_param_cb - general callback for a module/cmdline parameter
>+ *               to be evaluated before fs initcall level
>+ * @name: a valid C identifier which is the parameter name.
>+ * @ops: the set & get operations for this parameter.
>+ * @arg: args for @ops
>+ * @perm: visibility in sysfs.
>+ *
>+ * The ops can have NULL set or get functions.
>+ */
> #define fs_param_cb(name, ops, arg, perm)		\
> 	__level_param_cb(name, ops, arg, perm, 5)
>
>+/**
>+ * device_param_cb - general callback for a module/cmdline parameter
>+ *                   to be evaluated before device initcall level
>+ * @name: a valid C identifier which is the parameter name.
>+ * @ops: the set & get operations for this parameter.
>+ * @arg: args for @ops
>+ * @perm: visibility in sysfs.
>+ *
>+ * The ops can have NULL set or get functions.
>+ */
> #define device_param_cb(name, ops, arg, perm)		\
> 	__level_param_cb(name, ops, arg, perm, 6)
>
>+/**
>+ * late_param_cb - general callback for a module/cmdline parameter
>+ *                 to be evaluated before late initcall level
>+ * @name: a valid C identifier which is the parameter name.
>+ * @ops: the set & get operations for this parameter.
>+ * @arg: args for @ops
>+ * @perm: visibility in sysfs.
>+ *
>+ * The ops can have NULL set or get functions.
>+ */
> #define late_param_cb(name, ops, arg, perm)		\
> 	__level_param_cb(name, ops, arg, perm, 7)
>
>@@ -263,6 +331,10 @@ static inline void kernel_param_unlock(struct module *mod)
>
> /**
>  * core_param_unsafe - same as core_param but taints kernel
>+ * @name: the name of the cmdline and sysfs parameter (often the same as var)
>+ * @var: the variable
>+ * @type: the type of the parameter
>+ * @perm: visibility in sysfs
>  */
> #define core_param_unsafe(name, var, type, perm)		\
> 	param_check_##type(name, &(var));				\
>-- 
>2.7.4
>

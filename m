Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28194C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C035021D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vxcjpn4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389018AbfIYUGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:06:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42294 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbfIYUGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:06:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id z12so547502pgp.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7E6PtzpGtvxqr4och9mjwILwMa3ZbB0yuzrzq64KjBs=;
        b=Vxcjpn4CeGvMOOec8JYlXm87EsZ/+7uC/MvpvVHb7JYhg2Ffuf3XGxE+zBoehsoqYd
         H7Z2B+JEGz5IqKgEeiP5VEQWXMcebNkZ8ZCjRoYOZREGWTsufE0EGE1T9x75M1h8gGzr
         QeXvX24tu2QX0x2A/8jDEKulC//Wy8m1coR/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7E6PtzpGtvxqr4och9mjwILwMa3ZbB0yuzrzq64KjBs=;
        b=AuHsC4iojvNZXX2WufmR6EVPSWubqnY2yTe+roqXS6R/AKvv2hnfyumPj0p0++A6sA
         4o2PEnSAQ+rjl+U9qOg6+eQGXLjK1pCCQihBpCeqQN+hNBMbHAk9pOIChxi6/9UiE3f2
         Mc7jVFPwkder2wt7FPTx8KJPiAbXMW07G4CZh0he5wmz6MYK5HY1ngQIG5T2sOhPHqcJ
         9ssiEcsCe+OuymRu+H5O4jwDZWeC9ayTwuQIoUqtTd5fxNiSw2/Gpd8FRgSZwk64ucu2
         SFMYXVrrdQ1AB2zww7dEgMvIOKCHpKD2MAFcRDqnBsvAikb5lurtTYxDTJiZgGOHvtzG
         JBcw==
X-Gm-Message-State: APjAAAWlZVJHdjvAoEZgWiQ0NNGXUU6OwOeX8W5EMHX7Av/fpYNb0SmF
        Mp6BXy8sGJMBGJHXpGhmKYO2YdtRhko=
X-Google-Smtp-Source: APXvYqycrfHaEeGpaXs9vVtnZ8AEvVOZxGmlbkO/K3rJNruuuXDcyKKyqm1cwRZp1S2Db/Wb533+Xg==
X-Received: by 2002:a63:2104:: with SMTP id h4mr1077277pgh.295.1569441991117;
        Wed, 25 Sep 2019 13:06:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j24sm6388268pff.71.2019.09.25.13.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 13:06:29 -0700 (PDT)
Date:   Wed, 25 Sep 2019 13:06:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     bhenryj0117@gmail.com
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 2/2] docs: security: update base LSM documentation file
Message-ID: <201909251300.E9B819EB37@keescook>
References: <20190925101745.3645-1-bhenryj0117@gmail.com>
 <20190925101745.3645-2-bhenryj0117@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190925101745.3645-2-bhenryj0117@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 05:17:45PM +0700, bhenryj0117@gmail.com wrote:
> From: Brendan Jackman <bhenryj0117@gmail.com>
> 
> I was bringing myself up to speed on LSMs and discovered that this
> base doc file is out of date. Unless I'm mistaken the "stacking"
> functionality is still in significant flux (and also I am of course a
> newbie here) so I haven't really _added_ any info, mainly this patch
> removes misleading bits and fixes rotten references.
> 
>  - Since commit b1d9e6b0646d ("LSM: Switch to lists of hooks") as
>    part of the work helpfully summarised in [1], the LSM hooks are
>    stored in a table of hlists, the security_ops structure is
>    gone. The stacking of security modules no longer seems to be
>    deferred to the module.
> 
>  - security_hooks_heads, née security_ops, doesn't have the
>    sub-structures described here. The "future" flattening described
>    here appears to have happened a long time ago (In my hasty git
>    archaeology session I didn't find the old code at all).
> 
>  - There used to be a dummy LSM implementing "traditional superuser
>    logic", with the "capability" LSM as an optional layer, but since
>    commit 5915eb53861c ("security: remove dummy module") that is no
>    longer the case.

Oh very nice; yes, thank you. This is all very out of date. Notes
below...

> 
> [1] https://lwn.net/Articles/635771/
> 
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Brendan Jackman <bhenryj0117@gmail.com>
> ---
>  Documentation/security/lsm.rst | 94 +++++++++++-----------------------
>  1 file changed, 31 insertions(+), 63 deletions(-)
> 
> diff --git a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
> index aadf47c808c0..5048143d3656 100644
> --- a/Documentation/security/lsm.rst
> +++ b/Documentation/security/lsm.rst
> @@ -53,10 +53,8 @@ on supporting access control modules, although future development is
>  likely to address other security needs such as auditing. By itself, the
>  framework does not provide any additional security; it merely provides
>  the infrastructure to support security modules. The LSM kernel patch
> -also moves most of the capabilities logic into an optional security
> -module, with the system defaulting to the traditional superuser logic.
> -This capabilities module is discussed further in
> -`LSM Capabilities Module`_.
> +also moves most of the capabilities logic into a security
> +module, discussed further in `LSM Capabilities Module`_.
>  
>  The LSM kernel patch adds security fields to kernel data structures and
>  inserts calls to hook functions at critical points in the kernel code to
> @@ -84,19 +82,13 @@ were moved to header files (``include/linux/msg.h`` and
>  ``include/linux/shm.h`` as appropriate) to allow the security modules to
>  use these definitions.
>  
> -Each LSM hook is a function pointer in a global table, security_ops.
> -This table is a :c:type:`struct security_operations
> -<security_operations>` structure as defined by
> -``include/linux/security.h``. Detailed documentation for each hook is
> -included in this header file. At present, this structure consists of a
> -collection of substructures that group related hooks based on the kernel
> -object (e.g. task, inode, file, sk_buff, etc) as well as some top-level
> -hook function pointers for system operations. This structure is likely
> -to be flattened in the future for performance. The placement of the hook
> -calls in the kernel code is described by the "called:" lines in the
> -per-hook documentation in the header file. The hook calls can also be
> -easily found in the kernel code by looking for the string
> -"security_ops->".
> +Each LSM hook is a function pointer within a ``hlist`` in a global
> +table, ``security_hook_heads``.  This table is a :c:type:`struct
> +security_hook_heads <security_hook_heads>` structure as defined by
> +``include/linux/lsm_hooks.h``. Detailed documentation for each hook
> +is included in this header file. The placement of the hook calls in
> +the kernel code is described by the "called:" lines in the per-hook
> +documentation in the header file.
>  
>  Linus mentioned per-process security hooks in his original remarks as a
>  possible alternative to global security hooks. However, if LSM were to
> @@ -107,64 +99,40 @@ controlling the operation. This would require a general mechanism for
>  composing hooks in the base framework. Additionally, LSM would still
>  need global hooks for operations that have no process context (e.g.
>  network input operations). Consequently, LSM provides global security
> -hooks, but a security module is free to implement per-process hooks
> -(where that makes sense) by storing a security_ops table in each
> -process' security field and then invoking these per-process hooks from
> -the global hooks. The problem of composition is thus deferred to the
> -module.
> -
> -The global security_ops table is initialized to a set of hook functions
> -provided by a dummy security module that provides traditional superuser
> -logic. A :c:func:`register_security()` function (in
> -``security/security.c``) is provided to allow a security module to set
> -security_ops to refer to its own hook functions, and an
> -:c:func:`unregister_security()` function is provided to revert
> -security_ops to the dummy module hooks. This mechanism is used to set
> -the primary security module, which is responsible for making the final
> -decision for each hook.
> -
> -LSM also provides a simple mechanism for stacking additional security
> -modules with the primary security module. It defines
> -:c:func:`register_security()` and
> -:c:func:`unregister_security()` hooks in the :c:type:`struct
> -security_operations <security_operations>` structure and
> -provides :c:func:`mod_reg_security()` and
> -:c:func:`mod_unreg_security()` functions that invoke these hooks
> -after performing some sanity checking. A security module can call these
> -functions in order to stack with other modules. However, the actual
> -details of how this stacking is handled are deferred to the module,
> -which can implement these hooks in any way it wishes (including always
> -returning an error if it does not wish to support stacking). In this
> -manner, LSM again defers the problem of composition to the module.
> -
> -Although the LSM hooks are organized into substructures based on kernel
> -object, all of the hooks can be viewed as falling into two major
> +hooks, but a security module is free to implement per-process logic
> +(where that makes sense) by storing a blob in each
> +process' security field.
> +
> +Some LSMs can be "stacked" meaning multiple LSMs' hooks can be called
> +sequentially, while others are "exclusive" - see
> +LSM_FLAG_EXCLUSIVE. The "capability" LSM is built in with
> +CONFIG_SECURITY and provides POSIX.1e capability functionality; this
> +always appears first in the stack of LSM hooks. A
> +:c:func:`security_add_hooks()` function (in ``security/security.c``)

IIUC, the :c:func:`...()` marking isn't needed any more, just having a
word followed by "()" should trigger the markup.

> +is provided to allow a security module to add its hooks to the table;
> +this is typically called from the LSM's ``.init`` hook which is
> +called during LSM core initialisation.
> +
> +All of the hooks can be viewed as falling into two major
>  categories: hooks that are used to manage the security fields and hooks
>  that are used to perform access control. Examples of the first category
> -of hooks include the :c:func:`alloc_security()` and
> -:c:func:`free_security()` hooks defined for each kernel data
> +of hooks include the ``*_alloc_security()`` and
> +``*_free_security()`` hooks defined for each kernel data

Some of these are going away in favor of the "blobs" member of struct
lsm_info. Casey might have more to say on the plans here.

>  structure that has a security field. These hooks are used to allocate
>  and free security structures for kernel objects. The first category of
>  hooks also includes hooks that set information in the security field
> -after allocation, such as the :c:func:`post_lookup()` hook in
> -:c:type:`struct inode_security_ops <inode_security_ops>`.
> +after allocation, such as the :c:func:`inode_post_setxattr()` hook.
>  This hook is used to set security information for inodes after
> -successful lookup operations. An example of the second category of hooks
> -is the :c:func:`permission()` hook in :c:type:`struct
> -inode_security_ops <inode_security_ops>`. This hook checks
> +successful setxattr operations. An example of the second category of
> +hooks is :c:func:`inode_permission()`. This hook checks
>  permission when accessing an inode.

Casey, what do you think of the wording here? It's certainly better than
before, but maybe it should be further improved?

>  
>  LSM Capabilities Module
>  =======================
>  
>  The LSM kernel patch moves most of the existing POSIX.1e capabilities
> -logic into an optional security module stored in the file
> -``security/capability.c``. This change allows users who do not want to
> -use capabilities to omit this code entirely from their kernel, instead
> -using the dummy module for traditional superuser logic or any other
> -module that they desire. This change also allows the developers of the
> -capabilities logic to maintain and enhance their code more freely,
> -without needing to integrate patches back into the base kernel.
> +logic into a security module stored in the file
> +``security/capability.c``.
>  
>  In addition to moving the capabilities logic, the LSM kernel patch could
>  move the capability-related fields from the kernel data structures into
> -- 
> 2.22.1
> 

All my comments are basically nit-picks. :) This patch is already a nice
improvement over what's already there. Thanks!

-- 
Kees Cook

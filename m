Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048F3C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 10:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B918E21D7A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 10:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbWD2cOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389306AbfIYKSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 06:18:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43929 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfIYKSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 06:18:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id a2so3104995pfo.10;
        Wed, 25 Sep 2019 03:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rj/CjfFPGmjBYDYuOXK7jyZpbDhuxeaWBE4wZ/+UiVM=;
        b=IbWD2cOs+FOTLScZafxp0BySICxEIpNTEomusH+btyMETE1e7vt/Uksz2rlH74Kbvk
         v1JysCGNOMpTEV5ufvgmCs/ngIOxxHLaYeWxRTBj+iiCUwVlzbQGph4+C2oN0CkjDM3A
         zoK24CSeyqYkmt3wLeMyOIRkbbQyjKqDP9kKm6XyLJ+gmbVn5u8ImMxKMaXvodIe3bay
         tz5Y9ZH6i0KZYg2di169aZLMCl+NQ9OBzxg1iuml/K4cX73V6a4gYyxLlYTGNh0j1Xwr
         I6nelJdYyYDOQnHSbtbweMwabDh7d5RWZWZ48uC12GayNvbga5xIQZ4xL9qx6/thRceW
         nMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rj/CjfFPGmjBYDYuOXK7jyZpbDhuxeaWBE4wZ/+UiVM=;
        b=XhEDJuudWmmZ8aGWkRTQOK8n/0gosxUW2kbhdPX5YMeP0Q/W2v7j+adcaisgmT9hYw
         0n8gQXAoXo48qY8TtpJJSMBfbTRtBO9RCkwq+JgDuNAPbRhMNsSehMnXuTOe6JikGere
         9yYlIbVHmGo0/uX1HGvQfXENSXHlAulUr/aMhvUcc3/ZGxXKjqVbdrl09Ft37TSWAxqF
         y/CMVNkc1PzoFul1S8b+kOv5u0WYV+E9FI9tnOnyRAcR1RF7Rsa53ggejhiOOz3IZoxp
         g/TK5ZeCeWUfFEyk9PsY95610S17AvBn4b9Y90Mlb8JjhVqxCT20Fmum5z6HVv5VWkAc
         6W6w==
X-Gm-Message-State: APjAAAUmhhKiqsBke7pccRqxfVc5c9EbfBSvoEJydHoW8lYzlnSBz25t
        yUrblI5+KGMyFZPc9kF7ZGw=
X-Google-Smtp-Source: APXvYqx6c1oDiuBQiY+u3NDVTt8gzK1l6uFP74cY2ze0kA/Hwqk8J/Hrlgwd8q/FxAvg8pp7YtwUXA==
X-Received: by 2002:a63:6988:: with SMTP id e130mr8309463pgc.203.1569406689749;
        Wed, 25 Sep 2019 03:18:09 -0700 (PDT)
Received: from localhost.localdomain ([118.70.72.223])
        by smtp.gmail.com with ESMTPSA id i7sm2493107pjs.1.2019.09.25.03.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 03:18:09 -0700 (PDT)
From:   bhenryj0117@gmail.com
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Brendan Jackman <bhenryj0117@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 2/2] docs: security: update base LSM documentation file
Date:   Wed, 25 Sep 2019 17:17:45 +0700
Message-Id: <20190925101745.3645-2-bhenryj0117@gmail.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190925101745.3645-1-bhenryj0117@gmail.com>
References: <20190925101745.3645-1-bhenryj0117@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brendan Jackman <bhenryj0117@gmail.com>

I was bringing myself up to speed on LSMs and discovered that this
base doc file is out of date. Unless I'm mistaken the "stacking"
functionality is still in significant flux (and also I am of course a
newbie here) so I haven't really _added_ any info, mainly this patch
removes misleading bits and fixes rotten references.

 - Since commit b1d9e6b0646d ("LSM: Switch to lists of hooks") as
   part of the work helpfully summarised in [1], the LSM hooks are
   stored in a table of hlists, the security_ops structure is
   gone. The stacking of security modules no longer seems to be
   deferred to the module.

 - security_hooks_heads, née security_ops, doesn't have the
   sub-structures described here. The "future" flattening described
   here appears to have happened a long time ago (In my hasty git
   archaeology session I didn't find the old code at all).

 - There used to be a dummy LSM implementing "traditional superuser
   logic", with the "capability" LSM as an optional layer, but since
   commit 5915eb53861c ("security: remove dummy module") that is no
   longer the case.

[1] https://lwn.net/Articles/635771/

Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Brendan Jackman <bhenryj0117@gmail.com>
---
 Documentation/security/lsm.rst | 94 +++++++++++-----------------------
 1 file changed, 31 insertions(+), 63 deletions(-)

diff --git a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
index aadf47c808c0..5048143d3656 100644
--- a/Documentation/security/lsm.rst
+++ b/Documentation/security/lsm.rst
@@ -53,10 +53,8 @@ on supporting access control modules, although future development is
 likely to address other security needs such as auditing. By itself, the
 framework does not provide any additional security; it merely provides
 the infrastructure to support security modules. The LSM kernel patch
-also moves most of the capabilities logic into an optional security
-module, with the system defaulting to the traditional superuser logic.
-This capabilities module is discussed further in
-`LSM Capabilities Module`_.
+also moves most of the capabilities logic into a security
+module, discussed further in `LSM Capabilities Module`_.
 
 The LSM kernel patch adds security fields to kernel data structures and
 inserts calls to hook functions at critical points in the kernel code to
@@ -84,19 +82,13 @@ were moved to header files (``include/linux/msg.h`` and
 ``include/linux/shm.h`` as appropriate) to allow the security modules to
 use these definitions.
 
-Each LSM hook is a function pointer in a global table, security_ops.
-This table is a :c:type:`struct security_operations
-<security_operations>` structure as defined by
-``include/linux/security.h``. Detailed documentation for each hook is
-included in this header file. At present, this structure consists of a
-collection of substructures that group related hooks based on the kernel
-object (e.g. task, inode, file, sk_buff, etc) as well as some top-level
-hook function pointers for system operations. This structure is likely
-to be flattened in the future for performance. The placement of the hook
-calls in the kernel code is described by the "called:" lines in the
-per-hook documentation in the header file. The hook calls can also be
-easily found in the kernel code by looking for the string
-"security_ops->".
+Each LSM hook is a function pointer within a ``hlist`` in a global
+table, ``security_hook_heads``.  This table is a :c:type:`struct
+security_hook_heads <security_hook_heads>` structure as defined by
+``include/linux/lsm_hooks.h``. Detailed documentation for each hook
+is included in this header file. The placement of the hook calls in
+the kernel code is described by the "called:" lines in the per-hook
+documentation in the header file.
 
 Linus mentioned per-process security hooks in his original remarks as a
 possible alternative to global security hooks. However, if LSM were to
@@ -107,64 +99,40 @@ controlling the operation. This would require a general mechanism for
 composing hooks in the base framework. Additionally, LSM would still
 need global hooks for operations that have no process context (e.g.
 network input operations). Consequently, LSM provides global security
-hooks, but a security module is free to implement per-process hooks
-(where that makes sense) by storing a security_ops table in each
-process' security field and then invoking these per-process hooks from
-the global hooks. The problem of composition is thus deferred to the
-module.
-
-The global security_ops table is initialized to a set of hook functions
-provided by a dummy security module that provides traditional superuser
-logic. A :c:func:`register_security()` function (in
-``security/security.c``) is provided to allow a security module to set
-security_ops to refer to its own hook functions, and an
-:c:func:`unregister_security()` function is provided to revert
-security_ops to the dummy module hooks. This mechanism is used to set
-the primary security module, which is responsible for making the final
-decision for each hook.
-
-LSM also provides a simple mechanism for stacking additional security
-modules with the primary security module. It defines
-:c:func:`register_security()` and
-:c:func:`unregister_security()` hooks in the :c:type:`struct
-security_operations <security_operations>` structure and
-provides :c:func:`mod_reg_security()` and
-:c:func:`mod_unreg_security()` functions that invoke these hooks
-after performing some sanity checking. A security module can call these
-functions in order to stack with other modules. However, the actual
-details of how this stacking is handled are deferred to the module,
-which can implement these hooks in any way it wishes (including always
-returning an error if it does not wish to support stacking). In this
-manner, LSM again defers the problem of composition to the module.
-
-Although the LSM hooks are organized into substructures based on kernel
-object, all of the hooks can be viewed as falling into two major
+hooks, but a security module is free to implement per-process logic
+(where that makes sense) by storing a blob in each
+process' security field.
+
+Some LSMs can be "stacked" meaning multiple LSMs' hooks can be called
+sequentially, while others are "exclusive" - see
+LSM_FLAG_EXCLUSIVE. The "capability" LSM is built in with
+CONFIG_SECURITY and provides POSIX.1e capability functionality; this
+always appears first in the stack of LSM hooks. A
+:c:func:`security_add_hooks()` function (in ``security/security.c``)
+is provided to allow a security module to add its hooks to the table;
+this is typically called from the LSM's ``.init`` hook which is
+called during LSM core initialisation.
+
+All of the hooks can be viewed as falling into two major
 categories: hooks that are used to manage the security fields and hooks
 that are used to perform access control. Examples of the first category
-of hooks include the :c:func:`alloc_security()` and
-:c:func:`free_security()` hooks defined for each kernel data
+of hooks include the ``*_alloc_security()`` and
+``*_free_security()`` hooks defined for each kernel data
 structure that has a security field. These hooks are used to allocate
 and free security structures for kernel objects. The first category of
 hooks also includes hooks that set information in the security field
-after allocation, such as the :c:func:`post_lookup()` hook in
-:c:type:`struct inode_security_ops <inode_security_ops>`.
+after allocation, such as the :c:func:`inode_post_setxattr()` hook.
 This hook is used to set security information for inodes after
-successful lookup operations. An example of the second category of hooks
-is the :c:func:`permission()` hook in :c:type:`struct
-inode_security_ops <inode_security_ops>`. This hook checks
+successful setxattr operations. An example of the second category of
+hooks is :c:func:`inode_permission()`. This hook checks
 permission when accessing an inode.
 
 LSM Capabilities Module
 =======================
 
 The LSM kernel patch moves most of the existing POSIX.1e capabilities
-logic into an optional security module stored in the file
-``security/capability.c``. This change allows users who do not want to
-use capabilities to omit this code entirely from their kernel, instead
-using the dummy module for traditional superuser logic or any other
-module that they desire. This change also allows the developers of the
-capabilities logic to maintain and enhance their code more freely,
-without needing to integrate patches back into the base kernel.
+logic into a security module stored in the file
+``security/capability.c``.
 
 In addition to moving the capabilities logic, the LSM kernel patch could
 move the capability-related fields from the kernel data structures into
-- 
2.22.1


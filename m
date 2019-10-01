Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4F6ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0422086A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569951492;
	bh=MMmGvGL9mMISD7665FS8n/2elHIASz6KuyJpSch+Vzc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=x/OYman+FNJgv1uPuf59veotZGL8mJFfHlWEROBO4L9fn+C2DQHGTkCL+RVAr4LVA
	 evoAr3TQZQC86fRc+2hNuvE3ytjDtQZuyyBNELa7/YibKu7UoXRHGBtv3/FkWEU6kK
	 pSoGw5NOWivVrgZXQkW5FoG+/BVjnTqh03WVkarA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbfJARiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730447AbfJARiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:38:11 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7CEE2053B;
        Tue,  1 Oct 2019 17:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569951490;
        bh=MMmGvGL9mMISD7665FS8n/2elHIASz6KuyJpSch+Vzc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=PGyzGHOi8DLY9Ntkwu1xLIIjou96erVvR41GoRYE63/OEUdplRKDX/U+LkKD1XiPD
         4RC1VBOtqVJPdE3vzE0V0JTmVjnNOFDFOOfnH/zLIYFmxWmDIhAvlM0PHZnLoSvOgQ
         7wnlKe7hxq0JZ33qeMO21zV/luBcFtqS9qbtj/18=
Date:   Tue, 1 Oct 2019 10:38:03 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Denis Efremov <efremov@linux.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@armlinux.org.uk>,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH] ARM: xen: unexport HYPERVISOR_platform_op function
In-Reply-To: <20190906153948.2160342-1-arnd@arndb.de>
Message-ID: <alpine.DEB.2.21.1910011032500.20899@sstabellini-ThinkPad-T480s>
References: <20190906153948.2160342-1-arnd@arndb.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2019, Arnd Bergmann wrote:
> HYPERVISOR_platform_op() is an inline function and should not
> be exported. Since commit 15bfc2348d54 ("modpost: check for
> static EXPORT_SYMBOL* functions"), this causes a warning:
> 
> WARNING: "HYPERVISOR_platform_op" [vmlinux] is a static EXPORT_SYMBOL_GPL
> 
> Remove the extraneous export.
> 
> Fixes: 15bfc2348d54 ("modpost: check for static EXPORT_SYMBOL* functions")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/xen/enlighten.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index 1e57692552d9..845c528acf24 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -437,7 +437,6 @@ EXPORT_SYMBOL_GPL(HYPERVISOR_memory_op);
>  EXPORT_SYMBOL_GPL(HYPERVISOR_physdev_op);
>  EXPORT_SYMBOL_GPL(HYPERVISOR_vcpu_op);
>  EXPORT_SYMBOL_GPL(HYPERVISOR_tmem_op);
> -EXPORT_SYMBOL_GPL(HYPERVISOR_platform_op);
>  EXPORT_SYMBOL_GPL(HYPERVISOR_multicall);
>  EXPORT_SYMBOL_GPL(HYPERVISOR_vm_assist);
>  EXPORT_SYMBOL_GPL(HYPERVISOR_dm_op);

Hi Arnd, 

Thank you for the patch. HYPERVISOR_platform_op() is an inline function,
the underlying function that should be exported is
HYPERVISOR_platform_op_raw. So, instead of removing
HYPERVISOR_platform_op, we should change it to
HYPERVISOR_platform_op_raw.

For convenience, and for testing I cooked up a patch. Arnd, if you are
happy with it (in the sense that it solves your problem) we'll check it
in the xentip tree, unless you would like to get it in your tree?

Cheers,

Stefano

---

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

HYPERVISOR_platform_op() is an inline function and should not
be exported. Since commit 15bfc2348d54 ("modpost: check for
static EXPORT_SYMBOL* functions"), this causes a warning:

WARNING: "HYPERVISOR_platform_op" [vmlinux] is a static EXPORT_SYMBOL_GPL

Instead, export the underlying function called by the static inline:
HYPERVISOR_platform_op_raw.

Fixes: 15bfc2348d54 ("modpost: check for static EXPORT_SYMBOL* functions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 1e57692552d9..522c97d43ef8 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -437,7 +437,7 @@ EXPORT_SYMBOL_GPL(HYPERVISOR_memory_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_physdev_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_vcpu_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_tmem_op);
-EXPORT_SYMBOL_GPL(HYPERVISOR_platform_op);
+EXPORT_SYMBOL_GPL(HYPERVISOR_platform_op_raw);
 EXPORT_SYMBOL_GPL(HYPERVISOR_multicall);
 EXPORT_SYMBOL_GPL(HYPERVISOR_vm_assist);
 EXPORT_SYMBOL_GPL(HYPERVISOR_dm_op);

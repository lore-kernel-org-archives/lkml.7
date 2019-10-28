Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F29ACA9EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A4721783
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxSmDbo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbfJ1CnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 22:43:21 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35244 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfJ1CnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 22:43:21 -0400
Received: by mail-io1-f65.google.com with SMTP id h9so9076705ioh.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 19:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WajkIfso2UlXgRkDGGI9iOFobax0DuU9gdm0Iijm/A8=;
        b=rxSmDbo0YmfGeXOIN+Q9biZMXG5q+/XkXO3AjnWZKG9k2QoYsiz7/3dMdXaUmdydtA
         6BWrxQMI0AHuw0nXVv4ks4FtDO7UoGpAD31IjfmfGxPe4Gt//TYkVcJYWnDP1v1jNz+o
         c75oqllYLie1bX5jJdtqgLTrpy7qu3HR3TgrMMT1EF/Lmiodbh/48fx9vULV8AFTCVh4
         fcDqWkceNEwGsW++o1WE2+6Q5BW2nt6F1IKAKdnQqPfjoMyeDjSDkldHsSGNfZ72PjAv
         F/EwrYkqQLRi7CzIaRe56lr3UGRIuZFnStLJw69W5mywrUb9uT2V7KbcbKewcbFnfShe
         B4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WajkIfso2UlXgRkDGGI9iOFobax0DuU9gdm0Iijm/A8=;
        b=OMgEOGW3RjYSZQ5E+XBhYkwEPCZmxpdQfU+lxaZgRzSYVcHx5XRaCVtBzW/zAy6ry0
         EI/iICiqw1TYpHaabYw9khvbBqu2kC63ky0FhjebNrkcS9T1+Z6sQv2l2XLURxAKZ2zS
         ZJM1r0JRvFmG0yRBmZ0/+7ohn8FFO+VO1RsGgEflVNTjqKohBUvrBPK8Tu+WKZeYab/6
         YC5Q+UFAptqF38l41uRym/Y2RJB2t0g9Uho6jikqhMHXKhRQvLBgSO+17/eYw/nXUkc1
         p+mqzdFB1eXEmVAXSMcjbkooKbR3GJsHWVL0Q/N1Mgwu7Mjv/HJgFiSR/Cat8aWeuZmX
         IOxg==
X-Gm-Message-State: APjAAAU/M87ZH/AFOZLClkm3lnbicZJ3tEBTK2oTmH4UQLuloQBJF+2h
        fRazURPcjC4qBN9aa/K5ceK9pR0v/qmnzcPP9Lc=
X-Google-Smtp-Source: APXvYqwOWm0fMe4Z+23NbNt4s3moVCNRfSkGYs68cOaCdJ7rNfZZA3zAvx6xOt8t6pKut1UDb6mLgbG5D1F93mKzz20=
X-Received: by 2002:a5d:8247:: with SMTP id n7mr8103790ioo.195.1572230600541;
 Sun, 27 Oct 2019 19:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191025044721.16617-1-alastair@au1.ibm.com> <20191025044721.16617-10-alastair@au1.ibm.com>
In-Reply-To: <20191025044721.16617-10-alastair@au1.ibm.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Mon, 28 Oct 2019 13:43:09 +1100
Message-ID: <CAOSf1CGwuAkeayfk0uowN8gkKXWy8jKzgLX5-Gxxqn3ENNiUdA@mail.gmail.com>
Subject: Re: [PATCH 09/10] powerpc: Enable OpenCAPI Storage Class Memory
 driver on bare metal
To:     "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org, Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 3:51 PM Alastair D'Silva <alastair@au1.ibm.com> wrote:
>
> From: Alastair D'Silva <alastair@d-silva.org>
>
> Enable OpenCAPI Storage Class Memory driver on bare metal
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  arch/powerpc/configs/powernv_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
> index 6658cceb928c..45c0eff94964 100644
> --- a/arch/powerpc/configs/powernv_defconfig
> +++ b/arch/powerpc/configs/powernv_defconfig
> @@ -352,3 +352,7 @@ CONFIG_KVM_BOOK3S_64=m
>  CONFIG_KVM_BOOK3S_64_HV=m
>  CONFIG_VHOST_NET=m
>  CONFIG_PRINTK_TIME=y
> +CONFIG_OCXL_SCM=m

> +CONFIG_DEV_DAX=y
> +CONFIG_DEV_DAX_PMEM=y

These should probably be modules. Having them as builtins will force
their dependencies (i.e. libnvdimm) to be built into the kernel too.

> +CONFIG_FS_DAX=y
> --
> 2.21.0
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

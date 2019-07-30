Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BE9C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE662089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732557AbfG3K0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 06:26:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36401 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729295AbfG3K0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 06:26:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id i21so61569239ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 03:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3AZrte9zGIaQdupl3qaH2oH0hTd9+Q2ZgEdDma4uaQY=;
        b=nvEGV/nv+M9paSdLkn0s3Vi4BNR0JcGWW6+cfjf1wzlNKZ9eWrJ3DxQFTCUXqTX4U2
         p9vjRH0SuaQlv8jTu/v9LdRpgPZvOUF4LudvF7IpHm9lKK881toPcZA+pT6EmhbsvZFn
         CUONJxBAAOMkBIpl0eTQJoVijw8FBrp+1Ow0UocHzUBuutzlMnGR5Zw/y/QhrsnkBl33
         FAIsVOVU0P3VjQh6r18D/B3M7tB5dgcI4fsl5fP0pb+uqtP18W5GfLVsxjJB8SH7ANi4
         CVklNOu7g1ZPF2SEH9kzn3CzN2sO8cWdILfioSrES9MS5ZoAIR1Jmbi9Fx75cMJZ4y01
         NxrQ==
X-Gm-Message-State: APjAAAUBvOzsXAN0MvJ3C6spv5JJk+83VYFAok7m3U2eo0smq2thJ/bJ
        oviJYLm1kcHDuvhs3XJYoBAabrVhHzCuy/EY12xebirU
X-Google-Smtp-Source: APXvYqzqUCZfgnM9GrjGVPUd+zN+L+6rlwO3ATkueVi4I74ZRdHqk4Sa3JJmPLYPUXnNt++vpLFO0GqoKEtXeB8Psy8=
X-Received: by 2002:a2e:8945:: with SMTP id b5mr59164374ljk.93.1564482360720;
 Tue, 30 Jul 2019 03:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <patch.git-ff1c9045ebdc.your-ad-here.call-01564402297-ext-5690@work.hours>
In-Reply-To: <patch.git-ff1c9045ebdc.your-ad-here.call-01564402297-ext-5690@work.hours>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Tue, 30 Jul 2019 15:55:48 +0530
Message-ID: <CACi5LpNQ8bEC+2KE=DZaUjeSmA46U=3u8m2WQYJEexK7uE0L+A@mail.gmail.com>
Subject: Re: [PATCH] kexec: restore arch_kexec_kernel_image_probe declaration
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vasily,

On Mon, Jul 29, 2019 at 5:44 PM Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> arch_kexec_kernel_image_probe function declaration has been removed by
> commit 9ec4ecef0af7 ("kexec_file,x86,powerpc: factor out kexec_file_ops
> functions"). Still this function is overridden by couple of architectures
> and proper prototype declaration is therefore important, so bring it
> back. This fixes the following sparse warning on s390:
> arch/s390/kernel/machine_kexec_file.c:333:5: warning: symbol 'arch_kexec_kernel_image_probe' was not declared. Should it be static?

May be it would be better to add a 'Fixes:' tag here (but may be it
can be added while picking it into the tree). With the above minor
nitpick:

Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks,
Bhupesh

> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  include/linux/kexec.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 1740fe36b5b7..f7529d120920 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -183,6 +183,8 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
>                                    bool get_value);
>  void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
>
> +int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> +                                        unsigned long buf_len);
>  void * __weak arch_kexec_kernel_image_load(struct kimage *image);
>  int __weak arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>                                             Elf_Shdr *section,
> --
> 2.21.0
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCF7ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F64920872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439860AbfJQOLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:11:43 -0400
Received: from goliath.siemens.de ([192.35.17.28]:50691 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfJQOLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:11:42 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id x9HEBKKZ011676
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 16:11:20 +0200
Received: from [139.25.68.37] ([139.25.68.37])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x9HEBKiK018505;
        Thu, 17 Oct 2019 16:11:20 +0200
Subject: Re: [PATCH v2] scripts/gdb: fix debugging modules on s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Kieran Bingham <kbingham@kernel.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20191017085917.81791-1-iii@linux.ibm.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a6114e4d-0b5b-4e71-8408-f2f1d41bb9d1@siemens.com>
Date:   Thu, 17 Oct 2019 16:11:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017085917.81791-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.10.19 10:59, Ilya Leoshkevich wrote:
> Currently lx-symbols assumes that module text is always located at
> module->core_layout->base, but s390 uses the following layout:
> 
> +------+  <- module->core_layout->base
> | GOT  |
> +------+  <- module->core_layout->base + module->arch->plt_offset
> | PLT  |
> +------+  <- module->core_layout->base + module->arch->plt_offset +
> | TEXT |     module->arch->plt_size
> +------+
> 
> Therefore, when trying to debug modules on s390, all the symbol
> addresses are skewed by plt_offset + plt_size.
> 
> Fix by adding plt_offset + plt_size to module_addr in
> load_module_symbols().
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> 
> v1 -> v2: print the adjusted address.
> 
>  scripts/gdb/linux/symbols.py | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> index f0d8f2ecfde7..df4c810de663 100644
> --- a/scripts/gdb/linux/symbols.py
> +++ b/scripts/gdb/linux/symbols.py
> @@ -15,7 +15,7 @@ import gdb
>  import os
>  import re
>  
> -from linux import modules
> +from linux import modules, utils
>  
>  
>  if hasattr(gdb, 'Breakpoint'):
> @@ -111,6 +111,12 @@ lx-symbols command."""
>              module_file = self._get_module_file(module_name)
>  
>          if module_file:
> +            if utils.is_target_arch('s390'):
> +                # Module text is preceded by PLT stubs on s390.
> +                module_arch = module['arch']
> +                plt_offset = int(module_arch['plt_offset'])
> +                plt_size = int(module_arch['plt_size'])
> +                module_addr = hex(int(module_addr, 0) + plt_offset + plt_size)
>              gdb.write("loading @{addr}: {filename}\n".format(
>                  addr=module_addr, filename=module_file))
>              cmdline = "add-symbol-file {filename} {addr}{sections}".format(
> 

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

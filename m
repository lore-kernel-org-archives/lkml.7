Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA139ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8932B20640
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733306AbfJOPVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:21:45 -0400
Received: from gecko.sbs.de ([194.138.37.40]:57804 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732991AbfJOPVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:21:45 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id x9FFLZtr004347
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 17:21:35 +0200
Received: from [139.25.68.37] ([139.25.68.37])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x9FFLHkl014570;
        Tue, 15 Oct 2019 17:21:17 +0200
Subject: Re: [PATCH] scripts/gdb: fix debugging modules on s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Kieran Bingham <kbingham@kernel.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20191015105313.12663-1-iii@linux.ibm.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <356384d7-d14f-2c9d-1c13-3d96e75e1727@siemens.com>
Date:   Tue, 15 Oct 2019 17:21:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191015105313.12663-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.10.19 12:53, Ilya Leoshkevich wrote:
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
>  scripts/gdb/linux/symbols.py | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> index f0d8f2ecfde7..41c6d1a55b03 100644
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
> @@ -113,6 +113,12 @@ lx-symbols command."""
>          if module_file:
>              gdb.write("loading @{addr}: {filename}\n".format(
>                  addr=module_addr, filename=module_file))
> +            if utils.is_target_arch('s390'):
> +                # Module text is preceded by PLT stubs on s390.
> +                module_arch = module['arch']
> +                plt_offset = int(module_arch['plt_offset'])
> +                plt_size = int(module_arch['plt_size'])
> +                module_addr = hex(int(module_addr, 0) + plt_offset + plt_size)

Shouldn't we report the actual address above, ie. reorder this tuning
with the gdb.write?

>              cmdline = "add-symbol-file {filename} {addr}{sections}".format(
>                  filename=module_file,
>                  addr=module_addr,
> 

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

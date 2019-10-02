Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAB8C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 00:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659CE2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 00:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfJBAww convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 20:52:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:47189 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbfJBAwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 20:52:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 17:52:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,572,1559545200"; 
   d="scan'208";a="194707403"
Received: from unknown (HELO ubuntu) ([10.226.248.111])
  by orsmga003.jf.intel.com with SMTP; 01 Oct 2019 17:52:50 -0700
Received: by ubuntu (sSMTP sendmail emulation); Wed, 02 Oct 2019 08:52:50 +0800
Message-ID: <1569977550.9826.7.camel@intel.com>
Subject: Re: [PATCH] nios2: force the string buffer NULL-terminated
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Cc:     rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190805101712.22580-1-xywang.sjtu@sjtu.edu.cn>
References: <20190805101712.22580-1-xywang.sjtu@sjtu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date:   Wed, 02 Oct 2019 08:52:30 +0800
Mime-Version: 1.0
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-05 at 18:17 +0800, Wang Xiayang wrote:
> strncpy() does not ensure NULL-termination when the input string
> size equals to the destination buffer size COMMAND_LINE_SIZE.
> Besides, grep under arch/ with 'boot_command_line' shows
> no other arch-specific code uses strncpy() when copying
> boot_command_line.
> 
> Use strlcpy() instead.
> 
> This issue is identified by a Coccinelle script.
> 
> Signed-off-by: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Merged to v5.4-rc1. Thanks.


Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>


> ---
>  arch/nios2/kernel/setup.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
> index 6bbd4ae2beb0..4cf35b09c0ec 100644
> --- a/arch/nios2/kernel/setup.c
> +++ b/arch/nios2/kernel/setup.c
> @@ -123,7 +123,7 @@ asmlinkage void __init nios2_boot_init(unsigned
> r4, unsigned r5, unsigned r6,
>                 dtb_passed = r6;
> 
>                 if (r7)
> -                       strncpy(cmdline_passed, (char *)r7,
> COMMAND_LINE_SIZE);
> +                       strlcpy(cmdline_passed, (char *)r7,
> COMMAND_LINE_SIZE);
>         }
>  #endif
> 
> @@ -131,10 +131,10 @@ asmlinkage void __init nios2_boot_init(unsigned
> r4, unsigned r5, unsigned r6,
> 
>  #ifndef CONFIG_CMDLINE_FORCE
>         if (cmdline_passed[0])
> -               strncpy(boot_command_line, cmdline_passed,
> COMMAND_LINE_SIZE);
> +               strlcpy(boot_command_line, cmdline_passed,
> COMMAND_LINE_SIZE);
>  #ifdef CONFIG_NIOS2_CMDLINE_IGNORE_DTB
>         else
> -               strncpy(boot_command_line, CONFIG_CMDLINE,
> COMMAND_LINE_SIZE);
> +               strlcpy(boot_command_line, CONFIG_CMDLINE,
> COMMAND_LINE_SIZE);
>  #endif
>  #endif
> 
> --
> 2.11.0
> 
> 
> ________________________________
> 
> Confidentiality Notice.
> This message may contain information that is confidential or
> otherwise protected from disclosure. If you are not the intended
> recipient, you are hereby notified that any use, disclosure,
> dissemination, distribution, or copying of this message, or any
> attachments, is strictly prohibited. If you have received this
> message in error, please advise the sender by reply e-mail, and
> delete the message and any attachments. Thank you.

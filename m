Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E87C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590F12186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbfCAHa0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:30:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:50762 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfCAHaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 02:30:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 23:30:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,426,1544515200"; 
   d="scan'208";a="121750376"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.85])
  by orsmga008.jf.intel.com with SMTP; 28 Feb 2019 23:30:21 -0800
Received: by ubuntu (sSMTP sendmail emulation); Fri, 01 Mar 2019 15:30:20 +0800
Message-ID: <1551425419.24631.18.camel@intel.com>
Subject: Re: [PATCH 10/14] nios2: define syscall_get_arch()
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Ley Foon Tan <lftan@altera.com>,
        nios2-dev@lists.rocketboards.org
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Moore <paul@paul-moore.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Fri, 01 Mar 2019 15:30:19 +0800
In-Reply-To: <20190227153109.GF23744@altlinux.org>
References: <20190109124044.GA11935@altlinux.org>
         <20190109124323.GJ11981@altlinux.org> <20190227153109.GF23744@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-02-27 at 18:31 +0300, Dmitry V. Levin wrote:
> syscall_get_arch() is required to be implemented on all architectures
> in addition to already implemented syscall_get_nr(),
> syscall_get_arguments(), syscall_get_error(), and
> syscall_get_return_value() functions in order to extend the generic
> ptrace API with PTRACE_GET_SYSCALL_INFO request.
> 
> Acked-by: Paul Moore <paul@paul-moore.com>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: nios2-dev@lists.rocketboards.org
> Cc: linux-audit@redhat.com
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>

Regards
Ley Foon

> ---
>  This is just a gentle ping, the patch is unchanged.
> 
>  arch/nios2/include/asm/syscall.h | 6 ++++++
>  include/uapi/linux/audit.h       | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/nios2/include/asm/syscall.h
> b/arch/nios2/include/asm/syscall.h
> index 9de220854c4a..cf35e210fc4d 100644
> --- a/arch/nios2/include/asm/syscall.h
> +++ b/arch/nios2/include/asm/syscall.h
> @@ -17,6 +17,7 @@
>  #ifndef __ASM_NIOS2_SYSCALL_H__
>  #define __ASM_NIOS2_SYSCALL_H__
> 
> +#include <uapi/linux/audit.h>
>  #include <linux/err.h>
>  #include <linux/sched.h>
> 
> @@ -135,4 +136,9 @@ static inline void syscall_set_arguments(struct
> task_struct *task,
>         }
>  }
> 
> +static inline int syscall_get_arch(void)
> +{
> +       return AUDIT_ARCH_NIOS2;
> +}
> +
>  #endif
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 1568ddc1c945..efeb0bbd6c4d 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -403,6 +403,7 @@ enum {
>                                  __AUDIT_ARCH_CONVENTION_MIPS64_N32)
>  #define AUDIT_ARCH_NDS32       (EM_NDS32|__AUDIT_ARCH_LE)
>  #define AUDIT_ARCH_NDS32BE     (EM_NDS32)
> +#define AUDIT_ARCH_NIOS2       (EM_ALTERA_NIOS2|__AUDIT_ARCH_LE)
>  #define AUDIT_ARCH_OPENRISC    (EM_OPENRISC)
>  #define AUDIT_ARCH_PARISC      (EM_PARISC)
>  #define AUDIT_ARCH_PARISC64    (EM_PARISC|__AUDIT_ARCH_64BIT)
> --
> ldv
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

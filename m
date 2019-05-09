Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCB9C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 07:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D65F2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 07:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfEIHBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 03:01:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfEIHBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 03:01:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 997EB3097035;
        Thu,  9 May 2019 07:01:17 +0000 (UTC)
Received: from localhost (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B97A5D9D1;
        Thu,  9 May 2019 07:01:13 +0000 (UTC)
Date:   Thu, 9 May 2019 15:01:11 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org, dyoung@redhat.com
Subject: Re: [PATCH v4 2/3] x86/kexec/64: Error out if try to jump to old
 4-level kernel from 5-level kernel
Message-ID: <20190509070111.GE24922@MiWiFi-R3L-srv>
References: <20190509013644.1246-1-bhe@redhat.com>
 <20190509013644.1246-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509013644.1246-3-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 09 May 2019 07:01:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/19 at 09:36am, Baoquan He wrote:
> If the running kernel has 5-level paging activated, the 5-level paging
> mode is preserved across kexec. If the kexec'ed kernel does not contain
> support for handling active 5-level paging mode in the decompressor, the
> decompressor will crash with #GP.
> 
> Prevent this situation at load time. If 5-level paging is active, check the
> xloadflags whether the kexec kernel can handle 5-level paging at least in
> the decompressor. If not, reject the load attempt and print out error
> message.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 22f60dd26460..858cc892672f 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -321,6 +321,11 @@ static int bzImage64_probe(const char *buf, unsigned long len)
>  		return ret;
>  	}
>  
> +	if (!(header->xloadflags & XLF_5LEVEL) && pgtable_l5_enabled()) {
> +		pr_err("Can not jump to old 4-level kernel from 5-level kernel.\n");

Check the old thread again, found Thomas also had comment about this
error message. Just forgot updating it. Will update it with a new one.

> +		return ret;
> +	}
> +
>  	/* I've got a bzImage */
>  	pr_debug("It's a relocatable bzImage64\n");
>  	ret = 0;
> -- 
> 2.17.2
> 

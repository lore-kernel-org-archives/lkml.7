Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C89C4646C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 06:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788A22084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 06:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfFUGnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 02:43:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfFUGnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 02:43:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F651F74AE;
        Fri, 21 Jun 2019 06:43:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-101.pek2.redhat.com [10.72.12.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DAFB5D739;
        Fri, 21 Jun 2019 06:43:44 +0000 (UTC)
Date:   Fri, 21 Jun 2019 14:43:40 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, Jiri Bohac <jbohac@suse.cz>,
        linux-api@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        dhowells@redhat.com, linux-security-module@vger.kernel.org,
        luto@kernel.org
Subject: Re: [PATCH V31 07/25] kexec_file: Restrict at runtime if the kernel
 is locked down
Message-ID: <20190621064340.GB4528@localhost.localdomain>
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-8-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326182742.16950-8-matthewgarrett@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 21 Jun 2019 06:43:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/19 at 11:27am, Matthew Garrett wrote:
> From: Jiri Bohac <jbohac@suse.cz>
> 
> When KEXEC_SIG is not enabled, kernel should not load images through
> kexec_file systemcall if the kernel is locked down.
> 
> [Modified by David Howells to fit with modifications to the previous patch
>  and to return -EPERM if the kernel is locked down for consistency with
>  other lockdowns. Modified by Matthew Garrett to remove the IMA
>  integration, which will be replaced by integrating with the IMA
>  architecture policy patches.]
> 
> Signed-off-by: Jiri Bohac <jbohac@suse.cz>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Reviewed-by: Jiri Bohac <jbohac@suse.cz>
> cc: kexec@lists.infradead.org
> ---
>  kernel/kexec_file.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 67f3a866eabe..a1cc37c8b43b 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -239,6 +239,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  		}
>  
>  		ret = 0;
> +
> +		if (kernel_is_locked_down(reason, LOCKDOWN_INTEGRITY)) {
> +			ret = -EPERM;
> +			goto out;
> +		}
> +

Checking here is late, it would be good to move the check to earlier
code around below code:
        /* We only trust the superuser with rebooting the system. */
        if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
                return -EPERM;

>  		break;
>  
>  		/* All other errors are fatal, including nomem, unparseable
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave

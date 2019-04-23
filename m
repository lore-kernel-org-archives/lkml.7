Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AB2C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BC1218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfDWUfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:35:09 -0400
Received: from namei.org ([65.99.196.166]:35440 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfDWUfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:35:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x3NKZ2o0016312;
        Tue, 23 Apr 2019 20:35:02 GMT
Date:   Wed, 24 Apr 2019 06:35:02 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Robert Holmes <robeholmes@gmail.com>
cc:     jeyu@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: Make use of platform keyring for module signature
 verify
In-Reply-To: <1556005169-4139-1-git-send-email-robeholmes@gmail.com>
Message-ID: <alpine.LRH.2.21.1904240626430.9705@namei.org>
References: <1556005169-4139-1-git-send-email-robeholmes@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019, Robert Holmes wrote:

> This patch completes commit 278311e417be ("kexec, KEYS: Make use of
> platform keyring for signature verify") which, while adding the
> platform keyring for bzImage verification, neglected to also add
> this keyring for module verification.
> 

You should most likely add the keyrings list to the cc: for these kinds of 
patches.

> As such, kernel modules signed with keys from the MokList variable
> were not successfully verified.
> 
> Signed-off-by: Robert Holmes <robeholmes@gmail.com>
> ---
>  kernel/module_signing.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/module_signing.c b/kernel/module_signing.c
> index 6b9a926fd86b..cf94220e9154 100644
> --- a/kernel/module_signing.c
> +++ b/kernel/module_signing.c
> @@ -49,6 +49,7 @@ int mod_verify_sig(const void *mod, struct load_info *info)
>  {
>  	struct module_signature ms;
>  	size_t sig_len, modlen = info->len;
> +	int ret;
>  
>  	pr_devel("==>%s(,%zu)\n", __func__, modlen);
>  
> @@ -82,8 +83,15 @@ int mod_verify_sig(const void *mod, struct load_info *info)
>  		return -EBADMSG;
>  	}
>  
> -	return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
> -				      VERIFY_USE_SECONDARY_KEYRING,
> -				      VERIFYING_MODULE_SIGNATURE,
> -				      NULL, NULL);
> +	ret = verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
> +				     VERIFY_USE_SECONDARY_KEYRING,
> +				     VERIFYING_MODULE_SIGNATURE,
> +				     NULL, NULL);
> +	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
> +		ret = verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
> +					     VERIFY_USE_PLATFORM_KEYRING,
> +					     VERIFYING_MODULE_SIGNATURE,
> +					     NULL, NULL);
> +	}
> +	return ret;
>  }
> 

-- 
James Morris
<jmorris@namei.org>


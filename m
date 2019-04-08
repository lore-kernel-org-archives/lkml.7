Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E520C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19727213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGWzYh2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfDHWb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:31:59 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44432 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfDHWb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 18:31:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id d11so13135440edp.11;
        Mon, 08 Apr 2019 15:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vU42oe7bPEUfWKkstyh+HFo52l2jF2pUHiMoyw12OBA=;
        b=QGWzYh2/Y8UqBQhXGFbta6K3vc5Dr4jPzSD8Un8ynqGgYZXttlcpiuctlHRC41YSKV
         SQJx9nosicialZ6647PpH7mhsnek9HCfoyN3BoJQ/QZ5BGNF5lnTIAx+yvFeRF/dFOAM
         0BKinWJrQPz0X/h6cnszE2poNmhIFcX2OukjPumXssmBj9SlWmpzxg9f/GEOsUY60au6
         daySeu8La5hArA3UcK7bARZg466/BZK/8tk58jpHIZ9f9ibq5/sfPfyWEiFMZwYBAZi+
         apa6Y3GWYcc6ygVybmhd29liAVwnhOeZslxUVwmeRfW2mesSLy+1Bpa3JgmRgI+5d0Y5
         ohcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vU42oe7bPEUfWKkstyh+HFo52l2jF2pUHiMoyw12OBA=;
        b=P+E+Hd9v8Sw0xFt3sELGsnxt8zIO6tW9pjJT2Ap4H8Rg7hLnROMT07OjrquPpP898A
         giRZJ6ckWRZ6RKEOPtqSH5uFsxSlRExbQY1BiwTi15ghYHv5UZiH5TdRo5qFXH/YEOYe
         tLzvqx+6vxEP/OAzYCYuSGs5kM0swol/lfH0ptU8RSj0oQ3PGSdo2vmD9aDKyyC/SLpW
         scS7T1CxMVYr8R8MtsTvW+6l8s1RKPdQYu5Klr138NA7g2PnwtPAoFmZHSobRfBeH8f4
         4xFze19YNJGLgEGqEnCTvv/z/Ui/qXeO3pENAuW/Sl1hj1clIMGiZbMm4zdLobRYIAWz
         iSKQ==
X-Gm-Message-State: APjAAAWOSAGvC/q3iSc0b/SsnMUYAYDruaWxi8UvcgTDZJAndxXqtxgn
        X3is4bskXWRwDkqvNqrpKSI=
X-Google-Smtp-Source: APXvYqyp+a3Ps3LINrmsHrfAwnULgFPLrpW2H9u83tc/FtEdo8xNImLC831VPTNTpRUbI436Y/4esg==
X-Received: by 2002:a17:906:d28c:: with SMTP id ay12mr18628013ejb.51.1554762717159;
        Mon, 08 Apr 2019 15:31:57 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id j15sm2632420edt.47.2019.04.08.15.31.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Apr 2019 15:31:56 -0700 (PDT)
Date:   Mon, 8 Apr 2019 15:31:54 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-s390@vger.kernel.org, Ingo Franzki <ifranzki@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] s390: zcrypt: initialize variables before_use
Message-ID: <20190408223154.GC18333@archlinux-i9>
References: <20190408212648.2407234-1-arnd@arndb.de>
 <20190408212648.2407234-5-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408212648.2407234-5-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 11:26:18PM +0200, Arnd Bergmann wrote:
> The 'func_code' variable gets printed in debug statements without
> a prior initialization in multiple functions, as reported when building
> with clang:
> 
> drivers/s390/crypto/zcrypt_api.c:659:6: warning: variable 'func_code' is used uninitialized whenever 'if' condition is true
>       [-Wsometimes-uninitialized]
>         if (mex->outputdatalength < mex->inputdatalength) {
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/s390/crypto/zcrypt_api.c:725:29: note: uninitialized use occurs here
>         trace_s390_zcrypt_rep(mex, func_code, rc,
>                                    ^~~~~~~~~
> drivers/s390/crypto/zcrypt_api.c:659:2: note: remove the 'if' if its condition is always false
>         if (mex->outputdatalength < mex->inputdatalength) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/s390/crypto/zcrypt_api.c:654:24: note: initialize the variable 'func_code' to silence this warning
>         unsigned int func_code;
>                               ^
> 
> Add initializations to all affected code paths to shut up the warning
> and make the warning output consistent.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I'll never get used to seeing negative numbers assigned to unsigned
integers...

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/s390/crypto/zcrypt_api.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
> index eb93c2d27d0a..23472063d9a8 100644
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
> @@ -657,6 +657,7 @@ static long zcrypt_rsa_modexpo(struct ap_perms *perms,
>  	trace_s390_zcrypt_req(mex, TP_ICARSAMODEXPO);
>  
>  	if (mex->outputdatalength < mex->inputdatalength) {
> +		func_code = -1;
>  		rc = -EINVAL;
>  		goto out;
>  	}
> @@ -739,6 +740,7 @@ static long zcrypt_rsa_crt(struct ap_perms *perms,
>  	trace_s390_zcrypt_req(crt, TP_ICARSACRT);
>  
>  	if (crt->outputdatalength < crt->inputdatalength) {
> +		func_code = -1;
>  		rc = -EINVAL;
>  		goto out;
>  	}
> @@ -946,6 +948,7 @@ static long zcrypt_send_ep11_cprb(struct ap_perms *perms,
>  
>  		targets = kcalloc(target_num, sizeof(*targets), GFP_KERNEL);
>  		if (!targets) {
> +			func_code = -1;
>  			rc = -ENOMEM;
>  			goto out;
>  		}
> @@ -953,6 +956,7 @@ static long zcrypt_send_ep11_cprb(struct ap_perms *perms,
>  		uptr = (struct ep11_target_dev __force __user *) xcrb->targets;
>  		if (copy_from_user(targets, uptr,
>  				   target_num * sizeof(*targets))) {
> +			func_code = -1;
>  			rc = -EFAULT;
>  			goto out_free;
>  		}
> -- 
> 2.20.0
> 

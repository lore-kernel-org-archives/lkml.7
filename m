Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF39DC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD17320B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbfFSGeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 02:34:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44069 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfFSGeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 02:34:16 -0400
Received: from 162-237-133-238.lightspeed.rcsntx.sbcglobal.net ([162.237.133.238] helo=lindsey)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1hdUAb-0001Np-Om; Wed, 19 Jun 2019 06:34:10 +0000
Date:   Wed, 19 Jun 2019 01:34:06 -0500
From:   Tyler Hicks <tyhicks@canonical.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        ecryptfs@vger.kernel.org
Subject: Re: [PATCH -next] ecryptfs: remove unnessesary null check in
 ecryptfs_keyring_auth_tok_for_sig
Message-ID: <20190619063405.GB22021@lindsey>
References: <20190527132814.19600-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527132814.19600-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-27 21:28:14, YueHaibing wrote:
> request_key and ecryptfs_get_encrypted_key never
> return a NULL pointer, so no need do a null check.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

This change looks good to me. I've pushed it to the eCryptfs next
branch.

Tyler

> ---
>  fs/ecryptfs/keystore.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
> index 95662fd46b1d..a1afb162b9d2 100644
> --- a/fs/ecryptfs/keystore.c
> +++ b/fs/ecryptfs/keystore.c
> @@ -1626,9 +1626,9 @@ int ecryptfs_keyring_auth_tok_for_sig(struct key **auth_tok_key,
>  	int rc = 0;
>  
>  	(*auth_tok_key) = request_key(&key_type_user, sig, NULL);
> -	if (!(*auth_tok_key) || IS_ERR(*auth_tok_key)) {
> +	if (IS_ERR(*auth_tok_key)) {
>  		(*auth_tok_key) = ecryptfs_get_encrypted_key(sig);
> -		if (!(*auth_tok_key) || IS_ERR(*auth_tok_key)) {
> +		if (IS_ERR(*auth_tok_key)) {
>  			printk(KERN_ERR "Could not find key with description: [%s]\n",
>  			      sig);
>  			rc = process_request_key_err(PTR_ERR(*auth_tok_key));
> -- 
> 2.17.1
> 
> 

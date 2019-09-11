Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E14ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CC52084D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="BcqK+uXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfIKI4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 04:56:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36558 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfIKI4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 04:56:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id l20so19220898ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 01:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/E13juu/FtC97zR3HMtA4Q3ZzUhvcKxTohP/DIrieFE=;
        b=BcqK+uXn+oKcHQci2VioBov/yYrGjlPkyn/T/kLLSbgWOlSSf+NsSr9tcr+eWTkHB+
         jsfLdzZTp6C+J0ho7T2xrzmgZFcpO3Px/xdP0U/++BsKxOVGHFqBD5k1MeTP8WuVczL+
         0urtdMdVcnVQrzmqR98SdvyOPtyUvsVnd8Eb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/E13juu/FtC97zR3HMtA4Q3ZzUhvcKxTohP/DIrieFE=;
        b=VRhXh5x8mSo6WqGXCNsbEgGEnBK5mwjhf3o5d3ZgIEqTRcNtp21JzCf+T7GmUv24Oo
         /u8xLK5IPopSckiFDwgC91N0y1Dk1gxYlhETnhaYDSPEU28um1X+LFhGhLC9F5ZXM+E6
         HO9uCwJIDoWpXV7LANtc6eNiuQ7UmCwLk2l7IJTlCXW6UEshVO2REurohdacA3sRttMT
         sHSzKQtT2dzv6Qs+kCDTqm9EC2Tpg3yCDzc8JD6H8xvB/v8FUmpMz2JAz1NuAx+u7cfb
         ezP1AoP24FW+4I4TywB4NMRkeel3H/cSXB8Meo3+SE/udCaoqJ8GsYULr0eMId+ufKZY
         Sovg==
X-Gm-Message-State: APjAAAWeTRJwxeCKVj4Ny6zOcEYzDYpHE4SGSH+96T4vkkZKl617w4ci
        MzV81R5AtSDkBAZrwnPBOXNHhhqrTHICRZcX
X-Google-Smtp-Source: APXvYqy1RDrW7Pk+KOWN/Jc3bS05Tc1eYcGhatc7TiXDSqSL/sku24bMf+Y2wx8fUy/PfU+iLX5gpQ==
X-Received: by 2002:a2e:a313:: with SMTP id l19mr6461495lje.205.1568192177571;
        Wed, 11 Sep 2019 01:56:17 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t82sm4987346lff.58.2019.09.11.01.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 01:56:16 -0700 (PDT)
Subject: Re: [PATCH] Staging: exfat: Avoid use of strcpy
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Sandro Volery <sandro@volery.com>
Cc:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190911055749.GA10786@volery> <20190911084111.GG15977@kadam>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <214f3b20-fac4-df5e-6b3c-a08a19a8ea42@rasmusvillemoes.dk>
Date:   Wed, 11 Sep 2019 10:56:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911084111.GG15977@kadam>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2019 10.41, Dan Carpenter wrote:
> On Wed, Sep 11, 2019 at 07:57:49AM +0200, Sandro Volery wrote:
>> Replaced strcpy with strscpy in exfat_core.c.
>>
>> Signed-off-by: Sandro Volery <sandro@volery.com>
>> ---
>>  drivers/staging/exfat/exfat_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
>> index da8c58149c35..c71b145e8a24 100644
>> --- a/drivers/staging/exfat/exfat_core.c
>> +++ b/drivers/staging/exfat/exfat_core.c
>> @@ -2964,7 +2964,7 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
>>  	if (strlen(path) >= (MAX_NAME_LENGTH * MAX_CHARSET_SIZE))
>>  		return FFS_INVALIDPATH;
>>  
>> -	strcpy(name_buf, path);
>> +	strscpy(name_buf, path, sizeof(name_buf));
> 
> It checked strlen() earlier so we know that it can't overflow but, oh
> wow, the "name_buf" is a shared buffer.  wow wow wow.  This seems very
> racy.

Yeah, and note that the callers of resolve_path do seem to take a lock,
but that's not a global lock but a per-superblock (or
per-something-else) one... Obviously exfat should not rely on such a
single static buffer, but in the meantime, perhaps one should add a
name_buf_lock (though I don't know how long name_buf is actually in use,
so that needs checking).

Apart from the broken/lack of locking, it would be better to combine the
copying and length checking into a single check - i.e. do

  if (strscpy(name_buf, path, sizeof(name_buf)) < 0)
    return FFS_INVALIDPATH;

That's both more efficient and fixes the open-coding of sizeof(name_buf)
that is currently used in the if().

Rasmus



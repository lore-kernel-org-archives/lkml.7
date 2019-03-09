Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F063EC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADC120815
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxdG2MeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfCITAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:00:34 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33483 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfCITAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:00:33 -0500
Received: by mail-qk1-f193.google.com with SMTP id x9so536641qkf.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 11:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=psrxkLFpRq5N+QjLfthp0OTg5gMu9SOV1P8ti4DArQw=;
        b=rxdG2MeN+JbrJMJ9IvpoO7t4Z42ZImtEcri2/tOlzgd2YDGsTCug5suYlCO73TV688
         VRlUZydO1fGfbEDB31qG+xC6NDVoZMFvq92oHv1wxECTfvUWXvbOU2n46NDWg5Pbgizu
         /s1TkWJnz2dgKRHwqPwQDo2zAjYlTVnsS3OIwfkLMd8xuSQdVspkHK0wjwcjNmSz3lt8
         yOBIb/3kf8nTwG0AeQ0sI+eZYv3OtlopvHx8q8PPtd/N78HgE6mo+tr26NNOd2d7OJCX
         Ufcz5fqSEbdJB041FiNUioNqUaZqeManGNt/m/UU4u2WkX1182ainMteYOmT1It6dHFA
         0RLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=psrxkLFpRq5N+QjLfthp0OTg5gMu9SOV1P8ti4DArQw=;
        b=ndsOY36JpAxwY1Pl+BDRY0yh99hKA7EcibpkT+V1YsIglAI25os96ICv1X5RQkYlLP
         ZbcKQdgJ4Ohq8s3nsoxh3NJX3mbPbR7q0+96kSLYpamT6Zh0HDKo1NKtd+DV3VnSdEP0
         aYXfiWfBzmQIzv2q45YFfTeqoNbiaWyXDAFee3Fh3/NPG6EDHSfv2PLtVyjUwBfq4pFR
         QR4YN8HdxSusXBZfykwDmoO09TbzZ4J+VuzKJFwjNVESzc4iUq7X8pR8WZ838+HMsdMZ
         PdFI6vpTN6mNsvAcmabInHv0CRZBvjk/YWVkWQmDJIHlIT8XB3U6bp3cNhn/ezGsBW9f
         fWEA==
X-Gm-Message-State: APjAAAUahjZ5K5H01pykGRqKDuMtR/aFiXEaR56EGnDw/Avr5Jnewl2q
        5mjfADZMTzNh5us+Ygc/OcbT/Q8pjx7GEZpK66k=
X-Google-Smtp-Source: APXvYqxUVC0UL5ZGq40qfc3uNuxgJHAG/GAkRSGYjWMCEASG56djb623kjGuplKA82qhEL7MLsUM7GhfPrIDy+GBEL8=
X-Received: by 2002:a37:7d86:: with SMTP id y128mr9102135qkc.36.1552158032257;
 Sat, 09 Mar 2019 11:00:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:f553:0:0:0:0:0 with HTTP; Sat, 9 Mar 2019 11:00:31 -0800 (PST)
In-Reply-To: <d57e41f96a23f63aeb720d0ea73ba2b2bed0a938.camel@perches.com>
References: <20190309183047.10781-1-gui.maeoka@gmail.com> <20190309183047.10781-2-gui.maeoka@gmail.com>
 <d57e41f96a23f63aeb720d0ea73ba2b2bed0a938.camel@perches.com>
From:   Guilherme T Maeoka <gui.maeoka@gmail.com>
Date:   Sat, 9 Mar 2019 16:00:31 -0300
Message-ID: <CAPTV9hudtZ6_9VL2L=ic-LqMmj5Jb3WR9404isHU0NjxtG5A3A@mail.gmail.com>
Subject: Re: [PATCH 1/5] Staging: rtl8723bs: os_dep: Fix assignment in if condition
To:     Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the review Joe. I'll have that in mind in the next patch.

On 3/9/19, Joe Perches <joe@perches.com> wrote:
> On Sat, 2019-03-09 at 15:30 -0300, Guilherme Tadashi Maeoka wrote:
>> Fix an assignment in if condition.
>>
>> Signed-off-by: Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
>> ---
>>  drivers/staging/rtl8723bs/os_dep/osdep_service.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
>> b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
>> index 73b87da15eb2..c7fdcc6bbae3 100644
>> --- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
>> +++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
>> @@ -162,7 +162,9 @@ static int retriveFromFile(char *path, u8 *buf, u32
>> sz)
>>  	struct file *fp;
>>
>>  	if (path && buf) {
>> -		if (0 == (ret =openFile(&fp, path, O_RDONLY, 0))) {
>> +		ret = openFile(&fp, path, O_RDONLY, 0);
>> +
>> +		if (ret == 0) {
>>  			DBG_871X("%s openFile path:%s fp =%p\n", __func__, path , fp);
>>
>>  			oldfs = get_fs(); set_fs(KERNEL_DS);
>
> More common kernel style would be to rewrite the function
> (and to fix the typo of retrieve) to something like:
>
> static int retrieveFromFile(char *path, u8 *buf, u32 sz)
> {
> 	int ret;
> 	mm_segment_t oldfs;
> 	struct file *fp;
>
> 	if (!path || !buf) {
> 		DBG_871X("%s NULL pointer\n", __func__);
> 		return -EINVAL;
> 	}
>
> 	ret = openFile(&fp, path, O_RDONLY, 0);
> 	if (ret) {
> 		DBG_871X("%s openFile path:%s Fail, ret:%d\n",
> 			 __func__, path, ret);
> 		return ret;
> 	}
>
> 	DBG_871X("%s openFile path:%s fp =%p\n", __func__, path , fp);
>
> 	oldfs = get_fs();
> 	set_fs(KERNEL_DS);
> 	ret = readFile(fp, buf, sz);
> 	set_fs(oldfs);
> 	closeFile(fp);
>
> 	DBG_871X("%s readFile, ret:%d\n", __func__, ret);
>
> 	return ret;
> }
>
>
>

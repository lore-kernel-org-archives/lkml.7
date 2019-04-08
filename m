Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525A3C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141882148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQVD1vqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfDHRiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:38:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43183 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbfDHRiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:38:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id c20so8491130qkc.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 10:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Bsy0HHiQI23+wIyYZlKH9CNuQ+Oq7f3gnuvXfO+9Zc=;
        b=hQVD1vqA0mW3ErlYiutqWj1yqPpk9QIiLU8tHlCmeKK/OloCqrcTw5vKPjjlpxoYBj
         3Xy/3rI7TdcsQqOFh6MY+D67oP9VAI6lwtJ4OyAO7PBawIouKzQyuybYyxYOYikVMfLc
         4628+MkM9hYLJ/FuPvb+KnTjW9TQZMe/Wz36Nww0GHZbsbJpdpPKKKCxrsRu+zTgXgbw
         IW7NuxJlJHZEMO1tZx6gWVhqG6FZ5KkwX4rmkH73VybDGy4HLseYWTKAez9w91LjTw96
         YNinwurLvxqWnDwBe96M6jLF5BDYxSc+z4DbJYjBFzjvAhCE6O0dX/UtjHccs8wxMKmF
         ECrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Bsy0HHiQI23+wIyYZlKH9CNuQ+Oq7f3gnuvXfO+9Zc=;
        b=G6sO8hhwIiletQugXfZX64T9kszaK5VjpwjTAs7igJPgmadrmEZWtms7H6IIZWYGN5
         CZTfHYNHhYLua5flBEFrf+4LmhtM6sxVXhNMF/ZJWHgHqxm2EP9PjL7VZXGIorspI4i/
         kECrEG6HQEnI9nQhGiHmoQ9ACzqfADau1w8td2yDzWfxY+zBDdZ1qILoyVL6bSj3wDWX
         FGMGAtiCJAdvdk8eKZwefv3/pOOR0V9fCcp76/UVqGXnBK6VhLzoRi4FvCl+8wfflP7a
         H+3k68Klkr/yt4gAs642/mqC+3ltfiGTox1L+o0zwPtEf2yQ4GKzANMfSYorXEeEI7/u
         CfuA==
X-Gm-Message-State: APjAAAUwUUSnpYvDqWlR/4cbjHQG3tef+mK2SqsrcE/MimUMymPfNI2+
        9JN79NJG7qLfJtRWtzjbfkdIlxH97XU=
X-Google-Smtp-Source: APXvYqz+LqjRy1o/ppaWxQn/eTk86FXtlxBaiZ0V0810iap5MK7cWBQhEZXisW1Oo6fRSQbtYHHDmg==
X-Received: by 2002:a37:434d:: with SMTP id q74mr24349502qka.177.1554745083157;
        Mon, 08 Apr 2019 10:38:03 -0700 (PDT)
Received: from [172.17.120.85] ([179.184.205.250])
        by smtp.gmail.com with ESMTPSA id n24sm20860887qtc.21.2019.04.08.10.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 10:38:02 -0700 (PDT)
Subject: Re: [PATCH] staging: gdm724x: Add parenthesis to Macro arguments
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lkcamp@lists.libreplanetbr.org, realwakka@gmail.com,
        straube.linux@gmail.com, hle@owl.eu.com, rico.schrage@gmail.com,
        sophie.matter@web.de, Valentin.Vidic@carnet.hr, simon@nikanor.nu,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <1554253445-28635-1-git-send-email-andredainez@gmail.com>
 <20190403042632.GA31130@kroah.com>
From:   Andre <andredainez@gmail.com>
Message-ID: <0d8cd5e0-71f0-6748-08a6-84c3477c874d@gmail.com>
Date:   Mon, 8 Apr 2019 14:37:58 -0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403042632.GA31130@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, thanks for replying.

On 03/04/2019 01:26, Greg KH wrote:
> On Tue, Apr 02, 2019 at 10:04:05PM -0300, Andre Dainez wrote:
>> Fix checkpatch errors:
>>
>> CHECK: Macro argument 'len' may be better as '(len)' to avoid precedence issues
>> CHECK: Macro argument 'nlh' may be better as '(nlh)' to avoid precedence issues
>>
>> Signed-off-by: Andre Dainez <andredainez@gmail.com>
>> ---
>>  drivers/staging/gdm724x/netlink_k.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/gdm724x/netlink_k.c b/drivers/staging/gdm724x/netlink_k.c
>> index 92440c3..36d88f4 100644
>> --- a/drivers/staging/gdm724x/netlink_k.c
>> +++ b/drivers/staging/gdm724x/netlink_k.c
>> @@ -19,8 +19,8 @@ static DEFINE_MUTEX(netlink_mutex);
>>  #define ND_NLMSG_SPACE(len)	(NLMSG_SPACE(len) + ND_IFINDEX_LEN)
>>  #define ND_NLMSG_DATA(nlh)	((void *)((char *)NLMSG_DATA(nlh) + \
>>  						  ND_IFINDEX_LEN))
>> -#define ND_NLMSG_S_LEN(len)	(len + ND_IFINDEX_LEN)
>> -#define ND_NLMSG_R_LEN(nlh)	(nlh->nlmsg_len - ND_IFINDEX_LEN)
>> +#define ND_NLMSG_S_LEN(len)	((len) + ND_IFINDEX_LEN)
> 
> This makes sense, but:
> 
>> +#define ND_NLMSG_R_LEN(nlh)	((nlh)->nlmsg_len - ND_IFINDEX_LEN)
> 
> That does not, correct?
> 
Could you please clarify why this doesn't make sense?
If, for some reason I calculate by hand the pointer address and call this macro like: 
ND_NLMSG_R_LEN(nlh + sizeof(*nlh)), 
then it would expand like nlh + sizeof(*nlh)->nlmsg_len - ND_IFINDEX_LEN
which looks wrong in my pov, no?

Please, let me know if I misunderstood anything.
Thanks

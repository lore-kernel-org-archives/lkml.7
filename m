Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47117C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 18:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D8B20830
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 18:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TH0/BoxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfCCShk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 13:37:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35873 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfCCShk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 13:37:40 -0500
Received: by mail-pg1-f196.google.com with SMTP id r124so1408760pgr.3;
        Sun, 03 Mar 2019 10:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aoPw5I3Ewbr9354P6/DT203SccE5DmMTt6TnPmIIGa8=;
        b=TH0/BoxBB4YSfmi0BMxLuSE9NC0mpUQ75cO0BDYJFgeKLEm2Nb9a1lRECDUOum5Aod
         tuHeuWCaQu1I67R/2nE0wVNpU7A3F0pefpHjeEDm5WO8ALu++LVjLyIVQh9NdDPsl/pa
         ydNYfqgIlc44y+wnp+fCQx1XrQRRGAmLwjLqTxLFhOEOqGNtRi8mwheJxsFsxJpss+ho
         YLEgXtxVUzPD9UT6XrY3+jA+jTi/3EyPHEKptEszUHFkAWU5RVdO97ENPsbE9CR2gsLV
         TC+2OPFFJI5hvMBJszvXtM710QRnwRGo+QEI+kHuebDHwgkaxmFqfaqrjm0uqHNFs5uV
         2G5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aoPw5I3Ewbr9354P6/DT203SccE5DmMTt6TnPmIIGa8=;
        b=YYoEs0kYH8uXuJhqTTfpGGlBj/xu/RnOplUbolEPcQ5SeBnS6RgezPoU3BVNz4Xuud
         rKTDM1zckOHAlFGU/22j9tXCbArkrxvMCriFbgsieYazssw66atD4UBNBZs0rTPbxudP
         NpbWPWWFBCr1pNXYsU8JZ8WAhA2vXggBVED1G6b+30FFifZo77+D3HIw8QqLoQNerqKQ
         lZRm7Ugl1++H6+hoZOLqDX+bSv2dD4qIWC/KetjSdeT2TH5rpN/qsIV3YZwqCKJFeW2y
         lIMOKzahqQWui4cvUKfJl2nGe+fUnWvccQD4GFxo/kCf8HvHWeDcVWx0vGD2FpYms7LW
         mWUA==
X-Gm-Message-State: APjAAAV5CkVrUeIZSGhUTrB9MBVOg3KZ0560EyVwdWnkDNgWA5ZmoEKd
        FIB4UlWfQfF5l7mA5rUly/8=
X-Google-Smtp-Source: APXvYqxtGRxfWlyVtt1MZ7o4+N14v8xXIb8fOmL5O1RpDfIII/6XRxNqsYbeioUQsU9NKZV+nXjSLg==
X-Received: by 2002:a65:4203:: with SMTP id c3mr15042914pgq.271.1551638259289;
        Sun, 03 Mar 2019 10:37:39 -0800 (PST)
Received: from [192.168.86.235] (c-73-241-150-70.hsd1.ca.comcast.net. [73.241.150.70])
        by smtp.gmail.com with ESMTPSA id b85sm10085693pfj.56.2019.03.03.10.37.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 10:37:38 -0800 (PST)
Subject: Re: [PATCH] aio: prevent the final fput() in the middle of vfs_poll()
 (Re: KASAN: use-after-free Read in unix_dgram_poll)
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     davem@davemloft.net, jbaron@akamai.com, kgraul@linux.ibm.com,
        ktkhai@virtuozzo.com, kyeongdon.kim@lge.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com, hch@lst.de
References: <000000000000f39c7b05832e0219@google.com>
 <20190303135502.GP2217@ZenIV.linux.org.uk>
 <20190303151846.GQ2217@ZenIV.linux.org.uk>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <dd9d445c-4adc-67a7-8957-01f38cb39a70@gmail.com>
Date:   Sun, 3 Mar 2019 10:37:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190303151846.GQ2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/03/2019 07:18 AM, Al Viro wrote:

> Fixes: bfe4037e722ec
> Cc: stable@vger.kernel.org
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/fs/aio.c b/fs/aio.c
> index 3083180a54c8..7e88bfabdac2 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1767,6 +1767,7 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
>  
>  	/* one for removal from waitqueue, one for this function */
>  	refcount_set(&aiocb->ki_refcnt, 2);
> +	get_file(req->file);
>  
>  	mask = vfs_poll(req->file, &apt.pt) & req->events;
>  	if (unlikely(!req->head)) {
> @@ -1793,6 +1794,7 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
>  	spin_unlock_irq(&ctx->ctx_lock);
>  
>  out:
> +	fput(req->file);
>  	if (unlikely(apt.error)) {
>  		fput(req->file);
>  		return apt.error;
> 

Very nice changelog Al, thanks for fixing this.

Reviewed-by: Eric Dumazet <edumazet@google.com>


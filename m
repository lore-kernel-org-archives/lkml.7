Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67044C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CC2218D0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="fDhLY4Eg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfDOQWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:22:33 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34898 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfDOQWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:22:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id t4so7738795ljc.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 09:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w+tDuZqaqdzYfTQNvruROpEVJ+Nl3iAAOw59oxXlT98=;
        b=fDhLY4EgNp0rEvmmWYIDwvSTz86PV622/ZbPx8Nydj/91f5ap9awAqU44vHpR/qsml
         +3fZbv8B9sGerxHheki0s0DY3o9I6mpMwznGOaATX+/Iw0G6FOdjJc5IEEDit8Q0TXVQ
         bbJqOLg1y8LaULIiClN43T9p4KcJC0GJOtwF0uWprg+fwrU2udXX4nY+EuhK18qIMvje
         Nt9HxfOXgyMFxeSmKXon+RmXKBvrN7WBCj8oSdJ8dgK5Sw4fLYwnGpOUkkmAdfvCK8qW
         wNLs497JhyVZhG8CdmclxLWuOz05lgn5YZg+T3SEqGpfCN6Sw8G4/5qKJ822yqiy0Pbd
         29xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=w+tDuZqaqdzYfTQNvruROpEVJ+Nl3iAAOw59oxXlT98=;
        b=UmCuHPVgqobH1Tmdc7JAW3pgXQE95gXNP19G5HnwHpBJLLMsMLj67KTXps2Pxnfa/q
         wMdIxYjoyxHf2uysMULUM25Qzh9OF3MqPG0F4VYUTcEaen/lL/l/VnreLqhO+xA2Yzsm
         XcfYxWIVVGVcoTa4HgqwOnc7j7TYYM0xzGCEm9IxgjO2wnfzDs0j+F8ERHjB3mwmpyKv
         gr48CwXz61d7MJ2/9iczMJZW0roPJESNCvicxPN3bB8rUYEeQ5FRv/005NtmtE3I30oO
         bDkCZJ9aQ0bE5XKg03Lr2Kmd9JIrqqo0YJ+5pW1iK1beuy07uq76/DxZ6nWcxVr9/7V4
         afHw==
X-Gm-Message-State: APjAAAWAzBsU73eRamqd4ne9QK+AlMNLQbm6q34Z6FkFoppHNwkgepJI
        /uXy14t6CaJS3g5qR7Jdn3TvDQ==
X-Google-Smtp-Source: APXvYqw47gKudrEWEzYdf9hRdvuBBSXHXF2Nhii39dT9CsXBYIOV46XriMlCbOVjdnpxCrDf45A+Kg==
X-Received: by 2002:a2e:8156:: with SMTP id t22mr19961789ljg.77.1555345351659;
        Mon, 15 Apr 2019 09:22:31 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.85.61])
        by smtp.gmail.com with ESMTPSA id b78sm2132187lfg.38.2019.04.15.09.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 09:22:30 -0700 (PDT)
Subject: Re: KASAN: use-after-free Read in dvb_usb_device_exit
To:     Oliver Neukum <oneukum@suse.com>,
        syzbot <syzbot+26ec41e9f788b3eba396@syzkaller.appspotmail.com>,
        andreyknvl@google.com, syzkaller-bugs@googlegroups.com,
        mchehab@kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org
References: <000000000000789d3d058653d9bb@google.com>
 <1555326745.13626.10.camel@suse.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <1e782001-7f5c-623e-f4c6-6e1e0fc90598@cogentembedded.com>
Date:   Mon, 15 Apr 2019 19:22:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1555326745.13626.10.camel@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 04/15/2019 02:12 PM, Oliver Neukum wrote:

[...]
> From d6097d205ac61745334b79639d3b8b910ae66c71 Mon Sep 17 00:00:00 2001
> From: Oliver Neukum <oneukum@suse.com>
> Date: Mon, 15 Apr 2019 13:06:01 +0200
> Subject: [PATCH] dvb: usb: fix use after free in dvb_usb_device_exit
> 
> dvb_usb_device_exit() frees and uses teh device name in that order

   s/teh/the/.

> Fix by storing the name in a buffer before freeing it
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> Reported-by: syzbot+26ec41e9f788b3eba396@syzkaller.appspotmail.com
> ---
>  drivers/media/usb/dvb-usb/dvb-usb-init.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
> index 99951e02a880..2e1670cc3903 100644
> --- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
> +++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
> @@ -288,13 +288,18 @@ void dvb_usb_device_exit(struct usb_interface *intf)
>  {
>  	struct dvb_usb_device *d = usb_get_intfdata(intf);
>  	const char *name = "generic DVB-USB module";
> +	char identifier[40];
>  
>  	usb_set_intfdata(intf, NULL);
>  	if (d != NULL && d->desc != NULL) {
>  		name = d->desc->name;
> +		memcpy(identifier, name, 39);
> +		identifier[39] = NULL;

   NULL is for pointers, no?

>  		dvb_usb_exit(d);
> +	} else {
> +		memcpy(identifier, name, 39);
>  	}
> -	info("%s successfully deinitialized and disconnected.", name);
> +	info("%s successfully deinitialized and disconnected.", identifier);
>  
>  }
>  EXPORT_SYMBOL(dvb_usb_device_exit);

MBR, Sergei

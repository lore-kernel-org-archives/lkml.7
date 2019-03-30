Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A89BC10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED563218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="so0L3sFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbfC3RSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 13:18:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45419 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730215AbfC3RSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 13:18:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id m16so4608799edd.12;
        Sat, 30 Mar 2019 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S8BG72Oo0tHX897kf8Kx9NqYQIQigjHsIA8Roy9YfVw=;
        b=so0L3sFtKtc3gkNjFmz8Z1YrT2fmAPUKnvzW/OpbV+fiTCwxGKW6RDwMVCspRjFOd2
         MKd9cBMgDcIEj0I6pACu6nPsK2rHHikJ4bZI5BJSkf8L3DNL77w9pAK1aCiF2WTZVcnr
         qAZV0CGRIciKYtBcDf8q3lSx/AlzN+OjiW9FrucEka4cYJYDrKqbDdO8TZJsPWEAqfEZ
         vgijki4GxblPF4WqR2LMu8a4rXWerNxk57Ezvm57wuaZQ1i7j/7KmD8/o/Ps6I0u6aFp
         /mHrZXHs6GUiZJVKiRcGkD1STLRnpaV0si9OryKuuuulaGYIJ0CMLhD+rcGjUtfjaeYu
         F1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S8BG72Oo0tHX897kf8Kx9NqYQIQigjHsIA8Roy9YfVw=;
        b=l4ruqe33UFqWykknOW7c5AdvxOLPB6nHYy++i786Rb9uAwdRVQbhi+nAZQxu4ji6Vy
         evx2jH08VHZF17oKLQ9h8XFrbRUXYnugu7naE97LYDTLV2+sdm5VQUUSsy0KPMl797J/
         D4Ck4y6/vF8F8Cay3yiLEzOt53YECbspyqTOwaq44O92SIfLmHXPmE3NEF0vIBmM40jD
         bGruWE2BGu3cYuWuuuDnC2ArA4fYR9prg1XGMpY3o7Pfa3VqlhcZ1UpDidU/lau5kTVZ
         no90DYax2YyuKPcUQaPnVRqp7Kzs95WJ0M0ZO0wFWmEJfOQapcFURpiKkXr8Ddn+q6ad
         9kCg==
X-Gm-Message-State: APjAAAVaZPXV3EPZM2S7hQs2TZhwjXaunic1q9I1CivNO+VSOTPGUsbQ
        1KEHkfUDYNSOt/IwHX7jvsI=
X-Google-Smtp-Source: APXvYqwpDgPk+vDRhNzxobWSo6pWjtVA942tnOcgxftiOGsBY4lGaJJnzaDMMK3dMMRBbpz6wtpHdQ==
X-Received: by 2002:a50:8850:: with SMTP id c16mr29446255edc.145.1553966321627;
        Sat, 30 Mar 2019 10:18:41 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id g41sm1659252edb.23.2019.03.30.10.18.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 30 Mar 2019 10:18:40 -0700 (PDT)
Date:   Sat, 30 Mar 2019 10:18:38 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4.9 25/30] USB: core: only clean up what we allocated
Message-ID: <20190330171838.GA2150@archlinux-ryzen>
References: <20190326042607.558087893@linuxfoundation.org>
 <20190326042608.413616958@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326042608.413616958@linuxfoundation.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 03:30:04PM +0900, Greg Kroah-Hartman wrote:
> 4.9-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> commit 32fd87b3bbf5f7a045546401dfe2894dbbf4d8c3 upstream.
> 
> When cleaning up the configurations, make sure we only free the number
> of configurations and interfaces that we could have allocated.
> 
> Reported-by: Andrey Konovalov <andreyknvl@google.com>
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  drivers/usb/core/config.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> --- a/drivers/usb/core/config.c
> +++ b/drivers/usb/core/config.c
> @@ -763,18 +763,21 @@ void usb_destroy_configuration(struct us
>  		return;
>  
>  	if (dev->rawdescriptors) {
> -		for (i = 0; i < dev->descriptor.bNumConfigurations; i++)
> +		for (i = 0; i < dev->descriptor.bNumConfigurations &&
> +				i < USB_MAXCONFIG; i++)
>  			kfree(dev->rawdescriptors[i]);
>  
>  		kfree(dev->rawdescriptors);
>  		dev->rawdescriptors = NULL;
>  	}
>  
> -	for (c = 0; c < dev->descriptor.bNumConfigurations; c++) {
> +	for (c = 0; c < dev->descriptor.bNumConfigurations &&
> +			c < USB_MAXCONFIG; c++) {
>  		struct usb_host_config *cf = &dev->config[c];
>  
>  		kfree(cf->string);
> -		for (i = 0; i < cf->desc.bNumInterfaces; i++) {
> +		for (i = 0; i < cf->desc.bNumInterfaces &&
> +				i < USB_MAXINTERFACES; i++) {
>  			if (cf->intf_cache[i])
>  				kref_put(&cf->intf_cache[i]->ref,
>  					  usb_release_interface_cache);
> 
> 

You reverted this upstream in commit cf4df407e0d7 ("Revert "USB: core:
only clean up what we allocated"") in favor of commit 48a4ff1c7bb5
("USB: core: prevent malicious bNumInterfaces overflow"), which has been
in this tree since 4.9.71.

Sorry for not catching this earlier,
Nathan

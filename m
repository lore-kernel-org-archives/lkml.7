Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B88C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698822087E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHM8cp4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbfICLh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:37:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46104 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbfICLh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:37:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so2747304pfg.13;
        Tue, 03 Sep 2019 04:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NVdJdOAmZ0hGRuynRqiYY+kOL59PW+u7NGSvQi3VwYs=;
        b=eHM8cp4ihsKGLyApe2LHYWhPFemeX8QNSzZr3hpo6gJWwTRjfG8ULLup/PcLmFz2L2
         T5KUwoZmaXL4Eke2nJFQs20/Wo6eJCBJ51es1m6Ovq5iWbRJw7j6EKqX29dqD1y2uKp2
         V89HpB+BNLwlyyearYVpGXdYM4qVUD0+i1h6+nez2rZ6dptyoQjf57FwzbOyRHHu9+yD
         hLw4f20VFxI3+Mvvo7VZxmNYXRqi117G3RnyGiP4eu+ZFCTjzvy48+FSouCOooq7lPGb
         jBNzSBE03TVmlhVf/4on95nCmSD5utEDQtksDhbYb+jVo/WtfG3c2vkyOrMryjycrpzV
         AuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NVdJdOAmZ0hGRuynRqiYY+kOL59PW+u7NGSvQi3VwYs=;
        b=B5a2BT+Lad+Nr7L1GmbH7M9wLTsq2k4IXnn1WqUNt/aPXepGco8IOpYBmTUmWasdJE
         lS8vEuC3GAOaoOuCMN4/AC2Fmgt/OQaLpqN42VBhZoOvFd9fTtAXf1nC+sLuWqvB6bmH
         uXCCUFzGKQpUU355CUi2g2nY605bWuCpFzl5SJe3LnkxfJXjCgHs5kW3EkUwCnxyoq17
         I2P69YzSBiCSeIichOOqK/4jtKFWW9aSutMjlfEgv7IneUcJ4AaWkYnD0C3UQnQUl13/
         2M4RTSXA2mWVRtk+ReipOaolL5kfxI6MP1RJ3wxQgxLJDILD4KxgzcAYKUd7x855tZyZ
         WgTQ==
X-Gm-Message-State: APjAAAVbqH0yxPfGwGBuQsD2OqPndUewZaA/Z8jWCaGBtuTDcEK23NnP
        UgLSGaFHfvZ1MtV/tUixZ+s=
X-Google-Smtp-Source: APXvYqx+X9ArMamcoRQOqiJM66DXertYbZ4q3mJOy2DsEFr1QLydMsyCEfW6yDu0kFkJoqUw9PHWnA==
X-Received: by 2002:a17:90a:9bc5:: with SMTP id b5mr4450619pjw.107.1567510675387;
        Tue, 03 Sep 2019 04:37:55 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k5sm12461188pfp.109.2019.09.03.04.37.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 04:37:54 -0700 (PDT)
Date:   Tue, 3 Sep 2019 04:37:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] usb/ohci-sm501: remove the HCD_DMA flag
Message-ID: <20190903113753.GA20198@roeck-us.net>
References: <20190903084615.19161-1-hch@lst.de>
 <20190903084615.19161-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903084615.19161-2-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 10:46:10AM +0200, Christoph Hellwig wrote:
> This driver doesn't support normal DMA, only direct access to its
> local memory.  Remove the HCD_DMA flag to properly express that fact.
> 
> Fixes: 1e4946c4412e ("usb: add a HCD_DMA flag instead of guestimating DMA capabilities")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>

on top of next-20190903.

Thanks!

Guenter

> ---
>  drivers/usb/host/ohci-sm501.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ohci-sm501.c b/drivers/usb/host/ohci-sm501.c
> index 0b2aea6e28d4..c158cda9e4b9 100644
> --- a/drivers/usb/host/ohci-sm501.c
> +++ b/drivers/usb/host/ohci-sm501.c
> @@ -49,7 +49,7 @@ static const struct hc_driver ohci_sm501_hc_driver = {
>  	 * generic hardware linkage
>  	 */
>  	.irq =			ohci_irq,
> -	.flags =		HCD_USB11 | HCD_DMA | HCD_MEMORY,
> +	.flags =		HCD_USB11 | HCD_MEMORY,
>  
>  	/*
>  	 * basic lifecycle operations
> -- 
> 2.20.1
> 

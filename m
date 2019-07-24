Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6CFC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBD521951
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0TNFbYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbfGXPeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:34:03 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45489 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387406AbfGXPeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:34:03 -0400
Received: by mail-ot1-f65.google.com with SMTP id x21so9830523otq.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 08:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kC1SodG6AXAv+phL30dSkAMKxwqUJv5qok3MpByxuQU=;
        b=k0TNFbYt4kAUF2AG/Ng4zQ6P9Hmp06hq7RAKEn3xis6hUgSp11B+nvpqv9QgGiGApw
         BDsXGZdhhXsl0oRHQSWt+MmdKpjOg0c7qr6vDh4RepUfaac10DK0QWRyxAy3TCwCHr38
         N29SUwPCEaxMug+JOEU1YUzfJUSVQtCRwkqDeJt4p3L7k8x8Apj8x4hPX9fkaVwj+8zZ
         EMCs2YitypLMpyL77m5obFLYpePtAqedrWmeO0SD1KnVN1zmOWpSbwyDXzSKK4hOpDAA
         6I1oVondHm4N6t6RWyZV62G/1NjMrm2+LsSK1KYcfyjeP2pErxrOEsf04DJWF8lGu2VB
         i/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=kC1SodG6AXAv+phL30dSkAMKxwqUJv5qok3MpByxuQU=;
        b=r3dtfqEjwF5kUFJrTP5sxKOIdtCED+Iebq/QkG8MXxN/2KsU9hJGxljVZFT4CKQnVF
         vxAK34qWrASpTenkKvtxOU4CIbkPd3Dq554NOnovdrtzH9KXnXkqKwUaAy6lniFOdVRw
         PpCtHSryO6MseMAZrca7EUUFVUFBaHn0RzXqPFxNLkOJw48xYcUctafyx3QTLdcGcktg
         InRhPsel4BnNG6Bq3a4HwECdl59plLr8VHG/n5e415MeACIBUlIxNDl6n/K9nAO0Y2nR
         WMW796zJsIBBjd7KwAm305sak6VR/KeoFByyR8B+WI/C1Klae27NGPFSSZvyaSSGKywM
         0m/w==
X-Gm-Message-State: APjAAAVdc+l0k8Ahluo8IfvORE7TUb0f/lBM1H8Cnt2Dw4ALWstmZH6X
        o6CMd6Yj5pMMAs/AdfJQnw==
X-Google-Smtp-Source: APXvYqyHwyMyPeS9rI1fczzg1zb5B0BF9CH7dQ/0eXtgYNNCQhsux4jVbZeix2qz8iR0N820Eh6NVA==
X-Received: by 2002:a9d:7843:: with SMTP id c3mr52928807otm.1.1563982442015;
        Wed, 24 Jul 2019 08:34:02 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
        by smtp.gmail.com with ESMTPSA id r130sm16500943oib.41.2019.07.24.08.34.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 08:34:01 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:2041:57e1:ec94:5f0c])
        by serve.minyard.net (Postfix) with ESMTPSA id E679B1800CD;
        Wed, 24 Jul 2019 15:34:00 +0000 (UTC)
Date:   Wed, 24 Jul 2019 10:33:59 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Asmaa Mnebhi <Asmaa@mellanox.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Fix uninitialized variable in ipmb_dev_int.c
Message-ID: <20190724153359.GJ3066@minyard.net>
Reply-To: minyard@acm.org
References: <cover.1563978634.git.Asmaa@mellanox.com>
 <84ef25695b2bfa5100803d5bb30e5d4152e336e0.1563978634.git.Asmaa@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ef25695b2bfa5100803d5bb30e5d4152e336e0.1563978634.git.Asmaa@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:36:42AM -0400, Asmaa Mnebhi wrote:
> Signed-off-by: Asmaa Mnebhi <Asmaa@mellanox.com>

The patch is, of course, fine, but you should add some info
about how it was found and a Reported-by: tag.

Thanks,

-corey

> ---
>  drivers/char/ipmi/ipmb_dev_int.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
> index 5720433..285e0b8 100644
> --- a/drivers/char/ipmi/ipmb_dev_int.c
> +++ b/drivers/char/ipmi/ipmb_dev_int.c
> @@ -76,7 +76,7 @@ static ssize_t ipmb_read(struct file *file, char __user *buf, size_t count,
>  	struct ipmb_dev *ipmb_dev = to_ipmb_dev(file);
>  	struct ipmb_request_elem *queue_elem;
>  	struct ipmb_msg msg;
> -	ssize_t ret;
> +	ssize_t ret = 0;
>  
>  	memset(&msg, 0, sizeof(msg));
>  
> -- 
> 2.1.2
> 

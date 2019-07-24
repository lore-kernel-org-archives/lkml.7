Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55307C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AC121873
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwW7PY9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfGXUxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:53:47 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44283 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfGXUxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:53:46 -0400
Received: by mail-ot1-f68.google.com with SMTP id b7so10835180otl.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 13:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cUrlJCZxaf4T1g+T4aXAfuhu96qkBIISRiC4UHQUVRA=;
        b=GwW7PY9zHQi+1BkAgJ7qamRMiNcpVCQSgg4YCkiJDIKYBuL+yGWVhbmEixhU2TomMq
         jGUMq6Vihfz2OnrC3chQQiaF2/jRfEmNTr7Xfm/fgFH9gkG3w3g13OUArRjZzP6HoKuv
         yJ98dXCQMz8rDLi9P+cq9TBlPGPV4Dt6PG/HPbIdUw3ZIree8zjL13aYgirlVyXfwXit
         j4V9k1WD5wUWarOxRNF95VZvCXTMXJrSXtNGOoUPBYNueWHQFyJ7W8plNd8TH0uuPjOT
         hzWh72y7tYYp1TYQlj9Y2P8VZKHJt2YaFQwZhyslMtJviKQVHWgMFVnUwJQuxy3rDG3t
         19nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=cUrlJCZxaf4T1g+T4aXAfuhu96qkBIISRiC4UHQUVRA=;
        b=JA3D1e5SE0hg4VjV07t1v4jKC0Kn+rKPmNPEHDfggo9G0pWF5HLpTVg6qR8o1kfRj2
         I8pb65W2fBRxvKvRTvzBQXawZH0oVQT42SP0O6KeXP6NdAo1Ikxs15ajrBrURlDwgyOt
         Haou//2+5PqmiHzDTFMxZ+QZy9aZf3zP+Ptq9eIj0ZNol12MzbJQ1ft4NwJs40L1sEAF
         PMrUaTzIIr06+/SARASia/Go1Z+CYuL4OqdWqxGtLPK/YrpEtHxdB5ZCvPCypyGsmAgf
         ZM/s0q9AEpy2Rr+4tUC1WXu5evd+sqntcUsweldnc8cRDaNv8bE5ybILgsiA3y+DhWqD
         bN9Q==
X-Gm-Message-State: APjAAAVDeVF6gkwclp7ZxY+rFOClGKjWdBLFAU8k+9jVuqIY9NYH9orZ
        JzueCIQ/+8kuAHc5YcNgig==
X-Google-Smtp-Source: APXvYqwd9Qe2p+++OO1/Bp30E4fCRhCgWvcVMezJv3qluHQkMLsqCmsmOf+JU7ItKP744UzmZt9QgA==
X-Received: by 2002:a9d:65cb:: with SMTP id z11mr24566566oth.325.1564001625547;
        Wed, 24 Jul 2019 13:53:45 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
        by smtp.gmail.com with ESMTPSA id u16sm15844649otk.46.2019.07.24.13.53.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 13:53:45 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:e55a:7d0e:c640:aed1])
        by serve.minyard.net (Postfix) with ESMTPSA id 885721800CD;
        Wed, 24 Jul 2019 20:53:44 +0000 (UTC)
Date:   Wed, 24 Jul 2019 15:53:43 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Asmaa Mnebhi <Asmaa@mellanox.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Fix uninitialized variable in ipmb_dev_int.c
Message-ID: <20190724205343.GB5134@minyard.net>
Reply-To: minyard@acm.org
References: <cover.1563996586.git.Asmaa@mellanox.com>
 <571dbb67cf58411d567953d9fb3739eb4789238b.1563996586.git.Asmaa@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <571dbb67cf58411d567953d9fb3739eb4789238b.1563996586.git.Asmaa@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 03:32:57PM -0400, Asmaa Mnebhi wrote:
> ret at line 112 of ipmb_dev_int.c is uninitialized which
> results in a warning during build regressions.
> This warning was found by build regression/improvement
> testing for v5.3-rc1.

Applied, thanks for sticking with it :).

-corey

> 
> Reported-by: build regression/improvement testing for v5.3-rc1.
> Fixes: 51bd6f291583 ("Add support for IPMB driver")
> Signed-off-by: Asmaa Mnebhi <Asmaa@mellanox.com>
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

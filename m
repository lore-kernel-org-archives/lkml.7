Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B8BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE3C218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEa2UdHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfCUM1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:27:48 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43552 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUM1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:27:48 -0400
Received: by mail-ot1-f66.google.com with SMTP id u15so5196356otq.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 05:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0p1FvBImb+gWXfnoAUoCXfqBM3fRtXDledSoyVkbgmA=;
        b=QEa2UdHHdTAPJt5q0tyh+pD38hLHL5575nm56VQyoXx0J3zm6pojtm7XHFoHSeZ4TD
         ZFQfX+bhZ5LphW3p4fAZ9WZjZjFtFJSggpF9oJs2+tc+qxprmJ04TqIO5rlP0qeGJd68
         uTnnz/7nhjnDnmy2IPurltR7m0789O6irqDPhRIZ0A80iC96Qhk9hnJ2Kf44ogXWCnnZ
         BOcMOzQl0cPExHzZsPoc5kK6nEFpQ6/DnL/nqZoegkUK5dxtqYH35HginBfFt5J2b3mG
         1en5vxjhsn8qo2/WHxWl5nToONAYfCtVkqHhlbH9XRzGqh0nggLjS+E3QkBjDJ4cDZVP
         0EdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=0p1FvBImb+gWXfnoAUoCXfqBM3fRtXDledSoyVkbgmA=;
        b=fpjbfbq9awTlZYXTHecWyhb5SzHisUuN0r8S7O8oM80C/Uz1cCo4/gTdiSEI7IoIc0
         4UZTt91eDqZE5syLLbdrBNARLGGxhSklgO/o/XRiN07D+Gc0BS6r5nIGYuJn5oevwc5L
         QtmG7NNg4HBmS+7TYDiIqgGHA+gQ6IMjd9L0izmbrXtLz8ZjYI3FZhBjiN51Gupfd07/
         qbdgEEHBIW16TJjqRyL+R/9YMFQDJ6ByMTEqn0waiW1VvSrHXc2fSFuiPtDwenQJwzME
         roxNliiTxNuUY7PFktDT+easzQgdteGjL7q1OQ+vbboVggeTMtQaV6OKC6KLStFKzkWr
         oZJA==
X-Gm-Message-State: APjAAAXEQTmEw1Pn5OXBXLLUPKvdpd5rqPQGmgDC8zhUzABjfykVM4I9
        HrQI8UOyPmrGCY/CJI9kfMt47lk=
X-Google-Smtp-Source: APXvYqyyM4+WTwg2tWoFQmZ9Xq5Qa0JD5VsOKv+tGhiT50krl5YqkpWUXEqiedyCnGHv88TPZzFQSQ==
X-Received: by 2002:a05:6830:168d:: with SMTP id k13mr2367676otr.106.1553171267455;
        Thu, 21 Mar 2019 05:27:47 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id s185sm1856697oif.30.2019.03.21.05.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 05:27:46 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:5540:db73:cff8:1c30])
        by serve.minyard.net (Postfix) with ESMTPSA id 1FE3618003A;
        Thu, 21 Mar 2019 12:27:46 +0000 (UTC)
Date:   Thu, 21 Mar 2019 07:27:44 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     cminyard@mvista.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net
Subject: Re: [PATCH -next] ipmi: Make ipmi_interfaces_srcu variable static
Message-ID: <20190321122744.GD2628@minyard.net>
Reply-To: minyard@acm.org
References: <20190320133505.21984-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320133505.21984-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 09:35:05PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warning:
> 
> drivers/char/ipmi/ipmi_msghandler.c:635:20: warning:
>  symbol 'ipmi_interfaces_srcu' was not declared. Should it be static?

Queued for Linux 5.1.   Thanks

-corey

> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index c35f2bc..7ebdde4 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -632,7 +632,7 @@ static DEFINE_MUTEX(ipmidriver_mutex);
>  
>  static LIST_HEAD(ipmi_interfaces);
>  static DEFINE_MUTEX(ipmi_interfaces_mutex);
> -struct srcu_struct ipmi_interfaces_srcu;
> +static struct srcu_struct ipmi_interfaces_srcu;
>  
>  /*
>   * List of watchers that want to know when smi's are added and deleted.
> -- 
> 2.7.0
> 
> 

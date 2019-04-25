Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A06C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31F5217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYFuhWVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfDYGn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:43:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40025 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfDYGn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:43:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id c207so10607919pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 23:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hEV4zb2t1dOvvRUSSbh/S4EEO3mZ2CR/OGrDCKkPlp8=;
        b=FYFuhWVevJ5Gqi3JM8HPeznwJ82nXG9phA/ifMW49uk/KhRGGpM8XB47G0kjdMySf2
         ShF2OVXuh6O31JXPpYl2sk6ZAmp5H5mK1yPdz6FTX0XqZ+kVMajAzwfgeMP0+keN+fen
         X0gsNMZtuYBe0tZKQ547KQJRGrc77YCHC8uvgxKqtDF40jKrDjEXtnH0DZFDRapa8jeu
         41EuAIIWZ6FszOwKdrALzdF+hyOMOGA+qrKunRP4wvbBhzFWAtyQ1qhc4OU/e3VgtJtO
         jDDOJQSmSNaGlKCtWo1tDI3MHgQIltVZS4P0/dwrx6SXb7X68TmbZeu2Y7ZgTPYTJY4i
         ld7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hEV4zb2t1dOvvRUSSbh/S4EEO3mZ2CR/OGrDCKkPlp8=;
        b=iYLOsbcASe/UDfmuI7BtlQ77nhFTm8sz3qX9yqIKhhyae6376ST4c99xo8+gLuSQrD
         V8HNwLL334eulq+YWeG3GxBHcflwyIbUWN4Z5/ZpqBB8UbubQMsGdsd0EtJaC4ran2BF
         Z+hn6A537AlPFGSXNSvV9aMj18KZPryXgChdul3HizujW1VjUViddwotUYLu98f+a4+F
         Tcebk6bnX0jdEVes9xC12mCAVZLW+Knc7sz/ImXBqIMjQ6AH3nbsz7XgSGFJDNAR05pa
         pHmECLFa1fek7ITZxS7HhzzyyPZiIUODrrol1ZdJ2DALNObtbULc7ygXrQM1LWdmT9D9
         H4sg==
X-Gm-Message-State: APjAAAXBhbfClBcbpHn99N/oJ2lHrxUS1FyXmEvRrQspaLB3+XSLFb6w
        LsUucFnmpuVRIiRdAXYjwGfDBnJ4
X-Google-Smtp-Source: APXvYqzfznDC6jqZUIxO/nGv+Dj7yibVjgbvOJ+C4LOe17lg741FbS4lBCzQeO8M3eW2AKtZr8jkQQ==
X-Received: by 2002:aa7:8019:: with SMTP id j25mr38889933pfi.77.1556174605629;
        Wed, 24 Apr 2019 23:43:25 -0700 (PDT)
Received: from localhost ([175.223.37.83])
        by smtp.gmail.com with ESMTPSA id 10sm28567023pfh.14.2019.04.24.23.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 23:43:24 -0700 (PDT)
Date:   Thu, 25 Apr 2019 15:43:21 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC][PATCH 1/2] printk: lock console_sem before we unregister
 boot consoles
Message-ID: <20190425064321.GA27270@jagdpanzerIV>
References: <20190423062511.1118-1-sergey.senozhatsky@gmail.com>
 <20190423062511.1118-2-sergey.senozhatsky@gmail.com>
 <20190424144924.lw5sgl7qa2yrpxsj@pathway.suse.cz>
 <20190425035233.GA8532@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425035233.GA8532@jagdpanzerIV>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/25/19 12:52), Sergey Senozhatsky wrote:
> > Could we remove it in this patch? It touches it indirectly anyway.
> 
> Sure we can.
> 
> We also can take extra care of pr_info("%sconsole [%s%d] enabled\n".
> Right now we do
> 
> 	...
> 	console_unlock();
> 	console_sysfs_notify();
> 
> 	pr_info("%sconsole [%s%d] enabled\n",....
> 
> 
> But we can simply move that pr_info() a bit up:
> 
> 	pr_info("%sconsole [%s%d] enabled\n",
> 	console_unlock();
> 	console_sysfs_notify();
> 
> 
> So the message will be printed on all consoles.

---

Petr, Steven, would you prefer to have it as two separate patches - one
removes the comment; the other one moves pr_info("console enabled") - or
as one patch? It's sort of trivial enough to be in just one patch, but
I also can submit it as separate changes.

	-ss

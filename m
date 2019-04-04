Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2D4C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B1F21741
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApkgcGsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfDDV0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:26:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40697 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730884AbfDDV0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:26:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id u9so1847368pgo.7;
        Thu, 04 Apr 2019 14:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J+tBd2LOthh1tbIM7s+shSf48RSgcGEzJTxaCVkYGgA=;
        b=ApkgcGsWtZXSo4UhfENJDD23O0nN/PWQWac/OsLqktzNHO+OJPfxD9FMLkCf93dDrq
         FCw6YiwEz8IBr5GUT7G9yhfdnv7rc8hA0k3lugqYa+OkfMT4GUd12gM+XZHwTbfjv06F
         yiCJBPoiEwyXlHlHrHmmFf/5+inAzaBdClin3PaqZkO9vvjV0z2PovaQKjGUdFyNbiID
         ROB0sTS310lBvYnjIB6SFxqe1lVRcA9zWbDY5J84/b7X7+QWnbKlDEqq/x511G1htKGF
         pPKVQDA12YOUBArDraija8lbgBOKGIDU0qz5eNpnm3XFif7klaKIVxQUDp4y83YCIzyc
         0A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=J+tBd2LOthh1tbIM7s+shSf48RSgcGEzJTxaCVkYGgA=;
        b=Ge4V9KWgY6IrdfV9z9fQ2Ho6P7j6JQrQsSQgSyevaxIqjZVPQv0/nqQzvCEEJXPkQy
         cKzpiQ6+yESBQ9S/JWPawLi9dWCuYXBOqDrk9QD/Pwz+uS+4zsNHBN8O9WudpaObHlvf
         wzcVe/8MrSAL/Ry65SeVUPGq/wOmhuKg3DtVzEDHg5UIEtRj14z98+sIymw1rTEdJPfS
         hFi4xiCnHvkBi7b3uMjlC9yGiRItfBlGsECBAhGi1i9uKf+TI1iK0BVSm6JN5xgDnkQ7
         jPGq2vrUSnUV8KV/h56X0tjwHTegNDEezxXwhW3PDyHBxeqV2mbSShLl4vV0BhqRZ/6s
         tB8g==
X-Gm-Message-State: APjAAAUubd6NPne/x8MzUke2wNW3XFs27yPs69qV+Uy+/bzv38XbnaIb
        pkjdPZtTNYGrZtKwclNJz+urVeJG
X-Google-Smtp-Source: APXvYqwtou4XN49WWsaNwyT7Gz5n5uF4iKHPFDLwAardJNdS0dRrrlsxNQPExz1o15KPfG/kOB/uyQ==
X-Received: by 2002:aa7:87c5:: with SMTP id i5mr1634961pfo.20.1554413180862;
        Thu, 04 Apr 2019 14:26:20 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u13sm43315971pfa.169.2019.04.04.14.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 14:26:19 -0700 (PDT)
Date:   Thu, 4 Apr 2019 14:26:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the hwmon-staging tree
Message-ID: <20190404212618.GA20949@roeck-us.net>
References: <20190405075438.12f98275@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405075438.12f98275@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 07:54:38AM +1100, Stephen Rothwell wrote:
> Hi Guenter,
> 
> In commit
> 
>   742ad88f0440 ("hwmon: (smsc47b397) Use request_muxed_region for Super-IO accesses")
> 
> Fixes tag
> 
>   Fixes: 8d5d45fb1468 ("I2C: Move hwmon drivers (2/3)")
> 
The original subject is "[PATCH] I2C: Move hwmon drivers (2/3)", and
I consider it quite pointless to include the "[PATCH] " prefix.
Same for the other tag.

Guenter

> has these problem(s):
> 
>   - Subject does not match target commit subject
>     Just use
> 	git log -1 --format='Fixes: %h (%s)'
> 
> In commit
> 
>   4d730440042d ("hwmon: (smsc47b397) Use request_muxed_region for Super-IO accesses")
> 
> Fixes tag
> 
>   Fixes: 8d5d45fb1468 ("I2C: Move hwmon drivers (2/3)")
> 
> has these problem(s):
> 
>   - Subject does not match target commit subject
>     Just use
> 	git log -1 --format='Fixes: %h (%s)'
> 
> In commit
> 
>   2f38d5d31508 ("hwmon: (f71805f) Use request_muxed_region for Super-IO accesses")
> 
> Fixes tag
> 
>   Fixes: e53004e20a58e ("hwmon: New f71805f driver")
> 
> has these problem(s):
> 
>   - Subject does not match target commit subject
>     Just use
> 	git log -1 --format='Fixes: %h (%s)'
> 
> -- 
> Cheers,
> Stephen Rothwell



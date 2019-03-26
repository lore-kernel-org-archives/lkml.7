Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F2BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D023206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ8GQd0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732488AbfCZRuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:50:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33733 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732459AbfCZRuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:50:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id bg8so1972858plb.0;
        Tue, 26 Mar 2019 10:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g5cLVKsmhSj3cHjdFhsQhLZZcs1RTkw/1bNs1y78Bpw=;
        b=fZ8GQd0/xefWvZNyP5guUZtSlv96kb0bt1podvpTHrcVGBvgNZG98hrH56fV9BDfzj
         08fJ6gSr2wZCzOlcjOlewK+8bHproxp9CupZLr+IC4Hg7oPrzVGMk3J8pm1OoIcRzkkP
         d2kdETqr6os75p9v1opR1ZuUUK4xi52Z09gizXz0N2fZJsPFkBe+HfcMLzGxguwkfQqm
         0przGkEFkf70Jvh8xAhhmYrqwaudaXlhMEbcu1Ofj6Xb6txEgDmq6+6m9sC5kfdeaE25
         Wglm64GtoaOqA+3fs4rxoxS0uLME/GBBx1tHmRmYpLuDbBcv+TJ0r3NXVJdhgbksKY2i
         ocag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=g5cLVKsmhSj3cHjdFhsQhLZZcs1RTkw/1bNs1y78Bpw=;
        b=CZi4jLuG9vd2wRjEYKLT11x3G6/V4UpYTj6nnMgIfF/5wl+X2cONr4we9uK/J4jbsf
         2AxEFf2HVvM7bu0S1QU+VI1eBOy3u1rhMC/Sr/ZOFIjpl5qJdKQry4bOR/hmDGIwydsz
         7QkyiD/O1CppX9k7DF/Gf1CgxoBMcOvA7NIpX1C+L8D1m2s/IgDZlGkIz6nc7OjBYRoy
         WmaBir2M37fZ6YPkaj46s7vtsY+rPPNAJLBXKlY9wsb2B420o979K9ygmUrXVeWr4g0G
         VE7I+ruB1v5bGHjMp1VUDnRDcfmZAG1CFHA9YRtVFMnKcQb0PM+uoZOPYoIC6B1RMpCi
         QyMw==
X-Gm-Message-State: APjAAAXJ59+tBzCaixxT+vGN7Ii8eEg2mrDOkbh8FEUhQGh8p41I+Rwo
        81BTVDPf7eAT2uY/yg74TK0=
X-Google-Smtp-Source: APXvYqyRK2dxbfCIVyFmiQm7+Fq4tnhnugmGvCaqUPWuFNic12wE3bj3rwMbqY9MSYqobCtLzbw7dw==
X-Received: by 2002:a17:902:ab95:: with SMTP id f21mr32659764plr.188.1553622613310;
        Tue, 26 Mar 2019 10:50:13 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r8sm26287153pfd.8.2019.03.26.10.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:50:12 -0700 (PDT)
Date:   Tue, 26 Mar 2019 10:50:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.0 00/52] 5.0.5-stable review
Message-ID: <20190326175011.GE9916@roeck-us.net>
References: <20190326042700.963224437@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 03:29:47PM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.0.5 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 28 04:26:38 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 345 pass: 345 fail: 0

Guenter

Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD9EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D85020821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOYAgHpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbfDPQbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:31:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42918 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbfDPQa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:30:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id w25so10653175pfi.9;
        Tue, 16 Apr 2019 09:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oh1uKcUerVQMCsF3PlK4PJkvV6dHAHcgWuEGGwXRJ70=;
        b=LOYAgHpYvtJ3RAoWfJy+6ZZGnnSaMOqebUOmXWm+oVx2DnEpvb/mkOD8Swhbf0xCwM
         31LdlJQCiQLMs/q3HBzxebdw0FxHSnUUjUzjgmqw82m2PF8wFkoJt6JkzOLCl225zE4z
         AWnmQWzOQGKAAT1wFxFkAICiJAcLsbGtKSzhIFc5Jxq6Mv5ceH78GlINFMdfghiMuMd1
         HdETOw73VQ9so0br0mKtxc1rljWW3pQiFf02FDdfqdyAmDnBC7EGpF+nvK9F/J0uRdd6
         rXTiZupsyjcE1l5PFnTGusLoG3Htl5QYut8/uNJ1x71D+oaJcVAeKZv5Tlep/b0jS7lW
         tMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oh1uKcUerVQMCsF3PlK4PJkvV6dHAHcgWuEGGwXRJ70=;
        b=LshU9FaNU8UhER62WolM3ksi+uiqxz3jhAAdTGlOQZ0bO24dJkJuDqBdDxBOnbspUW
         HwrcdCVNSJEaZWBh7sQz1ZRNjSw/mnLf/H/rsPnt6c/fJKViiDgTonQ1SKB22VGlpOPT
         gGXOLLJ8CsGLUggpOph2EQKyZJhXuUDzdN5Wid/K+6v+vQ/IbLGOebhaO9C1FEk7APVV
         B1pKFUE5YcmAr4viMHXqb6nv6EqK3CA549ixJFjVH5Il2XBaBiRvt4XRIvvV3E0q69kh
         uQNtOl/dD0NrBiPx2UxZ291JJb3U0fHVPLWx6RClDsuO2w85EC1Mv6g611vN5oepY00o
         1Wwg==
X-Gm-Message-State: APjAAAUsFMVbEbEk6fPp8Sp0j8r6jJZuLbN8uEupw+HH9y2CmwtEc3FB
        2sqNbPguHV1pTKI/JC0bAhY=
X-Google-Smtp-Source: APXvYqwxqAzh0J1ibQDlnvZRO+9MUm5zezxt0GRGf9tZSTxXx1RSs+v4AdyXpF/Cg5eyeeNoUdZzKw==
X-Received: by 2002:a63:618d:: with SMTP id v135mr77009513pgb.2.1555432258821;
        Tue, 16 Apr 2019 09:30:58 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d20sm78538439pfo.77.2019.04.16.09.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 09:30:58 -0700 (PDT)
Date:   Tue, 16 Apr 2019 09:30:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/101] 4.19.35-stable review
Message-ID: <20190416163057.GC22656@roeck-us.net>
References: <20190415183740.341577907@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 08:57:58PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.35 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Apr 17 18:36:40 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 349 pass: 349 fail: 0

Guenter

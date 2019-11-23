Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40EBC43141
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 00:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF1120714
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 00:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574470047;
	bh=NDLfC6M/Zw0ZBHpO3gtjyF4fjrfE6+o0S1b5iBvWXxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=08mR8URPh+PjV5UKzH8br165Bp4moWTtRGC/vrIQkg7+EJhK0b2r4V9PEd4CavXMn
	 oVJ5pAgw9Xs6frg6rVzydXIf3B0oEdPz2K+55HJsJYNxaZR+0ZGql2XFShe/XKzkGH
	 QDtQNt0Exy3lFVrMnC6LpKfHNU2pt8wphRFTy5zM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKWAr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 19:47:26 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40691 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKWAr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 19:47:26 -0500
Received: by mail-ot1-f66.google.com with SMTP id m15so7786935otq.7;
        Fri, 22 Nov 2019 16:47:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=brIYs3WpNwPNTYUASSCYgUmn21fXdgxiC4cL9+e/ZoU=;
        b=lJS0XmDrSSxnt9zFfqXO34rfEINyqbOAzI207zX61n7uYMuYxygohU7R/OyL0PgoR8
         0JN9GEYfZoFrVopyXB0lk+KVN6NFJ5p+vc2jXCXBSezoJy64RFaYwHUEzzqb2cMixNfK
         Yh3hJSCbDpcmzfphLoSPPxb5jhw1YOjDMNLCAQiX7Eht3n3i5zkc63g3K0Hvp8EDxSnO
         eGyZD3Qt2Iy6wLbyYxpKDNhI/MQHX3TzTULPii+8Uj/+kd/oaZiuH51E0LQAZybTqgSu
         Hdu1NiKVZtQHzHBIHhP08N4xJ1q1K4IeyVBBeeSXOq9CKo3JtHo7mdQGsUvwLpxh+JPm
         oHhw==
X-Gm-Message-State: APjAAAWVE0cJiaCNsoJkUGK/8R7/8IkMmJGYb2sRcsiqYNcjlsTzLQcy
        zduNioTb0/rRQ/pRuVvsNw==
X-Google-Smtp-Source: APXvYqw6tcGYWeMhNGOxHEWcIsKy6LxITdr43FYvOiWFOb9uG6Aw3huTBvnlV96BZiW0gQrBvZbOog==
X-Received: by 2002:a05:6830:1af7:: with SMTP id c23mr12315972otd.247.1574470044033;
        Fri, 22 Nov 2019 16:47:24 -0800 (PST)
Received: from localhost (ip-70-5-93-147.ftwttx.spcsdns.net. [70.5.93.147])
        by smtp.gmail.com with ESMTPSA id l12sm2751120oth.76.2019.11.22.16.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 16:47:23 -0800 (PST)
Date:   Fri, 22 Nov 2019 18:47:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        paulburton@kernel.org, paul.burton@mips.com,
        linus.walleij@linaro.org, paul@crapouillou.net, robh+dt@kernel.org,
        mark.rutland@arm.com, syq@debian.org
Subject: Re: [PATCH v3 3/4] dt-bindings: pinctrl: Add bindings for Ingenic
 X1830.
Message-ID: <20191123004722.GA24380@bogus>
References: <1574317183-126374-1-git-send-email-zhouyanjie@zoho.com>
 <1574317183-126374-4-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574317183-126374-4-git-send-email-zhouyanjie@zoho.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 14:19:42 +0800, Zhou Yanjie wrote:
> Add the pinctrl bindings for the X1830 Soc from Ingenic.
> 
> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
> ---
> 
> Notes:
>     v2:
>     New patch.
> 
> 	v2->v3:
>     No change.
> 
>  Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

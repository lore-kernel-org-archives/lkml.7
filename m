Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBA8FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998262054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571321358;
	bh=/h9dbzkvdA1m6MQMs1W/fY8AIQ80ER55q72Dv3Xdfxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eILVNTII1jGanuDnmScNP75YOa92M7zCeCbPWjj/H226EjmapsZV2/rgt6H/vA24i
	 dorj5aWc1lV+aKjNu1c8Nt00pvrGUFBqfg8jVS1PUTYKDmsgPwRBXEuDk5qhOjuDSQ
	 S8P2AL/KqM7m3+G6AJW25ziob83MLQZYyeyCHfho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439834AbfJQOJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:09:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46602 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfJQOJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:09:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id 89so1957179oth.13;
        Thu, 17 Oct 2019 07:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kXGnqFYJa8gxk84zjaw258zWcPW1sB63qQ3t9jdm74M=;
        b=LJK1wmj31xyIwxT0iBvFmuJiBcM46Sy8zCtl3RhUDD6q79Ji9kTbmUJJKiBGoNbGyT
         5Xj+jzsMktKO/SBhSyxF24i9On/xDvRGl0mVJDi01iqKZEMxr4k01H0It3dJjwP/LKHv
         Db9SKymLeiOvFXGr91c3gkw9e1ig+gKIIp8xGU6dA8golIsWoptAGR/VBTj2da3hAc1W
         oIa1khIfZ1GPDXKp7TSKM+H3inNgz/gLpkRlcIuNnBIpQXeQNaFXSVODvQfrkcO8PZeM
         eAOLDf7aG+Bvv7fjMmM1Pe2rRCrihxVWa6p3/QLunGsH3H0DVhCLvamQDDxMauRMZh5k
         L8gA==
X-Gm-Message-State: APjAAAWvnwUTcSGVHdjhmmRR76+M18uUyEbWZpxrjNFDYVofjny7D2O4
        4b+qGEKNO7w+r1Dh6ONXGw==
X-Google-Smtp-Source: APXvYqzLM9ovRh2qGOqpLD8UeBmHywdySl5GPPNx0DqB4KZyst3Sp7rp33P5TB0666e1K2JiAr8IvA==
X-Received: by 2002:a05:6830:1f09:: with SMTP id u9mr3421418otg.310.1571321356236;
        Thu, 17 Oct 2019 07:09:16 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 60sm644410oto.27.2019.10.17.07.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 07:09:15 -0700 (PDT)
Date:   Thu, 17 Oct 2019 09:09:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     bp@alien8.de, mchehab@kernel.org, mark.rutland@arm.com,
        james.morse@arm.com, robh+dt@kernel.org, frowand.list@gmail.com,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        linus.walleij@linaro.org, daniel@iogearbox.net,
        paulmck@linux.ibm.com, Sudeep.Holla@arm.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devicetree@vger.kernel.org, dwmw@amazon.co.uk, benh@amazon.com,
        ronenk@amazon.com, talel@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, hhhawa@amazon.com
Subject: Re: [PATCH v7 2/3] of: EXPORT_SYMBOL_GPL of_find_next_cache_node
Message-ID: <20191017140914.GA21404@bogus>
References: <20191015120927.10470-1-hhhawa@amazon.com>
 <20191015120927.10470-3-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015120927.10470-3-hhhawa@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2019 13:09:26 +0100, Hanna Hawa wrote:
> Make of_find_next_cache_node() available for modules.
> 
> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> ---
>  drivers/of/base.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

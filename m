Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18165C04A6B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 03:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C3C2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 03:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tc5H3RUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfENDoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 23:44:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40291 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfENDoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 23:44:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id u17so8325796pfn.7;
        Mon, 13 May 2019 20:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4AJ5FnGOloA2S0ZUrh+LfmZEkg3Ito65JuKeYd8vSCk=;
        b=tc5H3RUWRl+DI97hF26G2YLwqalEZwm4M8Rb7vEjlpzOoWfHamziXrEFJE51LBJhHA
         r+CZl/DaWceomjkF15SBj/IB35bPRzvsRDPcUIOhoVhTsGygS0djLn12Z3/eDz+8Kmf3
         p5riyCEhvEqAsUMISp4deXi6XTxVdzow+bPm7JMm04K8qQWYKPunS1CXQsWupFz47Grm
         UZtUF66d8EqJui6r5l+ZTW5LvRqFHpbt7zrwIL9GAx0D3qYnkfDP8srSv8nExQXfdvqu
         c79VB+I0hpp4m64ACghPQEzxbgAjXXC3pmFEyGpvX6FZU4YTKzwGd+XvEqcOiSNBa0We
         5lKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4AJ5FnGOloA2S0ZUrh+LfmZEkg3Ito65JuKeYd8vSCk=;
        b=gT1gaMHSrjWLQzItdN/pxzYFIKwdsDV63CNs1zUJJ3zXLMSgOu+mGlXaNTQMJPQ/gs
         fyma3/PkPP7UBY8r/5/PT6vZ8HZTE3CsH9y8JJ8EPvtC2G1QSVFF5adVhL6gMPST1S78
         s+OjLs8hUG6p1vB6EdQTg6856JLoKNBbl2NJW9k+H86Z04T8o3s1neDqBPPIjF1QQOia
         +c5Q+jl1HzJEu5Rxi7dZfVZl1mbAfx1emve1iUkm7zb0RH7nxMVoEGQX3fckQP+AQPX9
         4B8ePv0Zgf+IdgO+ICWm/CTSskxGCMRg3zdXMGpqo8WYTRCaOt10fuUEhkLGJ5B3URCc
         kkmg==
X-Gm-Message-State: APjAAAV0L/U/QtDXXVsFVNObzhsFnC+2hcFHktyzyfj4gsIBcnlC577o
        ELCA5NfenEyyNqvfKkpqghk=
X-Google-Smtp-Source: APXvYqwIN7nyhhYo96Tbej6Nh49GC9Rg54E3Bv4OXMYCryD/l1YJFDMaxY0MkL+l9gIL0yOfClN0gw==
X-Received: by 2002:a63:1866:: with SMTP id 38mr35642275pgy.123.1557805453868;
        Mon, 13 May 2019 20:44:13 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id r11sm28824406pgb.31.2019.05.13.20.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 20:44:13 -0700 (PDT)
Date:   Mon, 13 May 2019 20:44:11 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Talel Shenhar <talel@amazon.com>
Subject: Re: linux-next: manual merge of the thermal-soc tree with Linus' tree
Message-ID: <20190514034409.GA5691@localhost.localdomain>
References: <20190513104928.0265b40f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513104928.0265b40f@canb.auug.org.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

On Mon, May 13, 2019 at 10:49:28AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the thermal-soc tree got a conflict in:
> 
>   MAINTAINERS
> 
> between commit:
> 
>   f23afd75fc99 ("RDMA/efa: Add driver to Kconfig/Makefile")
> 
> from Linus' tree and commit:
> 
>   7e34eb7dd067 ("thermal: Introduce Amazon's Annapurna Labs Thermal Driver")
> 
> from the thermal-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks for spotting this. I am re-doing the branch based off v5.1-rc7,
where the last conflict went in with my current queue.

> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc MAINTAINERS
> index 2ff031b5e620,7defe065470d..000000000000
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@@ -745,15 -744,12 +745,21 @@@ S:	Supporte
>   F:	Documentation/networking/device_drivers/amazon/ena.txt
>   F:	drivers/net/ethernet/amazon/
>   
> + AMAZON ANNAPURNA LABS THERMAL MMIO DRIVER
> + M:	Talel Shenhar <talel@amazon.com>
> + S:	Maintained
> + F:	Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
> + F:	drivers/thermal/thermal_mmio.c
> + 
>  +AMAZON RDMA EFA DRIVER
>  +M:	Gal Pressman <galpress@amazon.com>
>  +R:	Yossi Leybovich <sleybo@amazon.com>
>  +L:	linux-rdma@vger.kernel.org
>  +Q:	https://patchwork.kernel.org/project/linux-rdma/list/
>  +S:	Supported
>  +F:	drivers/infiniband/hw/efa/
>  +F:	include/uapi/rdma/efa-abi.h
>  +
>   AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER
>   M:	Tom Lendacky <thomas.lendacky@amd.com>
>   M:	Gary Hook <gary.hook@amd.com>



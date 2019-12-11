Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EC8C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CD0214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576075223;
	bh=qxSM7j8YWMNBv+etg8vjUZxp/0iLoNv+DuxrIYqvrvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fk2dOnB3QpHB1UuMrsrFd+GuuIg8I4lhCnKsIwHEemq7eajklBivpcXsIfJdDW7uH
	 IRO/N+hbw81QAnBL2CtNkdKmhLt6hf6G6aL8hKjMIevLpesGhurUq/gTwhwnmEmkAh
	 DhEXBTYXBX0ayePEL/vY6fGkFIm8oedMAEIeDqCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfLKOkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:40:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40856 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729829AbfLKOkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:40:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so7212347wmi.5;
        Wed, 11 Dec 2019 06:40:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6LV1fwVOyA4k6YB/7k6OFVrgJLqJ3K+42hjVJ8NocJk=;
        b=NTj1/R3FZHjfx6woRfFzMJyY4UniShJESW7YwqEMB1nw3Qi6sl20Bhto3EeipxXSNb
         vVtSsjfE6AzgVEpMDKK18JDp7I2vciEgZel2zM+f5e35YRZqZPL1VbsQBMDyErJ1HvsM
         FvPAzRmXB42abqyxFjtNh/gdGNF0R/fUx9TIXbP7Cbe3hguB2wZzGW5zgESQACnOQJ7p
         D9Zp6nVjRWkAX0At/AmoEZCIq60KBNrPvk7ERJB+sPpL2Li5VB3GXMut++GkJUr/94tH
         WSIJS7YR1Rpy3YIQOyRKXetlmGwkHNSfW8/nXeTxnDx8NavD7bg1gceylRandwOdTeGZ
         IO6A==
X-Gm-Message-State: APjAAAWg6bWsatMolsayehuPOraCVyA5xd6vhqyV7mNcRyMpuVItnQmA
        QcpEx1hkLlJvIuWuX95qiag=
X-Google-Smtp-Source: APXvYqwy5+56DBmRmzDDxsDEqO4nVMY1hhpPtbXGeA9ujbnffW2eerK2zHxCYwCg5ZzGAUu1VGoGHA==
X-Received: by 2002:a7b:c761:: with SMTP id x1mr113004wmk.37.1576075220183;
        Wed, 11 Dec 2019 06:40:20 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id f207sm2029578wme.9.2019.12.11.06.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 06:40:19 -0800 (PST)
Date:   Wed, 11 Dec 2019 15:40:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        cl@linux.com, gregkh@linuxfoundation.org, mgalbraith@suse.de,
        torvalds@linux-foundation.org, umgwanakikbuti@gmail.com,
        wagi@monom.org, stable-commits@vger.kernel.org,
        "Wangkefeng (Maro)" <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>
Subject: Re: Patch "mm, vmstat: make quiet_vmstat lighter" has been added to
 the 4.4-stable tree
Message-ID: <20191211144018.GG14655@dhcp22.suse.cz>
References: <156442332854185@kroah.com>
 <e4bd396a-1a10-1387-aa3f-4d61d31ab7b6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4bd396a-1a10-1387-aa3f-4d61d31ab7b6@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-12-19 22:32:49, zhangyi (F) wrote:
> Hi, all
> 
> We find a performance degradation under lmbench af_unix[1] test case after
> mergeing this patch on my x86 qemu 4.4 machine. The test result is basically
> stable for each teses.
> 
> Host machine: CPU: Intel(R) Xeon(R) CPU E5-2690 v3
>               CPU(s): 48
>               MEM: 193047 MB
> 
> Guest machine:  CPU: QEMU Virtual CPU version 2.5+
>                 CPU(s): 8
>                 MEM: 26065 MB

Does the same happen on the bare metal? Also what are the numbers for
the current vanilla kernel?
-- 
Michal Hocko
SUSE Labs

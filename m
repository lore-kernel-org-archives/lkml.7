Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006AFC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B853120880
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="E9q+sY+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfDGWkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 18:40:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37894 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfDGWkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 18:40:19 -0400
Received: by mail-lf1-f66.google.com with SMTP id u24so1115116lfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 15:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X8EXZ5qThMOjV9sV+VwAPmZrIaIEEM/RLUZkQY7UG3Y=;
        b=E9q+sY+ckQRg0z64ps4J4JwXm8OnD2dIoVw3BnumhU/vZYUjYJAMT0kZkHQuLenZj1
         FEnp4s3qJ+wnbf7060Xb91cLB9hy0PXrYu94a8FWbh2eX7SrRVD63MTEwNrkXp0Nlh66
         IoKtK5+5PHC6Tj5lctWhaJbB7w0j+sYlm9mIJLOXXl3IES3t1HEGDmAigdBDSzFm1YCd
         gJTItPVgH6hMo5BM9VY7N91K0oSXuucT553YxvLoNYPC01bnTC8Ku3XQgcYAxQ2sY54f
         7buQrFu7DQOQEGD3PB3MFGKPaW26I6FoG6aoMFwuqpJBnvLMXNVc3bJFV/JO9ecTtEPo
         PpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X8EXZ5qThMOjV9sV+VwAPmZrIaIEEM/RLUZkQY7UG3Y=;
        b=VUtcWzTWeMS2gWBz8B4wqQnnZqIjz9S04/YkT/cBjeQlQSGSsx/JOcFH6x7om+62zt
         fdZmmHGK8yfhQbm4ueWKOpYIvycy4Qkx1r9exbY4RsE76RJ1JdwOFuf3XXSKfOcIqtAt
         8MUVbvpoKdzc5WOjPQchT/ZUTWbHt0gRORorIJceFx4uV6b6iDFq/jnAxkTO2KlDCRWk
         pBBN4CKToZ7wQVfkGJaIGSAftGkGMyqWBDimQ1nWk0/7my/mL8hPvA7+ybtdeEE+zqau
         rRQFw0jDk28i3NFxVD7NrjrEXuNCWLOVKCUq62NJceRZHl6I+EDvOl1PnBDkBbWSo8jA
         yrjg==
X-Gm-Message-State: APjAAAVhwOUzqxCE+FGg0NcFDzbmcU45e5R0K+mj6IiJEz+sqUlVZUx3
        s9++FZL9EAaodS1sKx/EPkBeZA==
X-Google-Smtp-Source: APXvYqyzH49NRv/VY0QqqnWo3vzDVqcQhmmZmwI+N4cjR6EgIhWUiwCsjk12AgGeOrzOW8cMK7ubUw==
X-Received: by 2002:a19:740e:: with SMTP id v14mr14140188lfe.94.1554676817389;
        Sun, 07 Apr 2019 15:40:17 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id k90sm6082482ljb.89.2019.04.07.15.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 15:40:15 -0700 (PDT)
Date:   Sun, 7 Apr 2019 15:30:13 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     arm@kernel.org, Sugaya Taichi <sugaya.taichi@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: milbeaut: fix build with !CONFIG_HOTPLUG_CPU
Message-ID: <20190407223013.2h7ac44l24g2dike@localhost>
References: <20190313211935.646291-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313211935.646291-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 10:19:16PM +0100, Arnd Bergmann wrote:
> When HOTPLUG_CPU is disabled, some fields in the smp operations
> are not available or needed:
> 
> arch/arm/mach-milbeaut/platsmp.c:90:3: error: field designator 'cpu_die' does not refer to any field in type
>       'struct smp_operations'
>         .cpu_die                = m10v_cpu_die,
>          ^
> arch/arm/mach-milbeaut/platsmp.c:91:3: error: field designator 'cpu_kill' does not refer to any field in type
>       'struct smp_operations'
>         .cpu_kill               = m10v_cpu_kill,
>          ^
> 
> Hide them in an #ifdef like the other platforms do.
> 
> Fixes: 9fb29c734f9e ("ARM: milbeaut: Add basic support for Milbeaut m10v SoC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to fixes.


-Olof

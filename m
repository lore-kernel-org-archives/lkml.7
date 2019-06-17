Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FEAC31E59
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D85E21783
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="V3NslvGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfFQMAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:00:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45955 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfFQMAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:00:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so8979171lje.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 05:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/4EVEgl+d9IAA6s9s2TyM1gIRSoJRqPoVDCIFRTbu78=;
        b=V3NslvGXYtPstb6cR7cI/7KvbhwlAyfZCL0XVFFiJEzqkBstGj0r/qIZy4T25I9M8q
         JFt9PDkYXDksNP0gzDm3rOZ7tA1JtO1N/TeLbQlNLh045eexqJdnMryTs2pX9iAbcbq+
         z3LkZZdYgPobPuJT6fXK9PDtqGenYyfza2k+t0zNPWB4HzCXiii3XtseN73Y+uoJZXrM
         8S4ayQ6wuWedxgLq7nVm/zVwlRREKxosSnrUwtkcozFrV/RFeKofnkXpjBn4AKqGioLy
         EENss3lKzEsrg+mO01+7YSWAg9HCKkAy8z3xAU1/8W+NpE6X2rUBvaq6zp36wJpYk7RF
         X74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/4EVEgl+d9IAA6s9s2TyM1gIRSoJRqPoVDCIFRTbu78=;
        b=VgDCMZ9Akzbh2qs8yf2vG5XxZf5YPL4sKt45e0wQA5+hA724PzI3MABwZGnu4ndfo8
         C7KNm+jySHhdcwRj/+MBP1T0e5YkIRRJCFdMg2il/i7BIlpFe8+kjbEN6NV84oc2LCIy
         wDttcYQa9GclOidAvXKi/3/KxYBHPyjcjlKdcoyHc4hioyJ+YvbqSJfmxWgEFqOs9Nik
         E/v+XZ1lpXayEDznyOcA4qm2NWzUDhaQ8TIT/5HdyTdXjphC8SreYGKEjov34LjANtVq
         94OypkAw0M7h/afsuACwnwqLyq1yHQJg/uBL19+8Vdz8+gIL8PBHxLOZU/7vyqHEOaZO
         f2mQ==
X-Gm-Message-State: APjAAAXm4FhfGcYgl0nNoMosr87k/dK0l8FImjyHYLBX2Bbe2fenEGug
        qFa/dsTabtGXtLBzFWvqHH3DiQ==
X-Google-Smtp-Source: APXvYqzuPx51tnyeSykGoFxsmtaV7c9ny2FNFyxPBpLCPtgJqNBbTgwYFEMJuuwdI9q3Xzi9ilaOCg==
X-Received: by 2002:a2e:6545:: with SMTP id z66mr60107089ljb.146.1560772849565;
        Mon, 17 Jun 2019 05:00:49 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id j7sm2327947lji.27.2019.06.17.05.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 05:00:48 -0700 (PDT)
Date:   Mon, 17 Jun 2019 04:45:50 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>
Subject: Re: [RESEND PATCH 0/2] memory: move jedec_ddr_data.c and jedec_ddr.h
 to drivers/memory/
Message-ID: <20190617114550.77fikzakfxl4vqkc@localhost>
References: <20190603081233.17394-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603081233.17394-1-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 05:12:31PM +0900, Masahiro Yamada wrote:
> 
> I believe this is a nice clean-up of directory path.
> 
> include/memory/ has existed just for containing one header,
> and it is gone now.
> 
> There is no sub-system that takes care of drivers/memory/.
> I sent this series some time ago, but I did not get any feedback.
> 
> I am resending it to ARM-SOC ML.
> I hope Arnd or Olof will take a look at this.
> 
> 
> 
> Masahiro Yamada (2):
>   memory: move jedec_ddr_data.c from lib/ to drivers/memory/
>   memory: move jedec_ddr.h from include/memory to drivers/memory/
> 
>  drivers/memory/Kconfig                   | 8 ++++++++
>  drivers/memory/Makefile                  | 1 +
>  drivers/memory/emif.c                    | 3 ++-
>  {include => drivers}/memory/jedec_ddr.h  | 6 +++---
>  {lib => drivers/memory}/jedec_ddr_data.c | 5 +++--
>  drivers/memory/of_memory.c               | 3 ++-
>  lib/Kconfig                              | 8 --------
>  lib/Makefile                             | 2 --
>  8 files changed, 19 insertions(+), 17 deletions(-)
>  rename {include => drivers}/memory/jedec_ddr.h (97%)
>  rename {lib => drivers/memory}/jedec_ddr_data.c (98%)

Applied to drivers branch for 5.3. Thanks!


-Olof

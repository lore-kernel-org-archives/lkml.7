Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA47C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F5A20862
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574879318;
	bh=5oX0FiUSQGnkWCJrSH09o4sapdc832qarXbxHDBMYHY=;
	h=Date:From:To:CC:CC:CC:Subject:References:In-Reply-To:List-ID:
	 From;
	b=DzW5zYpSweZ+V3qiqxzRcS6ySpR8DCMP/J2mZEiVUZ40m/sCnlMjzHX0ClJL3nlGs
	 TEs2zqf7t5JHsfYgmt8IbpQe3i9/I9x4fh6+YlsYZkC/q8/L/mAp8293WxU1BuGAyx
	 bioWsdm3VztpQOcZSCBWnToDRjVNzATBnWBND9E8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfK0S2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:28:37 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34362 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0S2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:28:36 -0500
Received: by mail-pf1-f194.google.com with SMTP id n13so11458201pff.1;
        Wed, 27 Nov 2019 10:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:cc:cc:subject
         :references:in-reply-to;
        bh=KOBCAZS4o7TUQypcItA7+Hw4tKp1By3WtACFLdGuVac=;
        b=TpZ6X5NBslm9Q6vrpYlCXwCKSSXhiB1inw23pOG+/XOE0uRp1vElX3FID1TShiGRYf
         zdzckBtyvEJaGWSCwxMopQA9kRdyRrd8x6WMKOwRzuLh6lYPyD7UPyYBM6sSh8RTARm3
         kGTVNIPwUNDzP6Ceq5YdcFyQkyw6/VysCbqdBMJFZW/QJXyQl2WAImgUlEa/vdKlKgjB
         1DM2uHE/jHEJXKQWAPi36xyumNrv/RtbDiKIa4EMNAgmo69TR8KdKCg6CZxeyXorDS72
         eypYn+Hr9Gud1QmT21P+TKXoKE3E4kB9l6dBhRBoFgT3o7WP9KsS8NRVOIbdUUk1siKu
         Lkvw==
X-Gm-Message-State: APjAAAXm2u45rKb0ewyPVOGMXDH9rLortliL6/fE52Dq/ZeIKLsreX4h
        +5bT+DpSZRPnYOP+5aIWxHoHvlmq/LfUvA==
X-Google-Smtp-Source: APXvYqzrL9p9+x5Jl0fbMn4IDHc1hvuJvolaUecks1Cdmr20A0wUkVeP9uDm/ffwOKDGNJujoEqEqA==
X-Received: by 2002:aa7:8207:: with SMTP id k7mr50129037pfi.130.1574879315814;
        Wed, 27 Nov 2019 10:28:35 -0800 (PST)
Received: from localhost (MIPS-TECHNO.ear1.SanJose1.Level3.net. [4.15.122.74])
        by smtp.gmail.com with ESMTPSA id a3sm17107426pgh.91.2019.11.27.10.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 10:28:35 -0800 (PST)
Message-ID: <5ddec053.1c69fb81.8dd5b.e232@mx.google.com>
Date:   Wed, 27 Nov 2019 10:28:34 -0800
From:   Paul Burton <paulburton@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Paul Burton <paulburton@kernel.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
CC:     linux-mips@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix boot on Fuloong2 systems
References:  <20191127152612.21945-1-linux@roeck-us.net>
In-Reply-To:  <20191127152612.21945-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Guenter Roeck wrote:
> Commit 268a2d60013049 ("MIPS: Loongson64: Rename CPU TYPES") changed
> Kconfig symbols as follows:
> 	CPU_LOONGSON2 to CPU_LOONGSON2EF
> 	CPU_LOONGSON3 to CPU_LOONGSON64
> 	SYS_HAS_CPU_LOONGSON3 to SYS_HAS_CPU_LOONGSON64
> 
> It did not touch SYS_HAS_CPU_LOONGSON2E or SYS_HAS_CPU_LOONGSON2F.
> However, the patch changed a conditional from
> 
>  #if defined(CONFIG_SYS_HAS_CPU_LOONGSON2E) || \
>      defined(CONFIG_SYS_HAS_CPU_LOONGSON2F)
> 
> to
> 
>  #if defined(CONFIG_SYS_HAS_CPU_LOONGSON2EF)
> 
> SYS_HAS_CPU_LOONGSON2EF does not exist, resulting in boot failures
> with the qemu fulong2e emulation. Revert to the original code.

Applied to mips-fixes.

> commit 87f67cc4c7b8
> https://git.kernel.org/mips/c/87f67cc4c7b8
> 
> Fixes: 268a2d60013049 ("MIPS: Loongson64: Rename CPU TYPES")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Paul Burton <paulburton@kernel.org>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paulburton@kernel.org to report it. ]

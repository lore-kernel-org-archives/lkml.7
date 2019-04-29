Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CEFC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683322147A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="a7CUGp7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfD2Gzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 02:55:52 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42985 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfD2Gzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 02:55:50 -0400
Received: by mail-lf1-f68.google.com with SMTP id w23so6948431lfc.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 23:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Itypzg7jfUS2m0bdkut55783K6r9kms23kfOAhHmrZo=;
        b=a7CUGp7Ijy2wOvMx0I5N5nxzJ1rM0JGv5zI8yDPixJ2yRC/S+JQKCtTYDi0dha/4Md
         as9nawwRvUmWiMeQrW7UrYddXhDnnIOc6pdn2pmiAo/wF7Ow7aq8W5XhKb4LC83mE4HW
         L4ANcUaBvL4NCB8sUlW+obsZFbcLbaFtn4BQKMkHOR3LhVtzXbCo/y1W+0yq4/3HXqPW
         zhewyA+GlGTgGahc12zMiUrH4bKqYqYgUwxuEzQTQNG5ojYrvs8jjG7SWgJBHZXNXFs4
         aOYBx0Lx4FbzwC9eZy2cFoP9p1HivffbZnGEU7YrJfgo9FKdowVCmfcbHf5YKx3iLImI
         MSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Itypzg7jfUS2m0bdkut55783K6r9kms23kfOAhHmrZo=;
        b=lqsQQJTArJIj8KsLaHn4M5Z79OAR+DFn3t7gerKnQEuQZQh+U1BpP/IzXJQ3Z8bti4
         SutRebSfaEg1colHFzk0Ev8CrhxT3e2SCCuCwIO1+CokfofRXn4/kx1tUry4Y4KjmF0Z
         BLsE/RwjvgA6zbbNVUBAGO3Ip+Kx4SR0nuX56xyiLzQVo6e74LnA9TAXbP3mXv1S0uQf
         6qisuZpu2EAIlpGKO7EPeHs6w98G5PDRQDdjraXRojKxKf+JXMWVLhw8d8Jy4DNYopdR
         MBboXY5V+13ocE/4u8dbsRSH07qVJGicYkEp4YTTKklAaU9jOY/WgJCehaZxgLxqySuc
         ehZw==
X-Gm-Message-State: APjAAAVQsbNZ6G1HsHRmU1uIdqNxzeMuwyG88Kfigdrfd/gY8EEGY6U4
        hEfXfT+LaQjxwa6cdPXqD3G4sQ==
X-Google-Smtp-Source: APXvYqxY0m8o16v8TB+xLLFKL0O+IXTwf7rKZmb7YFTmFHToB13IDZnCVmnoKSP218wBTNckGNO0MA==
X-Received: by 2002:ac2:4a86:: with SMTP id l6mr30635614lfp.51.1556520948853;
        Sun, 28 Apr 2019 23:55:48 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id o12sm7042529lfl.66.2019.04.28.23.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 23:55:47 -0700 (PDT)
Date:   Sun, 28 Apr 2019 23:21:01 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     arm@kernel.org, Baruch Siach <baruch@tkos.co.il>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: debug-ll: add default address for digicolor
Message-ID: <20190429062101.txcoy3vup4jhw6eq@localhost>
References: <20190417151348.100050-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417151348.100050-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 05:13:27PM +0200, Arnd Bergmann wrote:
> The digicolor platform has three UARTs, but the Kconfig.debug
> file explicitly lists port zero as the one to be used for the
> console, while not providing any default values.
> 
> This can get an automated randconfig build stuck in a loop
> waiting for the user to input the number. As we already know
> the physical address, this patch provides that number as
> default, along with a reasonable default value for the virtual
> address.
> 
> Cc: Baruch Siach <baruch@tkos.co.il>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks!


-Olof

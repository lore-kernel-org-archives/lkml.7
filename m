Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113B9C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47F027862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CJiFdJrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfFCQFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:05:54 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46012 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbfFCQFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:05:54 -0400
Received: by mail-qt1-f196.google.com with SMTP id j19so6296795qtr.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 09:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9HiIovokzOYphw8IOYOQGLxzeS88agF96fM/nChgZT4=;
        b=CJiFdJrbD+cbmaYt9NoRnbWU46TlHs/rIasuzCXAC2ST66ULpZedGMfHxjy0rN1kGD
         qapjOsceVjypRME8Y3H9gFYa0pF0CKx/bLn3LOADFIupF+rmfxld9V9Ryvq0fL+qvX8P
         OAG53Q0lvIftSEJZ96Goym3zw2Qbs8WjUB2CCE5lwCP8Kqx8GcRH4ohHu+KqC2dqtQRO
         TeNZNfkJHIr+GOdqwWanYOcrSgi5zf9ZbSw2wEPRRoOUXzoMu0ksT594upJ6UL93Gsgj
         XeQ2nt2Tole1H3aaHz3kcM8bh6b5QT/73Wo9keSs/HIaMx1HLIjfUJuDRRi0D5tuJfqj
         J/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9HiIovokzOYphw8IOYOQGLxzeS88agF96fM/nChgZT4=;
        b=N0TiQYPK+3H4yUD6GEOZDN9Noo4Nyf0SJOHD6qr5p2He4CnyTemvA7RwPk34JGSip6
         9NxyMm4sZ8FwAMPdxfwAYO403hY/Pd45oORWT3SaMXdK7GV8CuNCDuZYS6vD1ikKnDUf
         eH+PgqQB4l6+DCwh+SujCZE19hjBvS2qik+W1O4aUdyEjOVftBQVOQzFiO9ace1uIIzq
         dknGLWE1DlYA91i2XURSFUsEQWRyFINlexVDT3LBPLck5HtPoHhNQdrZFVJrHDDjwQfT
         rUxscsIwBM/3tDH3JflmeINJg5aqnk0JERucbn7nesLKcWJSwIpWIQUWftAjpqT/mFYG
         uPIA==
X-Gm-Message-State: APjAAAXkS3AG5NR+zmPvUgEU9qmH2YC5+/2xvgz6NUrutNEAnj9/wvW2
        NNrIy8XeLc8SJn6sWRn8MiHCRw==
X-Google-Smtp-Source: APXvYqymChUmF/O60pHUin/O4Kk1XIV7XclnszRykg8S4CkA4sZaezgQfOsJoCq9uU9XsIwPJ7aC5g==
X-Received: by 2002:ac8:2cbc:: with SMTP id 57mr23098627qtw.222.1559577953439;
        Mon, 03 Jun 2019 09:05:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 102sm8429304qte.52.2019.06.03.09.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 09:05:52 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hXpT6-0005LA-8I; Mon, 03 Jun 2019 13:05:52 -0300
Date:   Mon, 3 Jun 2019 13:05:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [RFC PATCH 16/57] net: hns_roce: Use bus_find_device_by_fwnode
 helper
Message-ID: <20190603160552.GB11474@ziepe.ca>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-17-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559577023-558-17-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 04:49:42PM +0100, Suzuki K Poulose wrote:
> Switch to using the bus_find_device_by_fwnode helper
> 
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Acked-by: Jason Gunthorpe <jgg@mellanox.com>

Jason

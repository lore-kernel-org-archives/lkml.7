Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C971BC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7C22070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JhjAtp9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKVUVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:21:33 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34787 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfKVUVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 15:21:33 -0500
Received: by mail-qk1-f195.google.com with SMTP id b188so7462471qkg.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 12:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZJNST5spgJ+9+0zEr716mDrZrSEXVq6warPi8NwZbrs=;
        b=JhjAtp9Hhcee9dePtJRpLRpEX/HZaH15EcThHJwgzedX9w3iqvQW1XlNZs9lmKnMB5
         YHYRCtAhRXlYs+eaY/ppkhvKUDTXiE8JMKdVfpRw1/pEP9gch35FrKHITd/Z2d10XqkZ
         lmRigj1GfsO+Njc212aBszSd9MJNmFB0E+XQwbOHM4YwkVTBK29vpHgqJOqrwDdBQtsp
         6mwjwjiQtOiT5cPg8djKRQscdB1JKUiC/ubhBGKQfx34lMK/UVG1paKgZzCpk6izxgnX
         ikNa4k+s/6pQodVJh3YK88nJk3YSVSr2RkrK7ws34RT+Sl3hMBC8ARskMN9jFT1LEudO
         ma5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZJNST5spgJ+9+0zEr716mDrZrSEXVq6warPi8NwZbrs=;
        b=acJI+HPwBJ5mImbxkIJWhLCoDuuCg2/NiTgMgMuyH3Q150wsjIMbAgK6KFSu7JlkBf
         X0+MwY6kuyV3KyTnjBMZvUegXna0SJt2ajSD9DQNygTwl8TAp7s3BoorFlzSzHCJczXz
         MJEVYQ7OOcWAoBPe4cdSWV1awrSzDAUCItTxNDo0kq8UMkIKRN94J7Tifp0m6Dq0iYK3
         JDexlA+mKd7NcxZO2dJitWkLZBWdMjXlGr1S+LTJSt3FEZTd3LU1Ok6nR1Nhn4SOgaUy
         uIgtlospUQ52U9ObFu3HBDpp0PM9RLJVKupGDGw9eRxIRmIyPTr9YDle9ZZzVYi5jgg6
         S4Pg==
X-Gm-Message-State: APjAAAXpRz3zPrebnPwLICSHQD6zEEcRWFx8lHLrf04glawu/7WzpKpD
        UZlNKrWysewjEpth+ROg0b6Jyg==
X-Google-Smtp-Source: APXvYqxrPOvst0p298a7SIdNeCNXyIrt9qTv1oLj3gIr0rfw32Pl2OLk5QHxmI1OaJ4/l7n/eDJ7vg==
X-Received: by 2002:a37:7dc2:: with SMTP id y185mr4828809qkc.380.1574454092120;
        Fri, 22 Nov 2019 12:21:32 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id h37sm4083006qth.78.2019.11.22.12.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Nov 2019 12:21:28 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iYFQm-0000J6-Do; Fri, 22 Nov 2019 16:21:28 -0400
Date:   Fri, 22 Nov 2019 16:21:28 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] infiniband: Fix Kconfig indentation
Message-ID: <20191122202128.GA905@ziepe.ca>
References: <20191120134138.15245-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120134138.15245-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 09:41:38PM +0800, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/infiniband/hw/bnxt_re/Kconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied to for-next, thanks

Jason

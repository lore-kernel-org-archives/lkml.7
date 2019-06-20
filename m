Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83909C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586362084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HjU6/VsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbfFTPCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:02:19 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36041 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfFTPCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:02:19 -0400
Received: by mail-qt1-f196.google.com with SMTP id p15so3512346qtl.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 08:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LAmn0cqH4e72se7Q8G77z4kg+TBm3Zco/JpAJhHU5p0=;
        b=HjU6/VsM0KB/eiFddTY4G73EtF0wkPxc45dCBFALXB1aDrp7J/EZ28r/aC0D6MJ4v1
         5GbvVt4Fr4ufnUQUKluhoRRc5FT9fByNdINpkPRIjxWEEw8CPQbQd2cLSot/pwWjwHwd
         TDWwFzB4kLvy3XURKj9vXCAINfI3uBzFBn80p7LrCaitVz5PVpXrqlG5mCDg9vb4eaMg
         cRMD5aRRxXhfgdnAQqr5JY52mP+kRTo1jxJDTcWQi/TYRRRG61Y7xwOEFFB4zI0TKL/D
         noQEfYhRw/A2W/doc5ESujoy+wIklIBl+vv+hPExyIYvWT9EDwMSIHb8Ubc/2R6hg6KN
         F65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LAmn0cqH4e72se7Q8G77z4kg+TBm3Zco/JpAJhHU5p0=;
        b=g5EMyW6VOuLKaT9rB3kvc4TMT43m78lo99KXWcx+D/3BSZH0V1vkYUxDP7fL46IeF9
         bBQzXF0HtEdAjjOKGyT5qox6Ip+pEsQLGnmI3MBBOhpPFlXdyUu3Qx7qbkQR9UVj4Bkz
         YfLlUA7gmCSBxmhJJlXRcKUVpcNa8ezxgfKEfQZeNBMtKqVn2BjAOrjBNIYqTaHBP1dj
         JZmj1scuC4dqKKyi2yrVXnYRw8oyeoUQ7kdSQkKseyDF0Gs8OLKdNFtnwemDXLH998Ne
         jVHCj+3Zexu/+7tAI+MTKGJput0oaF79f0yWsnYOxq0Y9H3u1kHpZIBq2+EFQNPA38h/
         Zkqw==
X-Gm-Message-State: APjAAAUdqm3ZVagL5+osfyzB/5nZ6CczYIz6xoLpnbQIMHjXBhwecXIW
        S3zfOQMJlIT3JAUM5Ed6DptVPQ==
X-Google-Smtp-Source: APXvYqxm++fo1z3dN/3lnL7+x6ZfDiibahHp1txVIF2lDJNMIEgYUqEk6cEvG67c//h2loN0iLxAmw==
X-Received: by 2002:a0c:88a6:: with SMTP id 35mr9514994qvn.84.1561042938687;
        Thu, 20 Jun 2019 08:02:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id m4sm10510647qka.70.2019.06.20.08.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 08:02:17 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdyZt-0006OH-D4; Thu, 20 Jun 2019 12:02:17 -0300
Date:   Thu, 20 Jun 2019 12:02:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] RDMA: check for null return from call to
 ib_get_client_data
Message-ID: <20190620150217.GA19891@ziepe.ca>
References: <20190620135052.27367-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620135052.27367-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 02:50:52PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The return from ib_get_client_data can potentially be null, so add a null
> check on umad_dev and return -ENODEV in this unlikely case to avoid any
> null pointer deferences.

It would be a kernel bug if NULL is seen here.

Jason

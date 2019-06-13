Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F1DC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43D52173C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aWHGarpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfFMXqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 19:46:35 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33010 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFMXqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 19:46:35 -0400
Received: by mail-qt1-f194.google.com with SMTP id x2so516376qtr.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 16:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RgGAoG+EFMf//zammLV8SqiSMpUtRnVhf4DpaWCHX7A=;
        b=aWHGarpo0tIrRJnnHEvfX6dOp85DZ2yAXbWe98Gl1NCJG5FiDSUppC2+dI5ER7jYgw
         YsSgypAots/APmu4ggVN84azOxccssTNrejU4vMPnfIV1Yqcu8wgKKPXFGobIaPurl/c
         xtuA/tj/hPbjC7MKqxXRiA9dj8SNCLGjpJ51hSk7eI+7XeOqvTqtigoa5wCj964W53iz
         SY8ML6JU8pDFx8ASD0vTDJaxQUD+h3IpnITBK3xHeGW3cDRUV/sgMaTqZIi8ZikIlfG+
         Tl+RmI7ogX0qqxEJBSXZEENiSiYWVj3HxH9InOyRnOvAm0+DCx0VORB/VOkCv1xWMEtr
         L55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RgGAoG+EFMf//zammLV8SqiSMpUtRnVhf4DpaWCHX7A=;
        b=WAuVGfMRP14ZqC9wob4kgmGf88nsvtkfUagsEL+x+GfkRel6cGHvVou/BVzxlA+L59
         xVcvS0d0cnuql8m0rKcg6GgVtnpisnDKkRyy+Qcs0lsLE8WyOqCfyaBBeKjtGixufxE3
         PmYmY5e+QTh2N6JYYndyc1NL6BvvvjkSczTq5g7u2CCBskNlLijRSczr8hMfldjuFmTm
         +WV2eQJY1x6n7aCW6skvqLrB4HOLdsa0ehjbB4KqXQfXSwHqjI7A92Db+2q4b/odhPPz
         qRnEyeFBZ5lPIfCVlaaEJodnZd/p0GOUMQb/gsObaA9KCKl/Evnrm+/FTPqAI3iVB39K
         fF1w==
X-Gm-Message-State: APjAAAVy04pdAtfGH9gtSe9b0P+5qHOfxRtaypkHNinuU/Qwl4VNZb9h
        hkJCUwf3cMeBzcYQhByfi/vnJw==
X-Google-Smtp-Source: APXvYqy7v1SfVM+n642iOXecf/vv6RGRIGojTHovJbES5LjY20ZFEYPiWrYrOlaii9/jkMsM9sJAHg==
X-Received: by 2002:a0c:a902:: with SMTP id y2mr5720330qva.42.1560469594029;
        Thu, 13 Jun 2019 16:46:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h40sm996749qth.4.2019.06.13.16.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 16:46:33 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbZQP-0001A4-11; Thu, 13 Jun 2019 20:46:33 -0300
Date:   Thu, 13 Jun 2019 20:46:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/cma: Make CM response timeout and # CM retries
 configurable
Message-ID: <20190613234633.GL22901@ziepe.ca>
References: <20190226075722.1692315-1-haakon.bugge@oracle.com>
 <174ccd37a9ffa05d0c7c03fe80ff7170a9270824.camel@redhat.com>
 <67B4F337-4C3A-4193-B1EF-42FD4765CBB7@oracle.com>
 <20190613172355.GF22901@ziepe.ca>
 <1D8E6B14-3336-42B3-B572-596DD2183D89@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1D8E6B14-3336-42B3-B572-596DD2183D89@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 07:39:24PM +0200, Håkon Bugge wrote:
> 
> 
> > On 13 Jun 2019, at 19:23, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Thu, Jun 13, 2019 at 06:58:30PM +0200, Håkon Bugge wrote:
> > 
> >> If you refer to the backlog parameter in rdma_listen(), I cannot see
> >> it being used at all for IB.
> >> 
> >> For CX-3, which is paravirtualized wrt. MAD packets, it is the proxy
> >> UD receive queue length for the PF driver that can be construed as a
> >> backlog. 
> > 
> > No, in IB you can drop UD packets if your RQ is full - so the proxy RQ
> > is really part of the overall RQ on QP1.
> > 
> > The backlog starts once packets are taken off the RQ and begin the
> > connection accept processing.
> 
> Do think we say the same thing. If, incoming REQ processing is
> severly delayed, the backlog is #entries in the QP1 receive queue in
> the PF. I can call rdma_listen() with a backlog of a zillion, but it
> will not help.

backlog and queue depth are different things, we shouldn't confuse
them together..

Jason

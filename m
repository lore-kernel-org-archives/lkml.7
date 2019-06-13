Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDC0C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B47217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mT3F8J6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfFMRX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:23:57 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44461 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbfFMRX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 13:23:57 -0400
Received: by mail-qk1-f196.google.com with SMTP id p144so1144254qke.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 10:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GtpmeeTFCKpP6HQrilI3kSYLuVspQkmTP/uXeNzDQjo=;
        b=mT3F8J6NfzNTEEhWSzulXpOJYe2i9a0RuYZvLuz89rToDUw0iEhW0InNtPGdnBkhEK
         a+fiz8/aGS3ScKPNTOnoa0O0W9uViAdjElZYNdW8hJ20W86p4yu5MHDIwLYNA+3NZFlE
         GWNAlGdtPHRDhR7qREYLPpVVnpoR+1+ZhlssyM9eVdLnXX3y7kTm4BczGnYMLnfHl5w9
         OOGeasLQVks3ncSG3fiA0BebO5QmTQCYiJqfzK2Bo5DAZNiq4C+96flUcbb7TS89+dEx
         sK70TNR+KyjjryqnWboE0bAIloRYVP/5IZf7v0CT5LhsIhplTS5AQ0j0+4Vt8hh1bY+c
         bp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GtpmeeTFCKpP6HQrilI3kSYLuVspQkmTP/uXeNzDQjo=;
        b=KvmA8Qhn5ZXVETn8DrnE7S6h4JYez9R5hERkiQzxoa1Ph7enQeV1jOanyioWjTb/dy
         3zdON/dkz9/anqo0WMWv7KNdY/FJRvQezrPi6O4d69blbgmyrzILj4zjF2MU1Qn4n/75
         oxZvnHq78/aAfMUNEP0MxeyyB+12VgqjSovBwdsV0TBJLaRIFPrZmtfNwqtIrexP9U1E
         Q6xNoxigrK8hKa0+awnAwQ6NFGehJBeBMVrm8HiQ9rrTiOJMTAex5Lm8yZcrQpnCu7Dq
         xueR+a8lkTfSf4WZrJUFFvgjp3xRrdSR73j25uMRy2gAZQQjUIR0BjN2fS0f2xy9tfKK
         l61Q==
X-Gm-Message-State: APjAAAUkmrfrARGbNAkmUOAroUiQSsaByEmY7Gdz7tMT1x1OWdLRFWVK
        NtXrxGsnMsDyuvpqFuKT8fdf+A==
X-Google-Smtp-Source: APXvYqzLKXkhxqXNZBleEounkqFk8bLp5EAxXSPu8B/UrrQMyawGw3NOTt9zo5Plivrl2Y2xtYnMkA==
X-Received: by 2002:a05:620a:124f:: with SMTP id a15mr72445088qkl.173.1560446636313;
        Thu, 13 Jun 2019 10:23:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id c4sm98515qkd.24.2019.06.13.10.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 10:23:55 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbTS7-00034X-97; Thu, 13 Jun 2019 14:23:55 -0300
Date:   Thu, 13 Jun 2019 14:23:55 -0300
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
Message-ID: <20190613172355.GF22901@ziepe.ca>
References: <20190226075722.1692315-1-haakon.bugge@oracle.com>
 <174ccd37a9ffa05d0c7c03fe80ff7170a9270824.camel@redhat.com>
 <67B4F337-4C3A-4193-B1EF-42FD4765CBB7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67B4F337-4C3A-4193-B1EF-42FD4765CBB7@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 06:58:30PM +0200, Håkon Bugge wrote:

> If you refer to the backlog parameter in rdma_listen(), I cannot see
> it being used at all for IB.
> 
> For CX-3, which is paravirtualized wrt. MAD packets, it is the proxy
> UD receive queue length for the PF driver that can be construed as a
> backlog. 

No, in IB you can drop UD packets if your RQ is full - so the proxy RQ
is really part of the overall RQ on QP1.

The backlog starts once packets are taken off the RQ and begin the
connection accept processing.

> Customer configures #VMs and different workload may lead to way
> different number of CM connections. The proxying of MAD packet
> through the PF driver has a finite packet rate. With 64 VMs, 10.000
> QPs on each, all going down due to a switch failing or similar, you
> have 640.000 DREQs to be sent, and with the finite packet rate of MA
> packets through the PF, this takes more than the current CM
> timeout. And then you re-transmit and increase the burden of the PF
> proxying.

I feel like the performance of all this proxying is too low to support
such a large work load :(

Can it be improved?

Jason

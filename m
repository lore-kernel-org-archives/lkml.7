Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBB8C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C0E24679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihoUWUnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfLSMA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:00:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37125 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726712AbfLSMA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:00:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576756826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G9ICZdw8d/Cy5yfs9thcebSbyLAgCLlMcpKJwHMxudo=;
        b=ihoUWUnz0XrymbcJNSYdCLDTxPRGfdD1shbxgUGMx1iBix8ZgEkYFi6RkotCiO9a3NoPZD
        JImz6X4vZeItG9vSJ1scT26YrNnt3nJAs8azXQtA8rq/UMySAsdWXGp7v/VrhWZmA14guI
        86cmNkyLRsU3izEADXU45mKSsMKknZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-76UIkLS3MkOts9zWSA2hgg-1; Thu, 19 Dec 2019 07:00:22 -0500
X-MC-Unique: 76UIkLS3MkOts9zWSA2hgg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B272B477;
        Thu, 19 Dec 2019 12:00:20 +0000 (UTC)
Received: from carbon (ovpn-200-37.brq.redhat.com [10.40.200.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 921325D9E2;
        Thu, 19 Dec 2019 12:00:15 +0000 (UTC)
Date:   Thu, 19 Dec 2019 13:00:13 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     "Li,Rongqing" <lirongqing@baidu.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linyunsheng@huawei.com" <linyunsheng@huawei.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        brouer@redhat.com
Subject: Re: [net-next v4 PATCH] page_pool: handle page recycle for
 NUMA_NO_NODE condition
Message-ID: <20191219130013.7707683f@carbon>
In-Reply-To: <7d1d07c680b6411aada4840edaff3b12@baidu.com>
References: <20191218084437.6db92d32@carbon>
        <157665609556.170047.13435503155369210509.stgit@firesoul>
        <7d1d07c680b6411aada4840edaff3b12@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019 14:27:13 +0000
"Li,Rongqing" <lirongqing@baidu.com> wrote:

> seem it can not handle the in-flight pages if remove the check node
> id from pool_page_reusable?

I don't follow.
I do think this patch handle in-flight pages, as they have to travel
back-through the ptr_ring.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer


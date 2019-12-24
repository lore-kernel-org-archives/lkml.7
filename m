Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A43C2D0D0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 01:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56611206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 01:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DgjRBNM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfLXBBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 20:01:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26226 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726833AbfLXBBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 20:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577149279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wKGwxLX/FCIOtXSJBKDi/gZqjDBYqgyappeRbRNyA3o=;
        b=DgjRBNM0rsx17Lljsn1xuwOrdB2/cMQXqHaHvwnISxr0L7l2WMwWHGVlE9PWkyGm2UAbxr
        zKF4CLju8Dl9GapXhxT0q+UmJQ19J8Nz+cEhFCyCVFtVfltsu+iRcPyCaTtRd3t3tZ53fz
        kSg7SQI7QyuDXR4bF4pPvOiJzcmMH5Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-mx3ilqxiPhK1T0Kv8DrPaQ-1; Mon, 23 Dec 2019 20:01:12 -0500
X-MC-Unique: mx3ilqxiPhK1T0Kv8DrPaQ-1
Received: by mail-wr1-f70.google.com with SMTP id l20so1716501wrc.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 17:01:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wKGwxLX/FCIOtXSJBKDi/gZqjDBYqgyappeRbRNyA3o=;
        b=CoNRuU8XJFXXVFwmDRpTvKbSBLA0PT6KNdcYHJNoseQZQwVsbsv/Dj24d8GlEpzTVV
         CH36t2JEHRfvj0oo+6fgij0vQiwhH0rgE4GQeu/pl9VktxO1bmzdYGH2Cit81o713/mD
         s+4ds30smWv98tWoHR3TO7uZg+O60oYXdQjHrwGyEWLoAzYP/qxfa4iQxdNrM0lb0txk
         wWwVRpYFgotVdS7BaRuh21fc7VPq8OPK0cdMtG2yHB389mSspDt7ue1X1tHXORdPMgLJ
         v0og1A6rExeqdRpD43T8o1jnAZtd3yKloEDxlx/owXGaT/xx8VmtZ7ccdmV9azY6LKRW
         bmuA==
X-Gm-Message-State: APjAAAXnSXC7lqPbJFRpc8cic5fWkNIsWhZCjKh+0++CAG2TcCaePPSX
        EH6qtlb0y6+FA4lX7seTWS7NUsVLD5yVCu5e85KG+YVgzTOTh7J3D5OWaFpwuyca8LVHbvy4wYT
        3CoNx1Z5DMqhGXwyBNMj6Ehvv
X-Received: by 2002:a1c:a949:: with SMTP id s70mr1259558wme.69.1577149271650;
        Mon, 23 Dec 2019 17:01:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxLJho4Amg3V4idDnN+Jv3dMGQ/eq1KBwy2KoNXgtJ84RpjLjduJdXL7MDCC5i9GKS893LNmQ==
X-Received: by 2002:a1c:a949:: with SMTP id s70mr1259530wme.69.1577149271423;
        Mon, 23 Dec 2019 17:01:11 -0800 (PST)
Received: from mcroce-redhat.homenet.telecomitalia.it (host213-32-dynamic.19-79-r.retail.telecomitalia.it. [79.19.32.213])
        by smtp.gmail.com with ESMTPSA id e18sm22330532wrw.70.2019.12.23.17.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 17:01:10 -0800 (PST)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Tomislav Tomasic <tomislav.tomasic@sartura.hr>,
        Marcin Wojtas <mw@semihalf.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: [RFC net-next 0/2] mvpp2: page_pool support
Date:   Tue, 24 Dec 2019 02:01:01 +0100
Message-Id: <20191224010103.56407-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches change the memory allocator of mvpp2 from the frag allocator to
the page_pool API. This change is needed to add later XDP support to mvpp2.

The reason I send it as RFC is that with this changeset, mvpp2 performs much
more slower. This is the tc drop rate measured with a single flow:

stock net-next with frag allocator:
rx: 900.7 Mbps 1877 Kpps

this patchset with page_pool:
rx: 423.5 Mbps 882.3 Kpps

This is the perf top when receiving traffic:

  27.68%  [kernel]            [k] __page_pool_clean_page
   9.79%  [kernel]            [k] get_page_from_freelist
   7.18%  [kernel]            [k] free_unref_page
   4.64%  [kernel]            [k] build_skb
   4.63%  [kernel]            [k] __netif_receive_skb_core
   3.83%  [mvpp2]             [k] mvpp2_poll
   3.64%  [kernel]            [k] eth_type_trans
   3.61%  [kernel]            [k] kmem_cache_free
   3.03%  [kernel]            [k] kmem_cache_alloc
   2.76%  [kernel]            [k] dev_gro_receive
   2.69%  [mvpp2]             [k] mvpp2_bm_pool_put
   2.68%  [kernel]            [k] page_frag_free
   1.83%  [kernel]            [k] inet_gro_receive
   1.74%  [kernel]            [k] page_pool_alloc_pages
   1.70%  [kernel]            [k] __build_skb
   1.47%  [kernel]            [k] __alloc_pages_nodemask
   1.36%  [mvpp2]             [k] mvpp2_buf_alloc.isra.0
   1.29%  [kernel]            [k] tcf_action_exec

I tried Ilias patches for page_pool recycling, I get an improvement
to ~1100, but I'm still far than the original allocator.

Any idea on why I get such bad numbers?

Another reason to send it as RFC is that I'm not fully convinced on how to
use the page_pool given the HW limitation of the BM.

The driver currently uses, for every CPU, a page_pool for short packets and
another for long ones. The driver also has 4 rx queue per port, so every
RXQ #1 will share the short and long page pools of CPU #1.

This means that for every RX queue I call xdp_rxq_info_reg_mem_model() twice,
on two different page_pool, can this be a problem?

As usual, ideas are welcome.

Matteo Croce (2):
  mvpp2: use page_pool allocator
  mvpp2: memory accounting

 drivers/net/ethernet/marvell/Kconfig          |   1 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |   7 +
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 142 +++++++++++++++---
 3 files changed, 125 insertions(+), 25 deletions(-)

-- 
2.24.1


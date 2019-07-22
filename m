Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4390CC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236CF21BF6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfGVJOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:14:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56082 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbfGVJOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:14:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so34348156wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 02:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=buyBwragh/MiAtoP/qWU/+3wC1FPeSO8mS8xKGZe0WM=;
        b=QmXTfzoHNX+/35OflC4y97FKWY+u3nhBPCZkBbwvW7IF3K+tUVNEqXyfH2HpeN1O1T
         xk3RfUGlnx2Rleh4OU1/y0HvWw+HWsZouhdU+sWdTKs/l0/OAaGUbofR0CHvz7pOHKGK
         tafpzZF6xS9M62dTQX2xFhz2KhLB2tWsJ4LqAor9JP3vbcYiLBmEl+VGGA68emiCYJG/
         vQqk7/XxZDyaMCR0IneP4dwWUm0zCuR7bOFkqsJdtla2whl5h664TxDmM7VcLTWqpTH+
         6W2nLmmw3iSXGOf+K12g/AH3cohbCw7f7pIw9eVGZ/MzFJVaU2/kWMkXsdtz316M39os
         tzXQ==
X-Gm-Message-State: APjAAAXqbQ5518P2VIniUJMO2+HCAH+I6R1ezve2ZvA7pKD7IG7xF0Zq
        X1qGcNT02PB7xPqRRhEoBaXdtw==
X-Google-Smtp-Source: APXvYqxfShD/ei8RpJHH52M/aLQwRYii5G8tfg7PqTI4yQdrNr4boM5EbfQYG922Ax7/DzQZYsBz9A==
X-Received: by 2002:a1c:5f87:: with SMTP id t129mr66150883wmb.150.1563786877819;
        Mon, 22 Jul 2019 02:14:37 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it. [79.13.201.122])
        by smtp.gmail.com with ESMTPSA id 18sm35831732wmg.43.2019.07.22.02.14.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 02:14:37 -0700 (PDT)
Date:   Mon, 22 Jul 2019 11:14:34 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 0/5] vsock/virtio: optimizations to increase the
 throughput
Message-ID: <20190722091434.tzf7lxw3tvrs5w5v@steredhat>
References: <20190717113030.163499-1-sgarzare@redhat.com>
 <20190722090835.GF24934@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722090835.GF24934@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 10:08:35AM +0100, Stefan Hajnoczi wrote:
> On Wed, Jul 17, 2019 at 01:30:25PM +0200, Stefano Garzarella wrote:
> > This series tries to increase the throughput of virtio-vsock with slight
> > changes.
> > While I was testing the v2 of this series I discovered an huge use of memory,
> > so I added patch 1 to mitigate this issue. I put it in this series in order
> > to better track the performance trends.
> > 
> > v4:
> > - rebased all patches on current master (conflicts is Patch 4)
> > - Patch 1: added Stefan's R-b
> > - Patch 3: removed lock when buf_alloc is written [David];
> >            moved this patch after "vsock/virtio: reduce credit update messages"
> >            to make it clearer
> > - Patch 4: vhost_exceeds_weight() is recently introduced, so I've solved some
> >            conflicts
> 
> Stefano: Do you want to continue experimenting before we merge this
> patch series?  The code looks functionally correct and the performance
> increases, so I'm happy for it to be merged.

I think we can merge this series.

I'll continue to do other experiments (e.g. removing TX workers, allocating
pages, etc.) but I think these changes are prerequisites for the other patches,
so we can merge them.

Thank you very much for the reviews!
Stefano

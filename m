Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C285C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BCB2239F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TWoi52D8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391027AbfGWRST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 13:18:19 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:32839 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391013AbfGWRST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 13:18:19 -0400
Received: by mail-vs1-f67.google.com with SMTP id m8so29416136vsj.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 10:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0B8rPPy+2ZXzBZ5P/6QN4Hb9TBfPCAUoHiabvJr5FcE=;
        b=TWoi52D8rfeqTBQSa1fcx6QWG63Ntk0exIFf5AUJVd3WTblBruQ+cylK1+Aq6U2g8I
         I7t4fdrtcdj5SN1bDc0/Kg0coJ86BhXzItFv8/tlfnAujkwPIO9ZZ2RjaZb7NUSbooI7
         3ltnRcDS0Wf4Dq2qNc6ARyJizVl0RXPIagQpi/49DQJufEQ7sgs3+URXsAHw1IKoV2Cz
         CStWHQDRV/RAeZ7idchpS6ZNJrNUZDt/3Eyjdita5OUUpQHlDwi9JI3k2/on6Wfa/hYW
         cRWNKC09OYoVLpdxT0M9vuFRG9rF1fqOAV+dU5wZlNcsyZrhEpXaXS46fiW0mqgmA7oc
         81tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0B8rPPy+2ZXzBZ5P/6QN4Hb9TBfPCAUoHiabvJr5FcE=;
        b=n0P/HaXUH/w/ZJD35Jt7cRyQU5+vI5naJKobBW3XYL4pFrIiBNk2Te61VCqC4WJgXY
         DujSCg1t3sgF4W402T9HoQItuxmOppq/yILDjafok8fENFH86XQtqBYuXnQfKDZLUEcU
         m8JHGJHnquCrXHPZhglZQ73UhHnMJ4A8paNUW1WZM1HQM1KfHspE1u8L+MN+ek4f9vHG
         urbQBb0mDiaE9cWIx0I0Ob8U+mgbft4G1R62XVJPYQN/PkRMGEMA8V2YNjaick5C3Rvf
         97dae+w6in0h1jJJt7HDzo1RViA33/hJu3u71s5hEg3xbUn+ACHzJPzfoH0hzqoUmm+Z
         JQcA==
X-Gm-Message-State: APjAAAVols0Mq+UZJs3mAvR5dR6l+585AXYLxhrD2ud1YTMUTMbg/N8B
        kFRvsMqpLdo6cjcsRYURXr3BHQ==
X-Google-Smtp-Source: APXvYqxuzXgliI3GFFRnGNkj/EgjQA5jk124NBKZFVu7wii1lUqI5vsy37of5hMl2W7MgMsFdFJF7A==
X-Received: by 2002:a67:1e44:: with SMTP id e65mr50704721vse.45.1563902298689;
        Tue, 23 Jul 2019 10:18:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id s67sm15723604vkb.30.2019.07.23.10.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 10:18:18 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hpyQb-0002Yx-CQ; Tue, 23 Jul 2019 14:18:17 -0300
Date:   Tue, 23 Jul 2019 14:18:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Subject: Re: [PATCH 1/6] mm: always return EBUSY for invalid ranges in
 hmm_range_{fault,snapshot}
Message-ID: <20190723171817.GE15357@ziepe.ca>
References: <20190722094426.18563-1-hch@lst.de>
 <20190722094426.18563-2-hch@lst.de>
 <CAFqt6zY8zWAmc-VTrZ1KxQPBCdbTxmZy_tq2-OkUi3TVrfp7Og@mail.gmail.com>
 <20190723145441.GI15331@mellanox.com>
 <20190723161907.GB1655@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723161907.GB1655@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 06:19:07PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 23, 2019 at 02:54:45PM +0000, Jason Gunthorpe wrote:
> > I think without the commit message I wouldn't have been able to
> > understand that, so Christoph, could you also add the comment below
> > please?
> 
> I don't think this belongs into this patch.  I can add it as a separate
> patch under your name and with your signoff if you are ok with that.

Yep, thanks

Jason

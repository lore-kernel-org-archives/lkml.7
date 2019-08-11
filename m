Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E701C0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 08:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78EC216F4
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 08:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfHKImr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 04:42:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44435 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfHKImr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 04:42:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id 44so68957758qtg.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 01:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OwTyRG3c0uWeDZrJY6ZpPNgUs/dENdNyzYLQJF235ng=;
        b=D/zrSdi96VOcyqWD2WscCTxTBz0aEu/Nzvlt3G6e4aw1CrcBV647apLOKvB8v+F8fE
         HROBF2wImCx0D/ULRtSKAk3I+w5qKrNl9BIDs5TdDjb5+JSdTTpZ0ZSaMw14u8hzCjY7
         GKWNvK+9nmltfQhAr4f0c12Ek1r5O7cRdwAhtRqukDF7u2NDvlYckFiI6sxehhQoymNa
         PlYL2Jg7FIWMEPUv0Pwxn79OZOGT0k0nYGQJVeOK8COmVTnAoC5AcNs9EMl3dxXZU6H5
         6G0sJuPHbJoDp6J5Hq8wmDz7heYrsKxYEL8K7TeV4i3FFBo4SkbbuK4C7HQjyKN1O9vP
         WPNg==
X-Gm-Message-State: APjAAAUQc5uB1qwt0O9HQYbcfkHATrLSqxKvkvUt2FbyXqB5XDtnjAeE
        6j9m5uTp6yYVOKGaYuULWBvGIw==
X-Google-Smtp-Source: APXvYqzuHJ2U68lDoEL7EBgwf3NbWFXfC318bVrfWPFs3lvkcljrjOCTNgmV+LGovkQ0nKOOObqhmg==
X-Received: by 2002:a0c:ae6d:: with SMTP id z42mr25654119qvc.8.1565512966475;
        Sun, 11 Aug 2019 01:42:46 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id m5sm42472030qkb.117.2019.08.11.01.42.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 01:42:45 -0700 (PDT)
Date:   Sun, 11 Aug 2019 04:42:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linuxppc-devel@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190811041636-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <20190810143038-mutt-send-email-mst@kernel.org>
 <20190810220702.GA5964@ram.ibm.com>
 <20190811055607.GA12488@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811055607.GA12488@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 07:56:07AM +0200, Christoph Hellwig wrote:
> And once again this is entirely going in the wrong direction.  The only
> way using the DMA API is going to work at all is if the device is ready
> for it.

So the point made is that if DMA addresses are also physical addresses
(not necessarily the same physical addresses that driver supplied), then
DMA API actually works even though device itself uses CPU page tables.


To put it in other terms: it would be possible to make all or part of
memory unenecrypted and then have virtio access all of it.  SEV guests
at the moment make a decision to instead use a bounce buffer, forcing an
extra copy but gaining security.

-- 
MST

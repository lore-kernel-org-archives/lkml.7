Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E7DC0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 08:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE764208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 08:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfHKIzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 04:55:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42704 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfHKIzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 04:55:35 -0400
Received: by mail-qt1-f195.google.com with SMTP id t12so11449697qtp.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 01:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6/2qVAPvLy768Na8XqJHyfaQBOmu1VTQjHr1b0tqDos=;
        b=ZK247MQpGCfiPlj4HG6le8S9ob6xibKINExrP3oS+KUneAUryU7xK3+tF1N8P0FZVf
         BqyOGWQF9I5/pnm6NTpx1faSyZ5lc9v/y4xnJWY87QUORzsTpyI53b3XwhSWq/hZ4gzi
         JtFZ0ikk15BxYxH0K9BW5AqjejqNmIGIUYvSjW+uB7E71URijMzAJiFbIoeWWkq4P13f
         VDIA7adhkxRnDcrn1kd5le+8APImHyeyyA7luKMW8OS9FfIMMv+Xh7B7tRG/+2k4trT8
         a2c21qsgl7agovqPdmH4FgYExxE/1tO8NHXEGG6CivE3Vz0C2xyjO52wgwUwYwqrHgMV
         TteA==
X-Gm-Message-State: APjAAAVffyV1zs9UAC61FL0xCBxjKQIrvbaft9hLwqZtgL6S3gS2VxZK
        A1v1DtyfNsZO4+BULr6jPLnnJw==
X-Google-Smtp-Source: APXvYqwQSHWl5DZCKxcv6b09e+m/U60yeBUP2tSK+Zxbso+cleqVM/RZ1b43sqdRDBiAuYOyKuC1mA==
X-Received: by 2002:a0c:d91b:: with SMTP id p27mr25451190qvj.236.1565513734175;
        Sun, 11 Aug 2019 01:55:34 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id x26sm3314318qkn.116.2019.08.11.01.55.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 01:55:33 -0700 (PDT)
Date:   Sun, 11 Aug 2019 04:55:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190811044431-mutt-send-email-mst@kernel.org>
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
> So we need a flag on the virtio device, exposed by the
> hypervisor (or hardware for hw virtio devices) that says:  hey, I'm real,
> don't take a shortcut.

The point here is that it's actually still not real. So we would still
use a physical address. However Linux decides that it wants extra
security by moving all data through the bounce buffer.  The distinction
made is that one can actually give device a physical address of the
bounce buffer.

-- 
MST

Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AA6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8D22186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfCTP2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:28:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43967 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbfCTP2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:28:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so2166576pfd.10;
        Wed, 20 Mar 2019 08:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wh/Uw0SWb+MxE+egEQfFnWIp64CPV/rY9t5VChZfLHw=;
        b=PF7rf4csU8yA85K3zj8/f19uZsfG2HhmqKdsEzj1VIpb28UMX3980ufuEVB3ZY3veZ
         w89QQZCyxT77eyS7wbKQztoDHUgjtgRQeRi/6H62EkJW24y/KfF/vxdnZZ0pIDu4Lhvg
         Y9aodNYsFzlGNfZVqi6pY6RqTXpjkVAHPg3d3jYVeDn+xNmEVPMOMe1ZKBZcnQhLL1Q3
         e57UugK+CC1K2gmTUP9TWdEUceWWPOvlpyHSaKeOEwh9dzMpcdsXbRQwxuJDz1EELERX
         e7lKzz9sjxBea1s1StG9+GQwnUHecpxlymKY0Jm31/bMPQcIHW5cYGqqULhiVx0bMJ4R
         oQlw==
X-Gm-Message-State: APjAAAVu6tkj+yHu0xyaiMnJeqrV5IiKdVubR1JQC6nnEvOfpr592eAI
        YL/3PyooXiBn6neEmFF2lZQ=
X-Google-Smtp-Source: APXvYqy9G+mRBvlvVjrV8rCsQcDUNoEM3ObTxGG5g40gTUBTOAUUgy/9ahvZ2/zV7n03CK/9kIZ64A==
X-Received: by 2002:a17:902:9a5:: with SMTP id 34mr8683295pln.287.1553095688848;
        Wed, 20 Mar 2019 08:28:08 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h11sm2747295pgq.57.2019.03.20.08.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 08:28:07 -0700 (PDT)
Message-ID: <1553095686.65329.36.camel@acm.org>
Subject: Re: [PATCH 0/9] RFC: NVME VFIO mediated device
From:   Bart Van Assche <bvanassche@acm.org>
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        linux-nvme@lists.infradead.org
Cc:     Fam Zheng <fam@euphon.net>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, kvm@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liang Cunming <cunming.liang@intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        John Ferlan <jferlan@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Amnon Ilan <ailan@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Date:   Wed, 20 Mar 2019 08:28:06 -0700
In-Reply-To: <20190319144116.400-1-mlevitsk@redhat.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-19 at 16:41 +-0200, Maxim Levitsky wrote:
+AD4 +ACo  All guest memory is mapped into the physical nvme device 
+AD4    but not 1:1 as vfio-pci would do this.
+AD4    This allows very efficient DMA.
+AD4    To support this, patch 2 adds ability for a mdev device to listen on 
+AD4    guest's memory map events. 
+AD4    Any such memory is immediately pinned and then DMA mapped.
+AD4    (Support for fabric drivers where this is not possible exits too,
+AD4     in which case the fabric driver will do its own DMA mapping)

Does this mean that all guest memory is pinned all the time? If so, are you
sure that's acceptable?

Additionally, what is the performance overhead of the IOMMU notifier added
by patch 8/9? How often was that notifier called per second in your tests
and how much time was spent per call in the notifier callbacks?

Thanks,

Bart.

Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B16C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 08:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E06E2085B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 08:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfHKIoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 04:44:24 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35774 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfHKIoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 04:44:24 -0400
Received: by mail-qk1-f196.google.com with SMTP id r21so74957911qke.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 01:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hcr1GZOkXo/SpBuFQN2sn5O4znC3vPI6qwtk9Hnv4bM=;
        b=g2bGvZkA0JSKqZNhxcNaZrlUsq6SjfZrwahmt16MFJ86y9RwK4shxK+muKdvBImABD
         2vgQskyEUJ98R+AiLdts57h0mXyLvtQRrQBREdl3odX2ju6xsDQT1mFEm70hQ17zAisc
         H4TS6PnKMPFsnUu2c6izwaDNs/1aCbephdkdbNjhj9qjonGntG7fsD7+jKELo0WlNmE3
         E8l0K9BwdeeJFgDDz0Fcyrr6lUPQ88ekd6DeuORYAHS0mOPSiGq6U2ymlgt74mNyaa93
         8VCrUKbCQ51+ehjP5QKmYnICS7/+Sco7wkKhwSQLQbn4zTP+vBOjJ75QPHpOF71/olma
         8zKA==
X-Gm-Message-State: APjAAAXuIbx3NUC+H13C2XrM7CVgny0TYwlXbuUgq2NFe7LPyWHSzqpQ
        29iDh4U2CefW1KQPsKW6utXwZg==
X-Google-Smtp-Source: APXvYqwtJ8qJQX9u6p3npJxqnjO9//GeJFQdkKZGJ1PnQ4tx5aYXx+lvnUCwpoSIPVkCh1o6EEBaKw==
X-Received: by 2002:a37:b303:: with SMTP id c3mr25443520qkf.253.1565513063479;
        Sun, 11 Aug 2019 01:44:23 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id 23sm42858742qkk.121.2019.08.11.01.44.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 01:44:22 -0700 (PDT)
Date:   Sun, 11 Aug 2019 04:44:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Ram Pai <linuxram@us.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linuxppc-devel@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190811044256-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <20190810143038-mutt-send-email-mst@kernel.org>
 <20190810220702.GA5964@ram.ibm.com>
 <20190811055607.GA12488@lst.de>
 <20190811064621.GB5964@ram.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811064621.GB5964@ram.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 11:46:21PM -0700, Ram Pai wrote:
> On Sun, Aug 11, 2019 at 07:56:07AM +0200, Christoph Hellwig wrote:
> > sev_active() is gone now in linux-next, at least as a global API.
> > 
> > And once again this is entirely going in the wrong direction.  The only
> > way using the DMA API is going to work at all is if the device is ready
> > for it.  So we need a flag on the virtio device, exposed by the
> > hypervisor (or hardware for hw virtio devices) that says:  hey, I'm real,
> > don't take a shortcut.
> > 
> > And that means on power and s390 qemu will always have to set thos if
> > you want to be ready for the ultravisor and co games.  It's not like we
> > haven't been through this a few times before, have we?
> 
> 
> We have been through this so many times, but I dont think, we ever
> understood each other.   I have a fundamental question, the answer to
> which was never clear. Here it is...
> 
> If the hypervisor (hardware for hw virtio devices) does not mandate a
> DMA API, why is it illegal for the driver to request, special handling
> of its i/o buffers? Why are we associating this special handling to
> always mean, some DMA address translation? Can't there be 
> any other kind of special handling needs, that has nothing to do with
> DMA address translation?

I think the answer to that is, extend the DMA API to cover that special
need then. And that's exactly what dma_addr_is_phys_addr is trying to
do.

> 
> -- 
> Ram Pai

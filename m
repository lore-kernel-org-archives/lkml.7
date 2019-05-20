Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21139C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F402D20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbfETNRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:17:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45784 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfETNRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:17:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id j1so8718784qkk.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bZcyqtPfiR8OnSe7X+YvU6P3WmrTts8Lp+0qyg4aj2M=;
        b=otTZ8hslW6f26HeQGPPbVC9gSkBoKmbGfUTypf7xs0j65RiRHRhaTVTvaIASO6graT
         H+5ftdBZnZCnKJACBEeKPyjGAJ3woYdulbV5G/NOZ4/kqsIZaGle+mlHIv3LJJTpnVa8
         uA4eNTGTmcgQX9s7osiR+5b1Tew8g/C+ZzAIQJ/jvfw2ASA8jzsT5j7GmQRYvAm44emr
         WNwKJnG5tQWgIEufO1mbJ7gAjJ2RXz4bIp+vRmOaFCMk7Pqi2dwpQWuAQU5MOiNBQo2a
         5emHL2+WB52mAtO+D1cIC7MjMScclVusEL2m/VZHzdhiQaD+wNdeRhLr9u17pTbUFGTc
         1hCg==
X-Gm-Message-State: APjAAAXtU4AIV/RjxWCurndkNnbl1uBfbIoB634uADVwbXzCMW3NMOGI
        Sj0mJcs04zus0CvRiMUlLTDPDQ==
X-Google-Smtp-Source: APXvYqw0FqLkxwDq3if4j/PtdUGJI5ox1BH3UIwaju3gNcXX5ayK/jpLunGqH+2wq+Rcle7lAXdfbA==
X-Received: by 2002:a37:4c02:: with SMTP id z2mr46791719qka.1.1558358222050;
        Mon, 20 May 2019 06:17:02 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net. [173.76.105.71])
        by smtp.gmail.com with ESMTPSA id d16sm11577917qtd.73.2019.05.20.06.16.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 06:17:00 -0700 (PDT)
Date:   Mon, 20 May 2019 09:16:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     virtualization@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Michael Roth <mdroth@linux.vnet.ibm.com>,
        Mike Anderson <andmike@linux.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190520090939-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <87womn8inf.fsf@morokweng.localdomain>
 <20190129134750-mutt-send-email-mst@kernel.org>
 <877eefxvyb.fsf@morokweng.localdomain>
 <20190204144048-mutt-send-email-mst@kernel.org>
 <87ef71seve.fsf@morokweng.localdomain>
 <20190320171027-mutt-send-email-mst@kernel.org>
 <87tvfvbwpb.fsf@morokweng.localdomain>
 <20190323165456-mutt-send-email-mst@kernel.org>
 <87a7go71hz.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7go71hz.fsf@morokweng.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 06:42:00PM -0300, Thiago Jung Bauermann wrote:
> I rephrased it in terms of address translation. What do you think of
> this version? The flag name is slightly different too:
> 
> 
> VIRTIO_F_ACCESS_PLATFORM_NO_TRANSLATION This feature has the same
>     meaning as VIRTIO_F_ACCESS_PLATFORM both when set and when not set,
>     with the exception that address translation is guaranteed to be
>     unnecessary when accessing memory addresses supplied to the device
>     by the driver. Which is to say, the device will always use physical
>     addresses matching addresses used by the driver (typically meaning
>     physical addresses used by the CPU) and not translated further. This
>     flag should be set by the guest if offered, but to allow for
>     backward-compatibility device implementations allow for it to be
>     left unset by the guest. It is an error to set both this flag and
>     VIRTIO_F_ACCESS_PLATFORM.


OK so VIRTIO_F_ACCESS_PLATFORM is designed to allow unpriveledged
drivers. This is why devices fail when it's not negotiated.

This confuses me.
If driver is unpriveledged then what happens with this flag?
It can supply any address it wants. Will that corrupt kernel
memory?

-- 
MST

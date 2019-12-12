Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7660AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDFA214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOd92ifV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfLLK1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:27:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30674 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728567AbfLLK1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576146463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qU9B6VyDpHjtTgIgGRVPpWJk/W+j6466GBB3hhlYf7g=;
        b=NOd92ifV3zPMB/nmchhiAyUgeqWD5c0D4rpoW4t3O6Df1KVrkPFTDf3a148aigTyA5Ncbb
        z0N1+CUH32KYHDrEMUbHLpqxDfE5Bff4j/X5jtLVFev1cUhgzUL5t3lHy9uFI3oHAJLDG2
        nvEAyKg62AK86+MQRpyR+LixDI6Vbtk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-aVcbOIdYMpaEOy71RYTNzw-1; Thu, 12 Dec 2019 05:27:42 -0500
X-MC-Unique: aVcbOIdYMpaEOy71RYTNzw-1
Received: by mail-qt1-f199.google.com with SMTP id x8so1067848qtq.14
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 02:27:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qU9B6VyDpHjtTgIgGRVPpWJk/W+j6466GBB3hhlYf7g=;
        b=qh2cNlbZGqTdtjNQjqiTnQH1XmzgzOn6WiW/aBhd4EwWunPUQGgak53cbn7brqNqx8
         pDZHwplK7OCbOCBhHFny/bDB/0HQQZjluYXlLwgkGI32SwfWbpZUk7g/1yiBkW07CikB
         EDXtLFEInPZvvCnEJ88z93c7i/m7cinfysqcOf3wY+s4BR1SoIxIkcKyA7ztD8Vz8pAT
         kbL/rmM2GidgxX7v4mOfw7pRiK/m2sxSyGFvjbluVhhyHyZU4FaF6xjJQnci3Kl6Wari
         IRYcF6uOFubDlxnOpKbcsxUMtuoZJ2qNLPpPmNQTzZo/5yIaaBFGZHCNnvrr5a8YBbmD
         aIwQ==
X-Gm-Message-State: APjAAAWyRK9AJp+LuPDeaaW6/KWOJB0IJIL3QL9d31odlQjzxj6lQ3cO
        7j+2IL5ajNQ74Le82Fu9XF4FJpcqympa3BNDk7M2PAKDVsiy4hdL9UlnKFv4XKN/B6shVWw6smk
        eSjIwWxVETbhyxnt9E68oe2i1
X-Received: by 2002:a0c:fa4b:: with SMTP id k11mr7283779qvo.55.1576146461809;
        Thu, 12 Dec 2019 02:27:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqxtYqnSCAa6qS7eoPNNg8Gjl2R1rf+c6pT8ccpGnyGaK+GWirzetuKwnPIwjkwnOvZt6S9U2w==
X-Received: by 2002:a0c:fa4b:: with SMTP id k11mr7283726qvo.55.1576146461280;
        Thu, 12 Dec 2019 02:27:41 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id 2sm1599671qkv.98.2019.12.12.02.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:27:40 -0800 (PST)
Date:   Thu, 12 Dec 2019 05:27:33 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jason Wang <jasowang@redhat.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        John Garry <john.garry@huawei.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/24] compat_ioctl: scsi: move ioctl handling into
 drivers
Message-ID: <20191212052649-mutt-send-email-mst@kernel.org>
References: <20191211204306.1207817-1-arnd@arndb.de>
 <20191211204306.1207817-16-arnd@arndb.de>
 <20191211180155-mutt-send-email-mst@kernel.org>
 <858768fb-5f79-8259-eb6a-a26f18fb0e04@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <858768fb-5f79-8259-eb6a-a26f18fb0e04@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 01:28:08AM +0100, Paolo Bonzini wrote:
> On 12/12/19 00:05, Michael S. Tsirkin wrote:
> >> @@ -405,6 +405,9 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
> >>  
> >>  static const struct block_device_operations virtblk_fops = {
> >>  	.ioctl  = virtblk_ioctl,
> >> +#ifdef CONFIG_COMPAT
> >> +	.compat_ioctl = blkdev_compat_ptr_ioctl,
> >> +#endif
> >>  	.owner  = THIS_MODULE,
> >>  	.getgeo = virtblk_getgeo,
> >>  };
> > Hmm - is virtio blk lumped in with scsi things intentionally?
> 
> I think it's because the only ioctl for virtio-blk is SG_IO.

Oh right, I forgot about that one ...

>  It makes
> sense to lump it in with scsi, but I wouldn't mind getting rid of
> CONFIG_VIRTIO_BLK_SCSI altogether.
> 
> Paolo


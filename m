Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413D6C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 00:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FD8214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 00:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dweU4g9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfLLA2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 19:28:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54892 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727274AbfLLA2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 19:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576110495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hb5JBtjwXvbmme4Dxt6Sh1XFoFaw8S8TIapNfxubP9w=;
        b=dweU4g9qRul2Xs/g460LYbAYr5S8+ypUqYAZQcQfJpaJMViqx3i5t8elywOgP+k3d8B12e
        3iBFWTgPZEasIImgZ3o3+x0Bs71GRDgbo7iDGUtuPNB4o3C/3rE3XKg2IfckDWcZYOFR9Y
        fUhj/JhJ1QTGEyCfRy1r0Y5eca1T0XA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-y4knAMo1MuSJh-Zzb4H9RQ-1; Wed, 11 Dec 2019 19:28:12 -0500
X-MC-Unique: y4knAMo1MuSJh-Zzb4H9RQ-1
Received: by mail-wr1-f70.google.com with SMTP id t3so295807wrm.23
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 16:28:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hb5JBtjwXvbmme4Dxt6Sh1XFoFaw8S8TIapNfxubP9w=;
        b=KnXZjQaibDUS9t+HPDJOPfPgLvX6e2y0uW0sAZx0Mvh5CatPq8z2IfBYNLvNW4Xl4w
         +1Ke4s0CWGooVeFwDz+TezyKAL4163uTuBUFO3upJNN5ETw7Nu2V34LMv/sjDlkDsAD3
         52iafJvvDjjZgU9LOLfCglUKGwqyMcYYPADXhq9e+0iB+WRkWGmpRXY6hiIJCuzcw9jh
         7sL13DyleviAFUz8xjSVStyBSUjMWykzZin+935jrjmv+yKwTAnL4n239v0YvGd/BE3n
         uiCy0RlcrtWkB6gbyzpoXPvKzhqGJ8Pvkx8rJDAxNH8B2rRMeirwMPJGTuEagYXZePme
         iP1Q==
X-Gm-Message-State: APjAAAW/sJyyTrOYsiYtVfEkxzkBRe6yV2gGuPi+cRo+TvTJeaFvCr/G
        CZAZkzmTqQ1pYvYiaL5Bx0Naw1jG41D+yeF32IynZIgsf/qlQOh6RMG4KIjPPVw2J5MXl+Wbh01
        5oQbyqbnUPQnf1ru0W0IrawFX
X-Received: by 2002:adf:8bde:: with SMTP id w30mr2790580wra.124.1576110490980;
        Wed, 11 Dec 2019 16:28:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqwPP/UQtQvR7H0tI553soFfAslbKh86aszplkbovgcOGgnxj1GpFCjYyjEJLCUeQDAEqXIk1A==
X-Received: by 2002:adf:8bde:: with SMTP id w30mr2790552wra.124.1576110490746;
        Wed, 11 Dec 2019 16:28:10 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id g9sm4134194wro.67.2019.12.11.16.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 16:28:10 -0800 (PST)
Subject: Re: [PATCH 15/24] compat_ioctl: scsi: move ioctl handling into
 drivers
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jason Wang <jasowang@redhat.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        =?UTF-8?Q?Kai_M=c3=a4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        John Garry <john.garry@huawei.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20191211204306.1207817-1-arnd@arndb.de>
 <20191211204306.1207817-16-arnd@arndb.de>
 <20191211180155-mutt-send-email-mst@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <858768fb-5f79-8259-eb6a-a26f18fb0e04@redhat.com>
Date:   Thu, 12 Dec 2019 01:28:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191211180155-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/19 00:05, Michael S. Tsirkin wrote:
>> @@ -405,6 +405,9 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
>>  
>>  static const struct block_device_operations virtblk_fops = {
>>  	.ioctl  = virtblk_ioctl,
>> +#ifdef CONFIG_COMPAT
>> +	.compat_ioctl = blkdev_compat_ptr_ioctl,
>> +#endif
>>  	.owner  = THIS_MODULE,
>>  	.getgeo = virtblk_getgeo,
>>  };
> Hmm - is virtio blk lumped in with scsi things intentionally?

I think it's because the only ioctl for virtio-blk is SG_IO.  It makes
sense to lump it in with scsi, but I wouldn't mind getting rid of
CONFIG_VIRTIO_BLK_SCSI altogether.

Paolo


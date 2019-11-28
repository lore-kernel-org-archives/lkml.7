Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE876C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBBC2158A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpcqfBz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfK1BJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 20:09:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35765 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727088AbfK1BJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 20:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574903387;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gToFrwAF3Uy6k7hO1WWqHDn6U7gZbrdQcmuYWTaqI8A=;
        b=gpcqfBz1Ylbx1aypkkvbD35kuH0puFRd4e8AzgMeb5OsdWvvh73T47Uc9A2QDtNXKBb//t
        Govk5cqpV9apqenCxqAacmqY6ahj8m7YU5Rxppavke5Ptpx8Khzj7Ly5bXAWYQOlIVrdpI
        kx+p3rEypypk7T8WtdMjAZ9M3JBHwAI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-_X7-MDzDOWe9ZI7mo4FWFw-1; Wed, 27 Nov 2019 20:09:45 -0500
Received: by mail-pj1-f70.google.com with SMTP id t7so11986757pjg.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 17:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=gToFrwAF3Uy6k7hO1WWqHDn6U7gZbrdQcmuYWTaqI8A=;
        b=EDlLXNab7FGCy9WlVF6on9AC4yR9Nr5KuclvOvvm505Q0G1DCW9nYkILesgJgAw9+g
         8snpS60FrBRxPQ4kSfrl8+FCdyXC0unLhXpnqFj4qn4dheC6F7MyYoEWm5rSkq+JJZaM
         RftXzzxGspBTc3XsmTooSLR7cyvNhqPLw99Z7w13wD83FS5F4ZX1pRMFKRrpqxuNT8qh
         neIcZgJLyaD7Afi2+X1fKSLEmGB+WkS3GCzESjlXs92y6EpsPpeNwcCw/8rHkmkGEN5x
         +co8kbsKcpBBjOnWvHyINZWTG7uelok8DcCPONHzxBF8RRujxrUF9KYGGg1ss8eLt8Js
         tA4w==
X-Gm-Message-State: APjAAAUQuhjX8X26WWqIp/GW60uGtOPmGjZFlkLBtoFPmZqS0dw8T+Lg
        a+Q3AQQ3cZtZBcydjwT3ZLAN9gvtHj1npId0d63jqt+2rD6EiY/0q6kNrTY4At3VLyihnZHEhly
        L6VnCRnLqEbMNhdY1stohNypC
X-Received: by 2002:a17:902:bb83:: with SMTP id m3mr6896863pls.94.1574903384574;
        Wed, 27 Nov 2019 17:09:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqyIvzsNym80Q9Lwzet1IKxQ6KC5wqL0VT0ocnGy4kM0wenhkNMfOac8XHuBRaPjQdgzX7ZxoA==
X-Received: by 2002:a17:902:bb83:: with SMTP id m3mr6896839pls.94.1574903384223;
        Wed, 27 Nov 2019 17:09:44 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id v63sm18029926pfb.181.2019.11.27.17.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 17:09:43 -0800 (PST)
Date:   Wed, 27 Nov 2019 18:09:42 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: Update mailing list contact information in
 sysfs-class-tpm
Message-ID: <20191128010942.ysfkztficovmdl42@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
References: <20191025193628.31004-1-jsnitsel@redhat.com>
 <20191028205338.GI8279@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191028205338.GI8279@linux.intel.com>
X-MC-Unique: _X7-MDzDOWe9ZI7mo4FWFw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Oct 28 19, Jarkko Sakkinen wrote:
>On Fri, Oct 25, 2019 at 12:36:28PM -0700, Jerry Snitselaar wrote:
>> All of the entries in Documentation/ABI/stable/sysfs-class-tpm
>> point to the old tpmdd-devel mailing list. This patch
>> updates the entries to point to linux-intergrity.
>>
>> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> Cc: Peter Huewe <peterhuewe@gmx.de>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: linux-integrity@vger.kernel.org
>> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>
>Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
>/Jarkko

Should this go into your next branch?


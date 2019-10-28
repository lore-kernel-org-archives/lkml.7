Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE21CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029F5217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyY7wqnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389234AbfJ1VFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:05:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50578 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389188AbfJ1VFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572296715;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TxKlhPKEe4Eb/axUY+ph5O+S3W8S8DEGprY2128AzI4=;
        b=KyY7wqnhtiQ1muYynpu2Ss5D16X0yfQKIj27lzgcBCRKGAffq04yM6RX33QacpUDYLmo1y
        CLp3e5WE4H9r7olX626IBnGg9quQEzD39YWAbmwx1LgddBSLHygjssTQSImPwvn/Ye8x9w
        mhCtNLLWhLoUhovEic1iq9F/n5kAtl8=
Received: from mail-yw1-f71.google.com (mail-yw1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-i_rBb6VSM0e9RW7K8-ksqQ-1; Mon, 28 Oct 2019 17:05:10 -0400
Received: by mail-yw1-f71.google.com with SMTP id u131so8405092ywa.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 14:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=yf4+zj7RNOPk8CerubFQ1G5hNP+VaWNT7LPoqLWZ0Gk=;
        b=nhNfiOpKOcpY7UsYsVx2Q0jUYxRs0fj+HhxYZb8HCO2rCLoqDhzGwW2uNbvbhFxwax
         7QmEtPm4Gz1ZEtzzAk0GPLGA8o5QbW1dJCeIcrRuytPXun+9oMvH/Epeywkz5+6/roZJ
         A1EHOaMLvKO+ydVchXOWOYTvXx8pxrB98LaRtbTn+euchRHsXyjOIRHxFaX3WpnLP17A
         jH8airSQDfjvD5eKgXII+oYzqJFpgy5igWwA5P9jrdX6wXrlFYdvUbS8WTHyQedpeNw0
         vjYqNFB0NM6HdrlNwepfOTXeyU5lGMQWd41M3GC6WHZkIPdGMlVKuhTzexSu3+nhLtmU
         ik+A==
X-Gm-Message-State: APjAAAUbUyr/bj0p3qZthKAXgUkJ7gqDWzwSZB1Q9WlxPwOQP2GWzDLh
        qaJeg4OB2jgH3+NPRhL628s/h5dx2eCSTkmsoYwEC+YOMXZ8JOaGQxLNdnkJAEy2barAh2dgCGg
        LC2hoXL0GKtvceKxG/yZXhm3s
X-Received: by 2002:a25:49c7:: with SMTP id w190mr15832737yba.140.1572296709841;
        Mon, 28 Oct 2019 14:05:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxmmKVW7cJQlJOkIJYnBiX2JsU0pLw6AUn+HaxO5Jx8ZNWGwI05O9D8puCAWbLE4amCdxhDYQ==
X-Received: by 2002:a25:49c7:: with SMTP id w190mr15832711yba.140.1572296709459;
        Mon, 28 Oct 2019 14:05:09 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id j3sm9425112ywb.10.2019.10.28.14.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 14:05:08 -0700 (PDT)
Date:   Mon, 28 Oct 2019 14:05:07 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Add major_version sysfs file
Message-ID: <20191028210507.7i6d6b5olw72shm3@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
References: <20191025193103.30226-1-jsnitsel@redhat.com>
 <20191028205313.GH8279@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191028205313.GH8279@linux.intel.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: i_rBb6VSM0e9RW7K8-ksqQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Oct 28 19, Jarkko Sakkinen wrote:
>On Fri, Oct 25, 2019 at 12:31:03PM -0700, Jerry Snitselaar wrote:
>> +=09return sprintf(buf, "%s\n", chip->flags & TPM_CHIP_FLAG_TPM2
>> +=09=09       ? "2.0" : "1.2");
>
>This is not right. Should be either "1" or "2".
>
>/Jarkko

Okay I will fix that up. Do we have a final decision on the file name,
major_version versus version_major?


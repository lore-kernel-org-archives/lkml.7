Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0238CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE80F218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="O/+NlnVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfCVKHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:07:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35954 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbfCVKHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:07:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id r124so1198419pgr.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 03:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=J+rrCSXf6EDhMg8N962z2+QnRG5bP1uFmnXEPs0j13Q=;
        b=O/+NlnVSTw5SiI2sQnRScAd78vSi0gWMzklBTk3xrd5mRBjLmdnJ4WlMCdgiUUNvkK
         5ZvC6FEF1na2kILXyCWBHHDvMg36gxiBKp0QqAthaa0z7rFf4AgU2F9OvrU7E7SDxW8V
         7U0Y+K5nxdAZ+6WHQ2CLc86RH8ly+fGRM49V1se0uMiHXPgipGmnxYZMjhvjoqzd3Pup
         77IlrKOyLo8ZdIqy93hlDSlZf1MFR9F14Ch4VTFPXHqeipaXXPaY8xfdjfTA0xlvaItL
         CEQjClxSj2iLFqEMDSMOg73StZtGzxySl2wVF1daPAzUAiljLw3REgQVE2SWU8RsdAWC
         uC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=J+rrCSXf6EDhMg8N962z2+QnRG5bP1uFmnXEPs0j13Q=;
        b=Gs6H2SvZm+iQFRL8jSqLzqCvnd4DlViqdFvUcvgV44n9q3tcRtr0jZ8/IQHiJ4/Dc/
         9RPVdfcXA3UY2QD6VQc+xbx2CPqIj/GYWK0hP+a6B4UALqPM+rFQeWK2tmsip5LIoSL2
         vGFowuClzaOmLKiG4k79e/QofIASv1JlujZz0ooXZ0Iw56fWDlY6eA0+kvsOlKFx6bzw
         KdPrYWojJuQswtolZKhADhGD6ijo67y/FB15wYgWzRAlWi5sBF4MbnzcvAKJuX5mK4P1
         4gtFm+ZfP376UlcdIyU7Uy9qA9fVLvh4sQUF1ZlZO3+CAlqmEzJlWIKxKSoxXjJ03jMj
         WBIg==
X-Gm-Message-State: APjAAAUSPPdWWFNYMQ0A4ulqRNjDiTL2Z9AKMFbneaJLcaXmIamXGeGI
        qnt9LUxLqmlTuoTgkezcKwDlhw==
X-Google-Smtp-Source: APXvYqyr8dYWJR/uAoNHE+gLL3zDhJkNwqZisPA5Z4/7gZMhaspg1kaY8ouR5Wu4Xkce3PUBk1qd7Q==
X-Received: by 2002:a65:625a:: with SMTP id q26mr8091231pgv.61.1553249231142;
        Fri, 22 Mar 2019 03:07:11 -0700 (PDT)
Received: from ?IPv6:2a02:8084:20c3:bd00:49d7:4bdf:6b78:2db4? ([2a02:8084:20c3:bd00:49d7:4bdf:6b78:2db4])
        by smtp.gmail.com with ESMTPSA id v8sm9165115pfm.174.2019.03.22.03.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 03:07:10 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 7/7] iommu/vt-d: Remove lazy allocation of domains
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <20190314163501.2f414a78@jacob-builder>
Date:   Fri, 22 Mar 2019 10:07:01 +0000
Cc:     iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <48D45E21-9B4B-40AB-A698-5386E08A6646@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
 <F4D76093-3F9F-4184-9F92-191A01126D0F@arista.com>
 <20190314163501.2f414a78@jacob-builder>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jacob,

> On 14 Mar 2019, at 23:35, Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> On Thu, 14 Mar 2019 11:59:36 +0000
> James Sewart <jamessewart@arista.com> wrote:
> 
>> 
>> -	domain = get_valid_domain_for_dev(dev);
>> +	domain = find_domain(dev);
>> 	if (!domain)
>> 		return DMA_MAPPING_ERROR;
>> 
>> @@ -3914,7 +3624,7 @@ static int intel_map_sg(struct device *dev,
>> struct scatterlist *sglist, int nele if (iommu_no_mapping(dev))
>> 		return intel_nontranslate_map_sg(dev, sglist,
>> nelems, dir); 
>> -	domain = get_valid_domain_for_dev(dev);
>> +	domain = find_domain(dev);
> This patchset looks like a very good clean up, I am wondering why we
> can't use the generic iommu_get_domain_for_dev() here, since VT-d has a
> default DMA domain after your patch.

This should be possible, only downside is we get an iommu_domain from 
iommu_get_domain_for_dev and will have to check its not null before 
getting the dmar_domain from it. We will be able to remove find_domain 
though.

Cheers,
James.

Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F6FECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 23:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB38B20867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 23:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkEBhDMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfJGXnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 19:43:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55023 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729529AbfJGXnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 19:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570491810;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/KfdB8ibDs6rNq8kMkSKmIsENyVmHkVqr3DazxzG7Po=;
        b=UkEBhDMC5cX+ogTswYiExJFAoChR8g1xXgrqZSxLQdbNw9+wb6iO8SCBkiexIc4ch685y+
        ZOicxdneEq1fUpwel7NrsxFX9UwvPMrSYcOxPQcWEoleRe/o8w7XR9XseOpnfVKAKwyCXv
        VVXm4TVZ8IlOxDtpOmqCTmerGVzBMB8=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-n8uLjAiqOHaYf_eUQbW_eQ-1; Mon, 07 Oct 2019 19:43:26 -0400
Received: by mail-io1-f70.google.com with SMTP id u18so29494891ioc.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 16:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=/KfdB8ibDs6rNq8kMkSKmIsENyVmHkVqr3DazxzG7Po=;
        b=pLhcFFTDtKrdt/Cf1oFbyZC2bgpYX0Cpr04DL0dHHkZ4Gkl7Xururu+T8tQv7iSCvM
         89smdtJiyY2rQynLN3/uvFyzqCC0Eqm57FKu5rDNDGXIVm7tHBP/ljbYfEpNkO2usZS7
         QwoL1xn8C5mKAQ3tvfiuSLkydwDX4gS9CQaNu0cHvFWI5VjxkObNV+BFira7pku8Usxp
         04PrwKb6ijQ9PDZhnf3BpToh+ix9ulG6rgFpSvLoNHp4bc4VQUzAEOOWukninieOvcnM
         HC7HIRANj56zAyM3uhZnMSYPBrQijZfuFJR3yczC0q5clqJpNWr0BiYaisnTDYviPwmH
         ZYOw==
X-Gm-Message-State: APjAAAXEN08ez/Htlrf9Kx2bIwlUIDWPsK0WvE8hfgrBhGGlLHtfsqj7
        CXxd2bny6Pm9deRXjHZUM4rY3IuP1BBF+uRibAtNR/9EX0K70ad133epl5Q3xa4gteMV/iN+2GQ
        7YCn+351ZIBiWnK7dgcTpxjD0
X-Received: by 2002:a92:bb05:: with SMTP id w5mr31955911ili.303.1570491806350;
        Mon, 07 Oct 2019 16:43:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy6Zp5FZMi5yxzuc/xTznB+fkg/9WS8bWFCEBHlaPE1Pn9L5J3AawFt79dXD9lIFRMLG+45/g==
X-Received: by 2002:a92:bb05:: with SMTP id w5mr31955887ili.303.1570491806053;
        Mon, 07 Oct 2019 16:43:26 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id s5sm5479794iol.71.2019.10.07.16.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 16:43:25 -0700 (PDT)
Date:   Mon, 7 Oct 2019 16:43:23 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] tpm: Use GFP_KERNEL for allocating struct tpm_buf
Message-ID: <20191007234323.bzeov5mpc4xregcy@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191003185103.26347-1-jarkko.sakkinen@linux.intel.com>
 <20191003185103.26347-2-jarkko.sakkinen@linux.intel.com>
 <1570148716.10818.19.camel@linux.ibm.com>
 <20191006095005.GA7660@linux.intel.com>
 <1570475528.4242.2.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1570475528.4242.2.camel@linux.ibm.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: n8uLjAiqOHaYf_eUQbW_eQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Oct 07 19, James Bottomley wrote:
>From: James Bottomley <James.Bottomley@HansenPartnership.com>
>Subject: [PATCH] tpm: use GFP kernel for tpm_buf allocations
>
>The current code uses GFP_HIGHMEM, which is wrong because GFP_HIGHMEM
>(on 32 bit systems) is memory ordinarily inaccessible to the kernel
>and should only be used for allocations affecting userspace.  In order
>to make highmem visible to the kernel on 32 bit it has to be kmapped,
>which consumes valuable entries in the kmap region.  Since the tpm_buf
>is only ever used in the kernel, switch to using a GFP_KERNEL
>allocation so as not to waste kmap space on 32 bits.
>
>Fixes: a74f8b36352e (tpm: introduce tpm_buf)
>Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>


Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C33ECE587
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48C7217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i21eyPVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfJOH4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 03:56:46 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42403 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfJOH4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:56:45 -0400
Received: by mail-ed1-f65.google.com with SMTP id y91so17066005ede.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 00:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=purHCPGDjaKXkBT9wvD+Vn4dLucXAl8XRe5APKFmAL4=;
        b=i21eyPVWB0UJJtw29IaCJIn5X5m/4qC54mNfQFbR+mZgoEjTJrVlCkS3NRRnzDyFrE
         v55vFv3KYyKnKs/yP1Dk9iNltDwfelTDqDzVWY4yUZTb+memeZRKr3gXQAqRQunkumZl
         LSIe+GCv7AXoRPI6r0mcmAdTZvsK1tyYVfFiBZwV4IUGdsi6KBYcl2BLpMJo+m05x2MJ
         K8VMJdqusGaVP5K+2VrbuXSNoKsebYb+RnpqbEK4Sxmx3Op2+dibzT6IEL3of/xgD6ij
         HqIgNbJFjFj+IgDBy23MHdoibAIqZVp8ShbibSsp6HH7h10x98K7I7datCyiKmNeK7s/
         K30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=purHCPGDjaKXkBT9wvD+Vn4dLucXAl8XRe5APKFmAL4=;
        b=ehKSaFhA7CdP9gpoPzpdFrw8jJZi7r2T20dM4aJ77hkKL1hssvKs0s9VODRZIHONmm
         yubn8zzTrN3+ZOJMGt4jm6q0ujac1yGAKH0p2+Zy1lPHE/Gi6OO7fU8/Homc+DJ1u/S/
         DLjcpr+gQYO3H+54lMMo9twJ7Lm4pfx0qgVWfa+gMLe2d9haADBxunTMLrAR2ZxD1tyO
         /MAyB0yDu1BGDbqjrn7DUu4DjOcfh2xuxyrX0/CCZ1zf4zSe7IpRIq+iqaKMqlEymGZz
         j5tYxcYydOvBC9j2caUCeIMiBel01BgnaovG5lfuxzAwUcUE742LwEFh29aA4jxJucVL
         KPuA==
X-Gm-Message-State: APjAAAUAt3EffOkcQzGT/OaFJ9gl7s5tkgWGQNjXRmyN0jd5I2/XOKcb
        0ozFzxPKEyfhYlnwJO7rwDbOaA==
X-Google-Smtp-Source: APXvYqz87++12wSGikge8AEkKIiQU8AjWcOWzGOGNRXHRWUIyzTL0GFPStDmWg3XJPNCBwz9LHpsjQ==
X-Received: by 2002:a05:6402:21d6:: with SMTP id bi22mr31741791edb.19.1571126204054;
        Tue, 15 Oct 2019 00:56:44 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id br14sm2644807ejb.15.2019.10.15.00.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 00:56:43 -0700 (PDT)
Date:   Tue, 15 Oct 2019 09:56:41 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH v4 0/4] User API for nested shared virtual address (SVA)
Message-ID: <20191015075641.GC1467695@lophozonia>
References: <1570045363-24856-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <20191007123912.60c19a79@jacob-builder>
 <20191014101405.5429571b@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014101405.5429571b@jacob-builder>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 10:14:05AM -0700, Jacob Pan wrote:
> Hi Joerg,
> 
> Just another gentle reminder. I think we have reached consensus in this
> common code. Jean and Eric can confirm.

Yes for the whole series

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>


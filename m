Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EB0C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFC5208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oof2UcZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfITQis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:38:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37570 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbfITQis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:38:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id r4so7101766edy.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 09:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+JjVHOFtPkrIu+975k/69BRdOa3f1zZRGu6VFUJO+SE=;
        b=Oof2UcZtDBoL9r9YUCMpa+YnL1BKRRXdv7Tg4CF5oueJtWk+uI/AjuBbiD2CpsKKDn
         AJyUm43wEixxj0qrSfWYAMFH/5/QhaW282DyEwlTgG4FfNoIRDvyhemzDmKmj1JIloiA
         1NcnNuKU8cn5kN+lFOgJAV49GCt2d3K5r+DV3ZOuIgTWx74V5iWK9PH66MBrRLVPBEUp
         U5x9zERtv5LXZcdyFhAHH4kVijTEt98/vZF2jd80k77DoUU2q1UJen0oKmMMC2UaTi1U
         QOkg3f/Z+qjV88usI7PtEbXVbx0F5kKrmQmI2iY+Xp11ZQ4LcSYhXXD2ejNv6YjUuMVc
         L6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+JjVHOFtPkrIu+975k/69BRdOa3f1zZRGu6VFUJO+SE=;
        b=Yj2kIUdgXKE6HEsr5hwO8aohSbn90ORv7SMQTsSTBWKQk5eV2voPpSGqjBQKYb9UcY
         Ml1hW4V+vvdHf29KSOzxBVUGgTenEAo/XqxYdZOoDgo/XJvZWOxrZ7BDXC33ANhrkc/h
         /qkQ83BwzFHtIde38I8aoqNSJfc7FjRbuM1wiHYUOVbXpUPk+qTMHN6J+/cjKMroKjyN
         rb1H6v7hlnjiBGq3ylGG0ywoltsLTggc/eOlzw4anFPUEt67K4kRlDCUYTnupHoWFjdf
         J4mxi7QZb3IT5mvINHo4lSxDI1fftcsjqYkW1DK565nys9uCTJYq9KMS+w7w/V2dPQb6
         VAog==
X-Gm-Message-State: APjAAAXp7YweMz0e1+p1JWJqIdTXgD+kC7Vxx9/3oaCoVrt3+RkR1Ca1
        RLqSye5e6FQqPTsOh/NRzw0Gpw==
X-Google-Smtp-Source: APXvYqwJczKwjDOiGLA7EtKQlZ9dOCzqyi58hY9xeDlLLlGSMNkfPS+mwtXM4drn+jdNkHaovaWf1Q==
X-Received: by 2002:a17:907:20a2:: with SMTP id pw2mr19642839ejb.163.1568997526248;
        Fri, 20 Sep 2019 09:38:46 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id e39sm407528edb.69.2019.09.20.09.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 09:38:45 -0700 (PDT)
Date:   Fri, 20 Sep 2019 18:38:43 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 4/4] iommu: Introduce guest PASID bind function
Message-ID: <20190920163843.GD1533866@lophozonia>
References: <1568849194-47874-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1568849194-47874-5-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568849194-47874-5-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 04:26:34PM -0700, Jacob Pan wrote:
> Guest shared virtual address (SVA) may require host to shadow guest
> PASID tables. Guest PASID can also be allocated from the host via
> enlightened interfaces. In this case, guest needs to bind the guest
> mm, i.e. cr3 in guest physical address to the actual PASID table in
> the host IOMMU. Nesting will be turned on such that guest virtual
> address can go through a two level translation:
> - 1st level translates GVA to GPA
> - 2nd level translates GPA to HPA
> This patch introduces APIs to bind guest PASID data to the assigned
> device entry in the physical IOMMU. See the diagram below for usage
> explaination.

explanation

Otherwise Looks fine to me. I was wondering if we would be able to reuse
the API for Arm SMMUv2, which allows nesting translation, but without
PASID - there is a single address space per device, with two stages of
translation. I think it would work, although it would look better with
something like "PGD" instead of "PASID" in the API names (e.g.
iommu_sva_bind_gpgd) since that case wouldn't use PASID at all. But I
don't want to quibble over names, so

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7951CECE58A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1E0222CE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M0CGhE7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfJBOSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:18:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38450 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbfJBOSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:18:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id l21so15410047edr.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 07:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1fxLpOvxXjmYD9btfQy/Q69rKcNISxOaD+GEumCPo2Y=;
        b=M0CGhE7fvba+3sfLMywUWvxthwUABn1pfs/nG71DIGE6llAqL48cSUKBqCJXAv/bK4
         3s9dVWdEW6MGNWrNMbrewR+P3kTT36bEpTNZ7jB7ELJFO74woE3zAQNo8yf81otGx9np
         SuEYJ/RtzN/Wu+TrudFOrKTuuhBpLS2mvqJTVGNld+3dDmIW6/bN4aQ0uwLbkdmn/uvC
         NZ6PjPl5d3qAflqjfNiL1QiVN8ILAAKSn+hANSQ+vIFc1j8+tvURPV4+hCPewLISbmeV
         nZ7gTCZM5vGtGstE/uOEw4LcOImx3foPoFhpptWEQcRApzZwNpo7Pnn7GjqUtCTGPLGV
         dU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1fxLpOvxXjmYD9btfQy/Q69rKcNISxOaD+GEumCPo2Y=;
        b=PNEwJt7xgNSSq9mVmknzGLSuPyYOfLsMIdaFFYnKH65wwxuYUR3aGh1QpOQKxZGzB6
         8sKR0gk9Fw7F7sHq/DnkJOqKojHgWzXiJqEqh5QqHL6NDaOHFXs7zmsw6EL48eUw5zmG
         BSWregTrF8FrgTrfShaEQtq7haYIpGFwP93tNQP4p2mvLjZwrpGFPrddbJt8u8cjdB+8
         HXwynB7IduRuOer/hgQN/9FdpCz+zaPdxQgjaSz86HIGIdWwADFb4BOJHwl0mhyvnZ5E
         lp5AIpM6O+sMQ1aRW5FZ+nN6rl5zJ8UyKi19WVuzkUdHVooNgKzGw0P+zQTGKYFRpGKX
         ptiQ==
X-Gm-Message-State: APjAAAUb/881ZZulMvZ8NQXnE/2yDJa26TPy1dKXZ9N5BLIzHSkqZ0C4
        1N2dF9rzwSmNGo2X9zc6nOsXtBFPhaAE1w==
X-Google-Smtp-Source: APXvYqwzQCj4RcHWe9o2dtTIHvxFq6emx/0SCFncRGSHXKEzOKo92Y/YHzeOoyawc0mNLSdPyTt7bg==
X-Received: by 2002:a17:906:7e06:: with SMTP id e6mr3271372ejr.149.1570025893804;
        Wed, 02 Oct 2019 07:18:13 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id c24sm2254422ejp.43.2019.10.02.07.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 07:18:13 -0700 (PDT)
Date:   Wed, 2 Oct 2019 16:18:10 +0200
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
Subject: Re: [PATCH v3 3/4] iommu/ioasid: Add custom allocators
Message-ID: <20191002141810.GA407870@lophozonia>
References: <1569972805-27664-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1569972805-27664-4-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569972805-27664-4-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

There seem to be a mix-up here, the changes from your v2 are lost and
patches 1 and 3 are back to v1. Assuming this isn't intended, I'll
review v2 of this patch since it looked good to me overall.

Thanks,
Jean


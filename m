Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B84CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A16B20B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHKi2HpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393683AbfITQcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:32:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35947 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391242AbfITQci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:32:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id h2so7074850edn.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WDmmqCZYXexmb0eMYG+EBBMVOjtRn4WXWY9o5YS1U8w=;
        b=XHKi2HpQvTaSkYa589k9BCAaRbhq1vYia/RSN+zRQi7UhZpXqMPGKbGrZz7sGIXaAk
         4O9q+WGUu4fcL0IATXV0mJZxtaPNNNo7tlde6UlnOA0Tb+Niquur3wEf4lK28211rCLo
         /Eb+yd5VQQ42If/e68qL+FbFI9U+N+u4vv6V46QgiTaoPpQ2OH5wcxUYEfWtMY1znh5h
         nMqygv3vOtftd1WqijSQ5m1tFGJBW/kBReEDoour9JUJsyoTHYN1gZHw/cYNQ2E1zq7O
         aSwNUfDm0cL+hwYdEPj12VhzM7L9QEVqO+6IuNkRDvItfoccVz36ICWHVNiy9JmTaCNg
         KGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WDmmqCZYXexmb0eMYG+EBBMVOjtRn4WXWY9o5YS1U8w=;
        b=QmUi0gDAkP5I4gu6V6zm8BjuV97QMzeAOw96exKD8G39iFbFxB5KXMUIK5BqGgrppM
         f6uCwMHwQeDkdf8X2QKTKSVdgGeLyz5eg9XrhmdOxYn9WiSpOdVJSOdeJU2IdNW4w3Oc
         6ARD6ssmIpWB9FCRpct2pcNzyNRmFA9Z7i4rkz3mdi8+llZGmIreSNBOv+DOSUoS+9wY
         vEnlRMyXiywevdhso5J3P+AdDy51Pk0hbn7S7U7kdizW7YqeB43ppvC/GELcGM0x38RK
         04RH9RIacRj2vZIroS3GZoKjFT6ujx4iLxseTfD9h1x1A2HSfZmgOmmvxR44JvYjaqKD
         U+Mw==
X-Gm-Message-State: APjAAAXE3cg1268yTD1YN2ccLfX+oAx1uos0zExoJRGaaYbiq+IsDYtj
        9QHkGr3iB9zqGfXQkORf6tMbcQ==
X-Google-Smtp-Source: APXvYqy5vbARL91iYKGvt6OWKfTM8NNpXTSIn1jRhrBps5tW8eSu9hv2YM1yO+cHqlw9tFdbaGY94w==
X-Received: by 2002:a17:906:5c49:: with SMTP id c9mr20162972ejr.78.1568997157032;
        Fri, 20 Sep 2019 09:32:37 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id j8sm405906edy.44.2019.09.20.09.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 09:32:36 -0700 (PDT)
Date:   Fri, 20 Sep 2019 18:32:34 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/4] iommu: Introduce cache_invalidate API
Message-ID: <20190920163234.GA1533866@lophozonia>
References: <1568849194-47874-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1568849194-47874-2-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568849194-47874-2-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 04:26:31PM -0700, Jacob Pan wrote:
> From: Yi L Liu <yi.l.liu@intel.com>
> 
> In any virtualization use case, when the first translation stage
> is "owned" by the guest OS, the host IOMMU driver has no knowledge
> of caching structure updates unless the guest invalidation activities
> are trapped by the virtualizer and passed down to the host.
> 
> Since the invalidation data can be obtained from user space and will be
> written into physical IOMMU, we must allow security check at various
> layers. Therefore, generic invalidation data format are proposed here,
> model specific IOMMU drivers need to convert them into their own format.
> 
> Signed-off-by: Yi L Liu <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

I tried to take a fresh look at this and didn't see anything
problematic, though I might have been the last one to edit it. Anyway:

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>


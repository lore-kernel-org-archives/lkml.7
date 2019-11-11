Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BCBC17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C3A21D7F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Bgw8Z2dG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfKKOFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:05:24 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:35982 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfKKOFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:05:24 -0500
Received: by mail-qv1-f67.google.com with SMTP id f12so4908818qvu.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 06:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=TUlJCeoF38DKIrVWoIThW1y6VPH1GtKS/JV6B3O9+e8=;
        b=Bgw8Z2dGCYAnlOXhOPDnkhsV3By/I0Z7d7ccWtm1tXqINtmjF4r9crBGOwA312gElP
         ZZgSr9vVjPOGi06MDhGGOwG+eqKCnnjKUrq4pcXW6QB3+zhieOT4jwQrYDhQwtaU/CJz
         bwLos1fDgh9ocIxTS0BsZ5deRjRtihP/UhG66iyMXhsHdIYA2oLAV607Vi+lfk2FZCj6
         uAhu1UKADe4jAOz1KA4HWC+wkggiNw4PqETA5ozAyYyiu0x1NT+B4Q8HtRXyz9MiZxnF
         dCr44BHhu4tzalrK2+gzFzlz2k6eSpj7pvGZeZHdkbauLL6St6r4tcIXIBmh3R+3u6KP
         nJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=TUlJCeoF38DKIrVWoIThW1y6VPH1GtKS/JV6B3O9+e8=;
        b=OYxTpDSWwG1qZvyIeDC980jJ5FAvipsfKJiyUcabaDr0FvmeQGvkj7vqT6SvEJuwcM
         60tpiDE8cN0uonMhKMU9pP1m+Wu5JkOEeRqqtebp1iPfxCxJ6vNsvPzSqN40lxvPzmgw
         d1wN07ZPP5tBAq7kcSonl1m4azToRI67dFx/SoweaUpRarJHiIzgtO4Mnarjiz6+rY2a
         4lMiN05HsV/ukeqOPLKq3M+YMEBemBZEfK1HtKZrZFV2o2c3vLbJouCs0pQRQpx0CUmS
         w3pyD43VMkLhdPnq33clRsrHr9p2oOpERQ6EBB/kkhXVuZyy2VtlJjnXiBja1ILMw8LO
         vasw==
X-Gm-Message-State: APjAAAVDZT2UrlHz52UG3p5/MPPqQX7gOgZYAVvBLpER8KH7Ra1KWXly
        iNhgP38+jCW5SUG/4oG84jEpW+pEri6tGg==
X-Google-Smtp-Source: APXvYqzqhrRm/F68CA5PU/mQDVIRouMaJ2axN9SXyskCosIsXv5cShq2L9eqdvDzzBRD/pc3m0W5VQ==
X-Received: by 2002:a05:6214:90f:: with SMTP id dj15mr9905628qvb.224.1573481122495;
        Mon, 11 Nov 2019 06:05:22 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x11sm9257781qtk.93.2019.11.11.06.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 06:05:21 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Add Kconfig option to enable/disable scalable mode
Date:   Mon, 11 Nov 2019 09:05:20 -0500
Message-Id: <77EC0C76-22C1-4982-8E0A-9AD7223B3410@lca.pw>
References: <f5b8521e-d88d-5439-34e2-f7b54a77c9d3@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
        ashok.raj@intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
In-Reply-To: <f5b8521e-d88d-5439-34e2-f7b54a77c9d3@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 11, 2019, at 12:23 AM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
> The scalable mode is defined in VT-d 3.0. The scalable mode capability
> could be checked by reading /sys/devices/virtual/iommu/dmar*/intel-
> iommu/ecap. It's currently not friendly for reading. You need to decode
> it according to the spec.

This looks like some perfect information to put in the Kconfig description.

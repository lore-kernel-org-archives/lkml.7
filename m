Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF834C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC27A21927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gFhPQZUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390875AbfISPBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:01:46 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40618 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390849AbfISPBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:01:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id v38so3490831edm.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 08:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KzQTk6xzLzucmWYoRU1s1qEtj1rE5wSKjOBqxGDWi/o=;
        b=gFhPQZUtwgWrCpL+lfpRPt59XpuIEnB98c1kiyEq+ontzS1nT6THLM3v60XXSiiotI
         2hdM97Jp9Im9zb2prqtZ/Aqt5igaCx+De8KULA2DUqDHvZNCmqg7sY5NotIT7BO4ZVGZ
         NMXP0fwNtJF3kjd0+cx2ZH3Y0EuIbqYe/R/8WS74kFPM2RRv0U2rnGplh5k2BBbjVMSL
         AQNDV/6Ovn9dmPVN2mnJpyNLagnJRgjCfQRn8lVxn1yT47GHBHHR+Yb331ZtpumZ7oXx
         jRv77JQKQog4T53rFFKSYbM4Rs6GI674XoL6AR6MTapjm4AMv6R22A/Yfbwx4T6f6eXN
         /Isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KzQTk6xzLzucmWYoRU1s1qEtj1rE5wSKjOBqxGDWi/o=;
        b=QTLwR1VTAly02jIkRDBFbqGXvlBwnM1nwqTJFP1hYq0ZhofmCUd7sF+8k6cB5xSLVP
         /ik1zyLrn7aUIFNqYeah6XmpWfIFi9DPJpYqdBQ15a4/iANIcly7AhVtdNC0PZH1jJev
         uhim4UXnfW6c8vynKPYMRg2bTQN2O3+uYOCOnG+2mWH23H4duihZNf5soVjK1zbOQU7O
         S8XApd7cNZe3e/zy4ZIXV3CDGwy6NT4FNITsf6lU9WSbcgpiEhQGRA5OdxN2AWlIsUng
         b22lbtMMPfuyZNlfyc7FS8LUBN89uC31Icn3b0S4U72BawOqDon8iIxGa+SsFyHAvUNg
         /KRw==
X-Gm-Message-State: APjAAAWPitus8JWnPxM9AkbqoInj5/ixdnQOeNl0zjt+qPGfY8O4+K/X
        Q/SmeqqeI39iTolCTW/DAZeYJg==
X-Google-Smtp-Source: APXvYqy11szzvwjni4nk4Rtsyh7bSUzszKXPgiMJKzEOHUFSjeTYlwaY1Lk6k4T/GgI6xyRlGiG3Lw==
X-Received: by 2002:a50:d5c5:: with SMTP id g5mr16735289edj.57.1568905302153;
        Thu, 19 Sep 2019 08:01:42 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id g8sm892232edm.82.2019.09.19.08.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 08:01:41 -0700 (PDT)
Date:   Thu, 19 Sep 2019 17:01:39 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        will@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
        jacob.jun.pan@linux.intel.com, joro@8bytes.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        robh+dt@kernel.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/8] iommu/arm-smmu-v3: Add support for Substream IDs
Message-ID: <20190919150139.GC1013538@lophozonia>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
 <20190610184714.6786-5-jean-philippe.brucker@arm.com>
 <af286d72-97d7-d106-40a8-edfcbe563c98@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af286d72-97d7-d106-40a8-edfcbe563c98@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 05:31:53PM +0200, Auger Eric wrote:
> Hi Jean,
> 
> On 6/10/19 8:47 PM, Jean-Philippe Brucker wrote:
> >  	/*
> > -	 * We don't need to issue any invalidation here, as we'll invalidate
> > -	 * the STE when installing the new entry anyway.
> > +	 * This function handles the following cases:
> > +	 *
> > +	 * (1) Install primary CD, for normal DMA traffic (SSID = 0).
> > +	 * (2) Install a secondary CD, for SID+SSID traffic.
> > +	 * (3) Update ASID of a CD. Atomically write the first 64 bits of the
> > +	 *     CD, then invalidate the old entry and mappings.
> Can you explain when (3) does occur?

When sharing a process context with devices (SVA), we write in that
context descriptor the ASID allocated by the arch ASID allocator for
that process. But that ASID might already have been allocated locally by
the SMMU driver for a private context. As there is a single ASID space
per SMMU for both private and shared ASIDs, we reallocated the private
ASID and update it here. See
https://lore.kernel.org/linux-iommu/20180511190641.23008-25-jean-philippe.brucker@arm.com/

> > +	 * (4) Remove a secondary CD.
> >  	 */
> > -	val = arm_smmu_cpu_tcr_to_cd(cfg->cd.tcr) |
> > +
> > +	if (!cdptr)
> > +		return -ENOMEM;
> Is that relevant? arm_smmu_get_cd_ptr() does not test ssid is within the
> cfg->s1cdmax range and always return smthg != NULL AFAIU.

It might return NULL with patch 5/8, when we can't allocate a 2nd-level
table. I can move the check over to that patch.

> > +	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &smmu_domain->s1_cfg.cd);
> cfg.cd

Right.

Thanks,
Jean

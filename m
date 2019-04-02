Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F5FC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4E920651
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HOUylC4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfDBFNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 01:13:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38286 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfDBFNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 01:13:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so5734159pfo.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 22:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=L/Txs2KhoR/LCp72vvcU/NBLIXPTwf+X2+Bnxu39Vz0=;
        b=HOUylC4O6H7b6HY6clk7VwB2uZEyPDmCxH7V4gpCHPfJCbWoTr+hnwP/+IjJXLbCd+
         XcwAAwfQeWxwUa/FkJNUjnk6FWz768VsZ5eFBFjkXXKCK+NGmOdxEdEMUs6BCMWBxc6D
         /G1IscWMcYGSMNH00xnOnDVIbb8cHXayppNdJCO9vEysx2t/pG7SipdNkQideUjfySXM
         Ihd4k00GjfzN6LYbht82nMw02NMkUxyAT0AfDnr9OKM5NuUfMxLMoIM+trw8kUOhGWWs
         fE1TdsLETACUZSGCyef8MRUx1KamQo6ScGCPSVbngygqSMs47Gs/wQjNDGu0Qruxx2/E
         tN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=L/Txs2KhoR/LCp72vvcU/NBLIXPTwf+X2+Bnxu39Vz0=;
        b=L4yFNR8uqNs3VV+hGsIOfyW8XpNGYtczqUsArgtzho3hvVF+VJj1l3DHwUhVDQ+UOT
         AbjvZGJvdrYiRr9qyodpKjgiC5TPMnO4EUMyaLQUyTgPREcmFIxzX4NqQYb0sF0HaVZN
         7rXZZ5+Qe1993S2NU5fUtHvb01UA0OM2U0MIfnhrNS2QC/yS8/E3DGq15a+EqDw5okKM
         4v8NAPhwuTTymJCSaLw3s8xUktQz8KD95iKvJXEg5w+KPHFduZKxbamrdUm53H7FdnGq
         Pvr3eOeoXMa67UO+AVuNyCli1H3o9PV51qLSL9CQLXQATjEkl0x/yGIgbBFN0zTfVnAj
         SN7g==
X-Gm-Message-State: APjAAAWFeoTzIS5OBFQCs3vM2Yr0iI5B0r7gq6MASXOd0aeoo3cldD57
        DR809qm/ZTyYFfcf1g1dNpaMR0o+zB8axw==
X-Google-Smtp-Source: APXvYqzZ+y9xLIt+i4WUmynfLgRjbUR8IDnl2a/IclmhVtwA1/TDm8mp6g/l9J03EWFu599BQQDWFg==
X-Received: by 2002:a65:50c2:: with SMTP id s2mr56714056pgp.112.1554182002761;
        Mon, 01 Apr 2019 22:13:22 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id v20sm16071480pfn.116.2019.04.01.22.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 22:13:21 -0700 (PDT)
Date:   Tue, 2 Apr 2019 06:13:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        gwendal@google.com, jettrink@chromium.org,
        andriy.shevchenko@intel.com
Subject: Re: [PATCH v3] mfd: cros_ec: instantiate properly CrOS ISH MCU device
Message-ID: <20190402051317.GS4187@dell>
References: <1551428454-596-1-git-send-email-rushikesh.s.kadam@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1551428454-596-1-git-send-email-rushikesh.s.kadam@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Mar 2019, Rushikesh S Kadam wrote:

> Integrated Sensor Hub (ISH) is also a MCU running EC
> having feature bit EC_FEATURE_ISH. Instantiate it as
> a special CrOS EC device with device name 'cros_ish'.
> 
> Signed-off-by: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
> ---
> v3
> - Dropped "Intel" in commments in cros_ec header file. CrOS EC ISH
>   device is a generic ISH. This was missed earlier. 
> v2
> - Addressed review comments to term the CrOS EC device as a generic
>   Integrated Sensor Hub. 
> v1
> - Initial version.
> 
>  drivers/mfd/cros_ec_dev.c            | 13 +++++++++++++
>  include/linux/mfd/cros_ec.h          |  1 +
>  include/linux/mfd/cros_ec_commands.h |  2 ++
>  3 files changed, 16 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

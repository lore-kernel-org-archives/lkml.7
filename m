Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2D2C33C9B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9192075D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fCNtPRJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgAHGm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 01:42:58 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51677 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgAHGm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 01:42:57 -0500
Received: by mail-pj1-f68.google.com with SMTP id j11so633596pjs.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 22:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZtpTwioIOHM3oKkj4WmZlLgVZB4n/R3M1TPcRqo5YDc=;
        b=fCNtPRJsOjRbRXG9dM5lPebrDi5XFbj5wFzvUtS7aBxMCM3GJiJ2tJAwKOvnnHQmL7
         2pFpW2lGzCNd74SpFMEosQJysPE6RFXsAtKMevjA6KVRF5h34IcVTSx8/ulpKlpqlVHW
         YRK7QEysuZ6P7b5TaeNHucq1RZbUXmLRYdPUiNChUyir28glJdilnudQ7lPXKymkkwMa
         2UUYeJucOJ5mEQqnYfXjIjeBxMq9mpwYjK2P5W5M3Tot0G9c5ct68P5vBzuHrvevmx1O
         rOxvoXJClMJneIrD2WUQVKCi/ZFM0w09P0UyQ5h+nXnCObd8KAMu0mO34G0alpIT1fCK
         lwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZtpTwioIOHM3oKkj4WmZlLgVZB4n/R3M1TPcRqo5YDc=;
        b=NwH8pH1y4tAoydhYyYwCn8ScRX0fs+NKPPvwO0pJ4mU8aIrxRMDnmheVlmjz5NL0jT
         CpjD0HMwGCuDtT8xpvqLz7ZsiXrpPrPK72lW1+ONypQv6GZ8mArt7jOSfducAKNIrd1l
         7Y61+LZf8z46goEzcPD92RG+rFHJ9zhCHi3XpsIEG4xe4zP+/IdvY4Tpuy2vKXu1h8V3
         2ciGozn1SJyE7jR23WbCtCE4rGpHACU+pJeJQqLZksEsj9bjWsXizCDsF+u17aK4qXLV
         NDnDguaSQ0LhdsnlxzrxHrB5KAqil1arQisKCvBtJTCvZSH9u3RweMb2YNO9GNm/IlWl
         iluw==
X-Gm-Message-State: APjAAAX9ZMZ0L7LmxkIEgQagRS1XwoIOkTT+UBUU8NmYZHQjSTQs307l
        HyI1dgoCnDSkWCLICy+xybb9GA==
X-Google-Smtp-Source: APXvYqxEMgW5Ysr4BiXkXBvEQfuE5aIyNEvFeF9EZwEf4kwIrghAa3H5pB9v4fkrPabT/JnTvpm9Iw==
X-Received: by 2002:a17:902:d909:: with SMTP id c9mr3678116plz.337.1578465776541;
        Tue, 07 Jan 2020 22:42:56 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d129sm1917695pfd.115.2020.01.07.22.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 22:42:55 -0800 (PST)
Date:   Tue, 7 Jan 2020 22:42:53 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Elliot Berman <eberman@codeaurora.org>
Cc:     agross@kernel.org, swboyd@chromium.org,
        Stephan Gerhold <stephan@gerhold.net>,
        saiprakash.ranjan@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        Brian Masney <masneyb@onstation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/17] Restructure, improve target support for
 qcom_scm driver
Message-ID: <20200108064253.GB4023550@builder>
References: <1578431066-19600-1-git-send-email-eberman@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578431066-19600-1-git-send-email-eberman@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07 Jan 13:04 PST 2020, Elliot Berman wrote:

> This series improves support for 32-bit Qualcomm targets on qcom_scm driver and cleans
> up the driver for 64-bit implementations.
> 
> Currently, the qcom_scm driver supports only 64-bit Qualcomm targets and very
> old 32-bit Qualcomm targets. Newer 32-bit targets use ARM's SMC Calling
> Convention to communicate with secure world. Older 32-bit targets use a
> "buffer-based" legacy approach for communicating with secure world (as
> implemented in qcom_scm-32.c). All arm64 Qualcomm targets use ARM SMCCC.
> Currently, SMCCC-based communication is enabled only on ARM64 config and
> buffer-based communication only on ARM config. This patch-series combines SMCCC
> and legacy conventions and selects the correct convention by querying the secure
> world [1].
> 
> We decided to take the opportunity as well to clean up the driver rather than
> try to patch together qcom_scm-32 and qcom_scm-64.
> 

Series applied.

Thank you,
Bjorn

> Patches 1-3 and 15 improve macro names, reorder macros/functions, and prune unused
>             macros/functions. No functional changes were introduced.
> Patches 4-8 clears up the SCM abstraction in qcom_scm-64.
> Patches 9-14 clears up the SCM abstraction in qcom_scm-32.
> Patches 16-17 enable dynamically using the different calling conventions.
> 
> [1]: https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/drivers/soc/qcom/scm.c?h=kernel.lnx.4.9.r28-rel#n555
> 
> Changes since v4:
>  - Restored missing arginfo/args to pas_auth_and_reset
> 
> Changes since v3:
>  - Updated recepients
> 
> Changes since v2:
>  - Addressed Stephen's comments throughout v2.
>  - Rebased onto latest for-next branch
>  - Removed v2 08/18 (firmware: qcom_scm-64: Remove qcom_scm_call_do_smccc)
>  - Cleaned up the convention query from v2 to align with [1].
> 
> Changes since v1:
>  - Renamed functions/variables per Vinod's suggestions
>  - Split v1 01/17 into v2 [01,02,03]/18 per Vinod's suggestion
>  - Fix suggestions by Bjorn in v1 09/18 (now v2 10/18)
>  - Refactor last 3 commits per Bjorn suggestions in v1 17/18 and v1 10/18
> 
> Changes since RFC:
>  - Fixed missing return values in qcom_scm_call_smccc
>  - Fixed order of arguments in qcom_scm_set_warm_boot_addr
>  - Adjusted logic of SMC convention to properly support older QCOM secure worlds
>  - Boot tested on IFC6410 based on linaro kernel tag:
>    debian-qcom-dragonboard410c-18.01 (which does basic verification of legacy
>    SCM calls: at least warm_boot_addr, cold_boot_addr, and power_down)
> 
> Elliot Berman (17):
>   firmware: qcom_scm: Rename macros and structures
>   firmware: qcom_scm: Apply consistent naming scheme to command IDs
>   firmware: qcom_scm: Remove unused qcom_scm_get_version
>   firmware: qcom_scm-64: Make SMC macros less magical
>   firmware: qcom_scm-64: Move svc/cmd/owner into qcom_scm_desc
>   firmware: qcom_scm-64: Add SCM results struct
>   firmware: qcom_scm-64: Move SMC register filling to
>     qcom_scm_call_smccc
>   firmware: qcom_scm-64: Improve SMC convention detection
>   firmware: qcom_scm-32: Use SMC arch wrappers
>   firmware: qcom_scm-32: Add funcnum IDs
>   firmware: qcom_scm-32: Use qcom_scm_desc in non-atomic calls
>   firmware: qcom_scm-32: Move SMCCC register filling to qcom_scm_call
>   firmware: qcom_scm-32: Create common legacy atomic call
>   firmware: qcom_scm-32: Add device argument to atomic calls
>   firmware: qcom_scm: Order functions, definitions by service/command
>   firmware: qcom_scm: Remove thin wrappers
>   firmware: qcom_scm: Dynamically support SMCCC and legacy conventions
> 
>  drivers/firmware/Kconfig           |   8 -
>  drivers/firmware/Makefile          |   5 +-
>  drivers/firmware/qcom_scm-32.c     | 671 -----------------------------
>  drivers/firmware/qcom_scm-64.c     | 579 -------------------------
>  drivers/firmware/qcom_scm-legacy.c | 242 +++++++++++
>  drivers/firmware/qcom_scm-smc.c    | 151 +++++++
>  drivers/firmware/qcom_scm.c        | 854 +++++++++++++++++++++++++++++--------
>  drivers/firmware/qcom_scm.h        | 178 ++++----
>  include/linux/qcom_scm.h           | 125 +++---
>  9 files changed, 1232 insertions(+), 1581 deletions(-)
>  delete mode 100644 drivers/firmware/qcom_scm-32.c
>  delete mode 100644 drivers/firmware/qcom_scm-64.c
>  create mode 100644 drivers/firmware/qcom_scm-legacy.c
>  create mode 100644 drivers/firmware/qcom_scm-smc.c
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project

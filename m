Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FF5C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80527217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xVg4PJse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388816AbfEXBiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 21:38:52 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38325 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388762AbfEXBiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 21:38:50 -0400
Received: by mail-qk1-f194.google.com with SMTP id p26so2522780qkj.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 18:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BD8gsIvGveusm922tD1e2XMMn8H4dDeMiU5yfjezjZI=;
        b=xVg4PJseLvecfb9jz98prCdPoo9JQYisyN8ivZrwv0hVZSOVec7u8vyLPiJq1+AWkU
         xORi9/5fKgn1vYui99U0fVJvpP7Dcq6vdalwSuLo8zeRtE2qiHYW7xyaclgO3BgWgcUs
         hYoiRoYWFJcgtf34suZ4wcYNRghBczu4DMsNX4G89r2iXKVQoXBp67z0GaQTk51FzN4L
         rrdhxO61WsmSUNowOgD2qwQcBg03svO7TEO3Y4wE7v6ct7MaMYxuyIGg2daJ76EocMK9
         gdAdbpFVldM/rdtSs9O/n1vAh/FNLGi2O39ytO+3jdyJkOeeMsV44+RyLHGNIabnoYP1
         SxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BD8gsIvGveusm922tD1e2XMMn8H4dDeMiU5yfjezjZI=;
        b=P2RMqVv+2D60iaeZnaTsNnI1xSy4pw0gkVoE5oNirfdISpVvD/CgEwGG9NCYwe4ABS
         sOSdLdjrvz7KTaSWnNN1QmOyF6H7pUUm3VZzF1J52IDu6Sx1cjkun1lineBrwsfn5ZkA
         /vVb3pkFhcROFI3tVw1HBPm0hu9RgpPLNkfR8llJp5bIivqMkD99xDnrth9N6PbETxxL
         ZO/pEAfb1uK4ahifJd0fWqynEmZeHEDNoMCU3q2OWn18dTLOnPZqBxk5tdt+pbJ2IvOv
         h5DiKSgG2jjtgfwVWXJO+IkejMRfC9TDKTJquFQqjxkcOCHbjH2pE0HWz1Vgc2y2xx5f
         r8ww==
X-Gm-Message-State: APjAAAUHWluS7FoY4PjZ/6Dk6f0zWS4BjKtEaicSavAa0RtS8jG+qlVS
        ySduaBT8/pjWjobUB09Cp87O/rcCRE5+Sg==
X-Google-Smtp-Source: APXvYqwYIIZ/sR4oA2tEC93zoJvGsRR2w2lnu7OyHYSXPUgaNp8l91gDLyUIatxi+0C1sLDmYy+s8g==
X-Received: by 2002:a37:8703:: with SMTP id j3mr18291782qkd.188.1558661929282;
        Thu, 23 May 2019 18:38:49 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li483-211.members.linode.com. [50.116.44.211])
        by smtp.gmail.com with ESMTPSA id d58sm775782qtb.11.2019.05.23.18.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 18:38:48 -0700 (PDT)
Date:   Fri, 24 May 2019 09:38:42 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/30] coresight: Support for ACPI bindings
Message-ID: <20190524013842.GA5971@leoy-ThinkPad-X240s>
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
 <20190523143227.GC31751@leoy-ThinkPad-X240s>
 <23a50436-4bcf-3439-c189-093e1a58438d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23a50436-4bcf-3439-c189-093e1a58438d@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Thu, May 23, 2019 at 04:31:54PM +0100, Suzuki K Poulose wrote:

[...]

> > When you send out the new patch for exposing device connection, please
> > loop me so that I can base on it for perf testing related works.
> 
> Sure, will do.

Thanks a lot!

> As such, the perf testing should not be affected by that
> series. It is just a helper to demonstrate the connections. But yes, it
> will definitely help you to choose an ETF for a cluster, if you had multiple
> ETFs on the system. Otherwise, you should be OK.

Yeah, the perf testing approach is heavily based on sysfs out/in nodes
to find the trace pathes.

> Please be aware that the power management support is missing on ACPI platform.
> So you must make sure, by other means, that the debug domain is powered up.

Thanks for reminding; for the first step, I will not add any power
management enabling steps in the testing script, we can add the
related operations if later we have clear idea for this.

Thanks,
Leo Yan

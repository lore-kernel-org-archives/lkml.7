Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5B2C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A5320717
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sWqbqkCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfE1IJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:09:06 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:44730 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfE1IJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:09:05 -0400
Received: by mail-qk1-f173.google.com with SMTP id w187so10915301qkb.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 01:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xDOcfUm0hx1+moO7XUT4Qyuo28lq60TTV8oVJkJSDf8=;
        b=sWqbqkCcghXKhwjI3+Xh42gDOmLmikpVTRsgukr3jx+YA5eCGhQcPo2m93RTOPkLHB
         8fDzk0VoiU/nu0XtdRzDzm1BcyM5HaHfOEK8B6n4ScId52EtujnwrJtfsa3SZQFzt97H
         U3fwH09XvO7mt4qR588300BgcxUiO5wI+2dWpO2YYhIUiAPev1fe11v6d31JGQV9oJyW
         9mVCTrrOysEPJx7qWQisEpks+LiURbb/tVwuawJtM6YkK6N7W+zHJuVDcealqD8XzFlj
         0+94ZgNIRc+kTPajYrWDhPUxMEyVUv5sTA2qi9aZAG/OYnhA4VcohWEqjMSRjm+YyL9k
         MJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xDOcfUm0hx1+moO7XUT4Qyuo28lq60TTV8oVJkJSDf8=;
        b=RrB2y/VYSXXYByvw+yB57h77tJYDNUYsKrmA0H0Oq+w+LHV9pisXrNeSvWm3XL+jaV
         dNqEY2xNx9vUY0LgEy5xDh5ykT/hR9CB+tmao/s8KdEEiDcvg2gIr5sdOaOBxTlXi6c2
         UYlEmZx4txuNqIwyOOtDbv6gE8QWqZA5Ca95ZInRrXUHOO/zF9cv7VFz/X4BGrt5zDHj
         UPQKbsNHp4sJe/tWVM5577CvYEkCiKn9BPGscqkZpHJYqajkabk0O3zIz7MsdORD3S3T
         lGC/XXJEB8gvs7nNmOTakmDgS5f5EPXfO0jUU6uajQXeJ7mS+YBMPtdVrLGjw1J9t5gd
         hsEQ==
X-Gm-Message-State: APjAAAVxYKHd7PponcxuY1iuSKOHvnEy19Dvf6BAXJoSgukXK0lNFGgT
        xGOw71m7iaMIY9Ttp/289qORgw==
X-Google-Smtp-Source: APXvYqzfmlI/oHiU+Uq4sz7SDPAZyh1TsYqXiHyhgextGozcdW+UWA5iJ+nmKdMmrLAMcPrhVYv2GA==
X-Received: by 2002:ac8:1bec:: with SMTP id m41mr98723878qtk.272.1559030944933;
        Tue, 28 May 2019 01:09:04 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li483-211.members.linode.com. [50.116.44.211])
        by smtp.gmail.com with ESMTPSA id f67sm5267299qtb.68.2019.05.28.01.08.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 01:09:03 -0700 (PDT)
Date:   Tue, 28 May 2019 16:08:53 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/30] coresight: Support for ACPI bindings
Message-ID: <20190528080853.GB5753@leoy-ThinkPad-X240s>
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
 <20190528051924.GA19112@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528051924.GA19112@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki, Mathieu,

On Tue, May 28, 2019 at 01:19:24PM +0800, Leo Yan wrote:

[...]

> After I applied this patch set, I found all device names under
> '/sys/bus/event_source/devices/cs_etm/sinks/' have been changed as
> below on my DB410c board:
> # ls /sys/bus/event_source/devices/cs_etm/sinks/
> tmc_etf0  tmc_etr0  tpiu0
> 
> This leads to below command failure when open PMU device:
> # perf record -e cs_etm/@826000.etr/ --per-thread uname
> failed to set sink "826000.etr" on event cs_etm/@826000.etr/ with 2 (No such file or directory)
> 
> I must use below command so that perf can match string with the
> device name under '/sys/bus/event_source/devices/cs_etm/sinks/':
> # perf record -e cs_etm/@tmc_etr0/ --per-thread uname
> 
> Seems to me, this is an unexpected change and when I worked on the
> patch set v2, IIRC that version still can use '826000.etr' to open PMU
> device.
> 
> Please help confirm for this.  Thanks!

Finally, this is narrowed down to the patch 09/30 'coresight: Use
coresight device names for sinks in PMU attribute', so this is
delibrately to change to use new name format for perf command;
if so, maybe also update the documentation to reflect this change?

Thanks,
Leo Yan

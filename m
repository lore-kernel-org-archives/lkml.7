Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC40C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0BC2081C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="au44pDeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfE1Ovc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 10:51:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46683 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfE1Ova (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 10:51:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id bb3so827140plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 07:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4htO74nlZTTjjSOZRb+2oGEss+Qcefe+hGWQCyYkWoQ=;
        b=au44pDegu6gwO+Cf4teDgSVrwJlkGNEtG6C7VatYjseuou/yAacTS7Evb5615xq3g+
         CQ2KSL3YZAs5nW/Lu1FAkoZiLAg//aOMW1cai/0fWPB//zHyX7fonkQudab87mrGCWwO
         0rAlaXMI0UCuAAOuwoDiVWHn7Jp4SbacA+da05vZMNGzDhCnvgcFBtasTYz547ybOgq/
         dp0EQrHKeo1v1ougIdh51QKOB/otNfr9UrlhpwTdNPvZgTPKXs9VgQ5f1CloYbiU1dV2
         Rw7OzaW0syjJt2WODgNPxMcD1qxAm00CSJVg/dNu4RKe8HOo+iZW0uMPI8Ate3xRG+Zt
         WZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4htO74nlZTTjjSOZRb+2oGEss+Qcefe+hGWQCyYkWoQ=;
        b=hSFBgysqS6UGF+mP8dL6FxbW/drc85xcaPF7Avviz0Bpofq7lV/CVafJgMehh63TgQ
         4gWR2tnJFenUvAOzQB7fVKiT0OSqqgKvAh6POnZU/3gTJF0iqqzpOmQx5x6PBRW+uFyI
         EILATL+VrLC8M2TxrFKpZi0HmYHhAknEX8gWt2ujK/5Ixwu6Sa01pe7SIgz94TiIi7aR
         Pqo8/pwXtpdSHgDPgK/Mo2GBg90mGDK8JXzEsIpX7pA5NJ4D0Oc4CnX7CjP6jEPxbaif
         5x35oqPeR/wQ0e6G/8oNT2RvsFjjh61WgY5gfCHqoXQLtXyaB76f6BjENNxKPk6eL74r
         PZDg==
X-Gm-Message-State: APjAAAUlsIfsX/cbFKr/rw1kK7TO5zmqhLtKekFw4KiQAbs/F2kKOvpP
        SiDHLk8E7it8yg6nE1kNOZdW9g==
X-Google-Smtp-Source: APXvYqy3PNdTZipQ9Cj8tf7D5aG0YpWARynwkOVz5AcSSOfamZYs+WVN/eD3PulYkH/LJp02pSfptg==
X-Received: by 2002:a17:902:760f:: with SMTP id k15mr60674375pll.125.1559055089555;
        Tue, 28 May 2019 07:51:29 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m1sm2701885pjv.22.2019.05.28.07.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 07:51:28 -0700 (PDT)
Date:   Tue, 28 May 2019 08:51:26 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/30] coresight: Support for ACPI bindings
Message-ID: <20190528145126.GA20714@xps15>
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

Good day,

On Tue, May 28, 2019 at 01:19:24PM +0800, Leo Yan wrote:
> Hi Suzuki,
> 
> On Wed, May 22, 2019 at 11:34:33AM +0100, Suzuki K Poulose wrote:
> > This series adds the support for CoreSight devices on ACPI based
> > platforms. The device connections are encoded as _DSD graph property[0],
> > with CoreSight specific extensions to indicate the direction of data
> > flow as described in [1]. Components attached to CPUs are listed
> > as child devices of the corresponding CPU, removing explicit links
> > to the CPU like we do in the DT.
> > 
> > The majority of the series cleans up the driver and prepares the subsystem
> > for platform agnostic firwmare probing, naming scheme, searching etc.
> > 
> > We introduce platform independent helpers to parse the platform supplied
> > information. Thus we rename the platform handling code from:
> > 	of_coresight.c  => coresight-platform.c
> > 
> > The CoreSight driver creates shadow devices that appear on the Coresight
> > bus, in addition to the real devices (e.g, AMBA bus devices). The name
> > of these devices match the real device. This makes the device name
> > a bit cryptic for ACPI platform. So this series also introduces a generic
> > platform agnostic device naming scheme for the shadow Coresight devices.
> > Towards this we also make changes to the way we lookup devices to resolve
> > the connections, as we can't use the names to identify the devices. So,
> > we use the "fwnode_handle" of the real device for the device lookups.
> > Towards that we clean up the drivers to keep track of the "CoreSight"
> > device rather than the "real" device. However, all real operations,
> > like DMA allocation, Power management etc. must be performed on
> > the real device which is the parent of the shadow device.
> > 
> > Finally we add the support for parsing the ACPI platform data. The power
> > management support is missing in the ACPI (and this is not specific to
> > CoreSight). The firmware must ensure that the respective power domains
> > are turned on.
> > 
> > Applies on v5.2-rc1
> > 
> > Tested on a Juno-r0 board with ACPI bindings patch (Patch 31/30) added on
> > top of [2]. You would need to make sure that the debug power domain is
> > turned on before the Linux kernel boots. (e.g, connect the DS-5 to the
> > Juno board while at UEFI). arm32 code is only compile tested.
> 
> After I applied this patch set, I found all device names under
> '/sys/bus/event_source/devices/cs_etm/sinks/' have been changed as
> below on my DB410c board:
> # ls /sys/bus/event_source/devices/cs_etm/sinks/
> tmc_etf0  tmc_etr0  tpiu0

Yes, that is the expected behavior.

> 
> This leads to below command failure when open PMU device:
> # perf record -e cs_etm/@826000.etr/ --per-thread uname
> failed to set sink "826000.etr" on event cs_etm/@826000.etr/ with 2 (No such file or directory)

Correct.

> 
> I must use below command so that perf can match string with the
> device name under '/sys/bus/event_source/devices/cs_etm/sinks/':
> # perf record -e cs_etm/@tmc_etr0/ --per-thread uname

Correct.

> 
> Seems to me, this is an unexpected change and when I worked on the
> patch set v2, IIRC that version still can use '826000.etr' to open PMU
> device.

Correct - v2 did not address the new naming convention for devices present under
'event_source', something that was corrected in v3.

 
> Please help confirm for this.  Thanks!
> 
> Leo.

Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94341C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 06:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFA221019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 06:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A0ThL7X9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfE2Ge4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 02:34:56 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43869 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfE2Gez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 02:34:55 -0400
Received: by mail-oi1-f195.google.com with SMTP id t187so1105171oie.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 23:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=32oNNfOBxR/dIJDiqOCCeX3FJ2erRbG9x3SCfpFAaFc=;
        b=A0ThL7X9hLFBwyv6iK++tvStLIKMPWGta2pKdZiVten8r/ND4jT+vyGCCE5oL3sH4K
         APmx7ul95R/6gOgmEKWfoVrpaGhcozdHFgqQI4OAWBFMI0KT5KqgwRam+1TzGFVE8UzN
         AAIJVGcoqGd8spLrUOFgdK44JrEKVFmEoFOD6ccDslM4FoQiBPlpqGODKufQm61utEkj
         IyY35WqR1UX4/a4EJMV6Gi9xkOO4K6Zz4YvKInXqb3CR5bnZ1pP9WLciOAz6pR/rykjo
         6wQ4dz2Xsskpd3n7gHc9OUls52XyE3gyNqL52tMRc3LNph5j4qxbiRJWnhoqBxUr2S7E
         wb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=32oNNfOBxR/dIJDiqOCCeX3FJ2erRbG9x3SCfpFAaFc=;
        b=qejmYkoeh2KKvgL4ViwhqShgm9NeQMRyEINoYcHSka4FevuBF+GAHWTuycFbis7YQl
         G1/0qBsBwbwhkRqu1sfYS6Qk7umCppFmmyNGGvw5IDZshL195VrXynXF4pN7kmIdbrpy
         Hm93/LGMU47GQkn616Bw5+YLpGBkNZt2GgQS3TlZnNLXH8VuMxxryFSzRZVJAtcfzm4g
         UOOY8Eafymzb+jWokGIU6ONt40kifStFhZNBIzkp4EVecNi/w5XoqyxGFhsYxd91lEOF
         AznH5s3J4G+Xyt34PtAHCk2oSdT4M5tvqng85aJXc75JNLA3pEgn/J2Zl0x8OqoSkY+v
         Tnjg==
X-Gm-Message-State: APjAAAUp3sd8LaRifG3on/2U7Pz58KgHIE3RXwhuoSJvh4mRJk6oP14i
        6DcRbrkAbhHpRqsfvid7dT5f0A==
X-Google-Smtp-Source: APXvYqxHsfGGqbhU2XvuVpniJ59bCKj++ACikAww1d20dZ3Q6JWKSdvvP6mQjxwxg5tf7cOqfRU+xw==
X-Received: by 2002:aca:342:: with SMTP id 63mr5026668oid.10.1559111695072;
        Tue, 28 May 2019 23:34:55 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li808-42.members.linode.com. [104.237.132.42])
        by smtp.gmail.com with ESMTPSA id l184sm6005234oih.49.2019.05.28.23.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 23:34:54 -0700 (PDT)
Date:   Wed, 29 May 2019 14:34:49 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/30] coresight: Support for ACPI bindings
Message-ID: <20190529063449.GA15808@leoy-ThinkPad-X240s>
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
 <20190528051924.GA19112@leoy-ThinkPad-X240s>
 <20190528145126.GA20714@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528145126.GA20714@xps15>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 08:51:26AM -0600, Mathieu Poirier wrote:
> Good day,
> 
> On Tue, May 28, 2019 at 01:19:24PM +0800, Leo Yan wrote:
> > Hi Suzuki,
> > 
> > On Wed, May 22, 2019 at 11:34:33AM +0100, Suzuki K Poulose wrote:
> > > This series adds the support for CoreSight devices on ACPI based
> > > platforms. The device connections are encoded as _DSD graph property[0],
> > > with CoreSight specific extensions to indicate the direction of data
> > > flow as described in [1]. Components attached to CPUs are listed
> > > as child devices of the corresponding CPU, removing explicit links
> > > to the CPU like we do in the DT.
> > > 
> > > The majority of the series cleans up the driver and prepares the subsystem
> > > for platform agnostic firwmare probing, naming scheme, searching etc.
> > > 
> > > We introduce platform independent helpers to parse the platform supplied
> > > information. Thus we rename the platform handling code from:
> > > 	of_coresight.c  => coresight-platform.c
> > > 
> > > The CoreSight driver creates shadow devices that appear on the Coresight
> > > bus, in addition to the real devices (e.g, AMBA bus devices). The name
> > > of these devices match the real device. This makes the device name
> > > a bit cryptic for ACPI platform. So this series also introduces a generic
> > > platform agnostic device naming scheme for the shadow Coresight devices.
> > > Towards this we also make changes to the way we lookup devices to resolve
> > > the connections, as we can't use the names to identify the devices. So,
> > > we use the "fwnode_handle" of the real device for the device lookups.
> > > Towards that we clean up the drivers to keep track of the "CoreSight"
> > > device rather than the "real" device. However, all real operations,
> > > like DMA allocation, Power management etc. must be performed on
> > > the real device which is the parent of the shadow device.
> > > 
> > > Finally we add the support for parsing the ACPI platform data. The power
> > > management support is missing in the ACPI (and this is not specific to
> > > CoreSight). The firmware must ensure that the respective power domains
> > > are turned on.
> > > 
> > > Applies on v5.2-rc1
> > > 
> > > Tested on a Juno-r0 board with ACPI bindings patch (Patch 31/30) added on
> > > top of [2]. You would need to make sure that the debug power domain is
> > > turned on before the Linux kernel boots. (e.g, connect the DS-5 to the
> > > Juno board while at UEFI). arm32 code is only compile tested.
> > 
> > After I applied this patch set, I found all device names under
> > '/sys/bus/event_source/devices/cs_etm/sinks/' have been changed as
> > below on my DB410c board:
> > # ls /sys/bus/event_source/devices/cs_etm/sinks/
> > tmc_etf0  tmc_etr0  tpiu0
> 
> Yes, that is the expected behavior.
> 
> > 
> > This leads to below command failure when open PMU device:
> > # perf record -e cs_etm/@826000.etr/ --per-thread uname
> > failed to set sink "826000.etr" on event cs_etm/@826000.etr/ with 2 (No such file or directory)
> 
> Correct.
> 
> > 
> > I must use below command so that perf can match string with the
> > device name under '/sys/bus/event_source/devices/cs_etm/sinks/':
> > # perf record -e cs_etm/@tmc_etr0/ --per-thread uname
> 
> Correct.
> 
> > 
> > Seems to me, this is an unexpected change and when I worked on the
> > patch set v2, IIRC that version still can use '826000.etr' to open PMU
> > device.
> 
> Correct - v2 did not address the new naming convention for devices present under
> 'event_source', something that was corrected in v3.

Thanks for confirmation, Mathieu.

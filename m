Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6827C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE82216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VT9e/3yi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfE1RgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 13:36:19 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:47083 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfE1RgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:36:19 -0400
Received: by mail-io1-f68.google.com with SMTP id u25so898066iot.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 10:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aV83MWqVrs73/rZto20+uCA1itr43gbkk2Ocg5RD+lI=;
        b=VT9e/3yiMIFCZcvTwZ8i/MsJVhw154QE77tmlINEA88m7HhsJ1LaG04AUorwUZ3Z11
         Fk9maKkm6OobTPlJzcy4b2P7a8ImmRtEP5I8aPjkfkm1Mu7KNRiV2iJzCKOhSG+J/Lfu
         YLuSdrEHRAm87PlAKt5Gk7e1we4HaTzB21JcVXjJWZCrCcr34uJp3QOQQVJYev/0JHQd
         Hfle0iheN4Ufyskh2BYvW+8a9Z2S20TqeMijuFUQPIlJ6uz9a4mUW9lvT+7oCK2MBTGK
         OxxMWiJkHc+4de/xVYNTq4hFg81Mdm0C1IpMLumEMaI55/65A4oAy12obDs9jGroLWNp
         SBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aV83MWqVrs73/rZto20+uCA1itr43gbkk2Ocg5RD+lI=;
        b=iUpmg3jl3E9nx9wEx6aGRKS6o+dyuUCfpdw1mpVcsKdhQKKw63cMGy6K5VcamyoRbq
         7LhwOHsfTMJx3MWzl7LLo2mPoHuneytYnQf7vOLciXFeEDea2ab4fmL92D0k+aF7QopO
         76W0+giAj4JjqR+EndJRj/HYUm2UziMb+5GeMgX2qhooqtZGEqOHAC8PY9kAHwiXsY2N
         7HN7S2r3wAITApU8UCMcbvfxufUTqZgFX/76xln2Rq/qDtCfGzpL3fK0DKghTywjlhap
         QmB2KtlxzCAHszwNW0mz4qFnThv6fg44dZI7ivO6LIeUYDrCIWCMVNCZW/SS8UHuFTWk
         /7Jg==
X-Gm-Message-State: APjAAAXdGpreaxwDmZVpX8Pu6GuDo5DijIJirnOFQP4kIKPibMe2SeX6
        L7SxFf4GukxlUnvhn+mwDh/1wMA+w82zYIaT3v4aeCzhs0c=
X-Google-Smtp-Source: APXvYqzw4aa78ydNOscrUl5J1XO+DyDVCpzUub7yBc9JUhk30qWcmvo4lbzK2HGEjG2AWNX62qfyCbiG7lyTcRC3Shc=
X-Received: by 2002:a6b:780b:: with SMTP id j11mr408220iom.57.1559064978510;
 Tue, 28 May 2019 10:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com> <CANLsYkzRXXB1EFpWHn6JN_6pfOm-1TvVgiJY2MKExhifiBakBQ@mail.gmail.com>
In-Reply-To: <CANLsYkzRXXB1EFpWHn6JN_6pfOm-1TvVgiJY2MKExhifiBakBQ@mail.gmail.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 28 May 2019 11:36:07 -0600
Message-ID: <CANLsYkzK7N9Bt6E6f187LaDydeC5afMp=LjMuvhFYKbij_SyjA@mail.gmail.com>
Subject: Re: [PATCH v4 00/30] coresight: Support for ACPI bindings
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019 at 11:32, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Wed, 22 May 2019 at 04:35, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >
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
> >         of_coresight.c  => coresight-platform.c
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
> >
> > [0] ACPI Device Graphs using _DSD (Not available online yet, approved but
> >     awaiting publish and eventually should be linked at).
> >     https://uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel-1_1.htm
> > [1] https://developer.arm.com/docs/den0067/latest/acpi-for-coresighttm-10-platform-design-document
> > [2] https://github.com/tianocore/edk2-platforms.git
> >
> > Changes since v3:
> >  - Add tags from Mathieu
> >
> > Changes since v2:
> >  - Fix the symlink name for ETM devices under cs_etm PMU (Patch by Mathieu)
> >  - Drop patches merged already in the tree.
> >  - Add the tags from Mathieu
> >  - More documentation with examples of ACPI graph in ACPI bindings support.
> >  - Fix ETM4 error return path (Mathieu)
> >  - Drop the patches exposing device links via sysfs, to be posted as separate
> >    series.
> >  - Drop the generic helper for device search by fwnode for a better cleanup
> >    later.
> >  - Split the ACPI bindings support patch for AMBA and platform devices.
> >  - Return integer error for <platform>_get_platform_data() helpers.
> >  - Fix comment about the return code for acpi_get_coresight_cpu().
> >  - Ensure we don't have devices part of multiple graphs (Mathieu).
> >
> > Changes since v1:
> >
> >  [ http://lists.infradead.org/pipermail/linux-arm-kernel/2019-March/639963.html ]
> >
> >   - Dropped the replicator driver merge changes as they were pulled already.
> >   - Cleanups for Power management in the drivers.
> >   - Reuse platform description for connection information. Also introduce
> >     routines to clean up the platform description to make sure we drop
> >     the references (fwnode_handle).
> >   - Add RFC patches for exposing the device-links via sysfs.
> >   - Drop tracking the device in favour of coresight_device.
> >   - Name etb10 as "etb"
> >   - Fix other comments in v1.
> >   - Use a generic helper for searching with fwnode_handle rather than adding
> >     one for CoreSight.
> >
> >
> > Mathieu Poirier (1):
> >   coresight: Use coresight device names for sinks in PMU attribute
> >
> > Suzuki K Poulose (29):
> >   coresight: funnel: Clean up device book keeping
> >   coresight: replicator: Cleanup device tracking
> >   coresight: tmc: Clean up device specific data
> >   coresight: catu: Cleanup device specific data
> >   coresight: tpiu: Clean up device specific data
> >   coresight: stm: Cleanup device specific data
> >   coresight: etm: Clean up device specific data
> >   coresight: etb10: Clean up device specific data
> >   coresight: Rename of_coresight to coresight-platform
> >   coresight: etm3x: Rearrange cp14 access detection
> >   coresight: stm: Rearrange probing the stimulus area
> >   coresight: tmc-etr: Rearrange probing default buffer size
> >   coresight: platform: Make memory allocation helper generic
> >   coresight: Make sure device uses DT for obsolete compatible check
> >   coresight: Introduce generic platform data helper
> >   coresight: Make device to CPU mapping generic
> >   coresight: Remove cpu field from platform data
> >   coresight: Remove name from platform description
> >   coresight: Cleanup coresight_remove_conns
> >   coresight: Reuse platform data structure for connection tracking
> >   coresight: Rearrange platform data probing
> >   coresight: Add support for releasing platform specific data
> >   coresight: platform: Use fwnode handle for device search
> >   coresight: Use fwnode handle instead of device names
> >   coresight: Use platform agnostic names
> >   coresight: stm: ACPI support for parsing stimulus base
> >   coresight: Support for ACPI bindings
> >   coresight: acpi: Support for AMBA components
> >   coresight: acpi: Support for platform devices
> >
> >  drivers/acpi/acpi_amba.c                           |   9 +
> >  drivers/hwtracing/coresight/Makefile               |   3 +-
> >  drivers/hwtracing/coresight/coresight-catu.c       |  40 +-
> >  drivers/hwtracing/coresight/coresight-catu.h       |   1 -
> >  drivers/hwtracing/coresight/coresight-cpu-debug.c  |   3 +-
> >  drivers/hwtracing/coresight/coresight-etb10.c      |  51 +-
> >  drivers/hwtracing/coresight/coresight-etm-perf.c   |   8 +-
> >  drivers/hwtracing/coresight/coresight-etm.h        |   6 +-
> >  .../hwtracing/coresight/coresight-etm3x-sysfs.c    |  12 +-
> >  drivers/hwtracing/coresight/coresight-etm3x.c      |  45 +-
> >  drivers/hwtracing/coresight/coresight-etm4x.c      |  37 +-
> >  drivers/hwtracing/coresight/coresight-etm4x.h      |   2 -
> >  drivers/hwtracing/coresight/coresight-funnel.c     |  35 +-
> >  drivers/hwtracing/coresight/coresight-platform.c   | 810 +++++++++++++++++++++
> >  drivers/hwtracing/coresight/coresight-priv.h       |   4 +
> >  drivers/hwtracing/coresight/coresight-replicator.c |  42 +-
> >  drivers/hwtracing/coresight/coresight-stm.c        | 118 ++-
> >  drivers/hwtracing/coresight/coresight-tmc-etf.c    |   9 +-
> >  drivers/hwtracing/coresight/coresight-tmc-etr.c    |  44 +-
> >  drivers/hwtracing/coresight/coresight-tmc.c        |  96 +--
> >  drivers/hwtracing/coresight/coresight-tmc.h        |   2 -
> >  drivers/hwtracing/coresight/coresight-tpiu.c       |  24 +-
> >  drivers/hwtracing/coresight/coresight.c            | 164 ++++-
> >  drivers/hwtracing/coresight/of_coresight.c         | 297 --------
> >  include/linux/coresight.h                          |  61 +-
> >  25 files changed, 1332 insertions(+), 591 deletions(-)
> >  create mode 100644 drivers/hwtracing/coresight/coresight-platform.c
> >  delete mode 100644 drivers/hwtracing/coresight/of_coresight.c
>
> I have applied this set.

As Leo pointed out it would be interesting to update the documentation
in "Documentation/trace/coresight.txt".

>
> Thanks,
> Mathieu
>
> >
> > ACPI bindings for Juno-r0 (applies on [2] above)
> >
> > Suzuki K Poulose (1):
> >   edk2-platform: juno: Update ACPI CoreSight Bindings
> >
> >  Platform/ARM/JunoPkg/AcpiTables/Dsdt.asl | 241 +++++++++++++++++++++++++++++++
> >  1 file changed, 241 insertions(+)
> >
> > --
> > 2.7.4
> >

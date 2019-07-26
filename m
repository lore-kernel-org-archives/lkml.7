Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD65C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C524822C7E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H6VEWoLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfGZT5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:57:43 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30863 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfGZT5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564171063; x=1595707063;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=QBDHM2QuOIDcoSjew6sW8UylfxuzHuoReuIX707TDg4=;
  b=H6VEWoLTz7IJdlu/D91fqRCTvtH4g3CBgnaeKDEf399UVAMgLSC+B06Y
   kwKIZ+tvz7k468d8MteMH7CL6PuCS3WOg+v7Kyj00EpKbyd/lgO9o5CTb
   ShLDSsGyoIGgISmxHgD6IgLxqtswTDAsKDXahoQe9EV/blDhuxnfYvYc4
   vLceZHobexIMp5VMqYsVs3HX5Dbjs1Dm8fpSAJrj+YJiB63YYri4EFt1M
   n1eRdzeDVpJJVvr+nzFdhler7NIB8XnoyaqMX7agxhYAQhGPOKFZR0O5Q
   ZR3EE4/Nr4ebQ7d8lP2G5YaBQFcqojLfrgnMQZi1+ZGo5eDDo2GYSlIQw
   Q==;
IronPort-SDR: nNcO6OLZZiTMbascjVoRZnsMtZZsTBbzCiMJW4cDyKfAR0f9FMcinyNMCIUS2B+zMrs06m25Y+
 vCyX7htZUrSH3CaHH+oe7HN8ezrlHXYXwgpUEAVzWaYhgnuJ4mUbTxxRvrtOpnSXXvbVCubdaK
 JaF16lSJjsKJIYdP+TKAmQpsxwKhi3idy1oQgBO8seK8Gd26Y03BocDT0sGfyHGughGSE3a18h
 E3fmBUwghGk2bICdydXZnRntsBeYCWk6GKH0RCUTvPCrmpjg7GOiV4hlJE4dWjBPHew4YTsmJW
 n6k=
X-IronPort-AV: E=Sophos;i="5.64,312,1559491200"; 
   d="scan'208";a="115275100"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2019 03:55:39 +0800
IronPort-SDR: 8LPrpYh19xnDsQE0izFTFdBQs5tc9wI7e1QXBWiJNSpQETnZ+YjP6eICQ/tmboqHFYmaRgla99
 5r4+04++4geaCKkV/XeD6RT/BUJINKbOs6jLxkFatPCnqrT9c39PgbIwVdO9V/YswxfmpuO6CC
 lgmXe0x7O2ZRJ1v/x+GXUydYabQZiKIX1RlEX2E//uZlNtG8nG+qAwpuAuaPkzngblDLsIG/W6
 VJzEziSiOBXbV5y4lTzm28gED1zZrJndxwLlo97iizVoDg3Nv2KXJKLTAFhJyf0cSbA2BvTOwg
 gv6ADyObGkyr05ml7CzTZ2kD
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Jul 2019 12:53:48 -0700
IronPort-SDR: jt1iwJjO+UmUWfIifTmRgCjwAeMfW0RoIJnBpBx69FB4ukWCIxoG/e+596RpstmduUnDR0BgLW
 +m/UD6Kt+1Jo3HsPmuqIi3FJC3neC9MFO+PLwzwJxW4doLmTjF/MRAQheWndDqfPi9QPZfGEWC
 ZWAwI8MFyNTebGrMhf3AslZ5udniXOtAabGgqQTXEKW4Q3JPnBiNVKUCM1svnDAmi9sn1fj8j+
 ay4OJIRcmX/AV8QCUbuS1v5U1DQp5CkaUujBw5BiH6wAq3I9MrW3pYVApCmaOdt9BkCqX2VUWR
 Tbc=
Received: from unknown (HELO [10.225.104.231]) ([10.225.104.231])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jul 2019 12:55:39 -0700
Subject: Re: [PATCH 0/7] Fix broken references to files under Documentation/*
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?=c5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
References: <cover.1564140865.git.mchehab+samsung@kernel.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <04794d40-0b39-0223-c91e-03b46cb6e2db@wdc.com>
Date:   Fri, 26 Jul 2019 12:55:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1564140865.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/19 4:47 AM, Mauro Carvalho Chehab wrote:
> Solves most of the pending broken references upstream, except for two of
> them:
> 
> 	$ ./scripts/documentation-file-ref-check
> 	Documentation/riscv/boot-image-header.txt: Documentation/riscv/booting.txt
> 	MAINTAINERS: Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt
> 
> As written at boot-image-header.txt, it is waiting for the addition of
> a future file:
> 
> 	"The complete booting guide will be available at
> 	  Documentation/riscv/booting.txt."
> 

Yeah. We don't have complete booting guide defined in RISC-V land.
Documentation/riscv/booting.txt will be available once we have that.

In the mean time, do we need to convert boot-image-header.txt to 
boot-image-header.rst and fix the reference to 
Documentation/riscv/booting.rst as well ?

> The second is due to this patch, pending to be merged:
> 	https://lore.kernel.org/patchwork/patch/994210/
> 
> I'm not a DT expert, but I can't see any issue with this patch, except
> for a missing acked-by a DT maintainer, and a possible conversion to
> yaml. IMO, the best fix for this would be to merge the DT patch.
> 
> Patch 1 was already submitted before, together with the v1 of
> my PDF fix series.
> 
> Mauro Carvalho Chehab (7):
>    docs: fix broken doc references due to renames
>    docs: generic-counter.rst: fix broken references for ABI file
>    MAINTAINERS: fix reference to net phy ABI file
>    MAINTAINERS: fix a renamed DT reference
>    docs: cgroup-v1/blkio-controller.rst: remove a CFQ left over
>    docs: zh_CN: howto.rst: fix a broken reference
>    docs: dt: fix a sound binding broken reference
> 
>   Documentation/RCU/rculist_nulls.txt                |  2 +-
>   .../admin-guide/cgroup-v1/blkio-controller.rst     |  6 ------
>   .../devicetree/bindings/arm/idle-states.txt        |  2 +-
>   .../devicetree/bindings/sound/sun8i-a33-codec.txt  |  2 +-
>   Documentation/driver-api/generic-counter.rst       |  4 ++--
>   Documentation/locking/spinlocks.rst                |  4 ++--
>   Documentation/memory-barriers.txt                  |  2 +-
>   .../translations/ko_KR/memory-barriers.txt         |  2 +-
>   Documentation/translations/zh_CN/process/howto.rst |  2 +-
>   Documentation/watchdog/hpwdt.rst                   |  2 +-
>   MAINTAINERS                                        | 14 +++++++-------
>   drivers/gpu/drm/drm_modes.c                        |  2 +-
>   drivers/i2c/busses/i2c-nvidia-gpu.c                |  2 +-
>   drivers/scsi/hpsa.c                                |  4 ++--
>   14 files changed, 22 insertions(+), 28 deletions(-)
> 


-- 
Regards,
Atish

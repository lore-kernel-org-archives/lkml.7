Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49B9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 22:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39FC2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 22:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553810660;
	bh=vcdrYxHXX97GvWcGJEFDNLmKdjI/FuaYGS/SKVsowuQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=src3k1rxJu6RMxVZPx16jhAxS+SmxySVmBcJtkA1Z2zql0gsARV0CjJkfw4GkKQvA
	 JonYJbkN14Ky4mlBwKU1SDVM1gED9Eov0eaTwuxzwiCmmBh2w7/PDzN2lfBZ+9UDih
	 FSGtQqQ/kBij+Mh03sg4OdkPY7OBwVTSk5IHjWqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfC1WET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 18:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbfC1WET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 18:04:19 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22CFA21850;
        Thu, 28 Mar 2019 22:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553810658;
        bh=vcdrYxHXX97GvWcGJEFDNLmKdjI/FuaYGS/SKVsowuQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c0vuwFWR66/pHGYJwr7tZPerCVPKfqydjOYYicLyLlnFId3oBaP/PuLuMy7uMQpQ6
         EWB5zB2JHNQ7BZEQkGr1rnUqkeAgT0BJS6s2CYgqKzhGTOLbIzJiPWFTvaOgu+FSX+
         /M7yxp89H7AYQF5ii16jUeEz5jkEvaeH00VjjrUs=
Received: by mail-ed1-f54.google.com with SMTP id v21so358306edq.4;
        Thu, 28 Mar 2019 15:04:18 -0700 (PDT)
X-Gm-Message-State: APjAAAVAs8UTzasRIAfy5ukszXjjejMMFzcOph3w/Lc9fxSHsdwaLJGj
        tY8ZgDihx+g9Wv17JQREWAZZMcNkZhUwZc7b4RI=
X-Google-Smtp-Source: APXvYqyPWqlYIuHiy62YGAD6WEM8mlaaM5XjGg0xlgz1JTMVdttOdW0VL8+QomkRXjye6pkRkj0WQOyhz0xFKCNKMMo=
X-Received: by 2002:a50:eb4d:: with SMTP id z13mr22391287edp.200.1553810656714;
 Thu, 28 Mar 2019 15:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com> <1553483264-5379-6-git-send-email-hao.wu@intel.com>
In-Reply-To: <1553483264-5379-6-git-send-email-hao.wu@intel.com>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 28 Mar 2019 17:03:39 -0500
X-Gmail-Original-Message-ID: <CANk1AXSwZ3PU+PRGBDkx=0nkMNTRyC2OQMCm3kte+fq-N1KkyA@mail.gmail.com>
Message-ID: <CANk1AXSwZ3PU+PRGBDkx=0nkMNTRyC2OQMCm3kte+fq-N1KkyA@mail.gmail.com>
Subject: Re: [PATCH 05/17] fpga: dfl: fme: add DFL_FPGA_FME_PORT_RELEASE/ASSIGN
 ioctl support.
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Zhang Yi Z <yi.z.zhang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 10:23 PM Wu Hao <hao.wu@intel.com> wrote:
>
> In order to support virtualization usage via PCIe SRIOV, this patch
> adds two ioctls under FPGA Management Engine (FME) to release and
> assign back the port device. In order to safely turn Port from PF
> into VF and enable PCIe SRIOV, it requires user to invoke this
> PORT_RELEASE ioctl to release port firstly to remove userspace
> interfaces, and then configure the PF/VF access register in FME.
> After disable SRIOV, it requires user to invoke this PORT_ASSIGN
> ioctl to attach the port back to PF.
>
>  Ioctl interfaces:
>  * DFL_FPGA_FME_PORT_RELEASE
>    Release platform device of given port, it deletes port platform
>    device to remove related userspace interfaces on PF, then
>    configures PF/VF access mode to VF.
>
>  * DFL_FPGA_FME_PORT_ASSIGN
>    Assign platform device of given port back to PF, it configures
>    PF/VF access mode to PF, then adds port platform device back to
>    re-enable related userspace interfaces on PF.
>
> Signed-off-by: Zhang Yi Z <yi.z.zhang@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>

Acked-by: Alan Tull <atull@kernel.org>

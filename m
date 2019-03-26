Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2247BC10F06
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAA82084D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553563385;
	bh=XTza0M4aOIclUOllkCeDM3SweeaLQkRbgv14ot7P5Qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Tyl6Wue8otvKFP8ApI1j2Hj73FrUN4PMCPgYNerFMnlLeIIi6lDuHvnm8SVRXQpuu
	 LyTGFNZpx2tXGCwbYNh3bbZ2ESg+rjEccsawEOn6LPw7fB4Ghu5La+FVTBL/86OhrM
	 V1jotgueJSU9OJTikuBFJNLpxTFdpRuLyqqw2YYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbfCZBXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbfCZBXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:23:03 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AE7C20693;
        Tue, 26 Mar 2019 01:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553563382;
        bh=XTza0M4aOIclUOllkCeDM3SweeaLQkRbgv14ot7P5Qw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VFeKunSJkntdkjJHjlVf//jIy26/P3SsKv3YjWqn70wScB31zEPrmMYuIgAYevBqg
         1KgyKvX0j+vGNlMQUjL2MXWgM5h2A5Me9sZAclf3VwPNEymYsz+lwSSgHxtDJhkBl8
         gay4RgDYDP+QOdHVbNkN3lynnYsSRoh1IlaDDu78=
Date:   Tue, 26 Mar 2019 10:09:11 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     stable@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ravindra Lokhande <rlokhande@nvidia.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [BACKPORT 4.4.y 02/25] ALSA: compress: add support for 32bit
 calls in a 64bit kernel
Message-ID: <20190326010911.GB29420@kroah.com>
References: <20190322154425.3852517-1-arnd@arndb.de>
 <20190322154425.3852517-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322154425.3852517-3-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 04:43:53PM +0100, Arnd Bergmann wrote:
> From: Ravindra Lokhande <rlokhande@nvidia.com>
> 
> Compress offload does not support ioctl calls from a 32bit userspace
> in a 64 bit kernel. This patch adds support for ioctls from a 32bit
> userspace in a 64bit kernel
> 
> Signed-off-by: Ravindra Lokhande <rlokhande@nvidia.com>
> Acked-by: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> (cherry picked from commit c10368897e104c008c610915a218f0fe5fa4ec96)
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/core/compress_offload.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

How is this not a "new feature"?  What bug does this fix?  Has this ever
worked in the past?

thanks,

greg k-h

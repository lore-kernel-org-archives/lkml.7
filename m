Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CECC74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D68208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="grhzl8AV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfGJRBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 13:01:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37385 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJRBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:01:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id w13so2884730eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 10:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=llkyrv8T5BB/HVCy8v1HpqpbnOPnkBU/rokYNHhvmuw=;
        b=grhzl8AV8teK8XhW3XbppstbV4uHx7atS0zHXZVMV3YWm/uUUCkF5cTfSlFG6k1I9H
         UPVSnJ2Q008BHn/KS4BFP3nCnxCUcXGOf6Qm9+KBaf8xKWsz6KCOFRO4AToIIFncmOr3
         i9O10/umXaRY1F9BrdK/74Ud91WxD0x7kzZdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=llkyrv8T5BB/HVCy8v1HpqpbnOPnkBU/rokYNHhvmuw=;
        b=rXwgNIhXMUmbb9lAClboZ4ZZYPzfUgFJbyuGT1tE/L2pFPJzt3YhU9Tu2EuPre9HlI
         kBrI1eRIls/+O9WiUHY7naEG2TxfYs/RelL8pQ0wLHPSMuUMfXDnutokKMtNvfLKvKUx
         MWYKJ81SMcF+bt3TJygeEKh/1IFdjxw5qHCU57ceum7Yaf1LznkSqsB+8at9jyUHSQjO
         8RMBzuAe2kuzAOxMl1pzeMenWsDcWhar4bIfeMUIGcoSHt+TSlIAcEc07zmw/3nZj5CI
         FSm+Lg6ERnkNE7pzkZJwk48icnZ6NfCyILE0ul/XaSZzT8YY41zR5+95QOGjbXoBGc/v
         mqhQ==
X-Gm-Message-State: APjAAAVchDh1s8WBYeOiEdeY4UDEmdG5Mw/9QnDxs2GmfWtPLNvFDCog
        INA6larD5OH4eaLp23Mpz4xLFg==
X-Google-Smtp-Source: APXvYqyia5fmeFrANEsVPhXrDxEmf5uFDHhp9q1w9D2IUEj1JCjuoH4cBtgTpdbfSNGgmMllhPIxdw==
X-Received: by 2002:a17:906:1105:: with SMTP id h5mr18298837eja.53.1562778079172;
        Wed, 10 Jul 2019 10:01:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id hk16sm519328ejb.63.2019.07.10.10.01.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 10:01:18 -0700 (PDT)
Date:   Wed, 10 Jul 2019 19:01:16 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Simon Ser <contact@emersion.fr>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/vkms: Introduce basic support for configfs
Message-ID: <20190710170116.GB15868@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>, Simon Ser <contact@emersion.fr>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <cover.1561950553.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1561950553.git.rodrigosiqueiramelo@gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 12:23:39AM -0300, Rodrigo Siqueira wrote:
> This patchset introduces the support for configfs in vkms by adding a
> primary structure for handling the vkms subsystem and exposing
> connectors as a use case.  This series allows enabling/disabling virtual
> and writeback connectors on the fly. The first patch of this series
> reworks the initialization and cleanup code of each type of connector,
> with this change, the second patch adds the configfs support for vkms.
> It is important to highlight that this patchset depends on
> https://patchwork.freedesktop.org/series/61738/.
> 
> After applying this series, the user can utilize these features with the
> following steps:
> 
> 1. Load vkms without parameter
> 
>   modprobe vkms
> 
> 2. Mount a configfs filesystem
> 
>   mount -t configfs none /mnt/
> 
> After that, the vkms subsystem will look like this:
> 
> vkms/
>  |__connectors
>     |__Virtual
>         |__ enable
> 
> The connectors directories have information related to connectors, and
> as can be seen, the virtual connector is enabled by default. Inside a
> connector directory (e.g., Virtual) has an attribute named ‘enable’
> which is used to enable and disable the target connector. For example,
> the Virtual connector has the enable attribute set to 1. If the user
> wants to enable the writeback connector it is required to use the mkdir
> command, as follows:
> 
>   cd /mnt/vkms/connectors
>   mkdir Writeback
> 
> After the above command, the writeback connector will be enabled, and
> the user could see the following tree:
> 
> vkms/
>  |__connectors
>     |__Virtual
>     |   |__ enable
>     |__Writeback
>         |__ enable
> 
> If the user wants to remove the writeback connector, it is required to
> use the command rmdir, for example
> 
>   rmdir Writeback
> 
> Another way to enable and disable a connector it is by using the enable
> attribute, for example, we can disable the Virtual connector with:
> 
>   echo 0 > /mnt/vkms/connectors/Virtual/enable
> 
> And enable it again with:
> 
>   echo 1 > /mnt/vkms/connectors/Virtual/enable
> 
> It is important to highlight that configfs 'obey' the parameters used
> during the vkms load and does not allow users to remove a connector
> directory if it was load via module parameter. For example:
> 
>   modprobe vkms enable_writeback=1
> 
> vkms/
>  |__connectors
>     |__Virtual
>     |   |__ enable
>     |__Writeback
>         |__ enable
> 
> If the user tries to remove the Writeback connector with “rmdir
> Writeback”, the operation will be not permitted because the Writeback
> connector was loaded with the modules. However, the user may disable the
> writeback connector with:
> 
>   echo 0 > /mnt/vkms/connectors/Writeback/enable

I guess I should have put a warning into that task that step one is
designing the interface. Here's the fundamental thoughts:

- The _only_ thing we can hotplug after drm_dev_register() is a
  drm_connector. That's an interesting use-case, but atm not really
  supported by the vkms codebase. So we can't just enable/disable
  writeback like this. We also can't change _anything_ else in the drm
  driver like this.

- The other bit we want is support multiple vkms instances, to simulate
  multi-gpus and fun stuff like that.

- Therefore vkms configs should be at the drm_device level, so a
  directory under configfs/vkms/ represents an entire device.

- We need a special config item to control
  drm_dev_register/drm_dev_unregister. While a drm_device is registers,
  all other config items need to fail if userspace tries to change them.
  Maybe this should be a top-level "enable" property.

- Every time enable goes from 0 -> 1 we need to create a completely new
  vkms instance. The old one might still be around, waiting for the last
  few references to disappear.

- enable going from 1 -> 0 needs to be treated like a physical hotunplug,
  i.e. not drm_dev_unregister but drm_dev_unplug. We also need to annotate
  all the vkms code with drm_dev_enter/exit() as the kerneldoc of
  drm_dev_unplug explains.

- rmdir should be treated like enable going from 1 -> 0. Or maybe we
  should disable enable every going from 1 -> 0, would propably simplify
  everything.

- The initial instance created at module load also neeeds to be removable
  like this.

Once we have all this, then can we start to convert driver module options
over to configs and add cool features. But lots of infrastructure needed
first.

Also, we probably want some nasty testcases which races an rmdir in
configfs against userspace still doing ioctl calls against vkms. This is
ideal for validation the hotunplug infrastructure we have in drm.

An alternative is adding connector hotplugging. But I think before we do
that we need to have support for more crtc and more connectors as static
module options. So maybe not a good starting point for configfs.

The above text should probably be added to the vkms.rst todo item ...
-Daniel

> 
> 
> Rodrigo Siqueira (2):
>   drm/vkms: Add enable/disable functions per connector
>   drm/vkms: Introduce configfs for enabling/disabling connectors
> 
>  drivers/gpu/drm/vkms/Makefile         |   3 +-
>  drivers/gpu/drm/vkms/vkms_configfs.c  | 229 ++++++++++++++++++++++++++
>  drivers/gpu/drm/vkms/vkms_drv.c       |   6 +
>  drivers/gpu/drm/vkms/vkms_drv.h       |  17 ++
>  drivers/gpu/drm/vkms/vkms_output.c    |  84 ++++++----
>  drivers/gpu/drm/vkms/vkms_writeback.c |  31 +++-
>  6 files changed, 332 insertions(+), 38 deletions(-)
>  create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.c
> 
> -- 
> 2.21.0
> 
> 
> -- 
> Rodrigo Siqueira
> https://siqueira.tech

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

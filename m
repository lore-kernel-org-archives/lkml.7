Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0726FC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F7120873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IomabLXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfFRN6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:58:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38797 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbfFRN6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:58:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id r12so19697622edo.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 06:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5R+NHLt8PsIXt8anR6pHPXfCo/6c3mgcVEHW0Oc9gbQ=;
        b=IomabLXyUSPmgwDNcXRKvVrUMuM5eZ/qFxhM5kHvyjpENaInZNJNgpWS2VXKwHAf8l
         NEYfD3/Cknpfi5MEzA9EZaX9F2yCLM3CKUM7IF4wGm/S5BpJNzl8Jsl5PsP0DTT3/X1D
         dmpJqayomyio9iJpF1/FYtElgLw9pM2lZeCXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=5R+NHLt8PsIXt8anR6pHPXfCo/6c3mgcVEHW0Oc9gbQ=;
        b=bxqqDtjYGheY25vgcl0vyq1rRS6qUL5Vqqnpk9isAN8LXb9e9tGFTGg6vDrQIIFoK7
         uJ2Jbod9VDU+4Z50kn9LBh6mamte2GC7ZbwPiIybZBs6/yNwoCdjwSAOuGNXLOfPe+ou
         BqLkUrRgNZUAOJl/XBo8DHtvywaV2hxilbnp8hNVrGOX9Ox2WRP2B0K5pE/uQ9STLe5z
         +1Qsh6gooGK2TKg2vzm2rrxCXhqtNiOgOIxHvxr+QZ1QGo9CtYXRyok70DMHTHVh59mS
         cVfy/VBb0rClZfMcvZo3NFBVbybWeiLyhAdYzFCmRpkCJ9qq3Ef7P4QXmgbZ2sFftztR
         I0uw==
X-Gm-Message-State: APjAAAVO1nGhJSkDChEkXwGiOOznDk5BKp1mKeJ4is2JhwzxjLWtdIZg
        cj/nKksn2r3ysJKwV/I9HD09QQ==
X-Google-Smtp-Source: APXvYqyBb0v30F83VtHb2y9yPf5YE3kiCupaF4YgpnDXka6VJj+7GT+WSSudOjww3CuybbgcAiEZ8g==
X-Received: by 2002:a17:906:2415:: with SMTP id z21mr82019805eja.211.1560866288249;
        Tue, 18 Jun 2019 06:58:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id o22sm4776392edc.37.2019.06.18.06.58.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 06:58:07 -0700 (PDT)
Date:   Tue, 18 Jun 2019 15:58:05 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Ajay Gupta <ajayg@nvidia.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Li Yang <leoyang.li@nxp.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH] docs: fix some broken references due to txt->rst renames
Message-ID: <20190618135804.GZ12905@phenom.ffwll.local>
Mail-Followup-To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, Ajay Gupta <ajayg@nvidia.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Otto Sabart <ottosabart@seberm.com>, Li Yang <leoyang.li@nxp.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-i2c@vger.kernel.org
References: <6f09587b7678f2fb378d736f45a02ffa9412cc99.1560864716.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f09587b7678f2fb378d736f45a02ffa9412cc99.1560864716.git.mchehab+samsung@kernel.org>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 10:33:58AM -0300, Mauro Carvalho Chehab wrote:
> There are three left-overs from the recent file renames,
> probably due to some other conflicting patch.
> 
> Fix them.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
> 
> This patch is against today's next-20190617 branch. Not sure if it
> will apply cleanly at -docs tree. If not,  Please let me know for me to
> split.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
>  Documentation/devicetree/bindings/arm/idle-states.txt | 2 +-
>  drivers/gpu/drm/i915/intel_runtime_pm.h               | 2 +-
>  drivers/i2c/busses/i2c-nvidia-gpu.c                   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Documentation/devicetree/bindings/arm/idle-states.txt
> index 3bdbe675b9e6..d8d9aa7167e8 100644
> --- a/Documentation/devicetree/bindings/arm/idle-states.txt
> +++ b/Documentation/devicetree/bindings/arm/idle-states.txt
> @@ -703,4 +703,4 @@ cpus {
>      https://www.devicetree.org/specifications/
>  
>  [6] ARM Linux Kernel documentation - Booting AArch64 Linux
> -    Documentation/arm64/booting.txt
> +    Documentation/arm64/booting.rst
> diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.h b/drivers/gpu/drm/i915/intel_runtime_pm.h
> index f2d6299a8161..3cb391cd81c1 100644
> --- a/drivers/gpu/drm/i915/intel_runtime_pm.h
> +++ b/drivers/gpu/drm/i915/intel_runtime_pm.h
> @@ -44,7 +44,7 @@ enum i915_drm_suspend_mode {
>   * to be disabled. This shouldn't happen and we'll print some error messages in
>   * case it happens.
>   *
> - * For more, read the Documentation/power/runtime_pm.txt.
> + * For more, read the Documentation/power/runtime_pm.rst.
>   */
>  struct intel_runtime_pm {
>  	atomic_t wakeref_count;
> diff --git a/drivers/i2c/busses/i2c-nvidia-gpu.c b/drivers/i2c/busses/i2c-nvidia-gpu.c
> index cfc76b5de726..5a1235fd86bb 100644
> --- a/drivers/i2c/busses/i2c-nvidia-gpu.c
> +++ b/drivers/i2c/busses/i2c-nvidia-gpu.c
> @@ -364,7 +364,7 @@ static void gpu_i2c_remove(struct pci_dev *pdev)
>  /*
>   * We need gpu_i2c_suspend() even if it is stub, for runtime pm to work
>   * correctly. Without it, lspci shows runtime pm status as "D0" for the card.
> - * Documentation/power/pci.txt also insists for driver to provide this.
> + * Documentation/power/pci.rst also insists for driver to provide this.
>   */
>  static __maybe_unused int gpu_i2c_suspend(struct device *dev)
>  {
> -- 
> 2.21.0
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

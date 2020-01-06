Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A829C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB5021775
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgAFIff convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:35:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38226 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAFIfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:35:34 -0500
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ioNrH-00033b-Sd
        for linux-kernel@vger.kernel.org; Mon, 06 Jan 2020 08:35:32 +0000
Received: by mail-pf1-f200.google.com with SMTP id r127so36042310pfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 00:35:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tUJkQQozsNHPjRDCkf1oaa592cZNd4E3zEgxAi9AoEA=;
        b=F+wKiOqCaW05GuHjeVXOpKS1dNfKXe2sov4Z2qYcrPTHRl9k2J6S8PRjp8CFGrV7Rd
         H4IMD3EINJorE/XP166sYINM1YYdYpRghxX2qGbyoro7O/wt8Eq7Xwgm5DKnfX0PDoCA
         p+WS8nS8MPP2d5FEVTMLFfmcxXb1sMQ3PsfS4Yuq+WLTvf3KF2RyydGsIC1bKOTs2ZjV
         qvqPwYgkWbUIGQ4t00Iv+C3Lh6l3Our/Cl9LY6/rb5pLAME5CBu6thNeGgFDmzUc3Qz9
         DwjYKfmB4trxR0TXgcYnE9xQ6WmgtDTzslSa4HRUQj+k2eWe0ZJwCdSxbjXGLqu7FvNF
         YNYQ==
X-Gm-Message-State: APjAAAW550DZEHTCN80uCLraZ1EQ7cvKJZ2eslJAZPQ2OhTTvCXv4E1I
        OvNsoX4pE4llrhr9cOsBe0RbUucGJBpQNvb/RQro0EFmz87dCdK/fA+Z6K9bTdmvgbp3d6UGqBN
        vno7MDoxZVZQiD72KCA5PjIGVaeW4JOOww4KLZOLLTQ==
X-Received: by 2002:a17:902:9f92:: with SMTP id g18mr102350193plq.161.1578299730381;
        Mon, 06 Jan 2020 00:35:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqyGt+8LtQorps/GjLgBerFhym3Ndc9LEPYmbKUBg/Y/U3MscdcExRIY/gIf0zpowd3ltXbD7A==
X-Received: by 2002:a17:902:9f92:: with SMTP id g18mr102350166plq.161.1578299730046;
        Mon, 06 Jan 2020 00:35:30 -0800 (PST)
Received: from 2001-b011-380f-35a3-2839-ccbd-36ed-2f4a.dynamic-ip6.hinet.net (2001-b011-380f-35a3-2839-ccbd-36ed-2f4a.dynamic-ip6.hinet.net. [2001:b011:380f:35a3:2839:ccbd:36ed:2f4a])
        by smtp.gmail.com with ESMTPSA id bo19sm23083748pjb.25.2020.01.06.00.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 00:35:29 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v3] drm/i915: Re-init lspcon after HPD if lspcon probe
 failed
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20191224084251.28414-1-kai.heng.feng@canonical.com>
Date:   Mon, 6 Jan 2020 16:35:26 +0800
Cc:     ville.syrjala@linux.intel.com, swati2.sharma@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <85235F00-7FBA-46E4-B7A5-45294DE1B824@canonical.com>
References: <20191224084251.28414-1-kai.heng.feng@canonical.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jani,

> On Dec 24, 2019, at 16:42, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> On HP 800 G4 DM, if HDMI cable isn't plugged before boot, the HDMI port
> becomes useless and never responds to cable hotplugging:
> [    3.031904] [drm:lspcon_init [i915]] *ERROR* Failed to probe lspcon
> [    3.031945] [drm:intel_ddi_init [i915]] *ERROR* LSPCON init failed on port D
> 
> Seems like the lspcon chip on the system in question only gets powered
> after the cable is plugged.
> 
> So let's call lspcon_init() dynamically to properly initialize the
> lspcon chip and make HDMI port work.

Do you have any further suggestion for this patch?

Kai-Heng

> 
> Closes: https://gitlab.freedesktop.org/drm/intel/issues/203
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v3:
> - Make sure it's handled under long HPD case.
> 
> v2: 
> - Move lspcon_init() inside of intel_dp_hpd_pulse().
> 
> drivers/gpu/drm/i915/display/intel_dp.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index fe31bbfd6c62..a72c9c041c60 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -6573,6 +6573,7 @@ enum irqreturn
> intel_dp_hpd_pulse(struct intel_digital_port *intel_dig_port, bool long_hpd)
> {
> 	struct intel_dp *intel_dp = &intel_dig_port->dp;
> +	struct drm_i915_private *dev_priv = dp_to_i915(intel_dp);
> 
> 	if (long_hpd && intel_dig_port->base.type == INTEL_OUTPUT_EDP) {
> 		/*
> @@ -6593,7 +6594,12 @@ intel_dp_hpd_pulse(struct intel_digital_port *intel_dig_port, bool long_hpd)
> 		      long_hpd ? "long" : "short");
> 
> 	if (long_hpd) {
> -		intel_dp->reset_link_params = true;
> +		if (intel_dig_port->base.type == INTEL_OUTPUT_DDI &&
> +		    HAS_LSPCON(dev_priv) && !intel_dig_port->lspcon.active)
> +			lspcon_init(intel_dig_port);
> +		else
> +			intel_dp->reset_link_params = true;
> +
> 		return IRQ_NONE;
> 	}
> 
> -- 
> 2.17.1
> 


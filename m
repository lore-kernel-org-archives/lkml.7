Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21042C2D0D5
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DA420663
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLWRxc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 12:53:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37455 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfLWRxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 12:53:32 -0500
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ijRta-0007ad-EY
        for linux-kernel@vger.kernel.org; Mon, 23 Dec 2019 17:53:30 +0000
Received: by mail-pg1-f197.google.com with SMTP id q1so11006703pge.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 09:53:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OCo5Ypyu6pu38a6YJ1OXr5ycGEAIBEO34ruxpB+/INg=;
        b=QzM7/CkFujqIsXSmYvChWbNsorBuyQpn4lmXTVtKb0VsJ1CiFfaC54Snr35ChpyJu/
         OYpIN/DlSEHzvWBHEoJGunSvdzf7N9+u+jf2DLLghDEcFY/k67ADsVOEcPysnRxxuKiU
         5wZbbt2PgEiiGhx6tKCZpxMPG8jkx5/eSJiRgvvI0bSO+RRooFJgHXTsj6yNLAcO03ql
         2pD7EkqzaU93Uhv4WSouwOxRbMMBfMfKGgnPZwI1M8oGwbqnpVb1/H6WE56Caxs3aP6/
         2zmhgTFfwUpDU4Eykh7iLifZYdQdN8kLaVX+GbnMmMObx4LeNSpOaf6IcBNA2RvpfpEZ
         5A3w==
X-Gm-Message-State: APjAAAVQ3du9waqwyB3SH79BSytWTUGaNPw+4NaUM+Mcp0gB1B1IVtOW
        shHKtX8TukWNaU3nnTUE7as6PNKMRd4fhnz40QexjV05NQR4YCKBmRg5XzFtgM+ipGlw76h9RyD
        Mp8HGgx3FANXQAGzHCY7QCula1OO5DU8DPM49Honn+A==
X-Received: by 2002:a17:90a:ad48:: with SMTP id w8mr305876pjv.19.1577123608854;
        Mon, 23 Dec 2019 09:53:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqzvo2lxDezsV6ekd9axPKc4dlP+f7o4/vuSqg58LAdpfNg1seDqVMU+PZLKykU179GTIDOJzQ==
X-Received: by 2002:a17:90a:ad48:: with SMTP id w8mr305839pjv.19.1577123608621;
        Mon, 23 Dec 2019 09:53:28 -0800 (PST)
Received: from 2001-b011-380f-35a3-a059-d6a4-0e9a-8360.dynamic-ip6.hinet.net (2001-b011-380f-35a3-a059-d6a4-0e9a-8360.dynamic-ip6.hinet.net. [2001:b011:380f:35a3:a059:d6a4:e9a:8360])
        by smtp.gmail.com with ESMTPSA id q63sm3585026pfb.149.2019.12.23.09.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 09:53:28 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v2] drm/i915: Re-init lspcon after HPD if lspcon probe
 failed
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <87o8vzrljs.fsf@intel.com>
Date:   Tue, 24 Dec 2019 01:53:25 +0800
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, ville.syrjala@linux.intel.com,
        swati2.sharma@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <BD65D1A5-FB91-4A98-80BF-A8AAA84146B5@canonical.com>
References: <20191223171310.21192-1-kai.heng.feng@canonical.com>
 <87o8vzrljs.fsf@intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 24, 2019, at 01:36, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> 
> On Tue, 24 Dec 2019, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>> On HP 800 G4 DM, if HDMI cable isn't plugged before boot, the HDMI port
>> becomes useless and never responds to cable hotplugging:
>> [    3.031904] [drm:lspcon_init [i915]] *ERROR* Failed to probe lspcon
>> [    3.031945] [drm:intel_ddi_init [i915]] *ERROR* LSPCON init failed on port D
>> 
>> Seems like the lspcon chip on the system in question only gets powered
>> after the cable is plugged.
>> 
>> So let's call lspcon_init() dynamically to properly initialize the
>> lspcon chip and make HDMI port work.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> v2: 
>>  - Move lspcon_init() inside of intel_dp_hpd_pulse().
>> 
>> drivers/gpu/drm/i915/display/intel_dp.c | 6 +++++-
>> 1 file changed, 5 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
>> index fe31bbfd6c62..eb395b45527e 100644
>> --- a/drivers/gpu/drm/i915/display/intel_dp.c
>> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
>> @@ -6573,6 +6573,7 @@ enum irqreturn
>> intel_dp_hpd_pulse(struct intel_digital_port *intel_dig_port, bool long_hpd)
>> {
>> 	struct intel_dp *intel_dp = &intel_dig_port->dp;
>> +	struct drm_i915_private *dev_priv = dp_to_i915(intel_dp);
>> 
>> 	if (long_hpd && intel_dig_port->base.type == INTEL_OUTPUT_EDP) {
>> 		/*
>> @@ -6592,11 +6593,14 @@ intel_dp_hpd_pulse(struct intel_digital_port *intel_dig_port, bool long_hpd)
>> 		      intel_dig_port->base.base.name,
>> 		      long_hpd ? "long" : "short");
>> 
>> -	if (long_hpd) {
>> +	if (long_hpd && intel_dig_port->base.type != INTEL_OUTPUT_DDI) {
> 
> With this change, long hpd handling for DDI on platforms that do not
> have LSPCON, or has an active LSPCON, falls through to the short hpd
> handling. That's not what you're after, is it?

You are right, no :(

I'll send a V3.

Kai-Heng

> 
> 
> BR,
> Jani.
> 
> 
>> 		intel_dp->reset_link_params = true;
>> 		return IRQ_NONE;
>> 	}
>> 
>> +	if (long_hpd && HAS_LSPCON(dev_priv) && !intel_dig_port->lspcon.active)
>> +		lspcon_init(intel_dig_port);
>> +
>> 	if (intel_dp->is_mst) {
>> 		if (intel_dp_check_mst_status(intel_dp) == -EINVAL) {
>> 			/*
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center


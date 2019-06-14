Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2F5C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C81521744
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="bMvCQCY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfFNPAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:00:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39528 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfFNPAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:00:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id m10so3936640edv.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NbFRe8iz8+YgXTd9+j/Su+erCoaDy3fGkGP7auiuNUA=;
        b=bMvCQCY1CEGJuCCTGphkCQCQDXbBiiOzKD2MHOjDq+l9sETlfAVva1PsQHnRf2oUGN
         M5o0BI9D4sRZY9xNMHZwuhH8HqA0pR3KYSUbrT4aFt/AOsxxvjk9BZkDeqOL6uUKUt/2
         lfg6y+DC2kF7XSnWHwQW2J1I6e61GDiKl3nik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=NbFRe8iz8+YgXTd9+j/Su+erCoaDy3fGkGP7auiuNUA=;
        b=FKX3F1w6USKwYfq6qRcIKkkDfer4Jn6ZMhhVS4jCbnMKuge5rDK26jya13kd69zdsO
         gZPdlmglqIPYA+lGmwFuH9Uzwx7UpgH06168HCPdJvHoRhKSI2WjDDlwpIzMKtxYW8ms
         bApGggFr7FJva3fdPn/sST960MKuue3B4UGo31e0nQuAKhBHeeQ2IEHS/8JPK07og1Hp
         hmjRtIpMKPQsX2+hq0fVYquKwhUimmf1rZRwILKxgLAm5uoix4hFXh/+Kv3K8Au+tcNU
         uk1bh/x41+Si6X08I5fnaV/liKmUre4s8ci6Mk5hPZ5H7kVjKvnFdkUaHGfT8Xab7+f5
         ZYAA==
X-Gm-Message-State: APjAAAXwufeRZ9GE6uxc6A6A+dF8nsKanV+zo2dZnf92dRJkix4x9bVu
        XupP0xcZcRADoyEdpQ0VPOXBPA==
X-Google-Smtp-Source: APXvYqzbUincpkS9VRFPqctb2mtBCQ81/I0YaGNHD6rsk2qXjiGZJEqf/FLbTjm8dLd6boMGMh27sg==
X-Received: by 2002:a17:906:4e57:: with SMTP id g23mr10186023ejw.52.1560524444771;
        Fri, 14 Jun 2019 08:00:44 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 17sm962988edu.21.2019.06.14.08.00.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 08:00:43 -0700 (PDT)
Date:   Fri, 14 Jun 2019 17:00:41 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Young Xiao <92siuyang@gmail.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd: fix hotplug race at startup
Message-ID: <20190614150041.GA23020@phenom.ffwll.local>
Mail-Followup-To: Young Xiao <92siuyang@gmail.com>,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1560511763-2140-1-git-send-email-92siuyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560511763-2140-1-git-send-email-92siuyang@gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 07:29:23PM +0800, Young Xiao wrote:
> We should check mode_config_initialized flag in amdgpu_hotplug_work_func.
> 
> See commit 7f98ca454ad3 ("drm/radeon: fix hotplug race at startup") for details.
> 
> Signed-off-by: Young Xiao <92siuyang@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index af4c3b1..13186d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -85,6 +85,9 @@ static void amdgpu_hotplug_work_func(struct work_struct *work)
>  	struct drm_mode_config *mode_config = &dev->mode_config;
>  	struct drm_connector *connector;
>  
> +	if (!adev->mode_info.mode_config_initialized)
> +		return;

I think you want to delay your hotplug initialization until you're ready
to serve hotplug events, this here is fairly racy ...
-Daniel

> +
>  	mutex_lock(&mode_config->mutex);
>  	list_for_each_entry(connector, &mode_config->connector_list, head)
>  		amdgpu_connector_hotplug(connector);
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

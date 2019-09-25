Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2BDC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1A521D7A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="TZpROw2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392309AbfIYTcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 15:32:13 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43094 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732724AbfIYTcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 15:32:13 -0400
Received: by mail-yw1-f66.google.com with SMTP id q7so2490969ywe.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 12:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Y3TOSckvp+hB6Z7LsE8A0kv2GzhPr7GAD1mN1AzMI50=;
        b=TZpROw2tUrnCOXicxNYon+hvv+kCClgxG013aoYVP4mhRk2v//MwLA118MxX3QQ3Pw
         GUPXPZNG+FNUux41c2TLv80qKdieTIUQD97tEu/NnYq52Q1lslo/2fEYV7BOecY8q84s
         mjfw1eoqxRvIVf0B+Vg+DcElWVro432KeWSYZBYYqBjY09jyFod/nPtrXJ2Y9bRKz6VB
         23rnQq2OI6gPiN1wsIatwLThvj7XAX3IvCphHsxAcxQ9JSAXEzac5RWOwdTBWlcsVEJp
         FK1hR24W5S7kcvi9wOf8VvjRJvv000Xi2I1V+FjdqBvoIe4k56pVZcQja45lVweyUkkB
         1Thw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Y3TOSckvp+hB6Z7LsE8A0kv2GzhPr7GAD1mN1AzMI50=;
        b=lMXOMDwheCKyGjnv3AaL2aI6BirqgPzocu6G9R3DeJ8TugHmcJJz9v49u8U+LFbm5G
         samCC8H2cHls74O1GLW2z7YoxSsIgg1rsxaVrHedCm20Zwec44FxuztXKDFjPIbVgYxI
         2GsEhRFrpV7U2wIChZ8hfBmtPQsgFuO4WEMCXxgh2l2jEQyKHVQrNIGr0smCk3UGbc3X
         fpXlMEJVa1ldpUlexAMcx9Cj4kyG1lkV+4X8YZzlQd7ddcuPtfZhP/oqm/JpJW53GEuR
         4DxpbEYyC0XCV7w70I1aHQr+SWPM5rholUJNYY5fqP952V1peAR6vROcCjNIDmgtVuj9
         bFPw==
X-Gm-Message-State: APjAAAWgLciFt99POSJ+CfWFlWI6pDaZ8qeeBPu5d0x4VtyiEX+g/7PO
        lM+dJKtamIVQZgoGijpU9+EPFw==
X-Google-Smtp-Source: APXvYqyIEULWFxtN4GPZhWWBPSDO+4hsL0UrObHMV5ZObKETrz9HV4YQRUTFBUEcZdjSIwtuvvUPmA==
X-Received: by 2002:a81:704b:: with SMTP id l72mr6925535ywc.370.1569439932659;
        Wed, 25 Sep 2019 12:32:12 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id u138sm1331528ywf.7.2019.09.25.12.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 12:32:12 -0700 (PDT)
Date:   Wed, 25 Sep 2019 15:32:11 -0400
From:   Sean Paul <sean@poorly.run>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 18/27] drm/dp_mst: Remove lies in {up,down}_rep_recv
 documentation
Message-ID: <20190925193211.GJ218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
 <20190903204645.25487-19-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903204645.25487-19-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:45:56PM -0400, Lyude Paul wrote:
> These are most certainly accessed from far more than the mgr work. In
> fact, up_req_recv is -only- ever accessed from outside the mgr work.
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  include/drm/drm_dp_mst_helper.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
> index f253ee43e9d9..8ba2a01324bb 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -489,15 +489,11 @@ struct drm_dp_mst_topology_mgr {
>  	int conn_base_id;
>  
>  	/**
> -	 * @down_rep_recv: Message receiver state for down replies. This and
> -	 * @up_req_recv are only ever access from the work item, which is
> -	 * serialised.
> +	 * @down_rep_recv: Message receiver state for down replies.
>  	 */
>  	struct drm_dp_sideband_msg_rx down_rep_recv;
>  	/**
> -	 * @up_req_recv: Message receiver state for up requests. This and
> -	 * @down_rep_recv are only ever access from the work item, which is
> -	 * serialised.
> +	 * @up_req_recv: Message receiver state for up requests.
>  	 */
>  	struct drm_dp_sideband_msg_rx up_req_recv;
>  
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS

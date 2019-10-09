Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA16C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED2C206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fB1vGK0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbfJIQcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:32:41 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34290 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbfJIQcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:32:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id p10so2631605edq.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 09:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AsRzV/el8Z6unpKMWQXs9f6o4tkguJYdwjPl71MzeO4=;
        b=fB1vGK0Y8IInxFoNinBQl0U63Vrn/sGBs87QB1fHlAaA5THnBwVuB525lH71sSRqWR
         7u1F+4BGnXGpVDrX7Bmj2uK4hNBPzwIGfgKefHgP83Q/0Hj/fXjMRQbg9fNZeitUzVxK
         Vs+yuhtfDH6rElufVAUHv2i4AxeQ+P45uTWyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=AsRzV/el8Z6unpKMWQXs9f6o4tkguJYdwjPl71MzeO4=;
        b=UVNbnBinAhyQbwBDQJM4AA2ddt/tH01/Y7AahQzFCcS7oC+zTuTh0sPkpODsqGtno/
         qSaNRHzKdyzUPc2LynwPV/1goXIqB6UDfsZYqlJpgCAjRfto8s69oR4HA912zo4yhRBN
         8KLJJfJFoRmuAV4cBKmNt0Qb+Zkuv3uxGNj/mgeJsTWJyk7hmg/Of89QeLH01xdOZpXc
         2n6xy4Rzn/TajjBrYiFbZUJTozrPgIJTz+UhwN4DFzp5AZnvpBKCvyJaulJAXotiQPV0
         lARWocny6v/1vR8urfu+B/k02/rV2mvhEN/fKDBVzPlSgl2OBq6dBMrKXAgk78N1nFm6
         tBOg==
X-Gm-Message-State: APjAAAXHTip2i01sRBhinv2kA+jjYRqsOELoejPgZx2HoMZQ1zMbtvEV
        5wNl0jDXo6DszyENh9vQaaPGNw==
X-Google-Smtp-Source: APXvYqzwQw06TGxsSqHcjDC/wNFmpzXbSCEbJZ3820d/3Ps2IPTfJXCgo1jOu1txUjeab2Rpd2iaBQ==
X-Received: by 2002:a17:907:4150:: with SMTP id od24mr3627781ejb.135.1570638758954;
        Wed, 09 Oct 2019 09:32:38 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id h7sm425812edn.73.2019.10.09.09.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 09:32:37 -0700 (PDT)
Date:   Wed, 9 Oct 2019 18:32:35 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: drm/amd/display: Add HDCP module - static analysis bug report
Message-ID: <20191009163235.GT16989@phenom.ffwll.local>
Mail-Followup-To: Colin Ian King <colin.king@canonical.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <951eb7dc-bebe-5049-4998-f199e18b0bf3@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <951eb7dc-bebe-5049-4998-f199e18b0bf3@canonical.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 11:08:03PM +0100, Colin Ian King wrote:
> Hi,
> 
> Static analysis with Coverity has detected a potential issue with
> function validate_bksv in
> drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c with recent
> commit:
> 
> commit ed9d8e2bcb003ec94658cafe9b1bb3960e2139ec
> Author: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Date:   Tue Aug 6 17:52:01 2019 -0400
> 
>     drm/amd/display: Add HDCP module

I think the real question here is ... why is this not using drm_hdcp?
-Daniel

> 
> 
> The analysis is as follows:
> 
>  28 static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
>  29 {
> 
> CID 89852 (#1 of 1): Out-of-bounds read (OVERRUN)
> 
> 1. overrun-local:
> Overrunning array of 5 bytes at byte offset 7 by dereferencing pointer
> (uint64_t *)hdcp->auth.msg.hdcp1.bksv.
> 
>  30        uint64_t n = *(uint64_t *)hdcp->auth.msg.hdcp1.bksv;
>  31        uint8_t count = 0;
>  32
>  33        while (n) {
>  34                count++;
>  35                n &= (n - 1);
>  36        }
> 
> hdcp->auth.msg.hdcp1.bksv is an array of 5 uint8_t as defined in
> drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h as follows:
> 
> struct mod_hdcp_message_hdcp1 {
>         uint8_t         an[8];
>         uint8_t         aksv[5];
>         uint8_t         ainfo;
>         uint8_t         bksv[5];
>         uint16_t        r0p;
>         uint8_t         bcaps;
>         uint16_t        bstatus;
>         uint8_t         ksvlist[635];
>         uint16_t        ksvlist_size;
>         uint8_t         vp[20];
> 
>         uint16_t        binfo_dp;
> };
> 
> variable n is going to contain the contains of r0p and bcaps. I'm not
> sure if that is intentional. If not, then the count is going to be
> incorrect if these are non-zero.
> 
> Colin

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

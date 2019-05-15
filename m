Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401B6C04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116AB2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="eEBO9MSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfEOShP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:37:15 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34979 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfEOShO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:37:14 -0400
Received: by mail-qt1-f193.google.com with SMTP id a39so913491qtk.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SFNuIJemdTLO0xp4SS7eD7mTRt2jx19bhUfAq2FJGCg=;
        b=eEBO9MSQNtsb6zqoHTndPS0B0pR8E0sMp9T7yHW6qouW7Epg5SAzibiwdCmR3ibNGl
         D/S1jOoC2CAkyYprOIQpXzrm0BT5s0wI2sn0Gix9ARpYci3hGGmbmMyqd9it3GwAEj7C
         CiPRdXhZFO7FQKxofCxcAcaW6/fdl4oUvWmlMZSqXpiRT0sTARPesrhuPgFwsZ/HWvIr
         Nkkx6vFla5YJskiuqMxOiGm+DTXTF5AslGYsE1aXObkoOPMRkJ81w7W9Ne791MKUj9aU
         +saNoD9teyzZjIyA/28tOSqexFL/GyVjCBQCAOer25Gs869VftGpTli5Am3dCRe1qaQh
         NE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SFNuIJemdTLO0xp4SS7eD7mTRt2jx19bhUfAq2FJGCg=;
        b=lSHWQS1ulzOiZAJlueezQe7gF38Ems89WZxkHkj422JJrf2K9dR6bBudEWDmirNKuF
         5h1kvhaeyntReWdjgFhTuxXqKUViMlH1gE/TmQrzKjEsLxAimFRGT0ANupjzTkLp8yEH
         novtT7FxsRLRFw4W6HSTctnCntcz13ocR90X3TfVa3hJTnK/ZDe+t4TGqfbfLAL5b1fP
         Joumz2H7J43bixrMZJgjTHHPu5SICo1bBhfm4vtzPTIL6In7jm4peMGHE0QyB4RQMvtf
         496PtZkSHL2V4/0U5UFXN/1n8OHSXYzCiU8ZiinNbhwJrVNGICbw9p37b46FjIwzYRjM
         Th6A==
X-Gm-Message-State: APjAAAW6OmusY1oPJSpA+huP4PTrrDx+13Ji+r6isSLRSdvkpaboyDeG
        Sjf9tIM2MukqZ2dFB7YIVCnKFA==
X-Google-Smtp-Source: APXvYqxMIfZBBwCvYBUULJBhCR4PNZQyPokNd7gubEnQIC9pIP9wcs/fACEqVBe4sfNi7KMbt+/qXg==
X-Received: by 2002:ac8:534d:: with SMTP id d13mr13916550qto.217.1557945433945;
        Wed, 15 May 2019 11:37:13 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id b19sm1396281qkk.51.2019.05.15.11.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 11:37:13 -0700 (PDT)
Date:   Wed, 15 May 2019 14:37:12 -0400
From:   Sean Paul <sean@poorly.run>
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     robdclark@gmail.com, airlied@linux.ie, seanpaul@chromium.org,
        jsanka@codeaurora.org, jcrouse@codeaurora.org,
        chandanu@codeaurora.org, jrdr.linux@gmail.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Remove duplicate header
Message-ID: <20190515183712.GZ17077@art_vandelay>
References: <5cda6de6.1c69fb81.a3ae5.836a@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cda6de6.1c69fb81.a3ae5.836a@mx.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 12:57:28PM +0530, Sabyasachi Gupta wrote:
> Remove dpu_kms.h which is included more than once
> 
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Thanks for your patch, I've applied it to drm-misc-next-fixes.

Note for next time: The patch didn't apply cleanly since dpu_dbg.h has been
removed upstream. In future please make sure your patches apply cleanly and
at least build against upstream.

Thanks again!

Sean

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
> index dbe48e00..d692dee 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
> @@ -16,7 +16,6 @@
>  #include "dpu_hw_lm.h"
>  #include "dpu_hw_mdss.h"
>  #include "dpu_dbg.h"
> -#include "dpu_kms.h"
>  
>  #define LM_OP_MODE                        0x00
>  #define LM_OUT_SIZE                       0x04
> -- 
> 2.7.4
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS

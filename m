Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BA4C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9DF20659
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JSCLNoOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391114AbfGXTup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:50:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37579 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403868AbfGXTuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:50:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so22410251plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 12:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZiS4PVJdcBLmc+EYS5e2UtVsrajNWnABPfKSnbxUUWE=;
        b=JSCLNoOTRmBImRv/GQp82cRAhKzxYLY6eM7G1SCEaLqJNUKFetrvXnOIT1C3axrrLA
         okgoAGMPP5MNQoGP/FmGcK/HORz/CzUwB21EwRyomvOIb3GEopbMLxptRnGe4QuXzrnY
         ErpnH1D5RcxLfbI923kAx+00OdT9rSrt5fzf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZiS4PVJdcBLmc+EYS5e2UtVsrajNWnABPfKSnbxUUWE=;
        b=t1FfRN3Ypf1zNFjbW0n63o0qZ6LpFtsx11nN6vsk78ZKJWesWSm+FG48+TTDqnUqWR
         B5YvUEdwtmyjCG4MoqUNbeYSt2yzq32DjSQoy9D+IwJ4820Qiqjf6qFECmPmbjAjcHtS
         Ys3VaMwHFDjYkqnc5x6inBP90Lc5oMPX2wamCNB1cMXUagTPdn+qek+GcKAC33SKY+YP
         PW1n3gEdot3E6JbnNBHoA9Y1V9G1L+6ecx2QyoC0FHeLHDWozOjq6QzSzAGJSH7peqSI
         ERDwXQKvH14bHa7AvjE55pIyBB75BGUW2gSFjQ9xFmPPsKcBQcrigYahL5ZF41pdJhK4
         TSdA==
X-Gm-Message-State: APjAAAVr2qtZSZwJJ0BWJQuzjik7FxUx6UGZNA+V3+z+MJz/ARdD1+Zh
        lCdYxCXtQUrYpMaAVsPWcDdbxw==
X-Google-Smtp-Source: APXvYqylEdirCrmQb8nQ/YoDobsHGQHkafXJiR/HRUcSgdyvESCuzkLThZErLZWwsp/leXFInnRyVw==
X-Received: by 2002:a17:902:a03:: with SMTP id 3mr86200661plo.302.1563997839413;
        Wed, 24 Jul 2019 12:50:39 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id y11sm51127550pfb.119.2019.07.24.12.50.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 12:50:38 -0700 (PDT)
Date:   Wed, 24 Jul 2019 12:50:36 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>,
        Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org
Subject: Re: [PATCH 5.3] mwifiex: fix 802.11n/WPA detection
Message-ID: <20190724195035.GA241329@google.com>
References: <20190724194634.205718-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724194634.205718-1-briannorris@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 12:46:34PM -0700, Brian Norris wrote:
> Fixes: 63d7ef36103d ("mwifiex: Don't abort on small, spec-compliant vendor IEs")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

To add to this: unfortunately, the above went out to -stable earlier
this week. So a prompt merging would be appreciated, pending review of
course.

Sorry for the breakage.

/me goes to add another (embarrasingly missing) test case to our WiFi
test suite.

Brian

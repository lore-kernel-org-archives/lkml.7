Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB64CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E542173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urO4kUbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389192AbfJWN7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:59:48 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:42515 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfJWN7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:59:47 -0400
Received: by mail-lf1-f51.google.com with SMTP id z12so16161151lfj.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 06:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PzYDV5DXErX10ZqPaP0g5TiUIQRWwQClDhhFIA0pg7I=;
        b=urO4kUbKaHufZkqTEc0ZFNs9vm5MIShfzhvLzFTgW5Df8R7ZqVMoxYiIpAG0YmJO0n
         H27PFdt4KA3j1BkHFa0lSFOJKHH6stPLwNdYCtcqI5La1NGNUpApBQHwncgYNwefbm1p
         vfJlaJJGmv3ZtPrmNc1luqd63yrfj1OshxbKwpNkDEmejtdcDnh86aociFJJs1GCxU0N
         LzvOCSZhWzM/L21qan7KtnWkJ1tnQXQH5luoPGjvgucDeyKiYE2mhzHr0L02CiENe4dz
         bymt9lpb8tiG6x3B9/38Vxapyy5unN5YngQ43GGVLAZKBiaslP0REiesnuIkgKinmoTR
         mnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PzYDV5DXErX10ZqPaP0g5TiUIQRWwQClDhhFIA0pg7I=;
        b=YhYyQxBClcohQHDzh1jHiWcv3ZRorwUZs603bZCVL9DBNeYYrK2ByKflPiZAuT8t0D
         rVSLftAYPbve+K6o3d0COufkjyexsVGkOpoZhgWIemXVpG8jG2Ny+IzKiPdJFNe1LdlH
         Vs83b3yVNLQ+CpcV41vp2EbnalVZDhz5gHmRYkYT/VMCouwlWFvtFc0Mtt5YqmIlqCeM
         MOVf4/7vmV/icn8Jsmushj3TEA5x8ehyDdXCwoGzHtX0u/NUbxeDlO9pnlqTTmjad9hR
         9QGBcLVeMhYho9VT67OeTltBxO6gcGtiMDPDIhXhE/GTyxSaQqkFUJ9Tt5QX9tjwmQ88
         D90w==
X-Gm-Message-State: APjAAAWCxm1Z1H7dqtcjQWrD0WEZZQNeZCaj4b/3URabavFW3vy3GeIB
        4YTYOPns8Ivw9o1fXzXn51b3i8UO
X-Google-Smtp-Source: APXvYqxtoGMUq2m7AXo9nHC7MPm/FUIVQKfAs+qOOAeohUtP5YSnYiC/wDXHoi4eSTcxgeV3wxDBNg==
X-Received: by 2002:ac2:5b47:: with SMTP id i7mr15089170lfp.82.1571839185809;
        Wed, 23 Oct 2019 06:59:45 -0700 (PDT)
Received: from uranus.localdomain ([5.18.199.94])
        by smtp.gmail.com with ESMTPSA id h10sm10036618ljb.14.2019.10.23.06.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 06:59:44 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id AD63B4610AC; Wed, 23 Oct 2019 16:59:43 +0300 (MSK)
Date:   Wed, 23 Oct 2019 16:59:43 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [BUG -tip] kmemleak and stacktrace cause page faul
Message-ID: <20191023135943.GK12121@uranus.lan>
References: <20191019114421.GK9698@uranus.lan>
 <20191022142325.GD12121@uranus.lan>
 <20191022145619.GE12121@uranus.lan>
 <alpine.DEB.2.21.1910231457400.2308@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1910231533180.2308@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910231533180.2308@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 03:47:57PM +0200, Thomas Gleixner wrote:
> 
> So the fix is trivial.

Works like a charm.

Tested-by: Cyrill Gorcunov <gorcunov@gmail.com>

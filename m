Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6BEC31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 13:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8E821473
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 13:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UGeCBSBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfFON7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 09:59:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34448 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfFON7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 09:59:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id p10so3206348pgn.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 06:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kJzT+l+OO8n7EwqnrkDiquC/ywPXGBmvTdfRsOHf0Hs=;
        b=UGeCBSBInFsZbVoakbF5FAzrgs/2dJXEhyelWiWKzi5DAuY6acxFfpLNy1YCB09WqL
         ya7HACESBLUB2LwsNh5c1185X7xTWyGC6Rc0Q2XQWWRj41dkRfJGG+r09q96hLma0cHI
         6wvqNIS7byjkB4dM18vDS/A59EiMyBk3MtoIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kJzT+l+OO8n7EwqnrkDiquC/ywPXGBmvTdfRsOHf0Hs=;
        b=fDO24j4AAAanWfytSuIY6rW5FZVQnsidDWy0+Qg2JF2pCW5tnibB3ijXSbNnL2MKxd
         8yZH06ztElX8a3fqXX6WcwcmDTc3ThU2GA9IZyxndkUCFah3rOpz0rwTUOPyMvIvvchL
         d+eZnINc03lgvTE9RryAXUVotDh8FpAk/s5Sz7ZEIfQWSPImQ08I27u5rzeN6aMALMVC
         rCKFRZ6iMrsbNXEbBfbN1E/eOL7UJ5vjPktqqwffaaMqYmwyjOEpH+qUjk+PceMVtl1s
         fvEmYxxXyqVsxO3wSmU3mUnK9WRKHnLQdWM3s/IhqYy1yCEqx3VbcborJ131yjdnodV7
         LVlA==
X-Gm-Message-State: APjAAAX6mURB+OfjsJ8YTFovf/vBHvVisQ1jefjLwAZrD9RDneTFUzMo
        P/6M3IGwmPFmEbtTTdxxmKNw3w==
X-Google-Smtp-Source: APXvYqwLdXHp3JRB1CMRTIRlwcqnZowh9M3CVRPn206dvAaR65wDYVCfeSsmPH6ijlNC+WfgoUMszQ==
X-Received: by 2002:a65:63d2:: with SMTP id n18mr29109647pgv.278.1560607175951;
        Sat, 15 Jun 2019 06:59:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s12sm5323358pji.30.2019.06.15.06.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Jun 2019 06:59:35 -0700 (PDT)
Date:   Sat, 15 Jun 2019 06:59:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Jan Glauber <jglauber@marvell.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC] Disable lockref on arm64
Message-ID: <201906150654.FF4400F7C8@keescook>
References: <CAKv+Gu9U9z3iAuz4V1c5zTHuz1As8FSNGY-TJon4OLErB8ts8Q@mail.gmail.com>
 <20190522160417.GF7876@fuggles.cambridge.arm.com>
 <20190612040933.GA18848@dc5-eodlnx05.marvell.com>
 <20190612093151.GA11554@brain-police>
 <20190614070914.GA21961@dc5-eodlnx05.marvell.com>
 <20190614095846.GC10506@fuggles.cambridge.arm.com>
 <CAKv+Gu_Kdq=UPijjA84FpmO=ZsdEO9EyyF7GeOQ+WmfqtO_hMg@mail.gmail.com>
 <20190614103850.GG10659@fuggles.cambridge.arm.com>
 <201906142026.1BC27EDB1E@keescook>
 <CAKv+Gu_XuhgUCYOeykrbaxJz-wL1HFrc_O+HeZHqaGkMHd2J9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_XuhgUCYOeykrbaxJz-wL1HFrc_O+HeZHqaGkMHd2J9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2019 at 10:47:19AM +0200, Ard Biesheuvel wrote:
> remaining question Will had was whether it makes sense to do the
> condition checks before doing the actual store, to avoid having a time
> window where the refcount assumes its illegal value. Since arm64 does
> not have memory operands, the instruction count wouldn't change, but
> it will definitely result in a performance hit on out-of-order CPUs.

What do the races end up looking like? Is it possible to have two
threads ordered in a way that a second thread could _un_saturate a
counter?

CPU 1                   CPU 2
inc()
  load INT_MAX-1
  about to overflow?
  yes
                        dec()
                          load INT_MAX-1
  set to INT_MAX
                          set to INT_MAX-2

Or would you use the same INT_MIN/2 saturation point done on x86?

As for performance, it should be easy to measure with the LKDTM test
to find out exactly the differences.

-- 
Kees Cook

Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B38C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFD42054F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eDidBiQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfF0P6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:58:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41906 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0P6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:58:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id c70so1089232pga.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 08:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m5jdjA4Mh5T62bcbT0WAFOmvzJ4iQAhMoI15EEuz+WQ=;
        b=eDidBiQ2y/Qtxis5JF5IB4c+580qLNPD2Ms/iqUBqA4w6bRpvaG7xGa9PHfXMhj7A5
         sq7eHT8vxMHZKmCT/jZr2ztJ960Xa1KyD/abiniVSGEc24u8pegg8IszBfV7BuHMIgb2
         efUk40mVLp8AnvlC2CnjQ4KF0/1SBRWY4MlKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m5jdjA4Mh5T62bcbT0WAFOmvzJ4iQAhMoI15EEuz+WQ=;
        b=pnLydnsuJUrzyJHV+uiB3CJAaQyg/Ycpfg2TyrGFKeJD74kZYLvQeZzkCw0feSPQiv
         leBzbIuGGqD/TplLjYUaAyvI5rfI1p9mrhRi+lBzkYX+kLTURNYsyVcO2lngvWgwhW1S
         3HPT34Oo7xUPWnmOyiY74g+TA94DeOGe5k6H7z0OdJB9LXUD/tCHL0zXcQ+2Z9adzdSc
         TiIro91TltOXkt4m9GEy1Y4ToxJ9YgPfDVEMlSXNeJmQ/P20aCWRTk03guL7z8jvRCCA
         nnCILbVKSFh7KjD3319SA3KioAuPxqbehiMjRCmai3hr1j8xRXTxmKTw+aAV0gLIuIBk
         XCWw==
X-Gm-Message-State: APjAAAWGUKUSK2HZ5e1uquFzQdfvRfZUUf+xhjrTSh9EtOlNyNWZ01aA
        fzDURFZFgGbmlckvB3b8siDajQ==
X-Google-Smtp-Source: APXvYqyIy5H1rZHeSlyF/dzNgqGv0+nyO7uySXo5T9+Ws9Jg2z/muYju2K0H5Nt4iSCvXKnut2gMKw==
X-Received: by 2002:a17:90a:9a8d:: with SMTP id e13mr6973840pjp.77.1561651084576;
        Thu, 27 Jun 2019 08:58:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 125sm5650159pfg.23.2019.06.27.08.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 08:58:03 -0700 (PDT)
Date:   Thu, 27 Jun 2019 08:58:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>, Qian Cai <cai@lca.pw>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] arm64: Move jump_label_init() before parse_early_param()
Message-ID: <201906270856.8CF50064@keescook>
References: <201906261343.5F26328@keescook>
 <20190627080207.sdpwjoi4wnc664gp@mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627080207.sdpwjoi4wnc664gp@mbp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 09:02:08AM +0100, Catalin Marinas wrote:
> On Wed, Jun 26, 2019 at 01:51:15PM -0700, Kees Cook wrote:
> > This moves arm64 jump_label_init() from smp_prepare_boot_cpu() to
> > setup_arch(), as done already on x86, in preparation from early param
> > usage in the init_on_alloc/free() series:
> > https://lkml.kernel.org/r/1561572949.5154.81.camel@lca.pw
> 
> This looks fine to me. Is there any other series to be merged soon that
> depends on this patch (the init_on_alloc/fail one)? If not, I can queue
> it for 5.3.

Yes, but that series will be in 5.3 also, so there's rush for 5.2. Do
you want Alexander (via akpm) to include it in his series instead of it going
through the arm64 tree?

-- 
Kees Cook

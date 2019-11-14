Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CFBC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83265206EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M8nTD+rJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfKNKvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 05:51:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33647 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfKNKvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:51:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id w9so5931481wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 02:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Em/ldcBTiCkH89iKxfabm8RKdGIliRRbSNYWY3rbkD4=;
        b=M8nTD+rJCM8aJ5Gr+BGRla3e74JOsongzpE3NPb9CW5En3sYtp6dkkCANBdmu4Jz2s
         3OovYM867yc+76ka0oIsnRZejqkVigTGWm/uX95LvJ9x/pfP7Ix456YKay2EgrcHPD7A
         r9X7n5J9D009fVndtxJF4c+IIwCeUq2zUdrH+nIp1EvedN9F9mGioF+zdNxdEqdxrPUi
         Qqr1SAFoGmSsxqs7etJR+8ZT+CjFyyrD0+ZkN9nH26YDuPtCvrmPheCA+N9ZpnjeddS4
         e8mkvd7L7Re3XqcJxui7bEIxMOhn+iMBKr0rJR+nBxluy05X8FHUEGA5gZbei/8UixgF
         1mVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Em/ldcBTiCkH89iKxfabm8RKdGIliRRbSNYWY3rbkD4=;
        b=arqR4kZ7Ty3IZPdvmNR+zZ8z61Myo0YYZXvaYKWMGXqJ+i9y/NRfs3sLekXVg+sCly
         rpP6uwdMOHCfQ7hNg4PC8Jn1k8RIdJLXUJXlAMF1zpQ0tgyX13bdSbe1wNAKFKJhY85j
         aPwdQbnv3/ZYw49AUOswL+p9DH9PF5h/E9ae9V8c8ctunow/E6pjMyzjCeKq18n/ovmv
         hqouBWoqAqViISE3HbyRvXGPud/UGsywDduuUYZy2WHCDuDiRCT7FSBTx5i9v9fl26X6
         sM0Vt0ojHFKgpE7OpMp/gx2DYvHRY8tP5AG2av46X8diarvUWpoLAUuzCwFzbefSxOI2
         ULrQ==
X-Gm-Message-State: APjAAAVe36qCbsx+C+FxzwuSXTcdzAKitsL8famwoMCTnbgKa2cec8VD
        h7mBrpFy6wGjINIxjHIjQvdrFw==
X-Google-Smtp-Source: APXvYqxaypmv9+7GkWChObVbu7wiDzQPNbv9TlnsTgRI+u9RhlgUkWuJB4t1Q8ZmN11y6dU12rOr2Q==
X-Received: by 2002:a5d:4608:: with SMTP id t8mr7789448wrq.91.1573728688622;
        Thu, 14 Nov 2019 02:51:28 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id k14sm7236681wrw.46.2019.11.14.02.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 02:51:27 -0800 (PST)
Date:   Thu, 14 Nov 2019 10:51:25 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        qiaochong@loongson.cn, kgdb-bugreport@lists.sourceforge.net,
        ralf@linux-mips.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        James Hogan <jhogan@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/5] MIPS: kdb: Remove old workaround for backtracing on
 other CPUs
Message-ID: <20191114105125.t3jma3ghwj2wtv6w@holly.lan>
References: <20191109191644.191766-1-dianders@chromium.org>
 <20191109111623.1.I30a0cac4d9880040c8d41495bd9a567fe3e24989@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191109111623.1.I30a0cac4d9880040c8d41495bd9a567fe3e24989@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 09, 2019 at 11:16:40AM -0800, Douglas Anderson wrote:
> As of commit 2277b492582d ("kdb: Fix stack crawling on 'running' CPUs
> that aren't the master") we no longer need any special case for doing
> stack dumps on CPUs that are not the kdb master.  Let's remove.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I have no way to test this personally, so hopefully someone who uses
> kdb/kgdb on MIPS can.

I took this as a hint to add mips support to kgdbtest ;-)

Support is added and working well. Unfortunately lack of familiarity
with mips means I have not yet figured out which mips defconfig gives
us working SMP (and what the corresponding qemu invocation should be).

I think that means I still can't (quite) exercise this code fully.
The most appropriate test is bta on an SMP system, right?


> Ideally this patch should be Acked by MIPS folks and then land through
> the kdb/kgdb tree since the next patch in the series, ("kdb:
> kdb_current_regs should be private") depends on it.

An Acked-by from a MIPS maintainer would be very welcome. Perhaps
with a bit of extra work on the above I might be able to provide
a Tested-by:.

I didn't see anything that particularly bothered me in the patches but
given we're already at -rc7 I'm inclined to target this patchset for 5.6
rather than 5.5.


Daniel.

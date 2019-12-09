Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99454C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DA9207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575914482;
	bh=YulCWfGFQ/5kVEqLXec5lV0Jn7vDvr47wNbFqi37rmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v7GfseL5bNPJsVCEm3CWrTNle156hg3WY0Ccd2UvAEJQ3UeQEI1VrNoAy9OC0UOXO
	 5aeYIP99CM13vG4ScO6pYLAUmp9hSHIGLHM1MjijFbZ57QBxWXVUSMzxYkvmx3gBzB
	 QWHd8Fmh/hdKeix0FlzU7w65r5Jx2JdUU5jLqcAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLISBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:01:21 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39552 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfLISBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:01:21 -0500
Received: by mail-ed1-f68.google.com with SMTP id v16so13478715edy.6;
        Mon, 09 Dec 2019 10:01:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XBPWF36yw8kGA9V4eiTwglCircLVoutwoSlSz402ncU=;
        b=Iv8/V824canxNMj/5A4QWVlXrLi5uSkhD8ItHRwH2dM7IRnoLIubfKCUkCZ38j0T37
         KzCSipPDUbW2Qnhm7ZG/Q/BJA95z0Qow7EkCZYLPNXxbBJJEgo/D1/fwE60XzW4oQnHJ
         M61isQdGe8fHVSMYoF5aBp3+cQeT7UiYvhsvg8Az7kxjX/tDTjz94YLe02I8P7HBWvsq
         GJ0kPMncNUsKKoZlJxCkSvRhW+V5+d+s4WU+9pUB/nj9lOaLTHMLQeFUUdRJb/nnRalQ
         +NlbVMKFOU4yRLfpUFYZd014p8cw3upmVFrCmvvFPyCCgBzX9lnoqu0BIVX0sJoPiO2P
         c0WQ==
X-Gm-Message-State: APjAAAVUE2doUUTvizZplUbBVJNdvJGklberWARerEeUOe10elZBR6rd
        7pFjR4fPz/rvmcVccXyheF8=
X-Google-Smtp-Source: APXvYqyTu65gV4dJb5bBPF7KsnrL0RqP0HQAb2e4Y/50STU+LI6n3y6uAA7xycpb0Hu/XIbsj/m5Gg==
X-Received: by 2002:a17:906:fccc:: with SMTP id qx12mr33020600ejb.325.1575914479628;
        Mon, 09 Dec 2019 10:01:19 -0800 (PST)
Received: from kozik-lap ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id k15sm15418ejc.35.2019.12.09.10.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Dec 2019 10:01:18 -0800 (PST)
Date:   Mon, 9 Dec 2019 19:01:15 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kusanagi Kouichi <slash@ac.auone-net.jp>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] arm: exynos_config: Restore debugfs support
Message-ID: <20191209180115.GA13800@kozik-lap>
References: <CGME20191206124826eucas1p246538607df51f2d68bce3b09d974b292@eucas1p2.samsung.com>
 <20191206124721.9025-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191206124721.9025-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 01:47:21PM +0100, Marek Szyprowski wrote:
> Commit 9f532d26c75c ("ARM: exynos_defconfig: Trim and reorganize with
> savedefconfig") removed explicit enable line for CONFIG_DEBUG_FS, because
> that feature has been selected by other enabled options: CONFIG_TRACING,
> which in turn had been selected by CONFIG_PERF_EVENTS and
> CONFIG_PROVE_LOCKING.
> 
> In meantime, commit 0e4a459f56c3 ("tracing: Remove unnecessary DEBUG_FS
> dependency") removed the dependency between CONFIG_DEBUG_FS and
> CONFIG_TRACING, so CONFIG_DEBUG_FS is no longer enabled in default builds.
> 
> Enable it again explicitly, as debugfs support is essential for various
> automated testing tools.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig | 1 +

Thanks, applied.

Best regards,
Krzysztof


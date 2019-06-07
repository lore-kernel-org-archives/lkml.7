Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6BBC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6892020449
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HDqNDDQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbfFGW1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:27:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36888 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731343AbfFGW1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:27:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id 131so3046279ljf.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sk6hPvdH3BWSbBnwR/y7MxMwBKDXfZfimHiTdJQ7FFU=;
        b=HDqNDDQA5OUvAfv5ErMrdJxAulMyLpON958EjMhIAcyGxIJUP1kb+B46jbNu0+4dXM
         5Je9yjehnmD7Zv2NuCq70LI794rhd3OCrwrPAK2Bkq2fZdvsFT2e0EUreoRTCKdqUNBy
         XeC/Abhkf6qZX9ErnfN+DKKGYDP9BqOAMPDJEyVWmZBYnLbnj9lHzYM+xfbmcyghxFIM
         iDyWCycTTXrddQxoi07tpAReu4/aquRc0gmhS34qgcA/nvw0K3lYoiapKHBYvyoBHyJ2
         hGUc4WOp43VV2dlm8rPsQBSFipPR3Y4zM8jx8jOGLVvhPfSfpqX55bcf+3kNVzT/0qNF
         zsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sk6hPvdH3BWSbBnwR/y7MxMwBKDXfZfimHiTdJQ7FFU=;
        b=f0EctszqZzFKMLFLHcIog81TACZcpbFYFMqZVKotaxKXhD2NXQSCTI7iR3MpMItFid
         bLO2Y8qR7IywXwDR1ddY3jsjSKd8eh5xGgd7JSDBDG9q1nWGnssmwZC64m5xrDC/gAdf
         W1zJcFNJ1TYBEPAEsBuX3LboiMk3WzGGbNzHQO4efiJsbkHudEqgcmabiEj1X7dEIj+7
         Oagfx0lyk+dJSF/VuoOErB7dxLXA2p9+jxKFZciscrphHPfbqGnByGOJTtxsUwTUH8sI
         BB7ohUe1v75EkYK7cvYY3FYOvXLeLdQzbVaA6nBOyUUXYFJk8wxLCFwXluIdnqSRkwLk
         8B9Q==
X-Gm-Message-State: APjAAAVEM9mfN7eQaZNvUoRPGTGrLMlKVn7FVqG28XLyjsDs1sywTh2a
        iVPKkAIiIaT18jayGUEYMcO+UucqeVaWOsW1G/izdQ==
X-Google-Smtp-Source: APXvYqy/UI46+O5OT6qX2Cn14OJJPA3iOf6898d4EJfNCD4loFfPrXXvFp4sT2CgeK3eVLnXph8b+W0IiI28NUGwJXo=
X-Received: by 2002:a05:651c:92:: with SMTP id 18mr1717937ljq.35.1559946442977;
 Fri, 07 Jun 2019 15:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190607221911.118136-1-levinale@chromium.org>
In-Reply-To: <20190607221911.118136-1-levinale@chromium.org>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Fri, 7 Jun 2019 15:27:11 -0700
Message-ID: <CAOReqxi45h20K4aSfnGC7kQFx-nOyLrDCknKG_Lc5iyGS4+zrA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Intel: sst: fix kmalloc call with wrong flags
To:     Alex Levin <levinale@chromium.org>
Cc:     ALSA development <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Zhang <benzh@chromium.org>,
        Curtis Malainey <cujomalainey@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 3:19 PM Alex Levin <levinale@chromium.org> wrote:
>
> When calling kmalloc with GFP_KERNEL in case CONFIG_SLOB is unset,
> kmem_cache_alloc_trace is called.
>
> In case CONFIG_TRACING is set, kmem_cache_alloc_trace will ball
nit: *call
> slab_alloc, which will call slab_pre_alloc_hook which might_sleep_if.
>
> The context in which it is called in this case, the
> intel_sst_interrupt_mrfld, calling a sleeping kmalloc generates a BUG():
>
> Fixes: 972b0d456e64 ("ASoC: Intel: remove GFP_ATOMIC, use GFP_KERNEL")
>
> [   20.250671] BUG: sleeping function called from invalid context at mm/slab.h:422
> [   20.250683] in_atomic(): 1, irqs_disabled(): 1, pid: 1791, name: Chrome_IOThread
> [   20.250690] CPU: 0 PID: 1791 Comm: Chrome_IOThread Tainted: G        W         4.19.43 #61
> [   20.250693] Hardware name: GOOGLE Kefka, BIOS Google_Kefka.7287.337.0 03/02/2017
> [   20.250893] R10: 0000562dd1064d30 R11: 00003c8cc825b908 R12: 00003c8cc966d3c0
> [   20.250896] R13: 00003c8cc9e280c0 R14: 0000000000000000 R15: 0000000000000000
>
> Signed-off-by: Alex Levin <levinale@chromium.org>
Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>
> ---
>

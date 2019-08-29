Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EBCC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123A522CF5
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nvXZU0kl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfH2RsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:48:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43915 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbfH2RsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:48:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so1958368pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 10:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=90rdzfA3pQFTTD+WktPm5hw+SqSXSPzoFO0ejPyiLeQ=;
        b=nvXZU0kldmmMZp3VL246Oh/QBj4YT779VxETaJPpFYHPXJ9BYrRq3foTUldaV/pqyv
         DFfTp0bomcCAL58rraETjnr8sPv8dnSgqaRCxsUqBYSqpTjFfY29AOrVMPhfE0RON9H0
         w8Y+wJHk2y3MwxYfVQXQmG0CseTKPQBn1MvKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=90rdzfA3pQFTTD+WktPm5hw+SqSXSPzoFO0ejPyiLeQ=;
        b=VW/RMAtI+tiGj8i15WIgVl2vMBebKVmKqWX/WPMp4Dhl+aU7pJilfKP6nwRNg43J2S
         LzuS5rXdEaSOQwE78WpIbxouNGJNT/fE9Zyl28zddDCUAHN6HbEqa18YcL7DjN5+wGNS
         8ch5xbvuz/xLCEROExMjnIRXbrmlX8dd4vvemhUx/1qn/57z65wyl7WSTdqSH+ZlPR2d
         xGWP5W/vrzOeku4A4IL6nrswg6w7xLFRe9BTMnxJ4puKq/8PH8mLoInfFK6+uEUpf/F2
         CcGNW56x9FRHfnguuKYKEl26Z6q51/9H88j9p8Nx4gOUqqoiLe8W29vDuXheUhe2Gtr6
         qzDA==
X-Gm-Message-State: APjAAAUuOyQk55w6Balk4MzBrgJNhELk/UzV1F3NMI4RymSbNqpNlWB9
        R7xxJEn0VBH5mKsV1IoMQTXykg==
X-Google-Smtp-Source: APXvYqy65Ly3KOvta1q3yjixyorRLWYiltKYfxGEdKZHPogdneVuSW8XJmeoBqWPDMGusYqMegigeQ==
X-Received: by 2002:aa7:8498:: with SMTP id u24mr13196622pfn.61.1567100892560;
        Thu, 29 Aug 2019 10:48:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ck8sm2585527pjb.25.2019.08.29.10.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 10:48:11 -0700 (PDT)
Date:   Thu, 29 Aug 2019 10:48:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alex Dewar <alex.dewar@gmx.co.uk>
Cc:     re.emese@gmail.com, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3] scripts/gcc-plugins: Add SPDX header for files
 without
Message-ID: <201908291047.CDE576721@keescook>
References: <20190824153036.21394-1-alex.dewar@gmx.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190824153036.21394-1-alex.dewar@gmx.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 04:30:37PM +0100, Alex Dewar wrote:
> Replace boilerplate with approproate SPDX header. Vim also auto-trimmed
> whitespace from one line.
> [...]
> --- a/scripts/gcc-plugins/cyc_complexity_plugin.c
> +++ b/scripts/gcc-plugins/cyc_complexity_plugin.c
> @@ -1,6 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright 2011-2016 by Emese Revfy <re.emese@gmail.com>
> - * Licensed under the GPL v2, or (at your option) v3

This isn't equivalent, I don't think. SPDX says "v2 and later" and
removed text says "v2 or v3".

-- 
Kees Cook

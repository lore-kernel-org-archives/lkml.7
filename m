Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC24C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE5521924
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J5Hcxqc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfJAMAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:00:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44172 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfJAMAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:00:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id z9so2029132wrl.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 05:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cX58GGACbtrolGnd+9mQWdHIaAk/EA5heJpdGs+Z5xE=;
        b=J5Hcxqc6va3RD4CAhadBwUzrMU6yN/sHECz7MCwAgEwWB+Anlnnp3zu+G87CDgK1Jb
         1q3ZhMI0w6Q4jrEHyKsrtV8HgSW3roCzlKr8HJbl66Tojau2T69eNrCVLXmaT/Pxs8qg
         0AyO/HTM4pb6VDTonRpHGzevuxV1QSnLtbWDg7d9jIBysbnn7P9Dja4/IVYEI1WF4JDB
         5nMWgSgyhUln2kThGKs3PapKsqGJlWQltaqfunHfBmU2iBUfbhoQLhWOxADhfQt2Wxov
         HpTHXaqvdr9fNQNlGs529fiVtFvtxdnYRFYIeLeHdyrblyH3tq0qNya119frj63U9hE7
         kvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cX58GGACbtrolGnd+9mQWdHIaAk/EA5heJpdGs+Z5xE=;
        b=GF1QSJ0N9SyrFEudBGB7X+jyDeVnnglAeDNOItaJ0o9zcBTLnSPFQBiBd85bl53eoo
         v7y30GaeD9lKzcHfodLrUhYExtv+sAs6c8nW7i+qRvxvfuwyV/7Qw6rSMTAB92qJfsFx
         A/wT7XW5oEyGrvdAGL7N0fFyOofTocZRqRkc475LABmIDbqyAuesKdNDgnM/0xgCohCq
         eItfPYkae0pfmJbyWLHMqApEu34I62dq42OU7FoVyaVyppdw3OhMwOeDrp9k7hP00zhF
         J5rpRD1N6YmliCCZw6hPod6ZDKmvyFKZMQkBZ2vO6ocdWAq8wjXqFdEsDKwQ5tPmx5o0
         DN9g==
X-Gm-Message-State: APjAAAXxDxaf3VuVtDZnxSqMculyYS4w4wby+5XcI0qrMYM+/g525Sv9
        wbeWujQ6H1Q50LpaMs2lD32D0A==
X-Google-Smtp-Source: APXvYqwITNLfh4KoCqzJsE/cZlnld6OeSRg9Cn+FjjCeden2TyBIwPP2jxHWZzGoQuKeM3jwaX7gfQ==
X-Received: by 2002:a5d:44d2:: with SMTP id z18mr1493824wrr.122.1569931222387;
        Tue, 01 Oct 2019 05:00:22 -0700 (PDT)
Received: from dell ([2.27.167.122])
        by smtp.gmail.com with ESMTPSA id a7sm32966282wra.43.2019.10.01.05.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 05:00:21 -0700 (PDT)
Date:   Tue, 1 Oct 2019 13:00:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     vishnu <vravulap@amd.com>
Cc:     "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] ASoC: amd: Registering device endpoints using MFD
 framework
Message-ID: <20191001120020.GC11769@dell>
References: <1569891524-18875-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1569891524-18875-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <20191001064539.GB11769@dell>
 <2ff13a61-a346-4d49-ab3a-da5d2126727c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ff13a61-a346-4d49-ab3a-da5d2126727c@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Oct 2019, vishnu wrote:

> Hi Jones,
> 
> I am very Thankful to your review comments.
> 
> Actually The driver is not totally based on MFD. It just uses 
> mfd_add_hotplug_devices() and mfd_remove_devices() for adding the 
> devices automatically.
> 
> Remaining code has nothing to do with MFD framework.
> 
> So I thought It would not break the coding style and moved ahead by 
> using the MFD API by adding its header file.
> 
> If it is any violation of coding standard then I can move it to 
> drivers/mfd.
> 
> This patch could be a show stopper for us.Please suggest us how can we 
> move ahead ASAP.

Either move the MFD parts to drivers/mfd, or stop using the MFD API.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

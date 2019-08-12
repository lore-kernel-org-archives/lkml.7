Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D249C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B975206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nr1hMmtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfHLIMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 04:12:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45669 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfHLIMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 04:12:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id q12so13497974wrj.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 01:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sokJZLkNPUnTH7UQDyFo6f/1noe8aK7eS7kzgH8GIsI=;
        b=nr1hMmtXet+8ablw2NJEuHI3grRig1gViabXXqNU4/7QNt8V4U7TXNlFeQ8DGhKaP8
         JguAloMyUujDSfJ8USZRlhk2e3FbDZ1dmHDkMcgEYuavSdF4y505YTssFvdX+3gytLm0
         C00I0eclJJMDwKSvo+z/dNidPtfCto8si9PxbfeqQH7jZR5jalGquAyL+dqOSZpeVGjv
         HX60RGTe/DOSRXd2wGkFiEJ4yILuzlnemPf52xtCt/+GqR+cl0j8m8BLP/AcgkN4EAcn
         t3OVuvKD3KK82/dNMlw1zZRh2U+i1e2ZxgmIjrk6p/+0PUld1+Mz2l5+5jPMP+88fOfR
         Et3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sokJZLkNPUnTH7UQDyFo6f/1noe8aK7eS7kzgH8GIsI=;
        b=g0EpytnaALRv+iYRfO0YWL97eLVMndouFZn/5binutJZAaq0OvgxWnWWIVrUMhZ3Mh
         Ut7lUkwmfayQ3DVjhb+SEvbGuApP53S54WCRuknVVsm7gPB5JKucBOcmHiQ3QngBl9Mk
         3PJW32BHVBeMVuQIXL7hhZdfbyu1hI0QZa7Htar1P/WQVQS1gsdKfws772PS7lpc2d7v
         m9/PG9aA9qJNUKrPM7GLP5cE5e68zTdgahUPgxUN5gzv0fpkUTCs0+WMc992XVHj2Qik
         yWn4rKVJ+mqX/goQufIJm/iep9pbjXadUB3yzIihdX5Qk5vH+sonKXLomKEdpJOOftUd
         dCLw==
X-Gm-Message-State: APjAAAVm74EKhjVf5P1CIibcn/Owg4ftssr2fAbZ2fAd5kSsp+QouulC
        5Em/lHYNEUBQ4Jf7eZA1zpAcGQ==
X-Google-Smtp-Source: APXvYqx1OQqxQ8Wnsp/z2cQM9KUTftZPue3b+SHzZf2Cf2qMFxI4cvxLIr4PdAu+/VKFD90VZNqm9g==
X-Received: by 2002:a5d:634c:: with SMTP id b12mr18336536wrw.127.1565597535490;
        Mon, 12 Aug 2019 01:12:15 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id l3sm23964164wrb.41.2019.08.12.01.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 01:12:14 -0700 (PDT)
Date:   Mon, 12 Aug 2019 09:12:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: intel-lpss: Remove D3cold delay
Message-ID: <20190812081213.GI4594@dell>
References: <20190705045503.13379-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190705045503.13379-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Jul 2019, Kai-Heng Feng wrote:

> Goodix touchpad may drop its first couple input events when
> i2c-designware-platdrv and intel-lpss it connects to took too long to
> runtime resume from runtime suspended state.
> 
> This issue happens becuase the touchpad has a rather small buffer to
> store up to 13 input events, so if the host doesn't read those events in
> time (i.e. runtime resume takes too long), events are dropped from the
> touchpad's buffer.
> 
> The bottleneck is D3cold delay it waits when transitioning from D3cold
> to D0, hence remove the delay to make the resume faster. I've tested
> some systems with intel-lpss and haven't seen any regression.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202683
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

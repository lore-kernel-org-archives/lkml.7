Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAA3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA31F20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LhSVrJyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfDDHS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:18:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42932 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfDDHS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:18:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id r15so890967pfn.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 00:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LWVq7kqV99ONNNxy48MO6cOVNYHPd00IJl1wSK5Iakc=;
        b=LhSVrJyzC/60UOmVTGf1s8fCsjebazQoC02D5dKa5YxJ7ocXzvjwpAlskg/vlF7eV+
         shmMXlyzI2bujiM1/bK/4br/kBECQ2ZqbcfVbW2T4bLc0pIEl/SLx9XhuehbHGKJVg/N
         zvtPInnoSm/R2KI8Iko+Q2pZJrG+Whj2biQ6k9apHMnZbc/Ul/WIBUZmIlS9pT/rCrtM
         MPEwMMEH+Czu2qlO2cJcMFSjc6M6cwJwoQUCOZ7ZETKq8P3ohkB6IssTGAFBd8yXbEOe
         jY+CMXR3G+iCvPgcJLygPAUBTy+w4BO7nJlEEALm0X30QSdpeMb2oG3VvZptdgSWcsLJ
         G6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LWVq7kqV99ONNNxy48MO6cOVNYHPd00IJl1wSK5Iakc=;
        b=UtdIXwhAiuA/KWVuED3kzvUPucyP60dIlc1/Thv+MvgJEZR7sDxxiDWtDdPU990T+3
         F4nEU9CvnV3G+ri/qLyO/FjT98bVVquXhdpqwuMcNbuxF5yw/GXQclQPTW60t7XUylDE
         BMu3R0scc3qqWKW+q90YbV3HRjLkySnxgU9MEiYGnkbCEd6q8/jbyy5u3uKek0SEh3pp
         afA9EaSXZFBnPP8jRFnOeaEl7gzY9oxOiC9wueQ8njuydqR64xfWpNrl2IIs9niOJaOM
         9sqRtJl+G80yVKV1Tg+boZ2cdoHh/nLjke0bvmuxl806mdFN+8WWPoQ2maQY0CfA7kLt
         s79w==
X-Gm-Message-State: APjAAAWFhePx8tytQz3KgeEYfFu94hNj3kJUeLaYrZ2IaWm3D0MVkMZp
        RfQcy+DdpRLVktRsoOfov/o7/WGohp9YZA==
X-Google-Smtp-Source: APXvYqyNAdIf/IRhktgZFOad9e9/tnJUOeIYIeuFfkhYdfJUcEg4JrZhkVT1CSYfBHgCZSTgpk5gGQ==
X-Received: by 2002:a62:be13:: with SMTP id l19mr4166616pff.137.1554362307361;
        Thu, 04 Apr 2019 00:18:27 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id h187sm25554535pfc.52.2019.04.04.00.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 00:18:26 -0700 (PDT)
Date:   Thu, 4 Apr 2019 08:18:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: cs47l35: Make DAC_AEC_CONTROL_2 readable
Message-ID: <20190404071821.GI6830@dell>
References: <20190403095917.6351-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190403095917.6351-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Apr 2019, Charles Keepax wrote:

> From: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> There is a second AEC loopback on cs47l35 so the registers for it should
> be readable.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/cs47l35-tables.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

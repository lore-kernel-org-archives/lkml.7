Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CDEC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 04:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40749208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 04:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YGZ2aXL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfD0EjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 00:39:03 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39769 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfD0EjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 00:39:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id e92so2476018plb.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 21:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Osd9Hf47fsJxiMtBYizLGSJzqZeKmsAQhgBWnoHc10w=;
        b=YGZ2aXL9+BZGEZiCD6ENXrRuMSr/YDQ07o2ZEyeP/4rf0Tgta9YDXsZ/gmnHdljs6M
         XiSmKpwVvjkrcZRK7ciGAQuPyHd+4fzp+aU9+JVa3GUBIZw6xUBwhNpl5mox/44RTNfS
         gKhVxr+PW8Z0Ef41op62FkYQNtnR75qbTRhWhgpOC/atfOT2o9xKCCOrvyiMEMMflkyo
         LTOOObnKWH8OeH5EmdIgLfSHeBpIdbmWSSkX2ZUU1+oQJk8yfQ3am5h+mtp5k5L98OOr
         LTnGK8jMGOISg6p1xEtVR4gtzCM+jTDHCzRvKfel0Ornj37QZXqsTqSIWowy7cDzVGvS
         xhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Osd9Hf47fsJxiMtBYizLGSJzqZeKmsAQhgBWnoHc10w=;
        b=GGcHDX28Rk3we1SSJuE08GRqSF6aUi/N227/sqi0WY/DgKGif0CZUhhgudCVorwD3E
         oTXwMZb1OZi4CkSVxbITItEolocw4yuW6rhkLjYHQ5bD51weYZ6t6s9o6U0fn5LgLqmQ
         vM9wd3WvFa2tmrjxfMy6eSRq0M2kVjc4Z21PDoqde1tfFiY/PIlZz6ZvmDH9S/xxDYxi
         Rzb6odN7M0m6JZ6epB8whV5YQjwKtteO60gEZa7Mnr7ESqIvmgQpyx1Va6+fuip8i/BE
         /BErt3Ck4/9yK3HwHYZ2eI0npcS3d0lOx4GWxRJhVFg/g5ge7PXSHk7Llp3BZsgQs5w0
         ap/A==
X-Gm-Message-State: APjAAAXhfvjFCrbjjRnnqdos3cDOv8QZbeRA0Xx3+LPYkj4Y12cAlZYX
        mXVY438OMMxn997FlH3U0DkDmiG6Lmc=
X-Google-Smtp-Source: APXvYqwYzu/Zy3EM9Z4BsRgMw+I7DHKQkFcoee+4BnadXU+wS233ulhPtjjNPQW7Z7lFfJ7nV7eZPg==
X-Received: by 2002:a17:902:694c:: with SMTP id k12mr48725823plt.149.1556339942201;
        Fri, 26 Apr 2019 21:39:02 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x128sm48767554pfx.103.2019.04.26.21.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 21:39:00 -0700 (PDT)
Date:   Fri, 26 Apr 2019 21:38:59 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv1 0/2] qcom: pms405: adc fixes
Message-ID: <20190427043859.GC3137@builder>
References: <cover.1553088982.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553088982.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20 Mar 06:39 PDT 2019, Amit Kucheria wrote:

> A couple of fixes to the adc node in PMS405 to get thermistors to work
> correctly.
> 
> Amit Kucheria (2):
>   arm64: dts: qcom: pms405: calibrate the VADC correctly
>   arm64: dts: qcom: pms405: Rename adc outputs as per schematics
> 

Picked up the pair

Thanks,
Bjorn

>  arch/arm64/boot/dts/qcom/pms405.dtsi | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> -- 
> 2.17.1
> 

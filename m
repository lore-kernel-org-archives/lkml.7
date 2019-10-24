Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868D9CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E34205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KarVPLaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408797AbfJXH5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 03:57:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55792 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408787AbfJXH5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:57:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id g24so1623356wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 00:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2R2CzbjvEDjQmx61JPs0RIA5BRAZFdy1ELg14vUw0UQ=;
        b=KarVPLaBPctaaN5I1bubIar3T/z7eSO6kv6QHJHU97Yb654aPehI+thVq0mZ3Jm8nx
         n2c9tW1zImFk0i7AZS5BjlzwY9kxtexGvnoqflA6oaj3k1JJ0SOol5VCjorf9/t7/g+R
         zkdk5KQf7KCombZznlxFlE+f0Hre2crdS44Cd1lSoeRAoGYWiqRjNyVer9cKHhTF4UR5
         wzSWUb2gRLA7/KFvI++Xfpe0MFXxtl2mSbyfnVu7uFK1+eeSS5d2929gLYcg27fFo9vV
         6wG10gP2E5B7FNLyrKcPOyKtL1kFOHm43pq0c/OPj/qmwyfPc9vqIjTig758Wzk3opYF
         r+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2R2CzbjvEDjQmx61JPs0RIA5BRAZFdy1ELg14vUw0UQ=;
        b=mcbxZvUCVD99ezJDP2UqbnidUZr2ZpVxsrvL/lCx0ARlZqgj5fGfQ7+xLqhDJnUYd8
         1UUqbzZG6onxjLBEI6wIdv2AtalqO5hmUamhFBPLnevaneCq/0tYKzkjqVE19lrInZSw
         zpogmbv/zY4PbzafQBkdQzj+KEkhXZyXGZ1PO5Zn8dZbEzR/q18AE5s+9KCZLw5wTH7A
         T350pxSjl02ivUqCIyZui+ipl134bgYrNWb3Qx7oESc3bbit+aNmgqeDwnTuu5RjDqGR
         nPMiEa6kHEM6M8BcfFXjflzRWgVhgTaAbW1CI2tkRdTHpFl1/DLdMqgqDnt6cYo4zMpl
         m+6Q==
X-Gm-Message-State: APjAAAUTqct+MqrCnaQK5e0KELhsiQ9Z1PgbGLAfCzLknAciciaNsqus
        T+RGJbGF4TPXNmp6QjjEIbUdTg==
X-Google-Smtp-Source: APXvYqzfzbyOD0kMrrQiasuUlY/4XG7ebzJuOpr4xPK79DUE6o1jWvTCFJ/oMBpjTCu4tX/LxTh1vw==
X-Received: by 2002:a1c:6885:: with SMTP id d127mr3484113wmc.64.1571903842614;
        Thu, 24 Oct 2019 00:57:22 -0700 (PDT)
Received: from dell ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id d4sm31839931wrc.54.2019.10.24.00.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 00:57:22 -0700 (PDT)
Date:   Thu, 24 Oct 2019 08:57:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mfd: mt6397: fix probe after changing mt6397-core
Message-ID: <20191024075720.GI15843@dell>
References: <20191003185323.24646-1-frank-w@public-files.de>
 <20191016095338.GD4365@dell>
 <24600EAE-5379-475F-B83D-880E767F2CDA@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24600EAE-5379-475F-B83D-880E767F2CDA@public-files.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019, Frank Wunderlich wrote:

> Will it be merged on rc-cycle?
> 
> I ask because i see it only in mfd-next but not in fixes/torvalds-master

It's been sent to Linus for the -rcs.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C190FC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9346121739
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="fPZkCIk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfLPUVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 15:21:18 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41664 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfLPUVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 15:21:18 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so8222131ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 12:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Coj/0TiMCvz30A/R8txuCVhc5n1pm41RNaOjJUWUaS0=;
        b=fPZkCIk0sJHFLthoSa2l0yCn2V8lLSwii17NEqkwT98ikRbJYd1twQVIIGQw7ltrH6
         J6doHz2eDuvnDERtdF9jYiFBsZs/SpGZwOcVAugBoU9E3jT41G/1ZigNahbIa1J8rg5K
         kSbJqo+ITbb2zxFaZluYltZ1isGPfKYAAXcte6U5wo82/wR2RXiPcnHGvaAKqPXV0Dnk
         NKG2rqg84KUceg2vu6AL70Z+Ieyhw9hnEIQ5ol8TGm1ChMs4pc0/vpjrVAQGMVZuPzes
         sXe0f9brx+3rHfDB2mBiVtY6XH6BhzvHiPtE68xp98dm6LygxTRY0c3DDKJPoAoGnVLW
         xjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Coj/0TiMCvz30A/R8txuCVhc5n1pm41RNaOjJUWUaS0=;
        b=FnPKwzroueh0LiRAV5kWZ64yOVL2BRZHdlHNLjQw/xIDC7td/lYTulm8PAYgantTuk
         Mndc8HiGH8+mzrM+GilGRcLZlFeV3kLFNLF1e/wE+KoyUxzaMgXR6wf7ADb4laQFtZzV
         WH2EOnx5I0+CcYPczKIXXjsS7DXxZkqc8Evq2AXYukd4VXN+HQLtkpHMsHx5ZHSk9Ysu
         ziptUWO74re0JI3mg4SUR5eZI1+aX10Jmn4ago3XXtYsESYM6AqeMCQ/pUjdr8v/v51d
         pp9eQ5s4jyf0ET4IqhzzFEoPrL2Mb0cFV0lkmYHkgmcoKejJDaFC5sZ82DwWBtFelapJ
         2jLg==
X-Gm-Message-State: APjAAAVzlkBdHtD81vR9/GmVNXnrwfQuBXl/r8HA38f1jDz2edljFQgi
        0go4R883Mt5Xxx5cl84c3GRN8g==
X-Google-Smtp-Source: APXvYqwvffi+Q+fIIrfBgnRjuyf8h/Vz0+Y6j1dBgFciwrLYs7AYC/zjAUfMezy6GLiXnMwUcjT2XQ==
X-Received: by 2002:a05:651c:c4:: with SMTP id 4mr644180ljr.131.1576527676330;
        Mon, 16 Dec 2019 12:21:16 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id r26sm9508344lfm.82.2019.12.16.12.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 12:21:16 -0800 (PST)
Date:   Mon, 16 Dec 2019 12:21:06 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jose Abreu <Jose.Abreu@synopsys.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 0/8] net: stmmac: Fixes for -net
Message-ID: <20191216122106.582b6cc9@cakuba.netronome.com>
In-Reply-To: <BN8PR12MB326639325F465266DEACAA64D3510@BN8PR12MB3266.namprd12.prod.outlook.com>
References: <cover.1576005975.git.Jose.Abreu@synopsys.com>
        <20191213162216.2dc8a108@cakuba.netronome.com>
        <BN8PR12MB326639325F465266DEACAA64D3510@BN8PR12MB3266.namprd12.prod.outlook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2019 09:26:22 +0000, Jose Abreu wrote:
> From: Jakub Kicinski <jakub.kicinski@netronome.com>
> Date: Dec/14/2019, 00:22:16 (UTC+00:00)
> 
> > On Tue, 10 Dec 2019 20:33:52 +0100, Jose Abreu wrote:  
> > > Fixes for stmmac.
> > > 
> > > 1) Fixes the filtering selftests (again) for cases when the number of multicast
> > > filters are not enough.
> > > 
> > > 2) Fixes SPH feature for MTU > default.
> > > 
> > > 3) Fixes the behavior of accepting invalid MTU values.
> > > 
> > > 4) Fixes FCS stripping for multi-descriptor packets.
> > > 
> > > 5) Fixes the change of RX buffer size in XGMAC.
> > > 
> > > 6) Fixes RX buffer size alignment.
> > > 
> > > 7) Fixes the 16KB buffer alignment.
> > > 
> > > 8) Fixes the enabling of 16KB buffer size feature.  
> > 
> > Hi Jose!
> > 
> > Patches directed at net should have a Fixes tag identifying the commit
> > which introduced the problem. The commit messages should also describe
> > user-visible outcomes of the bugs. Without those two its hard to judge
> > which patches are important for stable backports.
> > 
> > Could you please repost with appropriate Fixes tags?  
> 
> I agree with you Jakub but although these are bugs they are either for 
> recently introduced features (such as SPH and selftests), or for 
> features that are not commonly used. I can dig into the GIT history and 
> provide fixes tag for them all or I can always provide a backport fix if 
> any user requires so. Can you please comment on which one you prefer ?

I think Fixes tags helps either way, if the fix is not important enough
upstream maintainers should be able to figure that out based on the
commit message (or you can give advice on backporting below the ---
line, like "Probably not worth backporting").

For the recent features it's quite useful to see the fixes tag so both
humans and bots can immediately see its a recent feature and we don't
have to worry about backports.

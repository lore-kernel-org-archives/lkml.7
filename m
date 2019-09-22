Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78B4C4360D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 02:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4F720C01
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 02:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="mfZxy2sq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfIVCtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 22:49:53 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:37293 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfIVCtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 22:49:51 -0400
Received: by mail-pl1-f174.google.com with SMTP id u20so700193plq.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 19:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=anDfSlcsinrIuqUyxfiFcZfqVNlRcVIERATNLsETqQY=;
        b=mfZxy2sq/aDKntUmvOesWWFgM501zlmT0QpE+8Y3+duZ2e9RLwsdz3EzbknN01qRdx
         /DJM6peKzpH1uE3x7/dOQZhRHneaUKMm5+UU6wBBXZopFmaET2zbcMvrcWFEH8Lcy1MV
         mHsKbJt/O4aAQLG8QlJ5NtzYWa8/QCeSzo9oMiCbVvSsyajYnvQd5hWIV29MDQWxeTMf
         6rnN4w9QkstK63hfcmaGs8Ww6Wf4CDRwdH/94iFQ1InHtTPUqSLl55mQ+r8R2G+4rc6m
         JkiB60FFY2ZFOwyHN7wEgkpBNBIkm7jIrh6HhqdgOUG69IsDm6L4nHXV4BDY+YZsIEfS
         +w1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=anDfSlcsinrIuqUyxfiFcZfqVNlRcVIERATNLsETqQY=;
        b=YuCt06VcOMlg1TGLYl/CotNj2gOOL/MExi/ev8UHbiZ3pXmdEiRNIm4LqB7yiTDwqo
         MsM6jf2boupiECgIvPMHfinvpSeTEJ9tXog/iVEYCwMY/Iwx0mUxEEKY0GzAi/IoxLcT
         AYFm1zVzgRzPAgFwB7P0ISutxEwB9YTlyoUcUq9wEf5SRkP+3T7KDqO9/QrxqLRYkArC
         yJvPa0q0kY9jkOkZ+VdB7fw0IZz9oPs7uqkw9XXYC4cSHWoKQNZ6qJQVH+16ysx62wtO
         45SZyOTwfAqefcxtSrklkfxafr8Ek+lhbSezEJeAX4+6Lr78y6kmktDZ8gVM416Xvq5T
         9ipQ==
X-Gm-Message-State: APjAAAXOFFvnWgQEpIKbsEYgcNHyYbKPFbLMuozs2wFvQUUtP4pj5O3Z
        mn+oJ51o60Z30jEFiiuZO4JOig==
X-Google-Smtp-Source: APXvYqw/mTTWbaH79472SmRNTbJG75f7zpe+KuB92ZzGVL55dDHwbFBp4ZPeMaM6FzznylBAqzVZQg==
X-Received: by 2002:a17:902:d714:: with SMTP id w20mr26240046ply.29.1569120589739;
        Sat, 21 Sep 2019 19:49:49 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id c31sm5709585pgb.24.2019.09.21.19.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 19:49:49 -0700 (PDT)
Date:   Sat, 21 Sep 2019 19:49:46 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] net: stmmac: selftest: avoid large stack usage
Message-ID: <20190921194946.710bb0f1@cakuba.netronome.com>
In-Reply-To: <20190919123416.3070938-1-arnd@arndb.de>
References: <20190919123416.3070938-1-arnd@arndb.de>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2019 14:33:43 +0200, Arnd Bergmann wrote:
> Putting a struct stmmac_rss object on the stack is a bad idea,
> as it exceeds the warning limit for a stack frame on 32-bit architectures:
> 
> drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:1221:12: error: stack frame size of 1208 bytes in function '__stmmac_test_l3filt' [-Werror,-Wframe-larger-than=]
> drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:1338:12: error: stack frame size of 1208 bytes in function '__stmmac_test_l4filt' [-Werror,-Wframe-larger-than=]
> 
> As the object is the trivial empty case, change the called function
> to accept a NULL pointer to mean the same thing and remove the
> large variable in the two callers.
> 
> Fixes: 4647e021193d ("net: stmmac: selftests: Add selftest for L3/L4 Filters")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thank you!

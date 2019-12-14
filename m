Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91461C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 00:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7485821655
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 00:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="moDlCKvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfLNAW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 19:22:27 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41345 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfLNAW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 19:22:26 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so545938ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 16:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=giiBxdvWgaNqH68xnv3JmWP9dzCBTdZ9klmH0YITisE=;
        b=moDlCKvuxDXDzEEAIiXkhQpF42yemoKEbL0AZF9wNsfDWxNqQ6PAyC79TcuJE7Mkc9
         Zd8qEd4kDdalk1yWC0H+Rr1MJ1/Yx0Hzhn7Tx0fCPyejRdP0cH3t3Jq5V7nYVWtI9cTR
         S7EOX9jtd1eh7m3Y6RLy5trfH8sioerQknIUhEUlEwtfb3Rtt9vMYdIm0xtLws8vyLIo
         8Wz5AZza9+t2BnITvbK6kvG+AWHbDFu93SVokmMiCVY0e3lv9bI1cVEarTCu+TarLpw3
         brGJ7zEjLhMXpGfaQjutJUx6HNe/0vR1nl/rzpmdY6cIp+tWFtL5Bbuhd7ElwsD/eF6b
         WE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=giiBxdvWgaNqH68xnv3JmWP9dzCBTdZ9klmH0YITisE=;
        b=BRT3ZG70DPaD8PWTy7jxwil6j6jnBmUGdhvaALP2wZ0Io0XNnOuB7UZQ8kgnFMHBkA
         pGpVBCOZBVb73l3r6LvXclUwbYx1106d3irmBi3BjSOnFz2n+j1dWuI8ArDbYTHx2VjM
         HzbdaLzVyaIoNOHoOHCt/yMTod7sA2iUD3pqnjp5lgGlyT39iSayQbp++oTQ9IGlHJ5j
         zscpLj+AM7psEQe4YbqUr3qIIWKdK9NjIMfEx+CH9mzvq8DjvaPudy02/5H5EsS3N8AZ
         LbyMyEkrThKkHBf2pgC6PnekCtcoIsH7VsqbrshShmZxHzdBiEdri2IlW3KUpytgAwZE
         sWBA==
X-Gm-Message-State: APjAAAW3Um1ifwFglS8r2hFiJkn5hGN7TlNB0Dybro7lsJPxrAHNPDzN
        XYE/E5O0yCQt5e4hbzxN+6rWbg==
X-Google-Smtp-Source: APXvYqxk4KifralwNEGO507iNNuOIWFqTEHw/xBJIq1aHCZdSobUATGCeEfnlG0VPQmTb1fbDwOe/Q==
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr11430388lji.256.1576282944630;
        Fri, 13 Dec 2019 16:22:24 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id k25sm5583547lji.42.2019.12.13.16.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 16:22:24 -0800 (PST)
Date:   Fri, 13 Dec 2019 16:22:16 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jose Abreu <Jose.Abreu@synopsys.com>
Cc:     netdev@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/8] net: stmmac: Fixes for -net
Message-ID: <20191213162216.2dc8a108@cakuba.netronome.com>
In-Reply-To: <cover.1576005975.git.Jose.Abreu@synopsys.com>
References: <cover.1576005975.git.Jose.Abreu@synopsys.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019 20:33:52 +0100, Jose Abreu wrote:
> Fixes for stmmac.
> 
> 1) Fixes the filtering selftests (again) for cases when the number of multicast
> filters are not enough.
> 
> 2) Fixes SPH feature for MTU > default.
> 
> 3) Fixes the behavior of accepting invalid MTU values.
> 
> 4) Fixes FCS stripping for multi-descriptor packets.
> 
> 5) Fixes the change of RX buffer size in XGMAC.
> 
> 6) Fixes RX buffer size alignment.
> 
> 7) Fixes the 16KB buffer alignment.
> 
> 8) Fixes the enabling of 16KB buffer size feature.

Hi Jose!

Patches directed at net should have a Fixes tag identifying the commit
which introduced the problem. The commit messages should also describe
user-visible outcomes of the bugs. Without those two its hard to judge
which patches are important for stable backports.

Could you please repost with appropriate Fixes tags?

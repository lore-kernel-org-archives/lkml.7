Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBE3C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17B2218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="j1N3WnyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbfJIXK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 19:10:27 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37742 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732199AbfJIXK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 19:10:27 -0400
Received: by mail-qk1-f194.google.com with SMTP id u184so3859603qkd.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 16:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=NTimbsKgKVFDwuRCQXDTlqAXzNdTJ0Hr/Eiu/ueYeWQ=;
        b=j1N3WnyQePch5c3ATnoCW8Gc5+utVUM07IPkUm9U5i1N1JvfqxJFhHzkKW934vUUlP
         WkvTVLgvTE4vl+TZ523OqX2PD2BC162vDZeljPWx3plErfZrydgfhBIbUm4Si1O7JuQ8
         KFdNtHeSfIjs8hVYdCqBuC7z01mVYUvA2DLlo76GRCdf/CtgLkEnXA6Z0trETa6mPkHf
         qw+2ujEP6/yOZsntZfx9+c3uhSPh1prUi4yCGrwvmiRrE5zjnK9zpU8wB6QCwFRuoqmn
         0HkXxV68gwvc4Sb8Ap5qeAJpn5pEnFjJ6dNTOpqRIc3z4GHLSG68hnzwQN8ar5PGZY96
         8tXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=NTimbsKgKVFDwuRCQXDTlqAXzNdTJ0Hr/Eiu/ueYeWQ=;
        b=mCNmQrIKbFoYyPNWuCM9dHwaYIUahrroPNVScuo/QEe8wNrTxofSXI9rI0kETtbzKu
         0uWUNp95SNvDWfV/a7LIgdFCDukoDF9KhSuZybn2LMPvTtH+2ftd+FrYBixVRrosdR32
         Sljxsx0qUaasG2WpJXvyOZC8gR1pYPleU+BelBR6ThnTiSBmWcF0pqvGGRzTHLm8rO77
         uGCbmgPkV8U2XOyrxa6bvBEOPnTHQnwdVfg/B0HuWYZNZq+zb3dcozl0bwFou6+3wF7w
         pFOkhIn/7C8rrOHmP3YTBxCrSKEiuX/EXsNmPemJRi9bvmW96W39KIs+bMa6x6hZUdAf
         RYdw==
X-Gm-Message-State: APjAAAXCQzLJgyypmhraohWQC6X7gLjPMa3UaDQM54UC1supMgazdGE4
        jXyK8bz2FnjWdQ6HXL2hUmP+rw==
X-Google-Smtp-Source: APXvYqxlFI2WcAzy9H2hDmeqvaySLV60xIVp+vEfJOOvBA+AepOhJJvAg79EbiCxLrXZdFhnQYnNxQ==
X-Received: by 2002:a37:6114:: with SMTP id v20mr6535756qkb.329.1570662626464;
        Wed, 09 Oct 2019 16:10:26 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id h29sm2161423qtb.46.2019.10.09.16.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 16:10:26 -0700 (PDT)
Date:   Wed, 9 Oct 2019 16:10:11 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Antonio Borneo <antonio.borneo@st.com>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: stmmac: fix disabling flexible PPS output
Message-ID: <20191009161011.117c7f77@cakuba.netronome.com>
In-Reply-To: <20191007154306.95827-4-antonio.borneo@st.com>
References: <20191007154306.95827-1-antonio.borneo@st.com>
        <20191007154306.95827-4-antonio.borneo@st.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2019 17:43:05 +0200, Antonio Borneo wrote:
> Accordingly to Synopsys documentation [1] and [2], when bit PPSEN0
> in register MAC_PPS_CONTROL is set it selects the functionality
> command in the same register, otherwise selects the functionality
> control.
> Command functionality is required to either enable (command 0x2)
> and disable (command 0x5) the flexible PPS output, but the bit
> PPSEN0 is currently set only for enabling.
> 
> Set the bit PPSEN0 to properly disable flexible PPS output.
> 
> Tested on STM32MP15x, based on dwmac 4.10a.
> 
> [1] DWC Ethernet QoS Databook 4.10a October 2014
> [2] DWC Ethernet QoS Databook 5.00a September 2017
> 
> Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
> Fixes: 9a8a02c9d46d ("net: stmmac: Add Flexible PPS support")

Applied to net, queued for stable.

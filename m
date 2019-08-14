Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0970C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B107720665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="zNc/D6Mi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfHNBPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 21:15:40 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37518 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfHNBPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 21:15:39 -0400
Received: by mail-qk1-f196.google.com with SMTP id s14so10887327qkm.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 18:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=gIDHACBtZG4QwgSbC4cEbESKInKtg+TuqLMDUeDDSt8=;
        b=zNc/D6MilOoRrB00soRn0mjxyGTsDiube/BSjdz6cyK7z4qSM0DbNjxFk2/ngCHwjj
         KPZBgmc6foRZ4ZzN3jqpQksWg3ioHMk6n++KvSFKKaFHJnSefIO5UVuab13lL+xXnd3K
         ikw+Uc4dUvRP+c6iIidWvLxoWelpk7RRECXxMnibtvLAHF/HWcYc/TVwjMLjPfGBQwbI
         WgMJLPF1637QnWcEWOcuCFzzJwH1y0wG54lMbM2TLVCSF319xaBCyNxidRBnNpB8PI6c
         zD7uaULnVp77lKsKYDEtVXx/Pia0KYO5imIuiH5ylXLeVrboaJFD+BYLEaxBBZCqsyqS
         HcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=gIDHACBtZG4QwgSbC4cEbESKInKtg+TuqLMDUeDDSt8=;
        b=PcTq6oxDxDapt/kLBOwGysUAWG1XaixWOhdKfOsxox8pTpcC+/5nhI4Vxs2ybUxsAa
         thFOXbbLaYyzjqO8VKvo/DbfMFTUPLREZIDf3FXSj4UshhFptnR2jR3wLqFLBab7kCPg
         BgSZYpOQxH0jyaeaRGTLViWwozgDfVTLP3t3vPlbSjoSerzerdA0vWME+GP3b6tNO2mY
         i+vEdiXIiFxHuHi146H+cOiBEG8wv3iX0XrOljCsdKc1xhIiMk0EK0AwOFUpniIO0yZC
         L9MQNbV0xrL2/loYgr81mPhrD9LFus2erPQysnxDZ4jDLxv/x5rxSEOGqXnDqJBx3Bzj
         ABlQ==
X-Gm-Message-State: APjAAAWRhgtDMlah4i6308R7yJ1Vqy6xUFz7uxLJXYOT67i944zehGHx
        PILF5KxKCSrQZsyfsfambpjVbQ==
X-Google-Smtp-Source: APXvYqzO9O6JnTuzid/xhpRnB9IpMkG8Ci/HMpVqlNr8ieHKt0Tj4Sib8VtZ6OEgsCnkPh+gCmoKeg==
X-Received: by 2002:a37:a742:: with SMTP id q63mr34544957qke.421.1565745338982;
        Tue, 13 Aug 2019 18:15:38 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id q29sm13587113qtf.74.2019.08.13.18.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 18:15:38 -0700 (PDT)
Date:   Tue, 13 Aug 2019 18:15:29 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Hayes Wang <hayeswang@realtek.com>
Cc:     <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/5] r8152: RX improve
Message-ID: <20190813181529.23d5c2d5@cakuba.netronome.com>
In-Reply-To: <1394712342-15778-295-albertk@realtek.com>
References: <1394712342-15778-289-Taiwan-albertk@realtek.com>
        <1394712342-15778-295-albertk@realtek.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019 11:42:04 +0800, Hayes Wang wrote:
> v2:
> For patch #2, replace list_for_each_safe with list_for_each_entry_safe.
> Remove unlikely in WARN_ON. Adjust the coding style.
> 
> For patch #4, replace list_for_each_safe with list_for_each_entry_safe.
> Remove "else" after "continue".
> 
> For patch #5. replace sysfs with ethtool to modify rx_copybreak and
> rx_pending.
> 
> v1:
> The different chips use different rx buffer size.
> 
> Use skb_add_rx_frag() to reduce memory copy for RX.

Applied, thank you.

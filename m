Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E62C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996F5206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="y0Kr3VZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfDZVUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:20:21 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39533 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfDZVUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:20:21 -0400
Received: by mail-qk1-f193.google.com with SMTP id f125so2763084qke.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 14:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=8cmc/D4NukGKbyOjK5PHEtv1evFQ5yeyybdRdE+Q7uM=;
        b=y0Kr3VZ7WPnShUAWp1r/PolWRNsFWWSzv0MWMjTTdrk34/NgJTQkmoyOafdzSVLtRt
         G5ComZOLMZy9ecavWlZ1CsVfsz0PKxZeHBdMZIbJ2KolaVFadWHC33I9oXjsATmkqqsP
         sihjNjPBij7HAlP9Sx8mr7VUv6Yizs7SEY0mP6Vyd/Rk3Za8HCH18kTsj69PgExRsm6E
         oHQylUjoI+d09Jmt6FB2K6KRllIZZFanRiDr1CL42psmQbQ+cXueM7LLj+TVK2rhPN3P
         fRe+MlT1R0sdSDJKLX2GqDEAsieTA+7aeSaRCBWIUdNYJ6UiTBXl/08298cIgdNVH3hk
         RxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=8cmc/D4NukGKbyOjK5PHEtv1evFQ5yeyybdRdE+Q7uM=;
        b=F+xh9GCh9Bb+lCxjI8jr8m7CifnbpfqIa/N34b7JtN2B6KAHVuNgETzY2J2+XEK7M7
         BmRDMQsqyivlhjV+U/byWg/4sHXCQcTMXfAfb0IQ9C+n2vB14FehF1dMD4YnJq+CrVYJ
         pOvBigeEYj6TupexYz2l/LibBslS9swHDWidjdh1y6Yuc46LxSlubv/2g4za5ZS9DzTt
         sv+yT3qFsxUzKXpST1wN7md2yHEQ/D384wCkLbs7CTWKZ+GxTCSq36LfcrHO6jtadoPU
         biR6Zbt2p7ZS2x5DLsto1lf9x1dMI9uduJ5UI0X58v1ojxKmTeXpLNF2g3XnDPbH3gY5
         yyiQ==
X-Gm-Message-State: APjAAAUOsbEjlM7ZPeRPj5qKrjFTrxoLZrKam3LOcWRdAYSf9UOAXLWj
        CFVHLto7vMv4bVNjo8U4zboMaw==
X-Google-Smtp-Source: APXvYqyRYQtfBc3FROZuwXh0z5KphSJUKNtBBzuOz6R3sQ6SyuXyxXp+ofZlrcQxfC3VCjMSJ/aKjQ==
X-Received: by 2002:a37:6ec3:: with SMTP id j186mr18620768qkc.148.1556313620130;
        Fri, 26 Apr 2019 14:20:20 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id s185sm3631869qkf.74.2019.04.26.14.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 14:20:20 -0700 (PDT)
Date:   Fri, 26 Apr 2019 14:20:15 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH net-next v2 00/20] net: ethernet: ti: clean up and
 optimizations
Message-ID: <20190426142006.7c562ed1@cakuba.netronome.com>
In-Reply-To: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019 20:12:22 +0300, Grygorii Strashko wrote:
> Hi All,
> 
> This is a preparation series for introducing new switchbase TI CPSW driver which
> was originally introduced [1][2] by Ilias Apalodimas <ilias.apalodimas@linaro.org> 
> and also discussed in private mails and at Netdev x13 confernce.
> 
> Following discussions and suggestions (mostly by Andrew and Ivan) we going
> to introduce the new driver which is operating in dual-emac mode
> by default, thus working as 2 individual network interfaces.
> When both interfaces joined the bridge - CPSW driver will enter a switch
> mode and discard dual_mac configuration. The CPSW will be switched back
> to dual_mac mode if any port leaves the bridge. All configuration is going to be
> implemented via switchdev API.
> 
> Hence overall change is already very big I'm sending prerequisite patches which
> are mostly minor fixes/clean ups and code refactoring to separate common parts
> to be reused by both drivers.
> Probably the most serious change from functional point of view is Patch 11.
> 
> These patches were NFS boot tetested on TI AM335x/AM437x/AM5xx boards.

FWIW I don't see anything too objectionable here, we will see if the
merging of the shared module bites us or not :)

One note - please try to keep your submissions under 16 patches in a
single series (that's 15 at most).

Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5059C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 22:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741A020882
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 22:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Ywwl1Svx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfIVW0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 18:26:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37788 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfIVW0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 18:26:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so7877644pfo.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 15:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=1sFK61oUgqTUxUpxUiqsl6lQSNHdbhMzERalasfMwlM=;
        b=Ywwl1SvxcgwtUppOmsgJLh+h2Ktkybgp4Vaz60SiIbKtvB1T1dsQGvBpVTiSPJ4bYa
         1qGFtfriYz4HlLKI4jr6q3I1ZtohSL9s2jglVQQEgFTTbNyCyq9Rqw7ivrBTRcifK4S/
         uHO2W2SdD7S27fGbs79iEGknXjYQ/+S/J/2Tjh/EWonGk0Ndnms8xZcEOzgUV4zaUxt/
         M3J8q589xxu9nDBYUrNfnS5lHECL7smxl0KQ60ErNkiUtUUX4Kt7m2Lb8DgaO1kO/aiB
         9hgX5TQVYLALaXuhUnQsehHBs+9+GqTykdtjFpY3fj4QsceSspM9FFzJ3uVtnWWNJOh3
         Pnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=1sFK61oUgqTUxUpxUiqsl6lQSNHdbhMzERalasfMwlM=;
        b=rX30Afk9rtMBqxF086li9vt+PSeqVzJFqSa5t8hRNyYs0iI7cspuZ4Ig/Xd/RRaDs8
         vRSY4RmL0dPOc0zf/LkgVNft/i8jJO3FEhh3rNJcRH2INUQnLYHSDu3T03piSLuYkvSZ
         5hoknAIQ+xfF+IfZ3kK7pmHyZKbIhOvbsQVMV3gH3xt6tfPxz+CQSuB+9iY8Cr0Rq2wd
         pDmmnFOyJsn1JR3UYbIr9eMiFuzkp7h+631lkLD0WxKQF5SwGtqGYyQHq93tKYt4NVEf
         SjFk5vCedlM0TmvbwEowKQCgSvUnjrgbzMS1l34Nhkqt89ymR0QiPF5kP8CG814wzOQA
         OoPw==
X-Gm-Message-State: APjAAAWa83fQLvvdzlDzrqyH2xrxZtqtt73+uWlxM8zquuj/0+OdMQpj
        Pb0eXzhwvZvEXlrD39McANHIyA==
X-Google-Smtp-Source: APXvYqx3wbLK6wMJ/WfshHZeRj3cjQnRgP7ZB71oVaFz42qy5jeUxtXdRvPoDikZXJxqH1xLOjkVpQ==
X-Received: by 2002:a17:90a:c212:: with SMTP id e18mr17011375pjt.110.1569191212590;
        Sun, 22 Sep 2019 15:26:52 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id c125sm11159763pfa.107.2019.09.22.15.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 15:26:52 -0700 (PDT)
Date:   Sun, 22 Sep 2019 15:26:49 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: b53: Use the correct style for SPDX License
 Identifier
Message-ID: <20190922152649.1fbe1df9@cakuba.netronome.com>
In-Reply-To: <20190921133011.GA2994@nishad>
References: <20190921133011.GA2994@nishad>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Sep 2019 19:00:16 +0530, Nishad Kamdar wrote:
> This patch corrects the SPDX License Identifier style
> in header file for Broadcom BCM53xx managed switch driver.
> For C header files Documentation/process/license-rules.rst
> mandates C-like comments (opposed to C source files where
> C++ style should be used)
> 
> Changes made by using a script provided by Joe Perches here:
> https://lkml.org/lkml/2019/2/7/46.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>

Applied, thank you!

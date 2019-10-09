Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80764C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 02:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F48A20859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 02:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="o6YUX3IX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbfJICxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 22:53:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38461 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfJICxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 22:53:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id x10so435637pgi.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 19:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=xRim+mhOCJGTKowYRKV3NyzpsEfdlIUKsJKh+AqHYlY=;
        b=o6YUX3IXKgDqRkUUB4jAxrLKnMv9u195epNuQDHWd79lRXpQirVzbkaFATUmcZpM6K
         qoOjmkCRW6UzwmI75V4bOke728nN3TleOlK3XILJxb/QVApSfoQMb0a/1/Wi1HTr/BHJ
         4WnO3FeJrmNvL94QuM2HGLvvVbx1/be8SvV1kZvt3SMN7K5atHeLqetDo9P3b8FltOTm
         viiU5dbJaAxgEIbjxz65RyTApcQ06iTAJH7XXk6Eir97XkFJanXGPakVZ2KAF5PRipaj
         mHJs1KZtfy5pzdy52G/kwXpfv2FOQ1swcnZIfhtp6aWErREG76rbIYVOyFVRLn9sdq1n
         Ifdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=xRim+mhOCJGTKowYRKV3NyzpsEfdlIUKsJKh+AqHYlY=;
        b=GPeq3rADcFNuCKLHIXgfpgiXFuEE6LH7Onu2GVUf7AJHO0zsd6orw+5WTB5sQpP9wS
         iw4eozY/c+nRr9sCG+j7mC9eMOANDIYS3870hG+3DOfgFwSLaKTmSvHzRwaOm/ZwyJtm
         D/GtYwQI0BqvFmwJHiMCMAKt0gKanBpfTjYvoTR4FSPwJNZqYeNteeb4A+2FVieQOgwG
         CAg3ey/8Ncjn6VMtgXJ5oHvdx/uhy8s6xbB5fkjl0S1ucHx+7M6JSzWpyM2PB6D3zzT+
         2XkzRNg0h5lF1MuyN6wmK7A5vRtE8MixHKxZMzL5rJWk7j7jAicQG7T9DiOM/MtQI+HH
         J+TQ==
X-Gm-Message-State: APjAAAWltt3sIuoxqKFTytCvcKEZIt9V3yZUSzw6zdfj9a8n/tvogfOB
        EJ9CCdpzygxmBsrxj9koxSxizQ==
X-Google-Smtp-Source: APXvYqwNNIA2eblAs30xCvzP9eU1wrJ7mImszORsLZV+sqLleDGhwp90qDeB6BRWfW/r8geWDh1P9g==
X-Received: by 2002:a17:90a:ba83:: with SMTP id t3mr68082pjr.139.1570589614966;
        Tue, 08 Oct 2019 19:53:34 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id 196sm529853pfz.99.2019.10.08.19.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 19:53:34 -0700 (PDT)
Date:   Tue, 8 Oct 2019 19:53:22 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        William Tu <u9012063@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ip6erspan: remove the incorrect mtu limit for ip6erspan
Message-ID: <20191008195322.5787f7c6@cakuba.netronome.com>
In-Reply-To: <1570528563-8062-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
References: <1570528563-8062-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Oct 2019 17:56:03 +0800, Haishuang Yan wrote:
> ip6erspan driver calls ether_setup(), after commit 61e84623ace3
> ("net: centralize net_device min/max MTU checking"), the range
> of mtu is [min_mtu, max_mtu], which is [68, 1500] by default.
> 
> It causes the dev mtu of the erspan device to not be greater
> than 1500, this limit value is not correct for ip6erspan tap
> device.
> 
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

Applied, but next time please make sure you add a Fixes tag, 
and put [PATCH net] in the subject for bug fixes. Thanks!

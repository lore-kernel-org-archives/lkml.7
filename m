Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB405C4740C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 03:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B4D2184C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 03:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="uOa4XPmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfIVDSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 23:18:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45174 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfIVDSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 23:18:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so6934854pfb.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 20:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=TFGjXXhKmjkAZP/tz+ArFN/SlKTThcfB37x7Td165fE=;
        b=uOa4XPmdMjEBXva+d+0v4ob182ddJrJVWcfSYiJ5oEr8CoojhpLY7lXAnOJWa4EnsL
         i7c/lJ6mWxzeZpsy/xLNKdUE5EQVOCiyo1Ues8Xri59h6IG+JRkjWTvQmKGQu3330slX
         EgZOraN56Jy75t2xbGqzfhpb+P3rlqUN+7HeBKnoUgTAwqRd77KhNgEm8Cwb7Dx11bDt
         n5HZhsporrJrpDiLqE0xb7N4x4AAVC3tGEzt5IE1NQVIiynG7m1ykH+4IVTYKIb1jiCr
         wytUqzTtWv8dqAoyq2nb4VNl9e3Tte4g/96gnMJp8PsCUuATXg71q+Z44waoulitkZO4
         DHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=TFGjXXhKmjkAZP/tz+ArFN/SlKTThcfB37x7Td165fE=;
        b=M+O0YnA2jCQ6tCvOZIu9zwVvpX4w9V6EQ0jHp0829yFuZfZO47XTI5BJkjqOgy0z3j
         hd64sxwQhq1zSRic9xwto76Ch/Xuzf9PmS/s/9c0akF79OsDB584CcOUoNBCCemCpH0D
         oiLJpHavO/7nZ7TcFEjTDbgIZBR24CocDstBrNlCHRhA9nzNfw7IeTL6WnOFR1ikrEPI
         8va4ysflF+Ys7YlKaZus8SpDitK7gDsXUKt7OlLuxgv2z86uzOPHEcBNSO5qWof8vEYp
         MK/YHG3V3uZO7XRXk8AZQolhnNsDT3h7S7mt5SMdz0e4hT4c47ayfv+1VGTQug95FdWC
         +V/A==
X-Gm-Message-State: APjAAAVtxhQ2gFrKRy2ddjeLNvpjPNcWQmTjEmIdZzIU4JGvW1sr3lxU
        RFa+JwzKo4Rva6N/pr+GiIvntQ==
X-Google-Smtp-Source: APXvYqxbBIkVgVFuicYvZV3pC7tph8zkTryWFhQebJpOhb1a4nS5KNsvCOsm8J3i//GSjmtAcRsV3g==
X-Received: by 2002:a65:6716:: with SMTP id u22mr22794378pgf.192.1569122326740;
        Sat, 21 Sep 2019 20:18:46 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id o9sm10479549pfp.67.2019.09.21.20.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 20:18:46 -0700 (PDT)
Date:   Sat, 21 Sep 2019 20:18:43 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     aelior@marvell.com, GR-everest-linux-l2@marvell.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] qede: qede_fp: simplify a bit 'qede_rx_build_skb()'
Message-ID: <20190921201843.12d21abf@cakuba.netronome.com>
In-Reply-To: <20190920045656.3725-1-christophe.jaillet@wanadoo.fr>
References: <20190920045656.3725-1-christophe.jaillet@wanadoo.fr>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2019 06:56:56 +0200, Christophe JAILLET wrote:
> Use 'skb_put_data()' instead of rewritting it.
> This improves readability.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thank you.

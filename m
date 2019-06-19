Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EE7C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC4B2187F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Xo6LWNf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfFSQJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:09:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42132 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfFSQI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:08:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id t28so1562416lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 09:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EV7Nd8ArFTdSsnM2yNQ22mJq4w9w0n+rqtDMUrqyLjM=;
        b=Xo6LWNf2yW8bsdWQcU/oU567sPXnlZCujiLaOIOOP1Y8fQk1Ug7fgb3Ehn+NqQe1C0
         Im0wRTB19X9kj9Tsl8KdUSjD9ysDk78nLuPoHqVZPEtHv3dZ4292JPwc0dMoLPBwyQrI
         1gbhS6/kuz2tM+XUgRhC02EnGaZzP034GfWdwwWPF206n992N1YqKspXdKhSJGJ61ESw
         uLRJdmJPVNOIPuASNhFSpGeAycunZRDnL67AZ47C2DitlbNKLIlLxz81bxDxTfAEggdZ
         acg/NAGAlYe/uYQ2BsoiC+nEQ12cUe61mY1gNmv+HLSUwX7kcHJ4dlMdu7H7W9+Bhrq8
         yN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EV7Nd8ArFTdSsnM2yNQ22mJq4w9w0n+rqtDMUrqyLjM=;
        b=toRTya36+8LJA0ijCJVRLZeXiAmEvsiWgTXhLdSLLqImtWcxMhDW/siNKQ6Nx+hPQN
         Pdknnlnt9dgUYH29gDYP/FE4wLethQjm0igXIB4moi0/sjrj3KBwLSdEVSJedhYNuy1C
         5r43F2z8FQ9Xg0NlGPtvCGLW/2DVdv0IyKkA/6l4mdFF0he/8siR8BpD6+356WUShcQx
         z5YWoWIVVuOKgdhLZyEtNd672NhKC2073xDknhjKOFcWoxuQdrp8wRdvl/FzBFd6f8CB
         KnZgMFKE5x5JOlbOCAU2TIcWma5XFrRPtQLcrctptTAWjp+3aFOl8kzMpOHOgwgQle67
         YEJQ==
X-Gm-Message-State: APjAAAVBJ2ccLPWYHgO1wvWCR7VZQ7UovwiDm/qdf4bMS0WwF7Uf4pC8
        NA15zVhdZIbLzmcEa/m3oeQkxQ==
X-Google-Smtp-Source: APXvYqzFHehp6jLxcD5jNWdD2OG4cJNUp3yrxOQ9It+m0Y+iLtkPEadbsk97iPVl1BSg7AO+I/lQow==
X-Received: by 2002:a2e:8696:: with SMTP id l22mr8123756lji.201.1560960537936;
        Wed, 19 Jun 2019 09:08:57 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id k12sm3050356lfm.90.2019.06.19.09.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 09:08:56 -0700 (PDT)
Date:   Wed, 19 Jun 2019 09:03:12 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        khilman@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] ARM: TI SOC updates for v5.3
Message-ID: <20190619160312.l2yfxrmzs4nygi4s@localhost>
References: <1560919218-3847-1-git-send-email-santosh.shilimkar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560919218-3847-1-git-send-email-santosh.shilimkar@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 09:40:18PM -0700, Santosh Shilimkar wrote:
> The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:
> 
>   Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers_soc_for_5.3
> 
> for you to fetch changes up to 4c960505df44b94001178575a505dd8315086edc:
> 
>   firmware: ti_sci: Fix gcc unused-but-set-variable warning (2019-06-18 21:32:25 -0700)
> 
> ----------------------------------------------------------------
> SOC: TI SCI updates for v5.3
> 
> - Couple of fixes to handle resource ranges and
>   requesting response always from firmware;
> - Add processor control
> - Add support APIs for DMA
> - Fix the SPDX license plate
> - Unused varible warning fix

Merged to arm/drivers. Thanks.


-Olof

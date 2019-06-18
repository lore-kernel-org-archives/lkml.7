Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EB3C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F3220861
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsUwJUj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfFRBL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 21:11:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33798 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRBL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 21:11:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id s49so19009172edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 18:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qkCiUVj0VugFone9Q9W6ljAve1bW+OW0QjoILb3tipw=;
        b=nsUwJUj/lnoFntRkDnKVwnq/d9FeGFWNDPrx740De1flmr61SPj8PnVj9Lai/iUZe+
         akX+bwe46jgvXe5eiSMOmY3eg6w4zRb4auJSbTpbgnJxzJ7BxCrqcwXEt66oI4EcFz9c
         aYOVWfuAEy0tnnSTZrOIJxC0ZUII/ATh1YqPRmvx2Mu1ffBpJDNgt4BKSqk5G4OuL/ep
         K1ERuFDRzRuPx/Z2ENWDMPsWGzSUQwFD7nbjnfSpUSBbeHyTXX99UtMf7U/G0o1gJ9k3
         Pixz5m/1o7PUAvKEZQXtVNem0tnvAMLGiMfHrG3115k9TkDOXV6QrEy1l0W6ciLVW3Ef
         mruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qkCiUVj0VugFone9Q9W6ljAve1bW+OW0QjoILb3tipw=;
        b=BJCh4sJM4TiWFS6H/aQkx6TjVmSfTZ9WtkTGrKffURD28BcleX3VQpj1oKntn7cY2G
         0aUUX0PXc5vafD1Wgdmddzq/OXPJljO51mKiUsj5qWLm65JRyz2ZRLQNYQ9g0Dp2T6Ow
         Ww8enS7Nx9ptXl4QaU1uzwppPO50xi9VqFnFX9wrc3yo6UgXDePDNh95n0eGhUrxuNLm
         MhqioDwK82Mkm6/OrFdrMQARTfv0ek9O/9Mn+hqfdIksFzZx9s3ptF7tHIJOEZhFYt5f
         AXm9CCD/OyMPATfd+p72yRA/DJkImL+7HwNp58bEorITDDc2s4MxSprQjFHTCYUUCbZ0
         Mbqw==
X-Gm-Message-State: APjAAAUdCH/cpNGbd4QVoU4poKbKfC/b+jGDZv0ubtZsb4jV2EgRydf6
        qqJxztAh65c1vQX78UZcGlo=
X-Google-Smtp-Source: APXvYqx9ccbJtoSHa26LPIc3BFE0FBLwxaIr/ZcAkWyuy0BkRFQO8MmPJEMmdpQ66+pUqnLE8HpP4A==
X-Received: by 2002:a50:b0e3:: with SMTP id j90mr2980661edd.26.1560820287270;
        Mon, 17 Jun 2019 18:11:27 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id p37sm4185558edc.14.2019.06.17.18.11.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 18:11:26 -0700 (PDT)
Date:   Mon, 17 Jun 2019 18:11:24 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Anthony Koo <Anthony.Koo@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Jun Lei <Jun.Lei@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: arm32 build failure after abe882a39a9c ("drm/amd/display: fix issue
 with eDP not detected on driver load")
Message-ID: <20190618011124.GA67760@archlinux-epyc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After commit abe882a39a9c ("drm/amd/display: fix issue with eDP not
detected on driver load") in -next, arm32 allyesconfig builds start
failing at link time:

arm-linux-gnueabi-ld: drivers/gpu/drm/amd/display/dc/core/dc_link.o: in
function `dc_link_detect':
dc_link.c:(.text+0x260c): undefined reference to `__bad_udelay'

arm32 only allows a udelay value of up to 2000, see
arch/arm/include/asm/delay.h for more info.

Please look into this when you have a chance!
Nathan

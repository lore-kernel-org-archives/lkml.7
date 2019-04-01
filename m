Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57CEC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C5120857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qu9IpSb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfDAOZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:25:35 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36082 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfDAOZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:25:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id s15so11028065qtn.3;
        Mon, 01 Apr 2019 07:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=riLy+wOMDJjLalIgp8WeAIwp53n0UWY2mctGtmm6h8o=;
        b=Qu9IpSb4+TqjO8121IL6Ov5/O5UaDryI/heXvL0P3nBMXqVVfaVw5BgtSpq9ySE983
         aHiK+AIr+sPScu8Br7W+fGVwvrXDzFoVv1+GwSPv4zxvErxVFf698e6+agY9RFqcAsel
         CqeKblETYffaQ7b/faamS/6dqGeB1O0WpMBRMiuSlRsV54e9o0JNS27v6dyyDwEeQbgG
         UQkPcgAhvD15cARkc2Buyg7q2089FRD7L5t4ChD3njQ/eWXPqcfmPbKGPlPW2vAtZU0/
         eyJZtsj+AMKMw19N76O+YI3TIN5OqJt83C2gsOBzdBsscW4UAfYszKy7sLyA8CoWLhcO
         ktgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=riLy+wOMDJjLalIgp8WeAIwp53n0UWY2mctGtmm6h8o=;
        b=BCHv7yCao7UKh/BoGV2sMLLEnsMLmX0qvwL5gaFlaEwb+KuYNX27jPFDMRQippXFTD
         g7h5l+D3OjMCXrBF3FTRYlCGSza8GLIjsX0fRNVPy3lT0Y31wP4IlxrX0E2oKtzW3OJe
         Ru/5El2YLlEvYp5OmrhLCcZqHm6Y5mAVeuUdGwvWm+gc2Dj9sHBltyXeSJ5CaTFNEeSR
         FrkKOskpP/C/7+bY6LtZEjaVLU5LUO13S7k8GyPPT5uwWG6g0GDi0JMr6su02MVqHToU
         nUSEuqc58I0YSMxPsauJfCRmNzRgaAxV+kXU5HPTLhNGOOZ0Y0fRCpdcdpVfoBvUr/wG
         gnow==
X-Gm-Message-State: APjAAAUA7uILVSbvRaBv5ax0NbnZntFTwXD07RdB7o3aF5ue6NBdOFL4
        XXhFMSoNhAZ7N/7bFjBHh8kv+93ShEY=
X-Google-Smtp-Source: APXvYqzcGA4mRrUM6nNt/c6AsMQpkFcIXiWiYhbXdywSuwchrzS3wxd+CBvOn5yvIAoYsvzrbBP5Ag==
X-Received: by 2002:ac8:2d1c:: with SMTP id n28mr52406988qta.159.1554128733903;
        Mon, 01 Apr 2019 07:25:33 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d205sm5436626qkg.66.2019.04.01.07.25.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Apr 2019 07:25:32 -0700 (PDT)
Date:   Mon, 1 Apr 2019 11:25:29 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Work on iio: stating: frequency: ad9832
Message-ID: <20190401142529.xgkqmndinctiro3l@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I was looking for some work on staging: iio: ad9832 and made some
observations while reading the driver.

Apparently it had no devicetree documentation so I tried to elaborate
one. 
It uses a platform_data variable to load external clock
frequency (I tried to make it use linux's clock framework).
Some device attributes don't seem to be standardized on
Documentation/ABI/testing/sysfs-bus-iio and there's no specific ABI
for ad9832 nearby nor at staging/iio/Documentation. So maybe those
missing ABI could be documented.
The device has to set some internal registers to operate correctly,
AD9832_FREQXHM and AD9832_PHASEXH, would it be feasible to set iio
chanels for this?
I couldn't understand why checkpatch.pl gave errors on IIO_DEV_ATTR_*
macros. To me they seem to have no problem.
Also it has that platform_data to be moved to include/linux/iio. Is
there any special reason for it not being there already? Which are
the criterions a platform_data need to satisfy to be put there?

I'm sending a patchset with some things I've already done.

Is there something else that could be done in this device driver?
Please, tell if I've forgotten something.

Any advice is welcome.
Thanks,

Marcelo

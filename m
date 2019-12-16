Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0863C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76C52146E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SiecKE/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfLPUAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 15:00:51 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:43640 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfLPUAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 15:00:51 -0500
Received: by mail-pj1-f65.google.com with SMTP id g4so3466211pjs.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 12:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=r8qzmMdF0D1xC5nnVedyWP2XlI7Ve+rZ+9sNoVRjFRw=;
        b=SiecKE/UinzqpLyQBs+yEgO3QpPJoOPtp160dyqWGW7bkIkYt2+fQaO7ZWmjsdE5KQ
         5rZL1oiQCatsGNcXX+Rgd7f3Xl7eoyOq+y+UWsuiZfhjz/8fapz4Uq3HS8xGRKnI+zlm
         sCrkRDidlxktRaEchXVFGeR8s0WIyMww7MLEMcq13ETN2EGNppzgilaxR0lpU65XcszA
         GX0J4Rw0z7NkfJ4rsnyZtbKB3IfoYHLWV2o6wD0wf4SH8kP3+GCyCvoACKdRXjO5kR5y
         OI0A6t7dx6ihTp03L0gcOgCAHXmeYuQAWED68jLrSpsu318xbd4wz5zy/JL3baS7x2kj
         n7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=r8qzmMdF0D1xC5nnVedyWP2XlI7Ve+rZ+9sNoVRjFRw=;
        b=QHo/WPPVykBtMgl5HGPXHtqTs5gg349KAscIOMCe4cCTFI48pOK0b09pJMV6Ue1896
         +N1B7ELvs1uE6cmxKpditvzDxskIa/1QKAWjcrOKJJoRjPiI6aLM9q3kvq1HQjj/SRfz
         LHNN3mIlqcavUkbSxAjtAB3m/b6sfUpSH2Zwx6J6NhofREGCPOXdUIHAiLhGHYpGW7VF
         v7C5NDMEq2nCgpHhWMl5UD9rdJdmEAjrEbnI3NGly4toPHHDRVMuuOaBdHUkyzJYz3cw
         luqRzn+zFfvxt2oD1rpcTc47nUWkWSIO9zp41Bm7vdzNndFyJZLPhMTyU9AoGKigmATQ
         ZysA==
X-Gm-Message-State: APjAAAWIvLErsS04nhncWnJv39Uku0UKyzoddZkKuztI4ERdJ3UhFU+j
        7jQh7AeeYxHIHWqlG8KTYCsdFw==
X-Google-Smtp-Source: APXvYqwT14DfCQl2bxHGgAYukZ3rXhtauf9/AST8UjoLC9sNuSdmayerLCZ+paOEtyNXBmIlumodKw==
X-Received: by 2002:a17:902:b48d:: with SMTP id y13mr18664296plr.215.1576526450635;
        Mon, 16 Dec 2019 12:00:50 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id 73sm23416974pgc.13.2019.12.16.12.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Dec 2019 12:00:50 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] arm64: dts: meson: add libretech-pc support
In-Reply-To: <20191209143836.825990-1-jbrunet@baylibre.com>
References: <20191209143836.825990-1-jbrunet@baylibre.com>
Date:   Mon, 16 Dec 2019 12:00:49 -0800
Message-ID: <7h5zig82ha.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset adds support the new libretech PC platform, aka tartiflette.
> There is two variants of this platform, one with the S905D and another
> with the S912.
>
> Changes since v1 [0]:
>  * update adc keys
>  * add phy irq pinctrl configuration
>  * update leds description

Queued for v5.6,

Kevin

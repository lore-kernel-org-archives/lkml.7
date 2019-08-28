Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83795C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4C72189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XTMO2HGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfH1PFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:05:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44445 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfH1PFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:05:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id c81so1892515pfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 08:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=bT8YwM8lVQY3Bq3jN8kP+13N5ePTqKFep5cdRAHRBlc=;
        b=XTMO2HGgu5TOWpIq2y/FGjSLIfekGl3M7vrFDWmmXrc3l7yTlbf9kzmw+6UgrRxdYf
         EUbuRzFeta2W/L+B3PZpY2qEZ/y7tzJ2F9OBVzaEfG4xsqk7cFhMoHP6Gqtqhoxfu0Qy
         gYPyPibTk1uvvsWLxnTDR1dWnS3h8m7lFWrTbJ45gr/cTJs2QW8ToY49DvtGetqBEYyv
         oyRJy0DZaBt5PB7jWV5PBWBzEGr01umcF/KgPXrcn29lDdPIOqrqGKLcrdvzpZjJ/6Nn
         mM9gdu1u/oEj8ogKNPKG2C1347dDMjGgsOFsW+F9OG5wvKz9ixqPyBLNi0DCc87HstDR
         Ep1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bT8YwM8lVQY3Bq3jN8kP+13N5ePTqKFep5cdRAHRBlc=;
        b=R7mBnjUJ/Eh8ssGHq3CH8dDsi80EKiKLsOak/ztGDFplnTnaoQzoAMwqA9S3DsRcpM
         510+qVGo31J4I2qal2We2mJyF4vs9A2hpXu5+IiSWrzf0NbkztH3a7xndqmKX+0lvmyO
         8cBc/XUXZ289xv01TbYKv3RA+b9MtTBLJxmlVKMXLjphIqjRpWk3g6UgigS1Kazzluz+
         p+KTKoifHOQKvv7DkmQbrGmT76E96igDHGuYXb+2iBD1y5JnN0kv4nfocrN0hNJPkVoR
         h6CvFN2JoXLnbfuh8On9gMNMxWmTBSK87Zx1VmtUxFdo4uQL6hRazhF/3vrEjArWwsBS
         roEA==
X-Gm-Message-State: APjAAAUUhxlIcbH5okJW3+u6X/dVBWd1leTaKQ3iKpiivY27XGLN8Y4S
        34RdAW1Zpz6qZ9dn8BxOORlQdMc/LcE=
X-Google-Smtp-Source: APXvYqzkvG1I1NPAFfC7H9Dk+LVN7x+xUAvV2mJTqg57N1F2qNKzHUY0aH5d1aHxD8OQH2RdhhU8aQ==
X-Received: by 2002:aa7:8705:: with SMTP id b5mr5275834pfo.205.1567004709374;
        Wed, 28 Aug 2019 08:05:09 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:cc35:e750:308e:47f])
        by smtp.gmail.com with ESMTPSA id b126sm6598437pfa.177.2019.08.28.08.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Aug 2019 08:05:08 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: meson: g12a: add tdm resets
In-Reply-To: <1j4l217m4h.fsf@starbuckisacylon.baylibre.com>
References: <20190820121551.18398-1-jbrunet@baylibre.com> <7hh862tbt2.fsf@baylibre.com> <1j4l217m4h.fsf@starbuckisacylon.baylibre.com>
Date:   Wed, 28 Aug 2019 08:05:07 -0700
Message-ID: <7h36hltjoc.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Tue 27 Aug 2019 at 16:42, Kevin Hilman <khilman@baylibre.com> wrote:
>
>> Jerome Brunet <jbrunet@baylibre.com> writes:
>>
>>> This patchset adds the dedicated reset of the tdm formatters which
>>> have been added on the g12a SoC family. Using these help with the channel
>>> mapping when the formatter uses more than 1 i2s lane.
>>
>> Because I forgot^W waited on this, we did the meson-g12a-common split,
>> so this no longer applies cleanly.  Could you rebase this on current v5.4/dt64
>> and I'll queue it for v5.4/dt64.
>
> Acutally it was already not applying when I sent this v1 ...
> .. which is why I sent a v2 [0] ;)
>
> [0]: https://lkml.kernel.org/r/20190823154432.16268-1-jbrunet@baylibre.com

Oops, I saw there was a v2, but I missed that in my `git pw` because v2
of the series had an "ASoC:" prefix in the cover letter, not an "arm64:
dts" one, so I skimmed past it.

Kevin

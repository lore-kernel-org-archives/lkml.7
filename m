Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B49C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE9C20678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aXIdqgLX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgAGKRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:17:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42043 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgAGKRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:17:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id q6so53160024wro.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 02:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wADUiklQGqkVRHS/MFhQD6ufQzvydVIjp5oA5mx3O5c=;
        b=aXIdqgLXGcmv5XCWk5/AXFvt6fEui+64l98g2DfWsHjiicwC53+ccrVBEOWxGu6r0Z
         OeX/eWnGUKmDmWq7Gm8cMLjPFpnCFP9nsTKP6jENm0v0ulgpfhpaLkQTsM42fLOdPXyi
         qeIUzoNItiGkVJOOoxvkNLtbZG7kSBpRqWXtQcwKWgprkCWjkmey0lApcH1eahUlZuEq
         vAtZMKN8dRXjrlg6LeuOpKVvZodzVc/EhPQ31bmlhdOF470N7/qIQr287KSbaJyx8DdH
         k/2w1gbE3JFdqVDxXHkkkuUgrYBSo+9xRGMKdA1Q1tGNlLlJJLBySBzZ8tYjR/O3eebQ
         H+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wADUiklQGqkVRHS/MFhQD6ufQzvydVIjp5oA5mx3O5c=;
        b=IM2mQT6WDp4OMyO6mzJQPv66NcuzO7St7ESKKrYS8KzHphfhIPwymYDI/RLgmQAh25
         /GUR7TxdCJlFwE7BmlFGata1WzJSJovlFUzEVeMfA+PmLPVlfbs4MCERlglhFvXCQmbR
         mTX33Tkozv6EY4xLMWo9/4APK5oR3N3XtQgwkBZ5pRppn2sjrRPBseNkPqJFmzKTMSAI
         hpnVkbEHOuSRE7NyO3CuBa8D//XgijIMLx0uShJ3Rpzka6CaFStzIwnM858dLWvOjkvc
         rK8fHSV50wDxOUl8ldHy64lmgU5JlvWsBsLuJTLsOua0DK2v0Qh34JebL3PZks+5HbP7
         thCA==
X-Gm-Message-State: APjAAAURd3CHARsLoFkaV+O6VapzAfxPGZChwkBzK5w8Sdfssq3vcto2
        fJJ7JKH58ROfrrsh8wDG+gCWJQ==
X-Google-Smtp-Source: APXvYqz4Rj4ufV3lelc5BTGQJhC+R/z8hRz+z92FuK07DVJDQcMJSplOxlPh60gzjWH8pqwxktrksA==
X-Received: by 2002:a05:6000:367:: with SMTP id f7mr105722054wrf.174.1578392266202;
        Tue, 07 Jan 2020 02:17:46 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id u22sm80773920wru.30.2020.01.07.02.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 02:17:45 -0800 (PST)
Date:   Tue, 7 Jan 2020 10:17:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     boris.brezillon@bootlin.com, airlied@linux.ie,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        sam@ravnborg.org, peda@axentia.se, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD and DRM due for the v5.6
 merge window
Message-ID: <20200107101748.GC14821@dell>
References: <1576672109-22707-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1576672109-22707-1-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MFD parts for testing:

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-drm-v5.6

for you to fetch changes up to 10f9167664362bac6f44813687cf52fec9d15845:

  mfd: atmel-hlcdc: Return in case of error (2020-01-07 10:08:58 +0000)

----------------------------------------------------------------
Immutable branch between MFD and DRM due for the v5.6 merge window

----------------------------------------------------------------
Claudiu Beznea (2):
      mfd: atmel-hlcdc: Add struct device member to struct atmel_hlcdc_regmap
      mfd: atmel-hlcdc: Return in case of error

 drivers/mfd/atmel-hlcdc.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

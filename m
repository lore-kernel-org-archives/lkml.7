Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12BAC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B5E21743
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="g90t1pfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbfFSNjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 09:39:04 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46105 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfFSNjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 09:39:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id z15so12124728lfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 06:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QKggU93Ov3OGvJTHnvBvpp3+c/GovGceSumOJbG5Kag=;
        b=g90t1pfGMsBwZkO7WMEchWQcZ+/SFokkE8pEWUuLCb4C3gYFVxXCamqCaOHb0oU86f
         hKn1mrowaUHFrQhDAjQgFXxbg41JHSzq1WOEiWnerS2ucghntb6bKh1mc/92iTFACbbV
         ir2tYsqSxKSCptkKdrbEiwPCf9vRVMh1WzcZoJzreE9lvPIWSArEMNbxvXH55EY0eHMJ
         VCWVsBapJ5f1S4WGzeGFZvGIZYVs77NHAMs9895hD1WvrARdnQgxMzX8XwB7QkNTXyNw
         TOcsiylUCckRO1mfm2IvdhpoopFTotV8sg8FNECsAi3P4PrzuPz1rGptQlH9L7wHUg96
         QsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QKggU93Ov3OGvJTHnvBvpp3+c/GovGceSumOJbG5Kag=;
        b=Npd8OW3vfi/izuk53FICqVfYUApRG2N3AkNQG+Y2+YPiBXCvTcqOeib7WSAxewm72M
         jr4ZXrUZKKIPXcJ0/16G3V69Qfc5/ziFIhLsJRNqCCnlFXo3/6wQQioe9/+8xSQW5euM
         y9q0VnrZsMUYha9FU55TGZ8ZKbADySZgveI7IUuV94uRWfkUUFP7aIQsq14L4Cx0yxxn
         64JljINmgtr/cq+tpKHIB4cJr8guPHsEQAYC5VlacCHBgziCI42r7/sVvVeozF7K6W3h
         u9b+iQoUjHpkK9PQaiHKe9sQz7y0Cygxld3wDuKWkWpMNuwSS2kIb0QshvmrZ0zHj42u
         A+vA==
X-Gm-Message-State: APjAAAXUTZ8D01m/6G0TaFoISOur3RAaBBP7Iq69T7mpM/vVhsXXg+Ao
        yoPgV8608cR0s9zA3xcm2L4VYA==
X-Google-Smtp-Source: APXvYqzy1/85AoVZe5aXzHxGKPGMI3YKh1i1xTNcGjAlPkxkPNjoWmNiF/UkKqbk9mR2Jw4m3oq8iA==
X-Received: by 2002:a19:9156:: with SMTP id y22mr16577964lfj.43.1560951542029;
        Wed, 19 Jun 2019 06:39:02 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id c15sm3082664lja.79.2019.06.19.06.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 06:39:00 -0700 (PDT)
Date:   Wed, 19 Jun 2019 06:16:59 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, vincent.guittot@linaro.org,
        arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 9/9] arm64: dts: sprd: Add Spreadtrum SD host
 controller support
Message-ID: <20190619131659.vjw5kgepe6pz5inz@localhost>
References: <cover.1559635435.git.baolin.wang@linaro.org>
 <3ca273e341f2f5f66b121d411428c60afd412586.1559635435.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ca273e341f2f5f66b121d411428c60afd412586.1559635435.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 04:14:29PM +0800, Baolin Wang wrote:
> Add one Spreadtrum SD host controller to support eMMC card for Spreadtrum
> SC9860 platform.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Applied, thanks!


-Olof

Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB417C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB08206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XqahE8ek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfDBHAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:00:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40997 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfDBHAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:00:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id 188so5870505pfd.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 00:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lG7q6x9bOATHtEAjfI+YGWaPNzgsxOn7kFCqmU7RA24=;
        b=XqahE8ekqUVFS4tzTGLzmL74ptchRVDTW9nkVV58ffVsP9BKCdg2INqdSOiiC9SjQD
         A1ugBwXu2E6MCucD4mUzKUFkzggMLo/BYZviJ+KD2XdmcDj5nFz933zBh9iicsR6O6rq
         Hz+9Vs3b/KmqdrWV1KWmYVwkCw9QsK/h/6D5Lv+M7DS0OgHWNupLDH9hNhvZMd1eNkK8
         xoVPrcceQ25WBMu0My92CJCK3O5h3z9zJhCIfs0CgluUkNlzi6vpYOFNYnNzhxb1ji9c
         3RvIDBZ3rWmNLAxnYcail7f+tn0CYOhEXpEqp0A52FZ/9z8rPUwf1um9LGF9CYnHyUR0
         w9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lG7q6x9bOATHtEAjfI+YGWaPNzgsxOn7kFCqmU7RA24=;
        b=AVqiwUZzpjXRFBbuvLDfjXsL5qMCA0KkLLXvq0mJkO+5qcmyOiTGr6FW896aMkhVGk
         5aviiYghnVei/xlk1CAfmjrTjv0dIRjwB6E7GVYSOrznIXcvPmd5/3kk7/H5N7npNDG1
         LhWM817/lS/PaIuHavDtGatueyBuxxzVfo6EsSmnR1nB9W+OQ7LvQX7nMrBI3WxACvMx
         WRLGlDB9o6ytBW5IRDz07KQGH74SL6Ie64KgKG2ZPyNkMOdgb9jbk+JQjuPxoesalDVE
         4062up+/47VTC/TB5oHH208+YDl4cRyOB7d8VZbPsR8f8f6scnI1WKhRG5x02Mm+QaL2
         t8Tw==
X-Gm-Message-State: APjAAAVUkfh1QyBiNHnrXOYb6dDErOR/6a25FgD47x8b0KE5a31W/zJr
        CitkgCpeQEkjf972zmhS1TJ0mw==
X-Google-Smtp-Source: APXvYqzTFEZ6Qlqz/GH8bk2tKD5L8rc0DmuRjI2qt8hubuCpxemLu19AP3S4u4E8ZhDqCUEBxfo5BQ==
X-Received: by 2002:aa7:8c84:: with SMTP id p4mr28442799pfd.164.1554188415241;
        Tue, 02 Apr 2019 00:00:15 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id v188sm17945692pgb.7.2019.04.02.00.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 00:00:14 -0700 (PDT)
Date:   Tue, 2 Apr 2019 08:00:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 3/9] dt-bindings: mfd: Add compatible for the MediaTek
 MT6358 PMIC
Message-ID: <20190402070007.GC4187@dell>
References: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1552275991-34648-4-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1552275991-34648-4-git-send-email-hsin-hsiung.wang@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019, Hsin-Hsiung Wang wrote:

> This adds compatible for the MediaTek MT6358 PMIC.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

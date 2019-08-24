Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF44C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 21:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FF420870
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 21:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="X6RCK4A2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfHXVMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 17:12:10 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:35995 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbfHXVMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 17:12:10 -0400
Received: by mail-wr1-f43.google.com with SMTP id r3so11737631wrt.3;
        Sat, 24 Aug 2019 14:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Iy/5bEEOYfDEI8uS9YsPalXrQmIXfqc76b7xMFBL04=;
        b=X6RCK4A2Jwrc3n8bHchGJ44qqh+EbuCLRwYrHn9K607tGJQL5U7Vf9g49d/NbvgNE1
         PUMZpRvE2ugbpCjsLLcF37QUk0DaaHCe3y2JgygAtStEQzTi0g6h7lQ4NABnquoePrsS
         wfDzjaOyAHtlHXhnXVZfH4fmqe2obymh6mPBigc+tDyyNW8VmMNaXtGWWfXYTFQG1ZRc
         GmIESa7DiLL3oyW9m6jl4LGh49hzCs+xB6z+FWvvzxavWKl/BoRJzjHulM36FKNWP0Q/
         ozIvZQsXRe4S2xgc6eYcrdSTCMi9gNRQdiHwQyzfCrXucnrGumf/T2roI6Ha6UIO+8pY
         505Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Iy/5bEEOYfDEI8uS9YsPalXrQmIXfqc76b7xMFBL04=;
        b=ABCymOQQBH/oyCly+qxpTAm/AFIlZS7vVe+qXeFzyFrW4YcdSQajYYm3HbkENQszvB
         im0aILU6whmU1FgWWs2kHwakWnINBhzoE8ZmAUvd+59NSLvzjyy5tZD3A5aiE0eETau4
         CFxpyK8izZLJyPVJXFnONCULOf8RN84Lq55R67R+NTpvqIP7gughLdeuL1+3RBEvDJWD
         sO6+AnDirWMCI7DmQUZ0tDEY4GfTvKtVfpi0bJnnXNcuV694nxg2UUE2vHUZDFt2/rOt
         UiuVf5N0mIEECEEprDP71uzaYVZpO7cP1kYQ5a6/TSAorbRTo4sG4VAbZlUbFXosSLPd
         n5Jg==
X-Gm-Message-State: APjAAAWUbfPVcJVqpt0IYuiaxPm7OSqBCWgJJcXohCSAkW39qdchvXq7
        oe5Bo4dM6IzUDyET49xoP38VgSBw
X-Google-Smtp-Source: APXvYqwXS3VX8r3hP1MDKfaRoFze51b3fXBK6iDIg61x8d/gRpLGZIH0numvlMifbzP2KUAXD5gzgg==
X-Received: by 2002:adf:f0ce:: with SMTP id x14mr6729779wro.31.1566681127579;
        Sat, 24 Aug 2019 14:12:07 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C1F6001D020CA8E905822D.dip0.t-ipconnect.de. [2003:f1:33c1:f600:1d02:ca8:e905:822d])
        by smtp.googlemail.com with ESMTPSA id g14sm12742386wrb.38.2019.08.24.14.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 14:12:06 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     eswara.kota@linux.intel.com
Cc:     cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, qi-ming.wu@intel.com, robh@kernel.org,
        hauke@hauke-m.de
Subject: RE: [PATCH v2 2/2] reset: Reset controller driver for Intel LGM SoC
Date:   Sat, 24 Aug 2019 23:11:58 +0200
Message-Id: <20190824211158.5900-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <90cc600d6f7ded68f5a618b626bd9cffa5edf5c3.1566531960.git.eswara.kota@linux.intel.com>
References: <90cc600d6f7ded68f5a618b626bd9cffa5edf5c3.1566531960.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dilip,

> Add driver for the reset controller present on Intel
> Lightening Mountain (LGM) SoC for performing reset
> management of the devices present on the SoC. Driver also
> registers a reset handler to peform the entire device reset.

[...]
> +static const struct of_device_id intel_reset_match[] = {
> +	{ .compatible = "intel,rcu-lgm" },
> +	{}
> +};
how is this IP block differnet from the one used in many Lantiq SoCs?
there is already an upstream driver for the RCU IP block on the Lantiq
SoCs: drivers/reset/reset-lantiq.c

some background:
Lantiq was started as a spinoff from Infineon in 2009. Intel then
acquired Lantiq in 2015. source: [0]
Intel is re-using some of the IP blocks from the MIPS Lantiq SoCs
(Intel even has some own MIPS SoCs as part of the Lantiq acquisition,
typically used for PON/GPON/ADSL/VDSL capable network devices).
Thus I think it is likely that the new "Lightening Mountain" SoCs use
an updated version of the Lantiq RCU IP.


Martin


[0] https://wikidevi.com/wiki/Lantiq

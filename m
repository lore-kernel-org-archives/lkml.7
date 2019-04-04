Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257ADC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E532D2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iRnosMd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfDDIQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:16:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34839 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfDDIQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:16:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so790014plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BwngZYyg16TfoGy4lDnsbMtIe+1yN851BWYmgtmkmYU=;
        b=iRnosMd/JxWbCuBfhRbvm7ynQ1923EcBAJh86rMJDan7tRs56C0fi2qOhCrW3kEUuM
         Q5kPl4zw8kCkyKug/hzTlHhZotSL+JT9U4yTbOSma0pgzZfM9xfsR3SMTa4HCb7IHF8Z
         hIsNic2ne2THjKQKgVTULzCqas7wDTc9+D6NHI7pnL0ngUWVuB/EDHlyZdDgTh9QaBlQ
         8+bEDZE6C05A4cEDx39U9RYWB9kKL2Ud6+JEYQ2GEmRsSP8Ce4+1WJ5Rha03o0qS96G/
         CPHgZJ81QgHTDUXLdNMjKlLDE/mIyA/xLXTXYCagukxTEFz2ylGJaYLyNw7DvHB2lnXy
         1O1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BwngZYyg16TfoGy4lDnsbMtIe+1yN851BWYmgtmkmYU=;
        b=fPdPKyqGaFKR7WYCZ0rl2ERk4ovubKcrNcsU7/VOxSpOquxgldPgzyiQ/tvUmGp1cM
         e8fYUwZD88RNZTD6XivakiHTh7yHb5EyE7sCniJio26g36G+rsJ7KV+PdLwcE8dlb3X1
         GcHCm4xoYcUeN91EqODI6GCY4BefZvkdDEfgYAN0hx3myCC5vElJtl3l+JzHmEtqMiST
         LhF59MoOr/NpjdXtdJ0s48RahpKUHNGPNdQYEDi0NCSGMzX/TfGHwXZwVIgX6ZIXQf1K
         dNxKuO9P/Hn2KpOgn9IQtPLsLp+9JgTO8YhzkePn/LO6Zy+s1wJRLoNV6dsgwokZ6dZX
         W7Ag==
X-Gm-Message-State: APjAAAWTMIBboXrhfof7cNB7ShjKttMnHV/GZW1B+oZfm1KW3q8lWsxk
        OQf4KVfPykut/0Vfdj4+OfUU0Pg5aYc=
X-Google-Smtp-Source: APXvYqzuANo2miNhQDvDydQ/6ez+Pq/xF2NOisGBDU3THJOTzj8mHkbcTOWfvlQDniDLD/UttZW/mA==
X-Received: by 2002:a17:902:3204:: with SMTP id y4mr5044345plb.80.1554365796847;
        Thu, 04 Apr 2019 01:16:36 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id d129sm26041389pfa.142.2019.04.04.01.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 01:16:35 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [RESEND][PATCH 0/3] DMA dts changes for hi3660
Date:   Thu,  4 Apr 2019 01:16:25 -0700
Message-Id: <1554365788-25610-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a few dts changes which didn't get picked up
for the last merge window to enable support for code
changes that did land in v5.1.

Let me know if you have any objecitons or feedback!

thanks
-john

Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org


John Stultz (2):
  arm64: dts: hi3660: Add dma to uart nodes
  arm64: dts: hi3660: Fixup unofficial dma-min-chan to dma-channel-mask

Youlin Wang (1):
  arm64: dts: hi3660: Add hisi asp dma device

 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

-- 
2.7.4


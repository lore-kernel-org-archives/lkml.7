Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4895C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7009E20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dPDSn7rR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfCZKlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:41:45 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39030 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfCZKln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:41:43 -0400
Received: by mail-oi1-f196.google.com with SMTP id n187so6686639oih.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 03:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7JulrIjGjw4aS5f5PUAk6l5Nt96av6iTfePl/MKlsU=;
        b=dPDSn7rR5bATKC5tkGqixUZxOUNPP06SCKGWE77wuNg/SGaLIVXZ6+zQXBhZnRff8t
         iGCSBLGRfDA1b3xDDa3ZxgjslTYHo3kVV05J4K4Im0ryowr3J/tY98J4YISON4V7//sW
         fTXLCNlXYHjvSgazzQ4RNpw1i4s71AqBEzkx0oueQI0+KJVp132wp2s9w3CK0Azb5ja6
         2Q8flIZYXFHjRIj2OcX8HMEI9bcOQCUoGX44qWiLbsgVH3SeyMTAWUZVId/yAKmnQob9
         WPUUgt69D276+bf4slYaPt7xyE1kOGA0IotzawvVj37bmhsPHtXGnvBUvK7H7JlwsBpA
         ycvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7JulrIjGjw4aS5f5PUAk6l5Nt96av6iTfePl/MKlsU=;
        b=Tbt6ABTJnNGV1mT+AEhaef0slAaMz/2tbRPUr1pswKa+7zS2kbPWeh5TzYS56sLdc+
         r364Q1cAlqL1ffkSazHwIEGaIbuTrBsmuIw9sHeBzzjjklAKeQ0NK9l/r+jfII7WB0ey
         rsu5IpteTamhoA8i5PMHk3EVyFADv1Q+2DV0rfDCc8nilpbEhOpxsj5aNBY4g8N2RLRc
         Pfv8f+kfL4C4tbJruPRTM6QFLZ3+S9OZV9qi3txu9z+lbn4fC798hatw0KPe6yguvSkd
         v+CHbgd75yWIe2xGgIOgz0KHJQ8/6xvqcr4Su9ly0QFeXsc+hBk/h4puTUK3NKj5OJrp
         z/Ww==
X-Gm-Message-State: APjAAAX25tR0EuX916twvjCzE9piClguc+a4vE86PYuuxkbfv559tEy6
        9PrijALL6xWb74ZVK00qD84tnEgvfMLilsBrGFRCYw==
X-Google-Smtp-Source: APXvYqwXZThf7CW4RQdE5DJW5Wv8wfDFbcooayt+EIwLjLRMoMWRU45639YIPrlVD5mDT0qhBRMyD38Vk7x8QQpxsqs=
X-Received: by 2002:aca:4a4a:: with SMTP id x71mr14972201oia.27.1553596903010;
 Tue, 26 Mar 2019 03:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1551689518.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1551689518.git.baolin.wang@linaro.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 26 Mar 2019 18:41:31 +0800
Message-ID: <CAMz4kuJitF7Q76T0Hoj1-UTAjQnepEs9aQHhy=r_Acdq+RiwGw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add new features for the Spreadtrum serial controller
To:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, lanqing.liu@unisoc.com,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, 4 Mar 2019 at 16:59, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> This patch set fixes the baud rate calculation formula issue, as well as
> adding power management support and DMA mode support for the Spreadtrum
> serial controller.
>
> Changes from v1:
>  - The patch 1 of V1 was applied, so remove the baud rate fix from this patch set.
>  - Add reviewed tag from Rob for patch 1.
>  - Fix the incorrect names' order in patch 3.

Could you apply this patch set if no objection from you? Thanks.

-- 
Baolin Wang
Best Regards

Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8741AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A11206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Eyc8Ar0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfLCKPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:15:44 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:37893 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfLCKPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:15:42 -0500
Received: by mail-lj1-f172.google.com with SMTP id k8so3121362ljh.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 02:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/8qJaL6cIhl0fjI1TGqv4uTX3sHJK7Sgw22wJkvMRuk=;
        b=Eyc8Ar0sSoYw+XIzyVmFTht1fy07eB21TPRu1y40rfzjyiLtvaYE6Tc3wWSu27DiVP
         mVAAFUaaPRZY4A+7+VEBK5LNrx42udMVjtT0JSEYuDhnX93tH3J0Gs6ujuWZSJBf45TA
         oozKyQv+qo7jUNuFsiHs0DqC6HPtG6AYjqO+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/8qJaL6cIhl0fjI1TGqv4uTX3sHJK7Sgw22wJkvMRuk=;
        b=lrJXkx5wYe20KfkNZpL3MLvYWwuLDnF1sT+Ky+F1MnWje2O4oUJINeUDw94GNfa5E2
         aezFAfFkxI1auCC2LWAD7FWOAmLI43pqAgXUEYm5Oco7dP92OnaW7fVeoF4jpub96R4o
         LBCpf8y4kBCRTON6V/KK9URgId+D/YjQtdCj+r7TGjtKqHPagkKdQfap5kGhUfLDDRNB
         S8sme1pVphJ1ahKC1mj7DSfkrxFT0ChiVZT/yG0xKAWMN55u8Xyga0xr6MY6480AHiqQ
         gB8oyasCNbJTXU01Z70QoU/qlzfhzQ7FPrh/YOYoTuRTEfUfP8bVLoBDGDDFDTHLisel
         W/ow==
X-Gm-Message-State: APjAAAXwoJYcHMScWboYJ3Uo2U+In9Cjl+xPmF+VWND8PkrlSCzgFXK0
        nJjUxREtMIsaqIL60cRFyExTeR2YtnoVMEf6
X-Google-Smtp-Source: APXvYqwrZz2qrGL3Xq92LPDcxFv8kW7a0UhkaUzjq1T95TVb7ijB+zJcU+B6NYuNCQOGDnjo1oGY6Q==
X-Received: by 2002:a2e:81c1:: with SMTP id s1mr2023877ljg.83.1575368139542;
        Tue, 03 Dec 2019 02:15:39 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l3sm1172943lfh.72.2019.12.03.02.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 02:15:38 -0800 (PST)
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: fsl,p2020-esdhc sdhci quirks
Message-ID: <8afd0f53-eba8-e000-d8cc-b464e65850c3@rasmusvillemoes.dk>
Date:   Tue, 3 Dec 2019 11:15:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Commits

05cb6b2a66fa - mmc: sdhci-of-esdhc: add erratum eSDHC-A001 and A-008358
support
a46e42712596 - mmc: sdhci-of-esdhc: add erratum eSDHC5 support

seem a bit odd, in that they set bits from the SDHCI_* namespace in the
->quirks2 member:

                host->quirks2 |= SDHCI_QUIRK_RESET_AFTER_REQUEST;
                host->quirks2 |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;

These are bits 10 and 12, so they are also known as
SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD and
SDHCI_QUIRK2_TUNING_WORK_AROUND. So if the fixes are correct, one should
use those names on the right-hand side, but it seems just as likely (I
can't figure that out from the commit messages) that the left-hand sides
should have been host->quirks ?

Rasmus

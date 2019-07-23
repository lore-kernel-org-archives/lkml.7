Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A73C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7957B21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dynamicaims-com.20150623.gappssmtp.com header.i=@dynamicaims-com.20150623.gappssmtp.com header.b="elzyr1bI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbfGWNwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:52:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35918 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfGWNwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:52:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so19475400pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 06:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dynamicaims-com.20150623.gappssmtp.com; s=20150623;
        h=to:subject:from:message-id:disposition-notification-to:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=9N8Qc+rRBbnfa+Ir61SRMq5lDQDDnvbN1u/t4PPmBYw=;
        b=elzyr1bIHEPrDvEWT2HkjNVXlDHSuea3NkIIKK8bj3o+bnzr5N4dvt18+BPlWVsFTx
         WmRGv3CDw7keFPvI5qtVGpC9JZ7iNAb0eH9lkdriodMertnbIjQkImmBcTKckoPoXTeO
         q0h4PoOSqBsrH+eIDkZ+5TkC1PrjJMK1c218hukHWsPmdoGfpAgHUuR30Bw2cVj0U5Y+
         NCbBHLbTgf/PhmUyaEs0HYJcgiezcj+QLkgd+4FS43F7arpgaYod+n8R/NjcuWjUI8Q0
         G+/pg3sL/rZ3Qdm7DLfxLFfhA8r0xDHR+cE3/A7dZLLtTQhgbBbUf4DkLQ9UGwfLeq2L
         OsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:subject:from:message-id
         :disposition-notification-to:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=9N8Qc+rRBbnfa+Ir61SRMq5lDQDDnvbN1u/t4PPmBYw=;
        b=MoefXTK4kaL065MqrS8311baEdWyLqcX/mZjl3Tf/llJcu1PCW8wNk1E2tFPicqIGr
         VHusfptlBzSXqXHamnciBc5aHx1v0AJYQQ7iubtTSX1pb4nusQsYCb9Q3mWx42ATZFmr
         0mkO3bu2WckNg9h3eVG4X3lyZLIADqIUVtkyF3qr5lqOlUQ9aO0xj1MV4u0NIcMq5dsa
         MC7oZ65EkPH0CNno5UlLZGY49cJqMdp2Wkpl3QGClTgVPPn9fPVXLzQJ9p0ptrs8CEln
         hsWBeY+Ga9Fo0Qx4sacREMnozj+OVX7y1uEG4kRqlfD1A83fLKeEznl+EGJmo1CGxHsI
         RCiA==
X-Gm-Message-State: APjAAAVARwZOG0rCHhcRsDM/zU5AqV7lEovIAUde1HXKsS7fruOB508/
        OwtjVuKGBQOP4gEYu/v+L2UWcMlI
X-Google-Smtp-Source: APXvYqzfdCh9eF8jDRCCTT3rnn3O1p36O9O5DcQII/shAgEUDq0raKLoJWdkG/vnDHQLKUtgSmZxOg==
X-Received: by 2002:a62:1515:: with SMTP id 21mr6093852pfv.100.1563889972168;
        Tue, 23 Jul 2019 06:52:52 -0700 (PDT)
Received: from [192.168.0.13] ([122.182.204.68])
        by smtp.gmail.com with ESMTPSA id b37sm71023544pjc.15.2019.07.23.06.52.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 06:52:51 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
Subject: Wine Enthusiasts
From:   Denna Ross <dennar@dynamicaims.com>
Message-ID: <1d92f8f5-af64-4a6c-a423-7d71941cd96d@dynamicaims.com>
Date:   Tue, 23 Jul 2019 08:44:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.3; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Antivirus: Avast (VPS 190723-0, 07/23/2019), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Would you be interested in acquiring an email list of "Wine Enthusiasts" from USA?

We also have data for Golfers, Alcohol Enthusiasts, Beer Enthusiasts, Chocolate Enthusiasts, Foodies, Travelers, Gift Buyers, Spa and Resort Visitors, Sports Enthusiasts, Android Users and many more..

Each record in the list contains Contact Name (First, Middle and Last Name), Mailing Address, List type and Opt-in email address.

All the contacts are opt-in verified, 100% permission based and can be used for unlimited multi-channel marketing.

Please let me know your thoughts towards procuring the Wine Enthusiasts List.

Best Regards,
Denna Ross
Research Analyst

We respect your privacy, if you do not wish to receive any further emails from our end, please reply with a subject "Remove".


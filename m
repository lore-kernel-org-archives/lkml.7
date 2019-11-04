Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3FACA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414852080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfOrRaDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbfKDSLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:11:25 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43218 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfKDSLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:11:25 -0500
Received: by mail-lf1-f65.google.com with SMTP id j5so12958889lfh.10;
        Mon, 04 Nov 2019 10:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=3l2wN8BPUAQjXnXowpvzrjpLgVWtjoWMN6bu9eZHgKM=;
        b=HfOrRaDKtUJA4s5ZyGtbTzfjZbsW+U4UAcZPOdmExxo0dNC3CdrGbAzpabIR8MV2du
         DD+todkndR0BUDCfB2fIzjCKg66sRKpNDKj2BnIzrTfAmCGbwAAaOu08e1cIWq/lOZ08
         PZGIWECyxuDfMA9+6vIMXe3nK+K7v4vGoXuByfId5GATYdyBe6eQMeI77aBtYJ2oxjq2
         jM78YB+KJsjZurAJNOC6YYcbTVTmLjomV8kRZI5bPEU+DRmAtmEzZE0nqFf83YrWUrbT
         CU8hXxTpMtAzEXW1hQiQYEuiCCHXNvPAWx/vwcywkhFtFpA1Ot6ojDd4vCT7c3+QgECX
         ZZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=3l2wN8BPUAQjXnXowpvzrjpLgVWtjoWMN6bu9eZHgKM=;
        b=XsoNZMLp96xgpjj+8fIRgNSvNe2BOvWLTGikb9QolefQOY/ZOJKG8Yqt28FPmRSlEK
         OFl8T6StC8CHfMAbah/DXiFksAQyRMjtOpT45LP2+DrE6LBkIBio80Rznm20ygozYa1n
         q1kr3jQqyrDzM3qNiKnicuZX1T3A06KWwk7/UDzA9c4ciUwBtHpi5Bb3vhohB7nWay7U
         ZsbvqSUdRzgzoLU7tOdH2P7PBfI0vl5F1+5fz0RuKSDTI3IWBDEvRgF+Vsvf0adGUkOn
         i8DmjoN6Fh0BCGXodNse0SoYDLkkzu/G1r+SmQMKdE7mgSoYXnyiluJBv31BY9CKAdMG
         5yhg==
X-Gm-Message-State: APjAAAVDjjVk+jgA90wGcac/3fW7/Ji6Ylv6J4TZWovuY1dL78e0Njck
        HRztbW1h+1qAMw61w/O4o6lwXl96YZ0=
X-Google-Smtp-Source: APXvYqwdqKyj8e9WJmZ1xah+3M6/voKiBmiQ8GwIV8nRRSyQnRXKnPfYE+gotxDg2d66WoCCHKPCLQ==
X-Received: by 2002:ac2:5f01:: with SMTP id 1mr17616223lfq.147.1572891083080;
        Mon, 04 Nov 2019 10:11:23 -0800 (PST)
Received: from [10.0.0.92] ([91.237.107.85])
        by smtp.gmail.com with ESMTPSA id a26sm8897526lfg.50.2019.11.04.10.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 10:11:22 -0800 (PST)
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        yurii.pavlovskyi@gmail.com, kristian@klausen.dk,
        andy@infradead.org, dvhart@infradead.org, corentin.chary@gmail.com
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
Subject: [RFC PATCH 0/3] asus_wmi: Support of ASUS TUF laptops on Ryzen CPUs
Message-ID: <d3dbac09-3c93-c695-ae52-4b599a0a78c6@gmail.com>
Date:   Mon, 4 Nov 2019 20:11:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch series adds support of ASUS TUF laptops on Ryzen CPUs to existing
asus_wmi platform driver and also fixes minor bug.

(Resend with proper patch indentation)

Leonid Maksimchuk (3):
   asus_wmi: Fix return value of fan_boost_mode_store
   asus_wmi: Add support for fan boost mode on FX505DY/FX705DY
   asus_wmi: Set default fan boost mode to normal

  drivers/platform/x86/asus-wmi.c            | 57 ++++++++++++++++++++++--------
  include/linux/platform_data/x86/asus-wmi.h |  1 +
  2 files changed, 43 insertions(+), 15 deletions(-)

-- 
1.8.3.1


Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C911C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179202184E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="DDyktx5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390880AbfGRQr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:47:26 -0400
Received: from smtp11.infineon.com ([217.10.52.105]:33566 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390695AbfGRQrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1563468444; x=1595004444;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=kki4KtqYA2sQqxiuXzigMEOgvjZhU1UpaQyoQtbjXL4=;
  b=DDyktx5Kdygcxo9UHVytcODMqyYxnQ2PWYZAJLlMapJUgMvSuZxCD8U1
   5ujK2WqQ1pCStMCf1VDsjRDO00Khlivt/13/NkOz8/ff7f1CQ5ucQcSMC
   a5QvwuTV4BQpnGBvknysEW5YOaJUxqunLY569xzD8LME3wWBUJVc+c8BJ
   0=;
IronPort-SDR: abjc1PHDzPZyUEzDhjM8xGq4BzeFr4DF0x0lEN48DzLGZfrOZDY1ciCf3Jrd/DE2qUgK98BV7Y
 14pC5Q1ciNrM4W/VKmWbeXaxYLkCgiXGSfwZk7+WCf2K7pYPYguAMlgIG/DMBQUYlufiItmh2g
 banU6U30JBGlgU4fsKsQxpfmQAidGPQjRKUAKTf0B+MDW7yOY7bjg7B9lKqIAW0ycV75b/V7cT
 KlPuIMFkt2/zwrpV/aiQ9qabcekbNM4iL3YoioLnVB+TufGNy64axBzBrk7WCMEfIR9ScXFC1j
 zEc=
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6000,8403,9322"; a="128252217"
X-IronPort-AV: E=Sophos;i="5.64,278,1559512800"; 
   d="scan'208";a="128252217"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2019 18:47:23 +0200
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Thu, 18 Jul 2019 18:47:23 +0200 (CEST)
Received: from [10.154.32.63] (172.23.8.247) by MUCSE708.infineon.com
 (172.23.7.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1591.10; Thu, 18
 Jul 2019 18:47:22 +0200
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
To:     Stephen Boyd <swboyd@chromium.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
CC:     Andrey Pronin <apronin@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-integrity@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20190716224518.62556-1-swboyd@chromium.org>
 <20190716224518.62556-6-swboyd@chromium.org>
 <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com>
 <5d2f7daf.1c69fb81.c0b13.c3d4@mx.google.com>
 <5d2f955d.1c69fb81.35877.7018@mx.google.com>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <b05904bf-00b9-bf30-0fc9-9f363e181d80@infineon.com>
Date:   Thu, 18 Jul 2019 18:47:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5d2f955d.1c69fb81.35877.7018@mx.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE712.infineon.com (172.23.7.70) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.07.2019 23:38, Stephen Boyd wrote:
> Quoting Stephen Boyd (2019-07-17 12:57:34)
>> Quoting Alexander Steffen (2019-07-17 05:00:06)
>>>
>>> Can't the code be shared more explicitly, e.g. by cr50_spi wrapping
>>> tpm_tis_spi, so that it can intercept the calls, execute the additional
>>> actions (like waking up the device), but then let tpm_tis_spi do the
>>> common work?
>>>
>>
>> I suppose the read{16,32} and write32 functions could be reused. I'm not
>> sure how great it will be if we combine these two drivers, but I can
>> give it a try today and see how it looks.
>>
> 
> Here's the patch. I haven't tested it besides compile testing.

Thanks for providing this. Makes it much easier to see what the actual 
differences between the devices are.

Do we have a general policy on how to support devices that are very 
similar but need special handling in some places? Not duplicating the 
whole driver just to change a few things definitely seems like an 
improvement (and has already been done in the past, as with 
TPM_TIS_ITPM_WORKAROUND). But should all the code just be added to 
tpm_tis_spi.c? Or is there some way to keep a clearer separation, 
especially when (in the future) we have multiple devices that all have 
their own set of deviations from the spec?

Alexander

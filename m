Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FECC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5D320883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="elVmDm2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfE1LWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 07:22:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34387 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfE1LWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 07:22:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id w7so8220982plz.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 04:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yh3DAsuBc4gaJRrR/0YoTC38OI767n+zAes4csgVWko=;
        b=elVmDm2gsK/dIGoNpFbZIl22gU7w01mHXsboFCvVWGWWAqbunekdZawS9aQsnHtYvY
         yeQDeDCZs2lKT5IMCh+4RuK5NE/eyeg91lZJTiukTaGHDDlzgtSq85TNuI7PEDpblfaM
         6rHkI7gu//zI5NedRhf5VpsXnLSwFDw32G33w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yh3DAsuBc4gaJRrR/0YoTC38OI767n+zAes4csgVWko=;
        b=q1kjGUls8imqMiHZ0tR50jfJoHTbru28vIWbgtT2xT8x5faa3gfZ9Ud4c7OKAmtyi5
         FUkqd3h7bL883CqDN1U7w3bmnvo+1KmGIswsdqekCeoP8B/C58VBdofWC5YHVVOWZ4wg
         70K+NIwmrY0LjlliOwd99M69wYWHKRdmzpgEJfIgfQ4Mezh58NwBV21vsaM6J3kE/hKD
         WJMXu9VwNUI97QWJipjZYxmZR+4WOo2Vb0yYVDlqWiG95bwv1H2wH9iGyspY5EyQR5bp
         7QvsjtdXUpUXrrs/kgOqhTMhEusU8nfjNFnAF0YC3tS11c8cWVXq4pn4ihNB3T8JDXgk
         bljg==
X-Gm-Message-State: APjAAAXlXEFhmfs955BD23rr/EPxDAAFUiLj4NVzIUQITgZ9dfpf4rll
        Cjk3Nn6cnE0VsazUKpkgorwTDQ==
X-Google-Smtp-Source: APXvYqwwzVy5Av2JOK5uYN5DGO0T44ahiMxb2TOXN05vS25P0a/7S3kdg9t9OcwT5IQOnJ3KQizstg==
X-Received: by 2002:a17:902:868c:: with SMTP id g12mr27817259plo.323.1559042525002;
        Tue, 28 May 2019 04:22:05 -0700 (PDT)
Received: from [10.176.68.125] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id v9sm13241440pfm.34.2019.05.28.04.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 04:22:04 -0700 (PDT)
Subject: Re: [PATCH 2/3] mmc: core: API for temporarily disabling
 auto-retuning due to errors
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-rockchip@lists.infradead.org,
        Double Lo <double.lo@cypress.com>, briannorris@chromium.org,
        Madhan Mohan R <madhanmohan.r@cypress.com>, mka@chromium.org,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Jiong Wu <lohengrin1024@gmail.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Avri Altman <avri.altman@wdc.com>, Martin Hicks <mort@bork.org>
References: <20190517225420.176893-1-dianders@chromium.org>
 <20190517225420.176893-3-dianders@chromium.org>
 <05af228c-139b-2b7f-f626-36fb34634be5@broadcom.com>
 <4f39e152-04ba-a64e-985a-df93e6d15ff8@intel.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <aa8e526f-b382-f3b7-74a5-e0fee09ae096@broadcom.com>
Date:   Tue, 28 May 2019 13:21:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4f39e152-04ba-a64e-985a-df93e6d15ff8@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2019 12:04 PM, Adrian Hunter wrote:
> On 26/05/19 9:42 PM, Arend Van Spriel wrote:
>> On 5/18/2019 12:54 AM, Douglas Anderson wrote:
>>> Normally when the MMC core sees an "-EILSEQ" error returned by a host
>>> controller then it will trigger a retuning of the card.  This is
>>> generally a good idea.
>>
>> Probably a question for Adrian, but how is this retuning scheduled. I recall
>> seeing something in mmc_request_done. How about deferring the retuning upon
>> a release host or is that too sdio specific.
> 
> Below is what I have been carrying the last 4 years.  But according to Douglas'
> patch, the release would need to be further down.  See 2nd diff below.
> Would that work?

That makes sense. The loop is needed because the device can be a bit 
bone headed. So indeed after the loop the device should be awake and 
able to handle CMD19.

Regards,
Arend

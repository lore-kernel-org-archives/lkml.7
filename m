Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2269C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 11:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D3E21D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 11:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="df2ht/hY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389996AbfISLjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 07:39:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51176 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388068AbfISLjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 07:39:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id 5so4115781wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 04:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DKzAQahCYPhZ2ssPBGIJt75n2wk0bxvGCrcodj0E+8o=;
        b=df2ht/hYt42oGahvKnuFkzhFM20BjG6q6b2qOTyHeZ5qndKJKUFk/S8p9AtiHgm21z
         lLbbmV9F/x0vLg/s2ehHstlIlV8sPpwE1vP2BHwIpiPdcgqKajPq3ENzi/oCValibmbG
         Sgz6zWgIP5QJmAUogGBCFWNuYvNKKEp5OhQA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DKzAQahCYPhZ2ssPBGIJt75n2wk0bxvGCrcodj0E+8o=;
        b=syD41KPZItQ4BaeezHRMCYTlEtvhfuY7f8A6na/QJFaoXOSUbw43XMComUGHvL0cyB
         JdQAx9tgkAh1pdXZou6bChcHiZxyLw2/s9h6pFSi46EVYSDl6bg3YoA5cfc8azfOlsti
         qQBDhG/143Mg7qZBhehWX/ObMcmZQGDg4DtAs0e6TRkstUHCnPUuPrziwB1Z1p3x+mKe
         7NnsUX1Cp7FCzbctj166czvwa0E1eIsfgBLUmV7wnuxqBLf9wrA/RH4313S3BK653UuU
         D5INw6ScHEiteeYYG/ms/tIpuxJKcvtN+Y/bkWsugWbNX76RPnu8pZhp0sQSrV8/M/lJ
         dH+Q==
X-Gm-Message-State: APjAAAWTrI0dOvs8wP23MMaT+3y5nTROs+thlyxUNGynQgZKFhPVn0KN
        iIUdhA6Z6/4Mjf5xLGAxR63XBQ==
X-Google-Smtp-Source: APXvYqynRI01eO1fYwKFW25INxMrTheYRYlf7PGDeX+77jnNAOkkPYIuZOeB0pAEfbh+4FmCSDeScw==
X-Received: by 2002:a05:600c:2208:: with SMTP id z8mr2687432wml.113.1568893173499;
        Thu, 19 Sep 2019 04:39:33 -0700 (PDT)
Received: from [10.230.33.15] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id z142sm11043922wmc.24.2019.09.19.04.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 04:39:32 -0700 (PDT)
Subject: Re: [PATCH 00/20] Add support for Silicon Labs WiFi chip WF200 and
 further
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        David Le Goff <David.Legoff@silabs.com>
References: <20190919105153.15285-1-Jerome.Pouiller@silabs.com>
 <20190919112508.GA3037175@kroah.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <7639195f-59f0-a0dc-02f2-45b3a08e7002@broadcom.com>
Date:   Thu, 19 Sep 2019 13:39:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190919112508.GA3037175@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/2019 1:25 PM, Greg Kroah-Hartman wrote:
>>    - I also kept compatibility code for earlier Linux kernel version. I
>>      may drop it in future. Maybe I will maintain compatibility with
>>      older kernels in a external set of patches.
> That has to be dropped for the in-kernel version.

There is no need to maintain such compatibility. You basically get it 
for free with the linux-backports project [1].

Regards,
Arend

[1] https://backports.wiki.kernel.org/index.php/Main_Page

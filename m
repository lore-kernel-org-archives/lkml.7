Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A438C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0717121872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aAuRd+Rs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfCOWqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 18:46:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40470 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfCOWqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 18:46:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id r23so8895408edm.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 15:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eajXAAAi7XNKaWrha17Hvvp0Tfkt+YEk+XHIyNYuSn8=;
        b=aAuRd+RsU8QmVHfkVFv4fkQdP6WACYWBIQ+mbt9zBA42D6fznzXL0qmRhLko3x2bS2
         zQHEU4fo4/+iQ01pro8K39BKALjScNJTGXDKn6i5MpWJxx+6pih+zhOTiOq6Keg4N+Js
         yGEQNIAwoaa0JJP8YjT45OJLHtW9vIEsEJ8gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eajXAAAi7XNKaWrha17Hvvp0Tfkt+YEk+XHIyNYuSn8=;
        b=JMLkaehI+/kxkSSy2JSF2sbEtSYfeKrsybpP8SI7syBGNBDasvTfuad08p4eBuSZo8
         rjw7reJLksYzXXw9HPy+HnDaYi2Lz+rDma4B/medA+wYsTzajMjQU+iWpI6knNTN3ely
         //72/gP+Oz3kC3ptN1KtGKBjkeQAI5W68funCd42ObktoxHiDbZ0jgLEFCiyRtZcwczk
         NC7OO3HYxLhYcoFQgBepcXaETLIY5SxcveEthWoqo/xNzVwfUND19Q5M6y2sqARp452M
         3PVneUXrGF0gsy5xZAQuE9zlinSerB2XUu+WU6TiuokRPmZkrvtaJL0wz3Hyalk7Tz0U
         A0eQ==
X-Gm-Message-State: APjAAAVsMPfrE3WY8mEvT7pTPltrSVrmRUYDj/C6g3R/TiunjRpx7Z8I
        o9oXc2CpmIttSwsMgxNKpREkJnLjp2TCWgNZJ1wZtNZjwqvv7udM1d4hWyrGi1gVBYrU7tiDxGt
        gkba8hDS4s++HDBYdK47qiXNKiOJCFQB4nB0FbuhI6lEEQXbAcmf3oKd1DV2SkRPCEgfwkydwZW
        DN4UHLZh6kX/Q=
X-Google-Smtp-Source: APXvYqyZEe4DTSSTBaG6JBTZkCjRVeCh17wd/rr6cnR6XJh2VRJBHC1JwHI+dv0bSUXC0AM+NbrC/Q==
X-Received: by 2002:a17:906:8401:: with SMTP id n1mr3442167ejx.143.1552689994185;
        Fri, 15 Mar 2019 15:46:34 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id q3sm962338eds.41.2019.03.15.15.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 15:46:33 -0700 (PDT)
Subject: Re: [PATCH v3] brcmfmac: fix missing checks for kmemdup
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Chung-Hsien Hsu <stanley.hsu@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <d712dd26-8b51-143a-b3ff-ad44f2774944@broadcom.com>
 <20190315170433.3845-1-kjlu@umn.edu>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <0b85b931-d9a7-46c8-2fc2-1c554793d35d@broadcom.com>
Date:   Fri, 15 Mar 2019 23:46:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190315170433.3845-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/2019 6:04 PM, Kangjie Lu wrote:
> In case kmemdup fails, the fix sets conn_info->req_ie_len and
> conn_info->resp_ie_len to zero to avoid buffer overflows.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 4 ++++
>   1 file changed, 4 insertions(+)

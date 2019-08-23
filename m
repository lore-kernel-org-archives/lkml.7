Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C084C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206CB206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fweN2nB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389495AbfHWIST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:18:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41247 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388631AbfHWISS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:18:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id j16so7790924wrr.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 01:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=prXm3P3EuozGuFJkO3h5BCLJubkE/g8QKoERuCU4E8M=;
        b=fweN2nB3N+MJP0ngSWEQ7i9ICK8STO+eyQwG7DASE6jmfiR7L1GVpnqrlGWHT9dAKv
         1MUob/wt6UwJlXxof8YC5qD4F3djycZ469WUJ+0rAFtioo5yfEwJYNZXPoPIUhPV9vyI
         AFX6KhzOeBh9MDNDlCaW8z9Z9l/KwtXeiWjjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=prXm3P3EuozGuFJkO3h5BCLJubkE/g8QKoERuCU4E8M=;
        b=TrOMFV+8iZ0WtYtCrBwk8mqiIr4T6IlRCbPE9RYyRuGT5WLG2YPPuxfG+l/Y2Lo3o9
         qQJ33nVCL0RNoMibFHLCcG3MAnA1GzzkQftdBVD4QI1WSgrj2+WVdaih8d67ROaAjsqg
         dxH4Ty1JchD1NHsyeUXOkecI8XtIKbsqnLYBOSOwNIY8Z6kpKB8MbmsBWxuHtTfwRA/Z
         s8HHf0qy9wHbaEY4iE/PheqXDkjqLGvn6gIGh5Unb6THYVDaxu0AaHoIw3Q8Sfblw1T+
         Ze6GLXXQkIEDZ6PBAZOC3dAeAvFh+IfmWKka6rT6w7RLJEf+AXhncVpIbyYEAquuCOxT
         JBcw==
X-Gm-Message-State: APjAAAVvX05V2fI9fRt08F6kPUZ8RQzyXfsIAIsmqXnXyYW4ol3hf2vF
        47sjPIML0/4ngVJoRyvxXXPvPg==
X-Google-Smtp-Source: APXvYqw+XUl+DLn+INP9GfpdrffdxYEgE59Xt8vee45Eb39L4aEq5x+cjyJsy5MtieVi+SDMo3zuBA==
X-Received: by 2002:adf:e504:: with SMTP id j4mr3465872wrm.222.1566548295940;
        Fri, 23 Aug 2019 01:18:15 -0700 (PDT)
Received: from [10.176.68.244] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id e14sm1771959wma.37.2019.08.23.01.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 01:18:15 -0700 (PDT)
Subject: Re: [PATCH] brcmfmac: replace strncpy() by strscpy()
To:     Xulin Sun <xulin.sun@windriver.com>, kvalo@codeaurora.org
Cc:     stefan.wahren@i2se.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, brcm80211-dev-list@cypress.com,
        brcm80211-dev-list.pdl@broadcom.com,
        linux-wireless@vger.kernel.org, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@cypress.com,
        wright.feng@cypress.com, davem@davemloft.net,
        stanley.hsu@cypress.com
References: <20190823074708.20081-1-xulin.sun@windriver.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <894851e7-f057-4789-f9af-f098a968d713@broadcom.com>
Date:   Fri, 23 Aug 2019 10:18:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823074708.20081-1-xulin.sun@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/2019 9:47 AM, Xulin Sun wrote:
> The strncpy() may truncate the copied string,
> replace it by the safer strscpy().
> 
> To avoid below compile warning with gcc 8.2:
> 
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:In function 'brcmf_vndr_ie':
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:4227:2:
> warning: 'strncpy' output truncated before terminating nul copying 3 bytes from a string of the same length [-Wstringop-truncation]
>    strncpy(iebuf, add_del_cmd, VNDR_IE_CMD_LEN - 1);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Xulin Sun <xulin.sun@windriver.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

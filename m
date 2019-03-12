Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD742C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85072214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="EJCptjVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfCLHmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:42:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42770 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfCLHmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:42:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id l16so1360333ljc.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 00:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x1AK6hGQYnn1yU9WidTpaVTYV5OktyA94EjAW9zkrNs=;
        b=EJCptjVc0CXr0pvMveEyTVmTcTdSekYyOdJDz4mxg06KBvwyjYnpPY6SBIDO+MEw6A
         m8uPfb0/JyasWw8HFo5QRVIcMci7JvkSVil+b6BonGi6Kmq35MR40eq33ajdjrSfQu/4
         tDO1AICd3TY7/i4X6Q7BSK3fx7LF1Km6/BDO4u8EppJES8hUT+jSc2oc9eM66olKj/FB
         SUAALWItpw3qs4Bq41uG7jtcj7zIsnyRErHbmp7iEq0dedA5kiCUBWM1lCWRNXx9Vumf
         3s7ve0lFpV1RGEiki07i/iS76XWlCxdH8AXHEyg6jVfwripe+fUvaza7QhWc5yLvfHtg
         HgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x1AK6hGQYnn1yU9WidTpaVTYV5OktyA94EjAW9zkrNs=;
        b=s73EY6qPzR305FjsVnLROjuse6hZHcCK72kJEGb/FJtrgwf/778nTmJKg09Ij9iRNv
         ic8FzkIGqHqYTzZXsDk2KsH9+wa8SiTliqOCnjXB1xDfgMVQpwcVAJY/qtOTxnJpaTqN
         np6rSPuXfu4/Um012CxN3Xnwc3Pj6SR1eCBSgG6T/SuwAuyIS7LsoSVmNnVzmDPfZF0Y
         V7Gws3EzJOaUek+KN6afJ9ZCg/szC3aRa0hTkFBr2f+fUESPakRP5r2iQ6mqX/+aH9Ex
         ro3efKi6J0Ff78UzVmlwu0LkPEKCawuhTUT/RA+INLb2AgELPZ+lo9xJ1oXFXu4Z1o3n
         bOLA==
X-Gm-Message-State: APjAAAV09kRU1N+RPjidQW7GxdBbEeyefhSEnCqnTCbhZ82VZNKs/mQb
        9bP5ZZ9DoP/Gm3Pvu+TQupIrX8CHFwk=
X-Google-Smtp-Source: APXvYqz+T2cByxyuRCxMT1ND4g2cvW9ws1m0Mqj1X8B3yyYz1noIBggrIQ6+mXv5z10Ci8rYvUJXbw==
X-Received: by 2002:a2e:9204:: with SMTP id k4mr14448661ljg.0.1552376537959;
        Tue, 12 Mar 2019 00:42:17 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.87.174])
        by smtp.gmail.com with ESMTPSA id v16sm1237651ljh.80.2019.03.12.00.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 00:42:17 -0700 (PDT)
Subject: Re: [PATCH] net: ravb_main: fix a missing check of of_get_phy_mode
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, "David S. Miller" <davem@davemloft.net>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Andrew Lunn <andrew@lunn.ch>,
        Magnus Damm <damm+renesas@opensource.se>,
        Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190312063827.16046-1-kjlu@umn.edu>
 <076a4b31-3e83-9e3d-81a7-55bb7f25a37f@cogentembedded.com>
Message-ID: <1574a042-b614-27e1-e149-4097781824e7@cogentembedded.com>
Date:   Tue, 12 Mar 2019 10:42:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <076a4b31-3e83-9e3d-81a7-55bb7f25a37f@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.2019 10:38, Sergei Shtylyov wrote:

>> of_get_phy_mode may fail and return a negative error code;
>> the fix checks the return value of of_get_phy_mode and
>> goes to out_release if it fails.
>>
>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>> ---
>>   drivers/net/ethernet/renesas/ravb_main.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c 
>> b/drivers/net/ethernet/renesas/ravb_main.c
>> index d28c8f9ca55b..791b6842eb12 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -1996,6 +1996,7 @@ static int ravb_probe(struct platform_device *pdev)
>>       int error, irq, q;
>>       struct resource *res;
>>       int i;
>> +    int ret;
> 
>     There's the 'error' variable already for such things, use it.

    Please ignore that. But the variable could be named 'interface' or 
somesuch. :-)

[...]

MBR, Sergei

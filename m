Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75D8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755312064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nelint-com.20150623.gappssmtp.com header.i=@nelint-com.20150623.gappssmtp.com header.b="SPNQcjCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfCKUtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:49:03 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:39074 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfCKUs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:48:59 -0400
Received: by mail-pf1-f180.google.com with SMTP id i20so117679pfo.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 13:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nelint-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WC0fKHncCGHlop3Orl1Gn6WudNgRDIGVNP7Gj49CLnM=;
        b=SPNQcjCPCfoldkt1TQLvSihBmENQkI1sQ9wHihpY6tTISYj3Are4vBYIMSMqPpM65o
         fvL1+PyXV4pseijfwiYvFWh7JL0R+y8ETmAvUskl1JvUzhEjNZsdj9JMdpJezlZzKtus
         aw+kjPcqxrUcUBp1t00KnsCEnyX2iz1VBiz9LMNPwV284OcuJK73PDEITGdY4onA0PTf
         66J3kFFilA8qPP9MDx3BQwkysNC1FJzHTOgQt4zUAyISplArMmuhESJlivdHR/4Cf/Aq
         pKkjbDc8ZYr1rnQqG/fOEoEkJyVGzGhAW1pMl6wguEmsDv5eU611NC25Dg+k8kpdnW+a
         LKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WC0fKHncCGHlop3Orl1Gn6WudNgRDIGVNP7Gj49CLnM=;
        b=LvzlNj+m+D9/LNe0ELz5qGgMsRFEsUA0lZF/Gwdh+98mSWtBqXqyJrPUPP+yd6AKNB
         2wODu0xuXI5TJ8E/vNZQO/nL+JBmGDXUTg86715zA1PuicdtPxwyCys35N/RNAAv5lh/
         F6ariggPBbedmY/Xmw/aeX3O626LA4maLi8X0uohrMONQ0RyrRYbIAXiK9TPmRRrqWkz
         Iwfw5rxFf5iY6f7Nok2d+ClhMIGfGiKBvssGDu9HTdpX6jaQ1DjL6GeMoAAoJW0itRaG
         Wi4YW70vbUIEG8S4rTZVP5DbYjWrwVF49bN3IptxqdFMKVXuzdg+vGs8QFrt1XvkTd2P
         7AxQ==
X-Gm-Message-State: APjAAAVzVFygwM2pKbkogYwAenMUK/c76JHN+qiRAGfBB7CSDOZzaqA0
        5Sa3XjYtnAK8Coqw8Vso6Nh3zg==
X-Google-Smtp-Source: APXvYqxAhI3a6wkqxm7FIr7u2RYpFl/LfIajy5rdxx+8naAV1ZN+tcCvA15/NIUylreVsJQe78+z3g==
X-Received: by 2002:a17:902:a612:: with SMTP id u18mr35416980plq.145.1552337338231;
        Mon, 11 Mar 2019 13:48:58 -0700 (PDT)
Received: from ?IPv6:2600:8800:1301:2190:cc32:ad00:b1c0:818c? ([2600:8800:1301:2190:cc32:ad00:b1c0:818c])
        by smtp.gmail.com with ESMTPSA id e8sm8728199pfn.103.2019.03.11.13.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 13:48:57 -0700 (PDT)
Subject: Re: [V2 1/2] clk: imx6q: remove unsupported pll4_audio_div
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     anson.huang@nxp.com, colin.didier@devialet.com, festevam@gmail.com,
        kernel@pengutronix.de, l.stach@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, sboyd@kernel.org, shawnguo@kernel.org,
        tiny.windzz@gmail.com
References: <1552304271.2453.12.camel@pengutronix.de>
 <1552319997-24622-1-git-send-email-eric@nelint.com>
 <1552319997-24622-2-git-send-email-eric@nelint.com>
From:   Eric Nelson <eric@nelint.com>
Message-ID: <0cf890a4-20b0-13ce-14d3-06f7c3227655@nelint.com>
Date:   Mon, 11 Mar 2019 13:48:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552319997-24622-2-git-send-email-eric@nelint.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > On March 11, 2019, 6:35 p.m. UTC, Stephen Boyd wrote:
 >
> Quoting Eric Nelson (2019-03-11 08:59:56)
>> diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
>> index b3cef29..34bb14d 100644
>> --- a/include/dt-bindings/clock/imx6qdl-clock.h
>> +++ b/include/dt-bindings/clock/imx6qdl-clock.h
>> @@ -213,7 +213,15 @@
>>  #define IMX6QDL_CLK_CKO2                       200
>>  #define IMX6QDL_CLK_CKO                                201
>>  #define IMX6QDL_CLK_VDOA                       202
>> -#define IMX6QDL_CLK_PLL4_AUDIO_DIV             203
>> +
>> +/* The PLL4_AUDIO_DIV divider only appeared in
>> + * early versions of the reference manual.
>> + *
>> + * Renamed to _BROKEN to prevent inadvertent use,
>> + * but reserved the array slot to maintain DT binary
>> + * compatibility.
>> + */
>> +#define IMX6QDL_CLK_PLL4_AUDIO_DIV_BROKEN      203
> 
> But it breaks the build. I don't get it. Just add a comment indicating
> it shouldn't be used? That breaks the cross-tree dependency chain and
> lets clk tree merge the clk driver part and arm-soc merge the dts part.
The device tree update also requires the update to clk-imx6q.c
for proper run-time operation, so I don't see how these two parts
can be separated.

I thought about leaving the PLL4_AUDIO_DIV clock in place but
turning it into a dummy (placeholder), but that might lead others
down the long path I traversed before I found out that my manual
was old and the clock didn't function.

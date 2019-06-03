Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CAEC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC38D28166
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfFCLpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 07:45:34 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:48453 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726561AbfFCLpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 07:45:33 -0400
Received: from [192.168.2.10] ([46.9.252.75])
        by smtp-cloud9.xs4all.net with ESMTPA
        id XlP5hL7kAsDWyXlP8hsryq; Mon, 03 Jun 2019 13:45:31 +0200
Subject: Re: [PATCH] media: stm32-dcmi: fix irq = 0 case
To:     Fabien Dessenne <fabien.dessenne@st.com>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Pavel Machek <pavel@denx.de>, linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
References: <1559294295-20573-1-git-send-email-fabien.dessenne@st.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <46944972-1f88-ef3b-fef9-8e37753c0ffe@xs4all.nl>
Date:   Mon, 3 Jun 2019 13:45:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559294295-20573-1-git-send-email-fabien.dessenne@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCN0MWjkjUyGzp6RpvMIZ2ZANeW2kYEP03Lpq3iqxfDwME2NkMqcJ+4u8wJA/QHfTb1eUz+uisc7OqX0O7kndwdR0ZVW6uYMPcB/P15b1VaJn538Lf+x
 NpoGEuGPiPtkBx9DsS6X0tLYlnRiI7z09uP0CoCsy8Xjtn42bpslVuei6PSli3eMoap5saASbpiDX6XpET+OFtD9B3RPXBwVdY8s8ZorQPRjKWBS+iFs5tU5
 JcyHlEgjEwFC3lQWFrLx7IKttSJSdQhzLTcFNI4C/GGkE2trkxzNun+9+Ruulo+8qY9ak+/SmKIQ+kgTg7xKgQBhwcWRnLRBWT55TpNhtogX6wNgZDrHA6R+
 DP8O8sDZLy5bkdDBxfik+WTTyrM7PXg/048e9w11h0IqIIlGhif1381FUXcLSGcLziyMd6bFNfwfgVfEUgK16hHn9FgCB4acy5ykhFHypGJ47adWQgK/dE6G
 9TJhkrGyPEBntvMjPZ9BgUNRVSNLdIIqLJzmuyPjIYgbtaRxjKOprgUXnCZ2Mg+Lh4zk3jdL6wiFvQH6IqSYwOZc/HHUQ3Mu+pq0ncGcj1p4oBZbHedZLcz6
 1ZXK7+Aa9y7T7q16w8DCGy61
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/19 11:18 AM, Fabien Dessenne wrote:
> Manage the irq = 0 case, where we shall return an error.
> 
> Fixes: b5b5a27bee58 ("media: stm32-dcmi: return appropriate error codes during probe")
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>  drivers/media/platform/stm32/stm32-dcmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
> index b9dad0a..d855e9c 100644
> --- a/drivers/media/platform/stm32/stm32-dcmi.c
> +++ b/drivers/media/platform/stm32/stm32-dcmi.c
> @@ -1702,7 +1702,7 @@ static int dcmi_probe(struct platform_device *pdev)
>  	if (irq <= 0) {

Shouldn't this be 'irq < 0' instead of '<=' ?

AFAICT irq == 0 can be a valid irq and isn't an error.

Regards,

	Hans

>  		if (irq != -EPROBE_DEFER)
>  			dev_err(&pdev->dev, "Could not get irq\n");
> -		return irq;
> +		return irq ? irq : -ENXIO;
>  	}
>  
>  	dcmi->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 


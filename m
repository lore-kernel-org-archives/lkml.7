Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AB8C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D235206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="azgcgMui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfGBJvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 05:51:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52097 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfGBJvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 05:51:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so221028wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 02:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZbbPe/OgCkiI4UCDPbrGqbpRXXo3jc53/IKcexuq+WY=;
        b=azgcgMuiRaVzBsgq1sukrVxzQ8OQuO+/ImiTQZlIiE7yGz03+rGbwf/y+jlTa8EVf5
         U5BPvszqu9eAKAv0ehLi3h1SuJNp0vPwtFnYTKvaQ++xEClDFTHjrCEC2Yj+9hhdbWY/
         GwyYqY4lC+isc3OF9NDiW3EhrcB+/X0mWegpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZbbPe/OgCkiI4UCDPbrGqbpRXXo3jc53/IKcexuq+WY=;
        b=laoygQJPGj7kTHGgWb2FfsQyeEAkEyr89AVXXdXOcF/wit/bLk19v4HjEg4EdLJPpZ
         SDGTapHtBq69Q7rZous3a6YaGZ7hXS6jkPAN4AvgdQgXpe769CYElz50P7QwT+3RM7RI
         55hnuX0aDBL65YFkB/oRJOpRQ9omQoJCT2ILvk74KQyaIYrFe5MXjt2P7aGrjeEo9fIY
         iLk8IiRiBA7dmH9eAYVnWmpbgLsTCAIIX+coU/Tyfm7Vl7YzH+jat08xEvE/VzuMnqAw
         Bo8Mr/hThG3pYVRxrvDx5Ng8wxreZi12DxORz1RBg1xdZ1HZ0JcoeRigY3eBSId71EwN
         6UCA==
X-Gm-Message-State: APjAAAXQWiJZ+puV/Bew5Xcox9uQJz/fb/0SOeI+dDLoRSCqOum2hC6I
        +nsjeHorXyYr20Ob09D1ulZwPA==
X-Google-Smtp-Source: APXvYqxfIT/N6efY+/XizNeh8qrIpeIdC2hZSqzcbMa/pkJ8u1aYFYMrVYqI5zI2V3ar9yLnF7yjWg==
X-Received: by 2002:a1c:7d4e:: with SMTP id y75mr2855969wmc.169.1562061108255;
        Tue, 02 Jul 2019 02:51:48 -0700 (PDT)
Received: from [10.176.68.244] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id g25sm1479624wmk.39.2019.07.02.02.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 02:51:47 -0700 (PDT)
Subject: Re: [PATCH] brcmfmac: Replace two seq_printf() calls in
 brcmf_feat_fwcap_debugfs_read()
To:     Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, brcm80211-dev-list@cypress.com,
        brcm80211-dev-list.pdl@broadcom.com,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Wright Feng <wright.feng@cypress.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <7d96085a-76e8-c290-698a-e1473d3f4be7@web.de>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <893cc567-0126-3ab9-92c5-de430fb066fc@broadcom.com>
Date:   Tue, 2 Jul 2019 11:51:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <7d96085a-76e8-c290-698a-e1473d3f4be7@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/2019 11:50 AM, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 2 Jul 2019 11:31:07 +0200
> 
> A line break and a single string should be put into a sequence.
> Thus use the corresponding output functions.
> 
> This issue was detected by using the Coccinelle software.

pot-ato, po-tato

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
> index 73aff4e4039d..ec0e80296e43 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
> @@ -225,10 +225,10 @@ static int brcmf_feat_fwcap_debugfs_read(struct seq_file *seq, void *data)
>   	}
> 
>   	/* Usually there is a space at the end of capabilities string */
> -	seq_printf(seq, "%s", caps);
> +	seq_puts(seq, caps);
>   	/* So make sure we don't print two line breaks */
>   	if (tmp > caps && *(tmp - 1) != '\n')
> -		seq_printf(seq, "\n");
> +		seq_putc(seq, '\n');
> 
>   	return 0;
>   }
> --
> 2.22.0
> 

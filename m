Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED77EC50724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4182470C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcZHnLR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfLMN5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:57:32 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37506 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfLMN5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 08:57:32 -0500
Received: by mail-pf1-f195.google.com with SMTP id p14so1525139pfn.4;
        Fri, 13 Dec 2019 05:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DPtsk1xekHf4rFompFbK+++ywQG55As5vK9YXX25XMc=;
        b=HcZHnLR1V2y0vLHORQuWaZK6tD618ijiTm+wMIWqy5ttOW+N7ncHscgh5Rpe5dPZrT
         DN5TbwDanXx3zF0C1n1Isg76VQZ9LDjiHkDa9ChFahhR03hwRxOX5qjlIMnwJY7/uprQ
         hBNvephzkogku4C0RQC7Vy3L8GIc/hwxtd98zpioMw+5rUen0Tug4tiV5k/Fa5t15Jjn
         7Fs+HcXsvfjoYjVmXDvoFRweQ45pZCMTvoFyqekuW0+koykZiDBQxAN0cAFFN5RDNFFp
         HLnYWZjtmfd1Jb6pQCJW0pWLCpogjw39HKPu8CakppP7DsK2nKsethsuR5wstovhgp1+
         1qjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DPtsk1xekHf4rFompFbK+++ywQG55As5vK9YXX25XMc=;
        b=DuL5wvfASUAWTfBaZMTr02jeA1XiRFTVp9UmdxTPucQaWsseHh5Xoaa89GpvHCgozh
         uL0hH0xXxh/5wiAgMmnNRCbNFSn7wUrIUIx/NeiOc1twlUyZ96gGDCr5nO+XEN4R+YvP
         Jmd9aCll5PXz2rGoGCnnAfEjlVQ2Ce17at9jQzodpdAIJyu+xuudx0lgYTet0x++Ins5
         FwBS5Whrtfc8xSFvI5uxpwA+K3/9RNEM624mvbTc2/h2HgCJu60D5iuAQ1U/Izm5j+M2
         IUH8DjpCht9JV3htoHTVBkQG1/kQgxP1Xe2axoe91KvRcIOKoAtwnKWmHtxV2Un9zkX3
         oQwQ==
X-Gm-Message-State: APjAAAVexmV0DslrUpVt/TKMcnW/ZTuRNmS1DSQne62Lbw/sAwsZwWbn
        RmfaGb+FTnDszluG3E2NsFrAhKfh
X-Google-Smtp-Source: APXvYqy9k2eDNK1J3IVJhR+gbK0hX/ItjAIfIbZD9dhbfVa/+PROIoCleTD5Ir8Ui3woBnQNkNMGYg==
X-Received: by 2002:a63:de08:: with SMTP id f8mr16905639pgg.107.1576245451363;
        Fri, 13 Dec 2019 05:57:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r68sm12605687pfr.78.2019.12.13.05.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 05:57:30 -0800 (PST)
Subject: Re: [PATCH v2] usb: typec: fusb302: Fix an undefined reference to
 'extcon_get_state'
To:     zhong jiang <zhongjiang@huawei.com>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191212122053.GA1541203@kroah.com>
 <1576239378-50795-1-git-send-email-zhongjiang@huawei.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3dbe90ae-d1df-0714-f797-c6c279bf620c@roeck-us.net>
Date:   Fri, 13 Dec 2019 05:57:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576239378-50795-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/19 4:16 AM, zhong jiang wrote:
> Fixes the following compile error:
> 
> drivers/usb/typec/tcpm/fusb302.o: In function `tcpm_get_current_limit':
> fusb302.c:(.text+0x3ee): undefined reference to `extcon_get_state'
> fusb302.c:(.text+0x422): undefined reference to `extcon_get_state'
> fusb302.c:(.text+0x450): undefined reference to `extcon_get_state'
> fusb302.c:(.text+0x48c): undefined reference to `extcon_get_state'
> drivers/usb/typec/tcpm/fusb302.o: In function `fusb302_probe':
> fusb302.c:(.text+0x980): undefined reference to `extcon_get_extcon_dev'
> make: *** [vmlinux] Error 1
> 
> It is because EXTCON is build as a module, but FUSB302 is not.
> 
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/usb/typec/tcpm/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> index 72481bb..5b986d6 100644
> --- a/drivers/usb/typec/tcpm/Kconfig
> +++ b/drivers/usb/typec/tcpm/Kconfig
> @@ -32,6 +32,7 @@ endif # TYPEC_TCPCI
>   config TYPEC_FUSB302
>   	tristate "Fairchild FUSB302 Type-C chip driver"
>   	depends on I2C
> +	depends on EXTCON || !EXTCON
>   	help
>   	  The Fairchild FUSB302 Type-C chip driver that works with
>   	  Type-C Port Controller Manager to provide USB PD and USB
> 


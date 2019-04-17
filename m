Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D52C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FF32073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="JjattUqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbfDQIuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:50:52 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43783 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731141AbfDQIuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:50:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id f18so21667830lja.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 01:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DVhd8fs5umKDxiiF8uOAyEdaazsYL5yIOc6xRx/Oseo=;
        b=JjattUqWxsbDQW+fiUr5mGsAl0aTZMHysS4vgnVE5o5Jcm49ufRjRzo7Ww2+Yfa+hr
         6l6aWV0xrREqBq3hgF1B6stGPe/+3SlTP+033CKqNjjmtgAbriHctOd6Sx6JDKRwH4ho
         MB991v/HvVmcL8n+LnGARX4wOKuUCMcYXTZ4WAiwxzJmOH6Hxg7+B/ObKZWVWBJc7aAt
         YV7fck0axAAs7TohCu7lW2yVbdrRbFF1I1tytgcKPG9Mtp0+x7UmI5opuQg562xBJwGT
         OF8UFz2Vi3Veao+6TRnF71x1o87Ocron+hzkMa9exWIor6VgmHizbCxxcVUtZCv2yQUA
         n6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DVhd8fs5umKDxiiF8uOAyEdaazsYL5yIOc6xRx/Oseo=;
        b=XxjiJqhL42HGV92r+SyYzwwoN6MAoJaZ7xoUEuUNPd/b6075xC2kgjmqnu4QvtQw+S
         VqBBO1fdrj0nyI/SDxO1FHjF2ZLUs2ERda2jUd7kyQdH09/+0ecIQi43hJDLIFZhHO+0
         qVw0JQFUjHKOn/Yl7Gz39oNM2TxFH2syWiTGw0Nndpovx7f5Z615ONvfvmmUtg1/IqbA
         P5xxaKRI9JYLyIYYxV4J880PHIgsxGM5KXQjkiSPGneoPbmCMwn1q4zKBpmxSWXyr1ef
         ejIAjjtPoy6nKAybRxp6xuMvyA9n7Iug8bq4OusbIxhd1KOSaLe1/xXwRYXtOk/mpxdu
         S1BQ==
X-Gm-Message-State: APjAAAUzlqkJryvGsQu77FJZ4nwb09N3cUHHCQN/nuVxhykI6cGn0Qxh
        epMvMpWq821UYaktx2sxvANzGQ==
X-Google-Smtp-Source: APXvYqw5lU+fOPhIR44TGx6+tbd8C37dxOaxBd9EzOonfyl+5Zkz2INyNqTfSJtr/ijbK84nOLSgMQ==
X-Received: by 2002:a2e:3e0e:: with SMTP id l14mr46687072lja.125.1555491050478;
        Wed, 17 Apr 2019 01:50:50 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.81.146])
        by smtp.gmail.com with ESMTPSA id b78sm3124344lfg.38.2019.04.17.01.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 01:50:49 -0700 (PDT)
Subject: Re: [PATCH v1 2/3] MIPS: ath79: ar9331: add Ethernet nodes
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jay Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, John Crispin <john@phrozen.org>,
        Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org
References: <20190417062201.15745-1-o.rempel@pengutronix.de>
 <20190417062201.15745-3-o.rempel@pengutronix.de>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <a846087d-91c5-c075-2a7f-3ccf05137c69@cogentembedded.com>
Date:   Wed, 17 Apr 2019 11:50:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417062201.15745-3-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 17.04.2019 9:22, Oleksij Rempel wrote:

> Add ethernet nodes supported by ag71xx driver.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>   arch/mips/boot/dts/qca/ar9331.dtsi           | 25 ++++++++++++++++++++
>   arch/mips/boot/dts/qca/ar9331_dpt_module.dts |  8 +++++++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/qca/ar9331.dtsi b/arch/mips/boot/dts/qca/ar9331.dtsi
> index 2bae201aa365..7d59c7c66dda 100644
> --- a/arch/mips/boot/dts/qca/ar9331.dtsi
> +++ b/arch/mips/boot/dts/qca/ar9331.dtsi
> @@ -116,6 +116,31 @@
>   			};
>   		};
>   
> +		eth0: eth@19000000 {

    The name should be "ethernet@...> according to the DT spec.

> +			status = "disabled";

    Mmm, this one is typically specified last in the node.

> +
> +			compatible = "qca,ar9330-eth";
> +			reg = <0x19000000 0x200>;
> +			interrupts = <4>;
> +
> +			resets = <&rst 9>;
> +			reset-names = "mac";
> +		};
> +
> +		eth1: eth@1a000000 {

    "ethernet@..." again.

> +			status = "disabled";
> +
> +			compatible = "qca,ar9330-eth";
> +			reg = <0x1a000000 0x200>;
> +			interrupts = <5>;
> +
> +			resets = <&rst 13>, <&rst 23>;
> +			reset-names = "mac", "mdio";
> +
> +			clocks = <&pll ATH79_CLK_MDIO>;
> +			clock-names = "mdio";
> +		};
> +
>   		usb: usb@1b000100 {
>   			compatible = "chipidea,usb2";
>   			reg = <0x1b000000 0x200>;
[...]

MBR, Sergei

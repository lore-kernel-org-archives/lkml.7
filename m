Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3B3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54B720830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1Fs01IF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfCDUml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:42:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45681 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCDUmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:42:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id w17so7034721wrn.12;
        Mon, 04 Mar 2019 12:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yEDxlqcGNZWjbAwI/KNaFadWLU/mUR+0LdgFi3waQKk=;
        b=l1Fs01IFqcrVADJWq7C0L7akOJLOF3mEjkX9m2vAkP1QXEW81vwR+RB89ZsMT8RI8p
         PP16LpZ1w41WfYCljSkMEBohPQWXZeWkfVjRKbzk2Wu1qXp6Svk1+ybRJRoj6EBzDz3C
         xSFj4G3lQyJJvv60qtswCKUXfDi6EtLqw19Aarf7nLEayR18pxZvq99se7WRHURk6Cv7
         eRJS2oCKqnm283Gacp5iedUqkJSkMVnh+4mbS+C4og+WaPQMq/jJ7ufc4iCkQw5TZn/n
         38TsbtHZ6jf1gWwWSzG6L5wfarqXTc/aamws5di2qEyFgaHPageQpijU+1MWIEoyVB0/
         1T0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yEDxlqcGNZWjbAwI/KNaFadWLU/mUR+0LdgFi3waQKk=;
        b=RRy7sjB3qnieORqgW0KDqPsdiKhN4VmkiSp8KlPjKlnuZ6nk4fc0XMxbT+Tq9G1Th2
         teE7Pk7NeXYHhhd2CEdycmel+2JkaBAd/ZC0DYUoW7Dy1yUoBVwHLt2LkpbilPBm+hDz
         0XmXNUEuSI/38YXFGXrKdBo4HT7C6MQvRumWHpg1xGFuDxB4sP8h+hn0XL8kgtJ7d8s4
         1njC2oBHyH8PRg4khzuCD9+F2EPPfHEy53RKbDMVz9BkTVDyZ4GUTMcJWlGGKhF+8ZyF
         73/xQcJszauQWhyQnLITf8kmY7yjycx8zU5hrODtKVEMOCSndC++v3ZrsIPMB/ah3ZdU
         oEfw==
X-Gm-Message-State: APjAAAXsm6vM0eVvnn5/+baLFcVwHqO1/Z6+UgxDWiCGlUSiq9NRnrD2
        Yzl0FXF4De9aplh/wq8q+U5mM1Rm
X-Google-Smtp-Source: APXvYqwH93Fu0Bo8lmy3AM8Tv6hw623NWe4w3Y1z5Qj12kswWvMx9DXWBpmlg1jfASuFYZoYv10dAA==
X-Received: by 2002:adf:8447:: with SMTP id 65mr13204174wrf.328.1551732158886;
        Mon, 04 Mar 2019 12:42:38 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:d8e4:889a:5ed6:37cb? (p200300EA8BF1E200D8E4889A5ED637CB.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:d8e4:889a:5ed6:37cb])
        by smtp.googlemail.com with ESMTPSA id x11sm17774553wrt.27.2019.03.04.12.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 12:42:38 -0800 (PST)
Subject: Re: [PATCH] net: dsa: mv88e6xxx: fix unused function warning
To:     Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190304203641.2052975-1-arnd@arndb.de>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <50a3d69d-2096-a4d9-7c5f-54496671ec85@gmail.com>
Date:   Mon, 4 Mar 2019 21:42:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304203641.2052975-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.2019 21:36, Arnd Bergmann wrote:
> The newly introduced function is only used inside of an #ifdef
> and causes a warning when that is disabled:
> 
> drivers/net/dsa/mv88e6xxx/chip.c:4623:13: error: unused function 'mv88e6xxx_ports_cmode_init' [-Werror,-Wunused-function]
> 
> Move it into the same #ifdef block to shut up the warning.
> 
> Fixes: ed8fe20205ac ("net: dsa: mv88e6xxx: prevent interrupt storm caused by mv88e6390x_port_set_cmode")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
A fix has been submitted already. See discussion here:
https://marc.info/?t=155170356600004&r=1&w=2
and the fix here:
https://patchwork.ozlabs.org/patch/1051275/

Heiner

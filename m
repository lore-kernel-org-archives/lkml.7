Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B28C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53D72084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="argDfeYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDCPUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:20:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52066 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfDCPUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R5T7kDV7TpyWs6S5Q85Fo4256ZuEQ3gxr7tNwxCads0=; b=argDfeYUxxJTNDNEAik618ZR/
        nDvEsQgUGtGwDfQm5SYJnaLznKQH1MSbdMsxl1TJk5Jm831iLQ5Vlx8VD4BrIKcFkQwy4JFaT7fDT
        COQALpBS2NabrxRQ4ZHD648+lNswBixF4f1SG11dZjlzCqmSZAV1DLuQ8doBSlPNgQ7y1biPZAaUF
        FtpYQRR+oI0kb8Lfl9kbPB2X+EZ1R5CeKyGbF3WG6qkpE6owAPcccveCxybFMTjp/N6+uxScYznJQ
        lCBLo1sogbpXqgbipYoeCPXjcXXEoCXN96K9WxmcSIs2jogPhr2gNmWyakJ246eZz1jHodCsPPDKX
        h9HwO3hTQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBhgX-0000Jo-Av; Wed, 03 Apr 2019 15:20:17 +0000
Subject: Re: linux-next: Tree for Apr 3 (acpi_dev_get_first_match*)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
References: <20190403192407.13a99513@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <532f66c8-4c25-10d3-d119-71f3c8f82edd@infradead.org>
Date:   Wed, 3 Apr 2019 08:20:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190403192407.13a99513@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/19 1:24 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190402:
> 

on i386 or x86_64:

The patch(es) that change acpi_dev_get_first_match_name() to
acpi_dev_get_first_match_dev() have a problem when CONFIG_ACPI is not set/enabled.


../drivers/gpio/gpio-merrifield.c: In function ‘mrfld_gpio_get_pinctrl_dev_name’:
../drivers/gpio/gpio-merrifield.c:388:19: error: dereferencing pointer to incomplete type
   put_device(&adev->dev);
                   ^

../drivers/extcon/extcon-axp288.c: In function ‘axp288_extcon_probe’:
../drivers/extcon/extcon-axp288.c:363:20: error: dereferencing pointer to incomplete type
    put_device(&adev->dev);
                    ^


-- 
~Randy

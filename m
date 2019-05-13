Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F127C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504DA2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zaltys-org.20150623.gappssmtp.com header.i=@zaltys-org.20150623.gappssmtp.com header.b="QyMS1Kkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbfEMLcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:32:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35628 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbfEMLcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:32:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id h1so6646185pgs.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 04:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zaltys-org.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:in-reply-to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=oW2OGfo2kmTLuf4Kc5CGIE4FQWJunf5Se7PBzqxMT+k=;
        b=QyMS1KkvVFMpgE8NWSvXdmK/oaHre2INuuntPie9HgV+miKlaRnV1PjPxBWhMwbA7Z
         mvnM8/inBQ015PcrGGYELYZXcPIWZoEra7stEA33UbOdFDDqtafe3k0xWiL4xDMZfN14
         oRgt0iFijQzgyJ7ipOWy8U4tPQYbqUhL8ZaEf3dYxSxdlacM2ix2wCyYRU9Hrvo5msIR
         /PSDuzWF6cuZaqs0QEXOXSPx9jqBz/8kW0DKR0vP4TjoL/bOG5vAgTdKCTdDZO8UaZ4+
         y8XSBnFPLCsmt9FbYFpuVEER9KiWJ5AmZdE/vwaD2c3yewD02JewIBif9h1kaLakn6ys
         82XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:in-reply-to:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=oW2OGfo2kmTLuf4Kc5CGIE4FQWJunf5Se7PBzqxMT+k=;
        b=VbFmEH2jEHX9djmZz9r7TMB0e6zVu6tCkhrrCbcGZy1kia1/t1HRd7KA2yEsVQSVxH
         CZll6IY36WReZtS5ZhSFFopVFgpnrPFx9y+N50B3Kuq+uEqZGkjUZ0s27ckvYypre2i+
         Ms4eH7hunFhLYLr/s9UTrFLZl4aFzX721MQbzM72GY/yq0sALX67J1JMZ3XibR7t5M/d
         XiUgJFZdfqc/HxF70Mth352aP/TXOPsETJsrIXwrizCTrlt6WgzL6O5A7OJcbGvrTRD6
         i3Djg34y7uZqjbcBlDNy3/x/jGn32oDV7bzGaq3WxCrcGLm4u9xbOgzg40AbHjlYtwfY
         seFA==
X-Gm-Message-State: APjAAAWxUCmMaBm/yPDmNSDMkYKYTvuHPeKNsGQ/38ykM61EJgszwWQi
        M/oV6ezn6FbelvKYkcPoo7zQtA==
X-Google-Smtp-Source: APXvYqxmZhyuK0mcNDMhg97F7hXXFjrF+5Xi3FPN/3a4oxJ4C/VPadqCq4QSeE7IoTblppgKCkskFw==
X-Received: by 2002:a63:7989:: with SMTP id u131mr21610419pgc.180.1557747164024;
        Mon, 13 May 2019 04:32:44 -0700 (PDT)
Received: from [172.28.0.10] (122-59-127-127-fibre.sparkbb.co.nz. [122.59.127.127])
        by smtp.googlemail.com with ESMTPSA id r9sm19107632pfc.173.2019.05.13.04.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 04:32:43 -0700 (PDT)
From:   James Grant <jamesg@zaltys.org>
Subject: Re: [PATCH 0/5] usb: gadget: udc: lpc32xx: add stotg04 phy support
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Felipe Balbi <balbi@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
In-Reply-To: <20190409120908.12079-1-alexandre.belloni@bootlin.com>
Message-ID: <efaaff85-ac39-f0e2-e042-7d6fd0c59054@zaltys.org>
Date:   Mon, 13 May 2019 23:32:38 +1200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-AU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested with a board containing LPC3250 SOC and STOTG04 PHY by using 
serial gadget.

Needed patch "[PATCH] usb: gadget: udc: lpc32xx: allocate descriptor 
with GFP_ATOMIC" also.

Tested-by: James Grant <jamesg@zaltys.org>

Regards,
James Grant.

On 09/04/2019 14:09, Alexandre Belloni Wrote:
> Hi,
>
> This series starts to clean up the lpc32xx udc driver and also repairs
> interrupt handling so hotplugging actually works. The design I tested
> that on uses an stotg04 instead of the usual isp1301 so support for that
> is also added.
>
> A bit more work is needed to get the RNDIS gadget driver to work.
>
> Alexandre Belloni (5):
>    usb: gadget: udc: lpc32xx: simplify probe
>    usb: gadget: udc: lpc32xx: simplify vbus handling
>    usb: gadget: udc: lpc32xx: properly setup phy interrupts
>    usb: gadget: udc: lpc32xx: add support for stotg04 phy
>    usb: gadget: udc: lpc32xx: rework interrupt handling
>
>   drivers/usb/gadget/udc/lpc32xx_udc.c | 167 +++++++++++----------------
>   1 file changed, 66 insertions(+), 101 deletions(-)

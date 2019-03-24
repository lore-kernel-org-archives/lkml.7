Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADAEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3772148D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="IQwS18ZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfCXQTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:19:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33311 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfCXQTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 12:19:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id v14so4451930lfi.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UyqVDhLC4OHpuBtwhSQ0ZuhPa8nU+D6SzGMHE1FiNTs=;
        b=IQwS18ZI7crnnbpYRF1xocEaHklD2D+PukRRZT1HnGmT23Ho34stCYUAqVnZmWrpYS
         LeC8djYJrGiiVGUPHuQZKiG4sVYmpLw9PlETADEmNtv0h+vQDaAKL6DS//CwDJs6vHEK
         dhDQ6yLxTMawIfy+Mr11A2JSj0kQRAgMxDGamA5bKvW87eeX93wzuep0FnqJou+9b6Xq
         KFz/D3WpG595WX1BMyClnktSiGMmPZu7b5VGSgSOao8zcCJOC7wNshtyyRGZZPq5bvvj
         HgwSD3D+Oc/we3vCc5VqEN4T8PYWvrft+GEi2LTdUSHy53u7lAeZQ3zYPTTt4Zs7kBqx
         Y9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UyqVDhLC4OHpuBtwhSQ0ZuhPa8nU+D6SzGMHE1FiNTs=;
        b=X4ln1Y0V7grym9h+VACDfFIkHGKGdctX30Sr91WtizxcWnYZXKn4sVyvz1DxZEiWyA
         OPdt3Bt1O7Bv8myZat166iofx8WAlNedENPdqDCRZHrfRfDC6jdftXRlWBqxE2/d+KKp
         uZ7jpDpnf/VkOXOK88DEW9zSYPWwkeMIDBpOFkumyZx3wqnnXjxHYNK8+04Gk4AsOsjD
         ZW9AaQrsNupuEpVF5SGN5zYNpr+2YkRXlYLay7q2ST1zy06GkQhrHThm96l3SuK76VvE
         QDEWvrGvTBcbIzwDWInt0FZ1hjoqBnYxoQlEOh4K1KEL2Rz3hCVBzYd5JlqzsIznxLwg
         Yxmw==
X-Gm-Message-State: APjAAAWOfd9eSnT/34l6t1cBTGKth2SIu0iVsl5263musROrZd0hDMX1
        nvfoBEoUVng156bkEprL9EdXLQ==
X-Google-Smtp-Source: APXvYqwaqRFeeg5cMADmKN0HFpWflJH8cDWRvMWVzAbZ5tlzYUg0lBd+5ttgyFeD7jeKzZl+Fsw5Rw==
X-Received: by 2002:a19:c90a:: with SMTP id z10mr9993966lff.40.1553444340176;
        Sun, 24 Mar 2019 09:19:00 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.80.147])
        by smtp.gmail.com with ESMTPSA id u1sm3016475lfm.4.2019.03.24.09.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 09:18:58 -0700 (PDT)
Subject: Re: [RFC PATCH v2 2/5] dt-bindings: mtd: Add binding documentation
 for Hyperbus memory devices
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tudor.ambarus@microchip.com,
        nsekhar@ti.com, Mason Yang <masonccyang@mxic.com.tw>
References: <20190321174548.9288-1-vigneshr@ti.com>
 <20190321174548.9288-3-vigneshr@ti.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <ca3326cb-1b37-cf9a-f196-3288a539d064@cogentembedded.com>
Date:   Sun, 24 Mar 2019 19:18:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190321174548.9288-3-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 03/21/2019 08:45 PM, Vignesh Raghavendra wrote:

> Add DT binding documentation for Hyperbus memory devices. Only
> Hyperflash is supported at the moment.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  Documentation/devicetree/bindings/mtd/cypress,hyperbus.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/cypress,hyperbus.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/cypress,hyperbus.txt b/Documentation/devicetree/bindings/mtd/cypress,hyperbus.txt
> new file mode 100644
> index 000000000000..cb408f80b868
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/cypress,hyperbus.txt
> @@ -0,0 +1,6 @@
> +Bindings for Hyperflash NOR flash chips compliant with Cypress Hyperbus
> +specification and supports Cypress CFI specification 1.5 command set.
> +
> +Required properties:
> +- compatible : "cypress,hyperflash" for Hyperflash NOR chips

   What about "cfi-flash", shouldn't it be also specified?

> +- reg : Address where flash's memory mapped space

MBR, Sergei

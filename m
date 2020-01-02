Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B397C2D0C2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB30217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=vesoftinfo-com.20150623.gappssmtp.com header.i=@vesoftinfo-com.20150623.gappssmtp.com header.b="bfIJxCTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgABTBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 14:01:37 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39291 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgABTBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 14:01:37 -0500
Received: by mail-pg1-f194.google.com with SMTP id b137so22307408pga.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 11:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vesoftinfo-com.20150623.gappssmtp.com; s=20150623;
        h=to:subject:from:message-id:disposition-notification-to:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=4gXnijrH/UrCGLfsjz+xgaW1JrTEiQCupSHdPP2/4/E=;
        b=bfIJxCTnxPa7f9pupEbZU/M3LxlhJDyMIidU9hywU5B9uq3fiAu3ypG2XBTkcDbX/G
         t2qojP9rtbhETTJbSc6cI5SrTtm2vkDcUyTR7ojGMBkQBNh921WtCOriWAIFFyWYYHFF
         KAQKBCfIl6RV6XaF9siAJ3M5J/ZEzuMQFf6LeaUzVf3FdSNI1FFzEyiOVSt3WUgtteJn
         C2uizHXKJP5vNsQd2lrObQC76C9jcCKO4XEQ2yasx/Rb65xuMDs19yD8z5H5ER6pZ0fh
         z5a0ErB6mseTi44iLM8VId94bj4SMWyfpUuFlN+uZAyTYiXMs13CRpLIdKuJyLXUZvDw
         386w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:subject:from:message-id
         :disposition-notification-to:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=4gXnijrH/UrCGLfsjz+xgaW1JrTEiQCupSHdPP2/4/E=;
        b=jXMy7DgaRn+Fxge8+7rac7EJuyxfLaxY+vJ4V4kDjPmycYKzhKSZ7diHvRUH8jkVtQ
         p7cK+vQMTxuvDryp7E94wmkdYlXGMtPFLvqMiE6K+EuV7pLrpL5vXTmrA2AY1znolnV2
         kvMCcSwA+O4fHnJ94bpHoe4oP3ug+Xb53YTsNUxA9vqOkPLXVZQTVxq71WFnDUmF9tGN
         wkBXhfAZK1iweC3BV2zlS9lGuGYdsDc4gXibpLhoogqKAHHaBL8FjP/UBi0cs9ol1Bea
         eac/XEbH2dzHjGC2aL36MDUgnbhcitri7ZX2Z7yTGPUeiQTKS2MlZXzo8vsh1O2ti9rZ
         QVLg==
X-Gm-Message-State: APjAAAUMrVKX/93rq6Ykn/g67JzG+fUjISkYac2RJO6aMNvvIZnPjCpe
        QElTOtLuzPDIHwxGhA3fLZXpuUCKYXE=
X-Google-Smtp-Source: APXvYqw7am3hrz74Fn69dk0QjYQRt8RS9hgRastQXVTHn1dBqV4ikbpQUPaYcMjtZfsvh1oSJsQEUA==
X-Received: by 2002:a62:1958:: with SMTP id 85mr87365066pfz.221.1577991696489;
        Thu, 02 Jan 2020 11:01:36 -0800 (PST)
Received: from [192.168.0.6] ([223.226.119.126])
        by smtp.gmail.com with ESMTPSA id q10sm61566687pfn.5.2020.01.02.11.01.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2020 11:01:36 -0800 (PST)
To:     linux-kernel@vger.kernel.org
Subject: Wine List
From:   Nicole Olson <nicoleo@vesoftinfo.com>
Message-ID: <127530c2-4a34-7f9f-2bd1-767579e832db@vesoftinfo.com>
Date:   Thu, 2 Jan 2020 13:31:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.3; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Antivirus: Avast (VPS 200102-0, 01/02/2020), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Would you be interested in acquiring an email list of "Wine Enthusiasts List" from USA?

We also have data for Beer Enthusiasts List, Liquor Enthusiasts List, Beverage Enthusiasts List and many more.

Each record in the list contains Contact Name (First, Middle and Last Name), Mailing Address, List type and Opt-in email address.

All the contacts are opt-in verified, 100% permission based and can be used for unlimited multi-channel marketing.

Please let me know your thoughts towards procuring the Wine Enthusiasts List.

Best Regards,
Nicole Olson
Research Analyst

We respect your privacy, if you do not wish to receive any further emails from our end, please reply with a subject "Remove".


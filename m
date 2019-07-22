Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D986C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C2721985
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=reply2setup-com.20150623.gappssmtp.com header.i=@reply2setup-com.20150623.gappssmtp.com header.b="Er1whEjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbfGVSvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:51:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38554 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbfGVSvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:51:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id az7so19544290plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reply2setup-com.20150623.gappssmtp.com; s=20150623;
        h=to:subject:from:message-id:disposition-notification-to:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=CkPTLp1+mLr2WEfeyAA98TPYjmGNdrnGzYHbmZtdlPc=;
        b=Er1whEjJ4kNYucyXbVOdIhrBNUD6NqjK/gBR+omL5PT370IIwZKZtMupePvJy7ntqU
         MuB3auJKkJSqLFoBHOumNxaIDprhkQOj5pPjReQvgDrZOLlp9Q3lNCelPfUaa4CeQ/g6
         1KVpuHzOxxJk9ow3+gidRwjh9DT1XCEfx3HEJmisgfAdc7EYTfTPWy4RNLFBzLch1mmc
         7xi6/0ewr5lpG7oA/3ZL96EZ5B8oEZoHxcbTPx8hiVQZa2K245djnaRYDaOod3QFplnW
         uw2jRlb/UAPCh4eeWMtcq/Cyy+cQh8xvsabdMrUmiBQA2/xIaUIsO0h3MfDpo3XWWolE
         RxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:subject:from:message-id
         :disposition-notification-to:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=CkPTLp1+mLr2WEfeyAA98TPYjmGNdrnGzYHbmZtdlPc=;
        b=ktKzs9JClxXRRgZpOo+CfVKx52APKzT7ooBaekUHWxytjsP0MjLT48x/8mr5nyfw2C
         zR7VuUDbCj+b0oFZdyXvU9pDOSD1AD2xjqtj931d2d6PSvzGHDbQjjHVdIs68ekNiGzj
         SVtZmoY/dMp/FyAw8EqPHEs53VjmuBiYN19ii0Z+hyT6uZbEs3eZVKwErNEthlrGqeBC
         0Iiqreg8tNtRcXTv6QlHwb/FlE0v6zZMInfq8R4XbevaACMLc5ZPN5z8pTRFXox5MPfr
         UPe+pQZ4Yo/oipJBI0ZGJSCiuRcL4pzHW0gtln0ECKsB1WevfiGzwsNHmO9KKQndKDbP
         TCaw==
X-Gm-Message-State: APjAAAVs7oHCd4/oSbpxtBOf0p3v1Vw2D+BShRWxnMQo6NHX3JTL4265
        mBIP+a1la5qbGquPrwf03208kn0G
X-Google-Smtp-Source: APXvYqxm8U0feXuxfSWfxLubfRTvs1pbMHcnkOb4MXmMeW89K1c9aX+6YdjZMlDFY0s/NYZGQkQ9pg==
X-Received: by 2002:a17:902:6b85:: with SMTP id p5mr73556286plk.225.1563821507341;
        Mon, 22 Jul 2019 11:51:47 -0700 (PDT)
Received: from [192.168.0.13] ([103.253.170.188])
        by smtp.gmail.com with ESMTPSA id p67sm48316622pfg.124.2019.07.22.11.51.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 11:51:46 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
Subject: Wine Enthusiasts
From:   Leslie Arthur <larthur@reply2setup.com>
Message-ID: <c54758c2-20be-ef3e-014b-5364844dfe95@reply2setup.com>
Date:   Mon, 22 Jul 2019 13:43:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.3; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Antivirus: Avast (VPS 190722-4, 07/22/2019), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Would you be interested in acquiring an email list of "Wine Enthusiasts" from USA?

We also have data for Golfers, Alcohol Enthusiasts, Beer Enthusiasts, Chocolate Enthusiasts, Foodies, Travelers, Gift Buyers, Spa and Resort Visitors, Sports Enthusiasts, Android Users and many more..

Each record in the list contains Contact Name (First, Middle and Last Name), Mailing Address, List type and Opt-in email address.

All the contacts are opt-in verified, 100% permission based and can be used for unlimited multi-channel marketing.

Please let me know your thoughts towards procuring the Wine Enthusiasts List.

Best Regards,
Leslie Arthur
Research Analyst

We respect your privacy, if you do not wish to receive any further emails from our end, please reply with a subject "Remove".


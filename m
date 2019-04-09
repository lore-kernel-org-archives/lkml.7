Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD05C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D39E2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=reply2setup-com.20150623.gappssmtp.com header.i=@reply2setup-com.20150623.gappssmtp.com header.b="fUZW2R7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfDIOMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:12:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38516 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIOMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:12:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id f36so4999642plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 07:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reply2setup-com.20150623.gappssmtp.com; s=20150623;
        h=to:subject:from:message-id:disposition-notification-to:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=4XXpP7UT8kcthP7v4uY3yHM4kQorlcIU8NjvRiByH+s=;
        b=fUZW2R7IrTfKJljfp/MjFCKlCZZ6w0joLr9PeGq0BSmiMMahSvOFmQq5O3GoQbJBGR
         m98yZaKX1dir0Om6TJvEFz7NJVKOmYza+OlVL11LMp1Iuf7UdwRcGx8lgExZ+mY8KE2C
         etVMmLHg/O/HdyuJ/vp9S09oMj1TUGOct9XldipJ7/b6tuAgFbo5GQZD8qOPI0A+fLPE
         U2o2/gwd5oS4Gj1pAizJEK3vLBvyFFaQDoDseB3DTZh57SK7ZBAggR8tbJWUE6Y4gv7c
         DjLGdFGHGwkC9eKC2mtOfnMa3yCAK4dHVr12wSX4oKgz2oEGAXIQy4XAu2jgjB9/Fyva
         PoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:subject:from:message-id
         :disposition-notification-to:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=4XXpP7UT8kcthP7v4uY3yHM4kQorlcIU8NjvRiByH+s=;
        b=gH4oGJpR6tVsrAXAYTEa0MYEPwwCQ+Un8RyzhdWswhKh5sTkkEPgX3Wg++KVbdC5l5
         T1Qsqh8bKhAr90qq1fwcbVjY9XSOWDiKvS4iNzBSnfWjaNtUshEDMkRuolFXtXOIA7Vc
         RFEZZrVkbJn+sehQfr/enpGRJnPL7kDXFQ5aXYHQVms6mCvJlgsUsm03GgBmTwQqTfeL
         touWm97N/RhTm2UIjeNU2baOqs1iPM23QYUnQ9gyV3Enj0vqxRpXxeraOwVSUCsy8fZm
         RTRrp1Hcl/HduXWeYnI9scfcnMF39H407IVRDD7OtnB9wQGUBI2rxZXJX3glL+Gi/Prf
         OU5g==
X-Gm-Message-State: APjAAAU7BVgy6fYgO+nCGW1urTs9UyydqfH2eVfmzONTrlEX98174fiv
        OWEdLjnJnhpzTpKvu1Qngc8stLE0230Ttw==
X-Google-Smtp-Source: APXvYqynMpvirgfWKSNdBcn2Z0PEDnWImraI0SaSBpABInSGg8FE/ChvOS+ZMT+qNNd52lt9yXgE/w==
X-Received: by 2002:a17:902:a583:: with SMTP id az3mr37647847plb.205.1554819140598;
        Tue, 09 Apr 2019 07:12:20 -0700 (PDT)
Received: from [192.168.1.134] ([122.167.91.152])
        by smtp.gmail.com with ESMTPSA id k65sm69240260pfb.68.2019.04.09.07.12.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 07:12:19 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
Subject: Wine List
From:   Lorraine Jackson <ljackson@reply2setup.com>
Message-ID: <3b4946e2-0547-be3a-18ef-78ab65cca20d@reply2setup.com>
Date:   Tue, 9 Apr 2019 09:57:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.3; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Antivirus: Avast (VPS 190409-6, 04/09/2019), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Would you be interested in acquiring an email list of "Wine Enthusiasts" from USA?

Our Databases:- Beer Enthusiasts List, Alcohol Enthusiasts, Travelers, Liquor Enthusiasts, Chocolate Lovers, Camping and Outdoor Enthusiasts List and many more..,

Each record in the list contains Contact Name (First, Middle and Last Name), Mailing Address, List type and Opt-in email address.

Let me know if you'd be interested in hearing more about it.

Best Regards,
Lorraine Jackson


---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus


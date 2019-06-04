Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A084C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62E2247FE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tradeshowsamerica-com.20150623.gappssmtp.com header.i=@tradeshowsamerica-com.20150623.gappssmtp.com header.b="X9O7rDjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfFDNKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:10:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43017 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfFDNKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:10:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so10334714pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 06:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tradeshowsamerica-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:references:in-reply-to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language
         :disposition-notification-to;
        bh=fVY0HIUpuHGTQdZzNgFbCBNw/NqFwFB4N3rt6IZYrDQ=;
        b=X9O7rDjVHebFx7Ix/hHKXNUiqVKNedKa4Hy1ApT4cJFV1brjssT2VjLgs+sWWtPHna
         mywcCuXn4oeGvywjp/GuuzlyehyZ3jqxlYw/K1q+qU+t8Ba8chR4sFAvaEizb03D4w0y
         qUBQdqSgVK2VEmKbEMV3Nx8dxdNtL158xqKgN53XcFHVmhsj/YY8YsjwXdkW5d7FuU4F
         OEjI/7jCIB8KR97564zJ82HuSXjXKzVAPo+uRr3WRcCOLB2eE4Uhu7SqPvGO0OTfDRH0
         F8mH1RJq1Lp85Sbk+YBucnjFhuAqpp+UgFbjZ1W3LWdwELKMM69eA8ImwyTmLN6SU59E
         R16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language:disposition-notification-to;
        bh=fVY0HIUpuHGTQdZzNgFbCBNw/NqFwFB4N3rt6IZYrDQ=;
        b=RIiuQ1y0fY5uypOQZ1i5a853vRB4nfkX56YZjSNYG/4wXyy6pGk5LhvDfj3bVCpciR
         TLMvFtd6cbGCulLOrBa8ZmYry5KyWDR4kZupijG+2AX4HhKQoJFmaNlY+cjrtyuVkNzy
         P+SjnPHKodHLY/OB4fBXNHFDjpxgPemz2lnwWmndotu8ZHi0ADIuq1p47+NuVmCWA9vD
         vjwooUzv932GIdq8uAS/rkfHaqQlzfI4ZxD+IhTAu72yfQEo8pRrlffoBpzsg6IwDj1c
         JqfpS8qq7qi/ujCyXinQcTeKsZXOnryA4oFkoVxm9177Of6pFk8aiYmmG54C7QCpS8x3
         SjDQ==
X-Gm-Message-State: APjAAAWnp7KjnLZIC9hZPvKyxhlCPEGDNT1xC7TiDyZ+3UFPCvG8Pnu0
        UBzcovwz0GlKsFWr0n3yrXYR2Q+PxA==
X-Google-Smtp-Source: APXvYqw0XGq6JV0XZ8MkZ1L0Z+Qvbmz91ODg+8elTufIBPBgPsoez9L6/T0y2lTqLMgeRsAv7EQFeQ==
X-Received: by 2002:a17:90a:d582:: with SMTP id v2mr35708289pju.22.1559653800701;
        Tue, 04 Jun 2019 06:10:00 -0700 (PDT)
Received: from adminPC ([49.207.51.185])
        by smtp.gmail.com with ESMTPSA id n13sm17164598pff.59.2019.06.04.06.09.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jun 2019 06:10:00 -0700 (PDT)
From:   Paige Hendrix <paige.hendrix@tradeshowsamerica.com>
X-Google-Original-From: "Paige Hendrix" <Paige.Hendrix@tradeshowsamerica.com>
To:     <linux-kernel@vger.kernel.org>
References: 
In-Reply-To: 
Subject: RE: Attendees Data Base of AD&M 2019
Date:   Tue, 4 Jun 2019 08:09:06 -0500
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAADkCdMSWxH5JthHX9TRvVHrCgAAAEAAAABJfZz13z+pHi8g2OzQOJlMBAAAAAA==@tradeshowsamerica.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdUVX/Q6PlHaxGShQ1mQix56j6JL4QAB3IEQAAAAFAAAAAAEYAAAAASgAAAAAwAAAAAEMAAAAARgAAAABMAAAAAEMAAAAASQAAAABTABW9DtMA==
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

I'm writing to follow up on my email. I didn't hear back from you for my
previous email.

If you're still interested, I would highly appreciate if you would share
your thoughts, so that we can assist you best solution along with affordable
cost.

Awaiting Response,
Paige


_____________________________________________
From: Paige Hendrix [mailto:Paige.Hendrix@tradeshowsamerica.com] 
Sent: Tuesday, May 28, 2019 11:12 AM
To: 'linux-kernel@vger.kernel.org'
Subject: Attendees Data Base of AD&M 2019


Hi,
I am following up to check if you are interested in acquiring Atlantic
Design & Manufacturing Exhibition 2019
Let me know if you would like to acquire Attendees Data Base?

Attendees List:  Manufacturers, Key Decision Makers, Buyers, Potential
Customers, Distributors, Importers  And Many More...
Each record in the data base contains: - Contact Name, Job Title,
Company/Business Name, Email, Tel Number, Website/URL etc.
If you are interested, please let me know your thoughts, so that I can send
you the no of contacts available and the pricing for it.
Awaiting Your Reply
Thanks & Regards,
Paige Hendrix
Marketing Executive



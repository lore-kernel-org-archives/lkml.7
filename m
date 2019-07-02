Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B7AC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 19:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D05221850
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 19:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dynamicaims-com.20150623.gappssmtp.com header.i=@dynamicaims-com.20150623.gappssmtp.com header.b="MX/bHmM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfGBTmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 15:42:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45261 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfGBTmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 15:42:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id bi6so906478plb.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 12:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dynamicaims-com.20150623.gappssmtp.com; s=20150623;
        h=to:subject:from:message-id:disposition-notification-to:date
         :user-agent:mime-version:content-transfer-encoding;
        bh=2B7NK/ZEqFIYT6SQs8fSOhl27jBu1V5KUpehg7vVsAU=;
        b=MX/bHmM3CoOjxodOKY+uWhEjr9eYEpAeDbzn7rasK8uCAqXfBsGRav6GabsMD2W4ZI
         oNHmgwLHGeFx+8Y9ZBravshTUjpF1N2rXLCOm8gBpyRjZszmlkyFsSBSDaa/5VILYxKg
         +YyOh8vjuvWcElBcf3rdqqn7b6ayhUkAzrggAZYF9rKtreNEeVRcVBcD/XQR3amurav/
         IqLz9UbD1INPHIA8JNS+vvPTW0fJG+oOWlAxGsPcxfdfd30+ChQeL/xpbMJOtwgDaxJe
         RagO0owQHv8NkdxRiO0Qsaay76j38+nRev74UUsSuQo62eUzgWusgtGdN83wqcWb6Qey
         Wz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:subject:from:message-id
         :disposition-notification-to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=2B7NK/ZEqFIYT6SQs8fSOhl27jBu1V5KUpehg7vVsAU=;
        b=NPoEBgtxFgLyKVCdY6o8/Ss4D+/XRBncFg2M74EM7x0wzef91xzLCBqwF5YG0FtxDe
         CQ4LpaL10YBkWz7w26/Ngv3Y5u+LqMz/jOtA/ywMOuWzn/QomF8/nOVhojVBkVN8luY9
         fhZPSMJghx6tpXVnBeWlIjNTtVG8ENluoW6ZQcNZQ/9moK5KCzykN+v1jH97MmcTSTyt
         A2K0YXouCwEPjuuT2wkdRJg9JC7kPRrRMjfrBmVdRY/5iQqtt0kBNgcLdhphohmW9E1v
         AsJB9MncSGsLJoWC60Yg6nCTlQDckXzoO5zC1998cW5eqNVxTwvhUGN1+aj9jmmDUqut
         776g==
X-Gm-Message-State: APjAAAW+Str9aCeJM5sJ/AbH2MlexO9Bcl2UX9AYvjHtM+JXGKk4DvfM
        4CwO/7JWmsGcpao1sJqI29atZ3s2tq0=
X-Google-Smtp-Source: APXvYqyOXx74acJvtbxoMTWzL6w1lSd1Ew9MU5ITUj4OONU2japQWZOr3qcploMfNPmjx/GduBE8Hg==
X-Received: by 2002:a17:902:6a87:: with SMTP id n7mr21121333plk.336.1562096564487;
        Tue, 02 Jul 2019 12:42:44 -0700 (PDT)
Received: from [192.168.0.17] ([103.253.170.189])
        by smtp.gmail.com with ESMTPSA id r88sm2858515pjb.8.2019.07.02.12.42.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 12:42:44 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
Subject: Wine Enthusiasts
From:   Amanda Bagnola <abagnola@dynamicaims.com>
Message-ID: <5D1BA6EC.5000602@dynamicaims.com>
Date:   Tue, 2 Jul 2019 14:48:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.3; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Would you be interested in acquiring an email list of "Wine Enthusiasts" from USA?

We also have data for Golfers, Alcohol Enthusiasts, Beer Enthusiasts, Chocolate Enthusiasts, Foodies, Travelers, Gift Buyers, Spa and Resort Visitors, Sports Enthusiasts, Android Users and many more..

Each record in the list contains Contact Name (First, Middle and Last Name), Mailing Address, List type and Opt-in email address.

All the contacts are opt-in verified, 100% permission based and can be used for unlimited multi-channel marketing.

Please let me know your thoughts towards procuring the Beer Enthusiasts List.

Best Regards,
Amanda Bagnola
Research Analyst

We respect your privacy, if you do not wish to receive any further emails from our end, please reply with a subject “Leave Out”.


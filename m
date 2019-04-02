Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB5BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FDD2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dynamicaims-com.20150623.gappssmtp.com header.i=@dynamicaims-com.20150623.gappssmtp.com header.b="UNUL0Mxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfDBUr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:47:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36761 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfDBUry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:47:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85so7142489pgc.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 13:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dynamicaims-com.20150623.gappssmtp.com; s=20150623;
        h=to:subject:from:message-id:disposition-notification-to:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=BIh3edP5+CCsS6XVeUYlh7avDbLJsv+MDFjHAI4O3X0=;
        b=UNUL0Mxr0m13kIrvzqGJif7aRXho197gu9AxcpSvaW7RyChEudrzKyoFPdWO+l3Hol
         mBuKWb1EdLkr779G8Ob2oHO8fv9UXQHiIt1azjNI/jzJ2vTtJBlTSjE3JVlJMKp/hDUo
         qfPM6Xhm2DzWtaMgjPwUFiJeNIE8tUFa4ZrQk/9acnFYDH1y7x7Dz+P+7M+MUSomFzbK
         LWdvc527TdkHvlPidnLT3WjaCsfNwjiHeLo7t6jTB0KVvkz1jkZWyFrRLLYFOMF+VVPC
         VHpD+55Zh4YE2BUtijsSjglDGi+Juc82kq+FdeR4sGzrAdwsP2F8V+6iWbqkngcqcqCS
         JL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:subject:from:message-id
         :disposition-notification-to:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=BIh3edP5+CCsS6XVeUYlh7avDbLJsv+MDFjHAI4O3X0=;
        b=FLM5S9vJTvhB+CVmmyT9tO9wWRqQylXUjVCxNbOjDcFIrXiR1TPu3nwONFBLgYuGMO
         VvHbbs748MbvmsMmHnehwpMbeiMx1O2ooFN613+ZfhwATsdsjbPo0bAU/65R9aw6EfHD
         hJStbzGrTHBHxLyyrm8gw3rOLpqgr/fa2ZF0rBNWGluM5xL53ssLTlkCNElTP2szgtZ5
         GOj2i/d9LyzyUBlMck9YuNZ/U8uPEgpnyHtlBZVp8aM75HhT/4aI8AN1E6KRB9Sd6OSV
         tu26vfaOi9OO9gSdN22VeBqK7CSzyv7RH9JJP22B9ZdP7yZIWLtEHpDFJQ063uKja2WC
         txag==
X-Gm-Message-State: APjAAAVXwtai2x+IKJCdPjAgvSJjJZIrOK+OUjrDsrd28CeWIe2tNaz9
        v0BnLxEvuT7IF3kSnAnXWRa/6PKf7a8=
X-Google-Smtp-Source: APXvYqyzIAExyVud3gsKmlRWvHcROa2M5FNBWdLsPQnjY6z3P8uWwe7vjv9FzMRCBNtwx/Xe1BmOPA==
X-Received: by 2002:a62:62c3:: with SMTP id w186mr40151357pfb.73.1554238073309;
        Tue, 02 Apr 2019 13:47:53 -0700 (PDT)
Received: from [192.168.1.130] ([106.201.97.251])
        by smtp.gmail.com with ESMTPSA id e2sm25185753pfa.64.2019.04.02.13.47.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 13:47:52 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
Subject: Wine List
From:   Matthew Richards <mrichards@dynamicaims.com>
Message-ID: <1a07446e-2796-2555-d6f2-e100b2002775@dynamicaims.com>
Date:   Tue, 2 Apr 2019 16:21:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.3; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Antivirus: Avast (VPS 190402-2, 04/02/2019), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Greetings for the day!

Would you be interested in acquiring an email list of "Wine Enthusiasts" from USA?

We have contacts for Beer Enthusiasts List, Liquor Enthusiasts List, Beverage Enthusiasts List, Spa and Resort Visitors List, Entertainment Enthusiasts List, Time-Share Owners List  and many more....

Each record in the list contains Contact Name (First, Middle and Last Name), Mailing Address, List type and Opt-in email address.

All the contacts are opt-in verified, complete permission based and can be used for unlimited multi-channel marketing.

Please let me know your thoughts towards acquiring wine Enthusiasts List.

Best Regards,
Matthew Richards
Research Analyst



We respect your privacy, if you do not wish to receive any further emails from our end, please reply with a subject “Leave Out”.



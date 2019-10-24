Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78906CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEB621872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gpiccoli-net.20150623.gappssmtp.com header.i=@gpiccoli-net.20150623.gappssmtp.com header.b="bO9y3mtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439806AbfJXQVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:21:50 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35772 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436636AbfJXQVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:21:49 -0400
Received: by mail-qk1-f193.google.com with SMTP id w2so23964493qkf.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gpiccoli-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zDjVoc4ZhVmwhaww0oFV1qxxU2wg2VdQwVJ+LB7hTz8=;
        b=bO9y3mtSncl3ggY/zbkn4aU1GQdXGoY3V8DN6Bw7mEkPvqRaOL6WmhxyqlnS2lm4SM
         EoyyJ1ZFTxqoDMaqOYCzwoQvgwtNAAkR3sPuwwTp5d+c/YZuuT7wnxSIFtxqNwfO0WZe
         5O4Q5w787BqZNCMKl9DQS6NGbU7xQs/vI7/l55W9FOZydLEGhqCAjA3C2tmCqcLvsP+x
         OBLu8R4lAzj+kPekv8rOW0hPVAubU+drLJn2FdPlpiC7G/+FBMghU8iZ2EY3eVPwNXEJ
         ZT5BywJa+NmGIGBDGTnpG8CKZgwdCRhn3VtuvnHm/hE0JrTdlSpmLh8kOwzQ9PqNn3uR
         PRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zDjVoc4ZhVmwhaww0oFV1qxxU2wg2VdQwVJ+LB7hTz8=;
        b=PGsbTfukjK32QsK6zdL99h9FiNUbrDXgyAMFmITAjtZd3ugLBIXfuPTwkgrsAL2pYt
         0j9+TqArxzYh2iSDczLvE8T7VrfriVvvs2HPDYzOpiRNPOJQg5/Zy2M3veBSn0VKEmso
         4cEtECxfcAAtz9JORTDhPHQJ2CKy/K4BrtZ6wQ6OtMf92WIIWswt2a2v9J4ODFHy2W4f
         zLvowMJ7HazptwO1AHv1cr1S9GIY3VF0REOkuHKPWbfBiQi+OATX8ZafPLj8sEXRsN7y
         MLLjVRIOhv6PCB55WWmbF9H5vfwVPx7XnMXGxzZphYmWqRX2z7CJo0kKqxzeBMx5sseB
         XG2w==
X-Gm-Message-State: APjAAAXFgYxSmjsa8QFL2A63jSrUXsCCM2IvZJvzz3jf04RZ4W7647n8
        vEYYUqOIOLXJWkbckqvMBVBSkg==
X-Google-Smtp-Source: APXvYqwwua2CAIbu7qdfqVfNb5aMpXewx4UU7yC975m/HE2i9Upar/3/FvCx+v7mAVrRfrRG71aUKw==
X-Received: by 2002:ae9:e316:: with SMTP id v22mr14664340qkf.122.1571934108584;
        Thu, 24 Oct 2019 09:21:48 -0700 (PDT)
Received: from [192.168.1.10] ([179.98.77.119])
        by smtp.gmail.com with ESMTPSA id c8sm12137843qko.102.2019.10.24.09.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 09:21:47 -0700 (PDT)
Subject: Re: [PATCH] hugetlb: Add nohugepages parameter to prevent hugepages
 creation
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>,
        Guilherme Piccoli <gpiccoli@canonical.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
References: <CAHD1Q_ynd6f2Jc54k1D9JjmtD6tGhkDcAHRzd5nZt5LUdQTvaw@mail.gmail.com>
 <4641B95A-6DD8-4E8A-AD53-06E7B72D956C@lca.pw>
 <CAHD1Q_x+m0ZT_xfLV3j6ma3Cc88fk9KnoS4yytS=PHBvJN7nnQ@mail.gmail.com>
 <20191015121803.GB24932@dhcp22.suse.cz>
 <b6617b4b-bcab-3b40-7d46-46a5d9682856@gpiccoli.net>
 <20191015140508.GJ317@dhcp22.suse.cz>
 <2d593c95-3c69-8f50-17ff-223bd607caf1@gpiccoli.net>
 <2df9c30d-b1e0-648e-93ba-85c78fbcbd0e@oracle.com>
From:   "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Message-ID: <2263e218-da8e-bc9a-0f4c-5697568b1bea@gpiccoli.net>
Date:   Thu, 24 Oct 2019 13:21:44 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2df9c30d-b1e0-648e-93ba-85c78fbcbd0e@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/19 3:29 PM, Mike Kravetz wrote:
> On 10/15/19 7:09 AM, Guilherme G. Piccoli wrote:
> Please do let us know if this can be done in tooling.
> 
> I am not opposed to the approach taken in your v2 patch as it essentially
> uses the hugepages_supported() functionality that exists today.  However,
> it seems that other distros have ways around this issue.  As such, I would
> prefer if the issue was addressed in the tooling.
> 

Thanks a lot Mike! I'll work on this and let you know if I were able to 
prevent hugepages from the tooling.

Cheers,


Guilherme

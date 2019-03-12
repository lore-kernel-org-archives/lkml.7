Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BC9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F34821734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="nL6edNcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfCLHu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:50:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42414 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfCLHuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:50:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id l16so1379581ljc.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 00:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lnU9zKsisr81L2NGsir7iwTiY7wAfYbdURDx3qKzauM=;
        b=nL6edNcNdoLIeojmaL/OM9EpeyX06cb85+Zai/WGk7pN5xbExTz8DBEC4qcD+PxPsY
         iQroLrHJgO+/n9Odj/+DZXN/4m2MOSHpzwmA9Fz7Etxsz9x+JqmgedeW60WDU2vO4pOB
         n36+O8p+H5a0//3/BQTz+w9ZGYUHQCFxva/9XIbKFNECgloDTcF0S+qJa1bOOk41cZg2
         96w99cMrdd1mBSJ09kBkzv7dHKKd5jLljB0nT2Kc6d/YSH15y2GXzUI4ApOTfh6mUe7T
         7szdrPl6HmloFIs3bW+hvy2tpZ1w5wlZc+1S8vM24kZggZzlp+sKogkGZw2GncgCpesJ
         XKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lnU9zKsisr81L2NGsir7iwTiY7wAfYbdURDx3qKzauM=;
        b=Rz6GHRmRYYM/Jua9wwmZzNFdvQot/D84sKqerqWCv7f6b7zxHd0DXUzpR5A9oFLrC1
         OAKA6RzpB39q49PFYo4glfvu036NaP0TFX+ZO4+QCdjOcnthawgmN0INxjVPpQmKsNve
         jOwnWpiDIsragHxgaNB+wJCS1UAKxixQ1sRtyeYJmhKmQBFbIFbzTFr33eqtf4GSkYL7
         XixULgB/LTKsymLX9rfMUu4LmCryE3LyUsKx/pek2P7fQxEhy/qoTPHL6TUJMb4MuxF6
         Tv/2dzomgM1czF9x0xMLIIF58trLW9l6Lg/6cn5Cm+p8xyB6Zqb+4qJhSTiLQd7LldbS
         +tjg==
X-Gm-Message-State: APjAAAXaXh1ef9HO9Z7HA6kulu4CgefK2FPQqI23FyoKgIBUduhMGpJu
        NPqEE7UwRyDC/i6MAI4BoVb3chCzCOM=
X-Google-Smtp-Source: APXvYqwYgMBQkzIv9vO4GqoxstFKMlnUb6zgA+ZOseQrfbG2FvFYQnINNGLseiE6MT2qWQvSCkcXpg==
X-Received: by 2002:a2e:408:: with SMTP id 8mr18986228lje.15.1552377052445;
        Tue, 12 Mar 2019 00:50:52 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.87.174])
        by smtp.gmail.com with ESMTPSA id u26sm1445142lfi.41.2019.03.12.00.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 00:50:51 -0700 (PDT)
Subject: Re: [PATCH v3] net: sh_eth: fix a missing check of of_get_phy_mode
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, "David S. Miller" <davem@davemloft.net>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <902bc3a0-94b5-cf00-6b41-f2724744fbe6@cogentembedded.com>
 <20190312074319.31161-1-kjlu@umn.edu>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <698b8971-75dc-e7a1-0d05-1a095e3fd34f@cogentembedded.com>
Date:   Tue, 12 Mar 2019 10:50:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190312074319.31161-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.2019 10:43, Kangjie Lu wrote:

> of_get_phy_mode may fail and return a negative error code;
> the fix checks the return value of of_get_phy_mode and
> returns NULL of it fails.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Fixes: b356e978e92f ("sh_eth: add device tree support")
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---

    It's a good practice to describe the changes between the patch versions here.

[...]

MBR, Sergei

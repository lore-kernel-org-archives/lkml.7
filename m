Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42DFC31E4D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1B22080A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QlGjKHJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387996AbfFMPiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:38:03 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:44594 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbfFMKKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:10:12 -0400
Received: by mail-qk1-f178.google.com with SMTP id p144so191492qke.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 03:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G+/m82mqxjd9gIpNfnWmM7e/plUww26lxwM8xYns8rs=;
        b=QlGjKHJz2GJTVK6mzm0yFP2cbnl7i+MZ4Xec/pPRbnT9GCY6XuiRDaX+gJ5XWSrcuU
         r/Hu1CyptYg6U9chTIjTCEE0D6UwpwwgZagYGIgc5djxOj9xXYoHCrDf0udxdDjrS7Xk
         o9TstvnafPjdhuXreF+benUANGH5H3n3o4tVV3PBfqEIeRdXcfFNr+36VTffGZfROpgf
         6H2gMVnOm7dyOt8j3Wg1ifrmysZdpT7crM3Um8X550quH4lDKsbf3luMiOFKb3Jmb1Fz
         T9ZqlBtKxJMGeL2M0+rmyVSP/XHiKPU/JuE8UKotyfuIvvuIn2iKjA2v6zuY2+4Fpciz
         jxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G+/m82mqxjd9gIpNfnWmM7e/plUww26lxwM8xYns8rs=;
        b=eOBq9TfUHbnBs/s0uif9/TAFxRik0/sDKEwA0KqzayFPszbe9BvsFMWeNlNaie3K71
         Kvn76WxNJ4x2JXK8vj8XgkLmR1TC1ERrk0YZKs8OCN7GfJsRgjO6JF6eKZNM/jOHArAV
         /2+daE4sABg2xf4vPR9ntFaaNkv5VmmI2LL3KCCHnRV0hQFkSa6FdeNp6H/0Nb6wYcbY
         ArDQ30mTQrF5Cxj2MfqN9NP4nmqFFFG6H//ptV597n1/OMcKrk1ZUcM47HrjUEHTHa9O
         zdT+u9SOBo60FfYX/2E2Vdkkdidi9EccvIxwzQlCKQb8t0A4PD2r/dxdzMUomYGKOhVZ
         ImZA==
X-Gm-Message-State: APjAAAWzm4zPVNirKHpeh2gGsdhn9TqsluMQ3tf17yFkosVN5WvTMME3
        G/YPQVi8/7DJHoG3D2/UV9VR2Q==
X-Google-Smtp-Source: APXvYqxIbHOzxEYwBro5PMImc2reA5unpanKIDqO46BvGxrEx2OSDXZil6QC+n4Uhb/HMkmgHAcJlw==
X-Received: by 2002:ae9:e306:: with SMTP id v6mr70280179qkf.145.1560420611302;
        Thu, 13 Jun 2019 03:10:11 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id u125sm1190373qkd.5.2019.06.13.03.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 03:10:10 -0700 (PDT)
Date:   Thu, 13 Jun 2019 18:10:04 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] coresight: potential uninitialized variable in probe()
Message-ID: <20190613101004.GB5242@leoy-ThinkPad-X240s>
References: <20190613065815.GF16334@mwanda>
 <20190613074922.GB21113@leoy-ThinkPad-X240s>
 <20190613081419.GG1893@kadam>
 <20190613095637.GA5242@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613095637.GA5242@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 05:56:37PM +0800, Leo Yan wrote:

[...]

> > In my experience it's better to initialize the return as late as
> > possible so that you get static checker warnings when you forget to set
> > the error code.
> 
> Just want to check one thing, which static checker you are using?

Okay, I think it's smatch :)

Thanks,
Leo Yan

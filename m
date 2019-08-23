Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ECAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D3E22CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XN0lurOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395116AbfHWM72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:59:28 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33190 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393400AbfHWM72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:59:28 -0400
Received: by mail-io1-f67.google.com with SMTP id z3so19904351iog.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 05:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DnAs7nFCuaLO5vNRp2s9zp3poLpxa7urFlzYqE5ngiA=;
        b=XN0lurOhtrkg36L2GKpPmfwcg84uyeTErti9SvwVgj4iarL8w4lhLLcfRPV4+pNjY9
         Iysq32EmrKX0UgEfiRaxEmCQdvwBttlwFVUK4OFyTbtzI8oaW6tmR423cXRlWgBke1WZ
         eEX3LdbycRD6/jLFjQ6YAv+YAlQcgbtlml3mNswVGBWsloV9t781MT46I3t0jPu5oUIL
         9f6NBbUcLuCTtNVjYQuQYoxYjva1XkkOnVmHtHLqxKgzNaOpqLstK8c2ufEPiYp9rXSb
         PAcnc60JMGOjj7EX+885raJADrCHUtp4TzEVyNrf3bnXEe6Zk+sHeRmqLHgyfshk5rXV
         AVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DnAs7nFCuaLO5vNRp2s9zp3poLpxa7urFlzYqE5ngiA=;
        b=osXUaJG6otcNq0n5z/UrEeAlGFkYIxuKX04buJk+SRkIH8L/LkxSPGDgq7w7VMHjln
         CskFG6UVuQPbaqZExBog9wbiNoytCoebfg0PrkACfXRUCFEzaWXUYm7Jzj9RGUF8gt1m
         gQm0CiBVW6W7jQFVrRUaulSVrvSwYEcOmb8KuTClHQJRDIwdu8DGFkno7NtPIXAee2se
         XerDqOQHMBhVWErbP2Uww4ma7UGKpPBCiDyk5GvnkG4wSLvmHdRkfnwsis144sYlZ5GO
         YwvYahDf9yoeqrpQRF9fyl34W7NDbvK1xTldMORjVbkLAONSkyGtzU1MrjdAsk49o94P
         nTGQ==
X-Gm-Message-State: APjAAAUhs8CvV383IHV9mDZy9Zv2fzHT6BKrkBkYU1eSlVyW/h8nRAkj
        /pKwWE6oxWYW9cSEeWDvcBT93SzmzXkeag==
X-Google-Smtp-Source: APXvYqy17/d6MTFbBNYw/eobqwz9FFA2Omm4QpHzDJfN7FQvbrvR5+tA2fJweHfKHlis0EsHyfoIGg==
X-Received: by 2002:a6b:7807:: with SMTP id j7mr6789350iom.224.1566565167620;
        Fri, 23 Aug 2019 05:59:27 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v12sm2372300ios.16.2019.08.23.05.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 05:59:26 -0700 (PDT)
Subject: Re: [PATCH v7] ata/pata_buddha: Probe via modalias instead of
 initcall
To:     Max Staudt <max@enpas.org>, b.zolnierkie@samsung.com
Cc:     linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        schmitzmic@gmail.com, geert@linux-m68k.org
References: <20190823104911.6840-1-max@enpas.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <875526ec-e514-362a-8730-6424bd10b517@kernel.dk>
Date:   Fri, 23 Aug 2019 06:59:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823104911.6840-1-max@enpas.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/19 4:49 AM, Max Staudt wrote:
> Up until now, the pata_buddha driver would only check for cards on
> initcall time. Now, the kernel will call its probe function as soon
> as a compatible card is detected.

Applied for 5.4, thanks everyone.

-- 
Jens Axboe


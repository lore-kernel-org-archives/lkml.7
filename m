Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7ADC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C02214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wcbRtEO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfHSTCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:02:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37644 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHSTCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:02:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id 129so1711529pfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 12:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q4rnD2AOpR/95lDbnfWSHnN+HAD3xqLotj0pdJ8MO+M=;
        b=wcbRtEO1DusCAM1DvYyK7yjIacFwB4c4UdScyq0KyWRqUoBbeE5BKNXkLGisv9kBee
         p/OgJnoyojBTfv/j/fpknTzK56CUwtudc2AD1rnCkbjh7sSqFDdf3BhuMZxSbwcT71TY
         VvwOANzgfrA5q1DYG23XtR9vcMeohomgM4S5VNhkBEMhuXlftWBkoOEvo4BJUTXoXUD7
         DW3e8p9TzLJ3Pa7Lg571PN81Iqj5sm8iVdxDhfhQnpdUOhjTBaPASWSeuSchn9vpxt7H
         nku1L7mOF/WO5sATX0KzvAg+GE0YDjfFsUd7z/aL5VHUfrYpjsVMp+aNf3Rm+dyC5Zbv
         DLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q4rnD2AOpR/95lDbnfWSHnN+HAD3xqLotj0pdJ8MO+M=;
        b=hCqINNVFP95crE3v9GHo3T8e9QtOmDm9QSDfs2IZjDo4wfqUaRpVkdyGlft7Xk2MQN
         2OrjXkbIqEs05aQ/3oUimWkMysAPLeASenWZNEd2QZGV5JJ878MLz2yOa3t/4J4wFLcf
         wbgaVkpMu66N/jXCGwwKHZt5YmF7Rqqk+bfmAW2xD2rp2BEfHL7gzcSmu8zLwZ+6lI0Z
         pUrJdHBe/RmVe1q2ZXt6tPfgv0iW9Z1rE6EWbq57DeeGRTHCjm7NndsATBUYrbdtr0aY
         OKCgaqS7/MT+3E54rmkenPvaiel+WnKAW911GnAGTEXtVdV3SO99atrafaZbA3NwV4+A
         6HBQ==
X-Gm-Message-State: APjAAAXsBzFuXTNKaMVFwWrYuFfrSLeay3LgQGKznkEahnRJU04k8AHJ
        AHKHCiKGio3VjJAbtHO2dO8XfA==
X-Google-Smtp-Source: APXvYqxH8yWDCow6bOeY76BOUcDqXc0DwsAsYiHabmcjP4BE1AURGMn4k5/tw7ig0wz77cTgZzRVCg==
X-Received: by 2002:aa7:9298:: with SMTP id j24mr24981971pfa.58.1566241331348;
        Mon, 19 Aug 2019 12:02:11 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1133::103e? ([2620:10d:c090:180::3970])
        by smtp.gmail.com with ESMTPSA id s67sm15532333pjb.8.2019.08.19.12.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 12:02:10 -0700 (PDT)
Subject: Re: [PATCH v3] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
To:     Sagi Grimberg <sagi@grimberg.me>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ryan Hong <Ryan.Hong@Dell.com>, Crag Wang <Crag.Wang@dell.com>,
        sjg@google.com, Charles Hyde <charles.hyde@dellteam.com>,
        Jared Dominguez <jared.dominguez@dell.com>
References: <1565986579-10466-1-git-send-email-mario.limonciello@dell.com>
 <b4456ee7-6f5d-5968-2167-9900f049e5c6@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3d01da80-be78-5ca6-6ef2-c0e44840118f@kernel.dk>
Date:   Mon, 19 Aug 2019 13:02:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b4456ee7-6f5d-5968-2167-9900f049e5c6@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/19 12:57 PM, Sagi Grimberg wrote:
> 
> 
> On 8/16/19 1:16 PM, Mario Limonciello wrote:
>> One of the components in LiteON CL1 device has limitations that
>> can be encountered based upon boundary race conditions using the
>> nvme bus specific suspend to idle flow.
>>
>> When this situation occurs the drive doesn't resume properly from
>> suspend-to-idle.
>>
>> LiteON has confirmed this problem and fixed in the next firmware
>> version.  As this firmware is already in the field, avoid running
>> nvme specific suspend to idle flow.
>>
>> Fixes: d916b1be94b6 ("nvme-pci: use host managed power state for suspend")
>> Link: http://lists.infradead.org/pipermail/linux-nvme/2019-July/thread.html
>> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
>> Signed-off-by: Charles Hyde <charles.hyde@dellteam.com>
>> ---
> 
> Jens, can you please rebase for-linus so we have the needed dependency:
> 4eaefe8c621c6195c91044396ed8060c179f7aae

I just did as part of adding a new patch, being pushed out shortly.

-- 
Jens Axboe


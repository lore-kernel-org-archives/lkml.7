Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CC6C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DAF22CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfHSVXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 17:23:06 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:35756 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbfHSVXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 17:23:05 -0400
Received: by mail-ot1-f50.google.com with SMTP id g17so3066482otl.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 14:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mhcxS9SHhvc2vuS8TVLaSTM7jzu2HtphXaxiYUBsdyg=;
        b=pqdREpQpx3EzYRkrAH2c3ZJ05V6wGg23X2PGZg1kQ23qEh33/H9X8QMEYlOnGBROjj
         3ynQiWTcq63rv+mouQA0MKYkr0WGjYqmGiLySQhK2CguP5eMyZ7VSgDEJFHYi8ugqHUv
         ohbrbtpluei8CVNloMg5X83+reF7IopM2fzQsMGr+5HMg9D/sfjRv9kkJ6iQoAZoyApS
         aggOmo/TJY2NWLF/oe3Imy4MORS7E8vOOAi9zQqcfU5aJaOm8oNkDZf8fMLVZkkGIixu
         eViyqpbJB1cL+gThcjESuFJkaovSZpGYaYkp+HBtgPpHcQau3/l4dR+sEyd7FWfrM9QQ
         UK/g==
X-Gm-Message-State: APjAAAXpXhYE+k386YCSHkIBhJfx0azCAgCm5yylCUUEF28m0W9ufE4m
        /bJa4bKAwgcRr7/m2YxBaT7KlDOT
X-Google-Smtp-Source: APXvYqzBKAayT/AnSwfPcGrUj38b/YdUfoh8g9XVswN8WmxHkMDL8mxXrwAPr87NNqXWxAjsYdzcwA==
X-Received: by 2002:a9d:741a:: with SMTP id n26mr10656928otk.198.1566249784877;
        Mon, 19 Aug 2019 14:23:04 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id q24sm5911029otl.31.2019.08.19.14.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 14:23:04 -0700 (PDT)
Subject: Re: [PATCH v3] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
To:     Jens Axboe <axboe@kernel.dk>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Keith Busch <kbusch@kernel.org>
Cc:     Crag Wang <Crag.Wang@dell.com>, sjg@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, Ryan Hong <Ryan.Hong@Dell.com>,
        Jared Dominguez <jared.dominguez@dell.com>,
        Charles Hyde <charles.hyde@dellteam.com>,
        Christoph Hellwig <hch@lst.de>
References: <1565986579-10466-1-git-send-email-mario.limonciello@dell.com>
 <b4456ee7-6f5d-5968-2167-9900f049e5c6@grimberg.me>
 <3d01da80-be78-5ca6-6ef2-c0e44840118f@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <064c6b07-be80-1147-5a16-9a455db988fe@grimberg.me>
Date:   Mon, 19 Aug 2019 14:23:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3d01da80-be78-5ca6-6ef2-c0e44840118f@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Jens, can you please rebase for-linus so we have the needed dependency:
>> 4eaefe8c621c6195c91044396ed8060c179f7aae
> 
> I just did as part of adding a new patch, being pushed out shortly.

Thanks

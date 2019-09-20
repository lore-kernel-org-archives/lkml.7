Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D3CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 17:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E4F2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 17:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfITRQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 13:16:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53313 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfITRQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 13:16:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id i16so3310791wmd.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 10:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YR0zbmZklabsj9m40RWWGNVwYGCuiC00vlKIfOS7/Yg=;
        b=Cofpjj4FjZqIe5WaCgSs/sL0JdLCQoP1XYoyCKBe+QlDg4bxrf7+mZCydVKzOjqK30
         AN6zrVv04u711mCkPFN0clBAEUCZ2W7+lQAiKX24GXyljdf8yArsJwUFvOTPwsbLcm6r
         eD2sgxeylgHAD9SKn5+3XEBiyQi4pKYLtJCQ5Zoga6OzUhCf1BMZcLX4CFde4nOAgWru
         IxrPwMT/fddv84Kif0FZtaG0olWJdjSZuAePZISvUf+uckMzodE4r4msM+osiZfJGXSb
         GobKxWL7fHRrPk6ZRy8EaLd34G9sdgPL/lpQSWHB8kGfGvLDU6+Lxg1+Q1J3eNtbOpU3
         J8Sw==
X-Gm-Message-State: APjAAAUq7J62X+OqxdS/pw1hUgtVIsTmBVzxZZzX+C+ZxOwjRRN7v1Ir
        pvxrkCMkVqc/Ptt2tY610Cw=
X-Google-Smtp-Source: APXvYqwfAHY19VaoaQAnHnGDPRz5ft1lXcuguBb35DPLUuKeg8GEac2U2iHOsXrH9BA5Vu3rISUzoA==
X-Received: by 2002:a1c:a851:: with SMTP id r78mr4221372wme.166.1568999764570;
        Fri, 20 Sep 2019 10:16:04 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id t203sm3366541wmf.42.2019.09.20.10.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 10:16:03 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-pci: Save PCI state before putting drive into
 deepest state
To:     Mario Limonciello <mario.limonciello@dell.com>,
        Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ryan Hong <Ryan.Hong@Dell.com>, Crag Wang <Crag.Wang@dell.com>,
        sjg@google.com, Jared Dominguez <jared.dominguez@dell.com>
References: <1568830555-11531-1-git-send-email-mario.limonciello@dell.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <90d1915d-a8e7-5a48-6f00-62060988de4a@grimberg.me>
Date:   Fri, 20 Sep 2019 10:16:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568830555-11531-1-git-send-email-mario.limonciello@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keith, can we get a review from you for this?

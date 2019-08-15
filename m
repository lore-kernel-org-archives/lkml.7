Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D2EC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F9C2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbfHORTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:19:09 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46296 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731134AbfHORTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:19:09 -0400
Received: by mail-oi1-f194.google.com with SMTP id t24so2741011oij.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q57CbEezHwaz+ruo0Zds0qNhqBgg8E8BpKrwrd/odqY=;
        b=AltNo9BZZj7G+Vyg74jgB7cmxsjytAmmFuBRKnSUiu2I2zlRDUDAJ87i03cRx2Pun7
         rG1bIqCLtXvKuEzIa8YLmGEWIXYYPn4RMq0VLqr8ncQZLW6qTXu4D2aq2NvPSd8IM1FW
         mS6y5Zt944ALkQsvv1yn6XXaodrKDPdEWyZ+MXhvyW+l+TvWZCYgsK/h4OvcuJdgxjpe
         rrcRLjgsqaz6WIfWKl4zCQ+OzJzpC8HU3R+NaJzZ7FzeUZRul2jcQAmRZCiShTD4Ofjb
         0/GTzXiKawO1ht1R43EEy/DscQ4WPHfftHAT/mxaQypSXz43fQsQqZbvhj9jQYGr3QZr
         4XQQ==
X-Gm-Message-State: APjAAAUcpWZlD6IfCoVBKSs+3R37/q4JoCfIIeJVJs4FniTMPAQy8Qaa
        J5fV9GK3Zr70hPQkO13kKjM=
X-Google-Smtp-Source: APXvYqzhcy7Iuwhfr0kqvlxMGNPiAIGusoibvIvXEYeU0fjFFc68uuXB3h+Pa0DQkgvBY2qvjT/+Ow==
X-Received: by 2002:a05:6808:643:: with SMTP id z3mr2130261oih.101.1565889548604;
        Thu, 15 Aug 2019 10:19:08 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 12sm1130310otn.23.2019.08.15.10.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 10:19:07 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
To:     Keith Busch <kbusch@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ryan Hong <Ryan.Hong@Dell.com>, Crag Wang <Crag.Wang@dell.com>,
        "sjg@google.com" <sjg@google.com>,
        Charles Hyde <charles.hyde@dellteam.com>,
        Jared Dominguez <jared.dominguez@dell.com>
References: <1565813304-16710-1-git-send-email-mario.limonciello@dell.com>
 <32f20898-b9af-eee0-97de-0a568de54b57@grimberg.me>
 <20190814201900.GA3511@localhost.localdomain>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0cafca37-011d-4c19-4462-14687046a153@grimberg.me>
Date:   Thu, 15 Aug 2019 10:19:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814201900.GA3511@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Mario,
>>
>> Can you please respin a patch that applies cleanly on nvme-5.4?
> 
> This fixes a regression we introduced in 5.3, so it should go in
> 5.3-rc. For this to apply cleanly, though, we'll need to resync to Linus'
> tree to get Rafael's PCIe ASPM check after he sends his linux-pm pull
> request.

We need to coordinate with Jens, don't think its a good idea if I'll
just randomly get stuff from linus' tree and send an rc pull request.

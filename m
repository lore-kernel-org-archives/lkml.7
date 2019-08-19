Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B4DC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1048322CE8
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfHSS57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:57:59 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39912 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfHSS56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:57:58 -0400
Received: by mail-oi1-f195.google.com with SMTP id 16so2136803oiq.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 11:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=epBwfbywhqGj6/Txp0wEnIqhhkUDSBU1c4DDd4zaWhE=;
        b=frf2svS7pAimA9d8RKidjSmAfFxOUGTfvykdQO0nNMav9l6otcXJAisPd+mb9Aka/L
         oKL5N+Tt57Z+Ppix5jJmL9bh/ZjWzDX2oEEgMz5J/sYYW+5XXOLj89yRx1tmBIP5+6a3
         xdXYMbczluornGzDdH+6/A1RN/V+LRecVmjnjGHKQnIz1Mv6k+4AOevYo73abKOpz8g0
         BocBXyyA6qk8/5ZrsU8alBL6yTR86fit3s1ArzKF+Mlyw4PnFM9RW6dYBexjLWtKHJS3
         F/cp5spYOB6EdqYxv/VG5t3bnIudi49UlnCV0hVqhH+HCrEwjzdauUT3JiXJnVMGNtFp
         wyqQ==
X-Gm-Message-State: APjAAAVyn8nXGjOEglGB5SUvmkeELQmkAOqOEmKKucUFSzJqx2VnWQ6h
        hEtQn92a3NwgWhhbTNUwwTU=
X-Google-Smtp-Source: APXvYqyPxFwJuZH9ewhvaT43uWW7EVT9DpjXXfGo8Fo4ATfdTuU3+8Znf78pYmMPzOvs6K6TZUjYCA==
X-Received: by 2002:aca:4813:: with SMTP id v19mr1919384oia.17.1566241077612;
        Mon, 19 Aug 2019 11:57:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 98sm6073398oti.18.2019.08.19.11.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 11:57:56 -0700 (PDT)
Subject: Re: [PATCH v3] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
To:     Mario Limonciello <mario.limonciello@dell.com>,
        Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ryan Hong <Ryan.Hong@Dell.com>, Crag Wang <Crag.Wang@dell.com>,
        sjg@google.com, Charles Hyde <charles.hyde@dellteam.com>,
        Jared Dominguez <jared.dominguez@dell.com>
References: <1565986579-10466-1-git-send-email-mario.limonciello@dell.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b4456ee7-6f5d-5968-2167-9900f049e5c6@grimberg.me>
Date:   Mon, 19 Aug 2019 11:57:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565986579-10466-1-git-send-email-mario.limonciello@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/19 1:16 PM, Mario Limonciello wrote:
> One of the components in LiteON CL1 device has limitations that
> can be encountered based upon boundary race conditions using the
> nvme bus specific suspend to idle flow.
> 
> When this situation occurs the drive doesn't resume properly from
> suspend-to-idle.
> 
> LiteON has confirmed this problem and fixed in the next firmware
> version.  As this firmware is already in the field, avoid running
> nvme specific suspend to idle flow.
> 
> Fixes: d916b1be94b6 ("nvme-pci: use host managed power state for suspend")
> Link: http://lists.infradead.org/pipermail/linux-nvme/2019-July/thread.html
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> Signed-off-by: Charles Hyde <charles.hyde@dellteam.com>
> ---

Jens, can you please rebase for-linus so we have the needed dependency:
4eaefe8c621c6195c91044396ed8060c179f7aae

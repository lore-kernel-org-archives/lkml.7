Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB62C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356D821D56
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfIZP1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 11:27:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36275 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfIZP1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 11:27:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so2055901pfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 08:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qc1eT7uGpsF0iy1oLm7/WXrBC6ZEepJkU73RRHx5dH0=;
        b=efzXnksXXtL04eifVsoF+x6Sa1EZQNFtXW7XLp0B+660cIABXss7XhQ489SeTP//Ht
         GvkxfdSL92lbS391nHofJVLmqqlhSAdRQd2+UkcPI7zB9ave+ZeSoXKyMaEdy1SAG1qh
         bn62Fix4CqeFktc5QMRHrbi4QObege89OcNEAVE8dCRpjPg1bFRJASe2gQIaf8WHEWm1
         98A7XgIXFpobWEUe52wrwhtR/F6RwXpXx/2UdHO6+UDkA6iZEhUxC5LoAb/Te6LQK1TI
         kSx8pXJJvcp6tx/k5QDhiTlJF0UBXdb6T21PT3TNjtdd7mcmSzcZFhWcf+HJSpiDOjQP
         NJrw==
X-Gm-Message-State: APjAAAUl+9qRFbgjl+vSrzG46gpWu8FHrxa/MjUfoWeSCLviitJKpu6w
        xISF2aT78pbekio3PypoUi+r3ZL0SVE=
X-Google-Smtp-Source: APXvYqwGFGS4yGLwH4fuhh+5a6Avm0Pvov6zh/fM8C2sSarzJjXPxgSMdRhJzwplpiuLMxQxAzls7A==
X-Received: by 2002:a62:168e:: with SMTP id 136mr4318015pfw.144.1569511635448;
        Thu, 26 Sep 2019 08:27:15 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id x8sm2589409pgr.30.2019.09.26.08.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 08:27:14 -0700 (PDT)
Subject: Re: [PATCH] async: Using current_work() to implement
 current_is_async()
To:     Yunfeng Ye <yeyunfeng@huawei.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        bhelgaas@google.com, dsterba@suse.com,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        sakari.ailus@linux.intel.com
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <395617ec-ef92-c20f-d5c1-550b47a07f6d@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8336ea6a-bc98-bd45-b317-3fc8d5f1d9f8@acm.org>
Date:   Thu, 26 Sep 2019 08:27:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <395617ec-ef92-c20f-d5c1-550b47a07f6d@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/19 1:40 AM, Yunfeng Ye wrote:
> current_is_async() can be implemented using current_work(), it's better
> not to be aware of the workqueue's internal information.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

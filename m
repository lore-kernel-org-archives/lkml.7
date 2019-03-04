Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8774BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5583C2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJyW+KIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfCDSi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:38:28 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43728 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfCDSi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:38:27 -0500
Received: by mail-pg1-f196.google.com with SMTP id l11so3678057pgq.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 10:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xj8BgPrnfVZvKnhnS1GuA2yiFsYMoZDIJcW3TElT7k4=;
        b=XJyW+KIbJhwK1oK4eVmC0jvAtQncdJXBvmC705eNjpwQLB0i5jx3IAuo3WQUTt4KtU
         ct8kCwXGwA35cYzVuGX1vUbxFXYEGv5wX8vhWoOBvW1oGf3QhGk394coOWl1PNTPV8uE
         Hx/G26JAEWBZJp4spmNLo0MxtpjImPFBZXUylZsILI5NbH7JFlvtncNYkgiA4OeVdrVK
         Zizl0glNpgqTEcV8UKRJ2B3nF4KwazEgf7n3O+C26quZHupRPfNzVmP6qLlanzLp7W5y
         n6nrRxTtgjNUogaxyC1cDR7JvtRFJpqKZfmrbVxhSAxBjArCCb7nfbpxQG4R2+Zpr9A7
         3FGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xj8BgPrnfVZvKnhnS1GuA2yiFsYMoZDIJcW3TElT7k4=;
        b=Y41SO7dl/OXjbxRWtvURUFl5QpA9bOmBzl3Q9RwYFdYvQTn0GD69e+3qmgjCtnJdoU
         WbnrFaz0REaEksM3nmA757I8PzdSmXk9OkwprprUE8QKD/s4oziFC61gmXA8sYparY1I
         drPo2uONBbZ8ZE81IaGF3Pm3E+2HTTBCwfY2zQ4hguZWdzYYe17j7q+poRD/z6hofzMo
         9v/ZdRNzAR6VhK7bTQLR6AFzQUdu5rtd8M4Kjtyu759qFGuGE38qy43ZtBKUxNwdYN1Y
         COA+0EpF6RN20fVm/aFRa2y0NnRgqnEMD84gyoTiXXoDvV8FkMqD6RGs8vLcF2L3ox1b
         bJ9w==
X-Gm-Message-State: APjAAAVHCKIKkn0ejHqsINZtqLR10Dfw49XfQ+v7VUOSVfOrUOf2OTsu
        rl47r46Xicg4GwJGhnVTUow=
X-Google-Smtp-Source: APXvYqzv7t8p8shqXHtlwNykxQB+pHIdlm2pEmQQXk6b/icIDsfm6Qk35gabGFkhu8i1zJQfW7CVRA==
X-Received: by 2002:a63:d810:: with SMTP id b16mr19437381pgh.220.1551724706340;
        Mon, 04 Mar 2019 10:38:26 -0800 (PST)
Received: from [10.69.37.149] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id h184sm22550438pfc.78.2019.03.04.10.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 10:38:25 -0800 (PST)
Subject: Re: [LKP] [workqueue] 4d43d395fe:
 WARNING:at_kernel/workqueue.c:#__flush_work
To:     Sagi Grimberg <sagi@grimberg.me>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
References: <20190304134116.GF25100@shao2-debian>
 <d6c6c236-7546-b5a4-47bd-d64b8b37083c@i-love.sakura.ne.jp>
 <b247096b-9033-a06b-fd2b-2d0f8611eb97@grimberg.me>
From:   James Smart <jsmart2021@gmail.com>
Message-ID: <6b0a949b-4696-bb38-6c86-a8f5ff2e1513@gmail.com>
Date:   Mon, 4 Mar 2019 10:38:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <b247096b-9033-a06b-fd2b-2d0f8611eb97@grimberg.me>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/2019 10:21 AM, Sagi Grimberg wrote:
> 
>> Forwarding to NMVE people:
>>
>> kernel test robot found that
>> flush_work(&ctrl->async_event_work) is called from nvmet_ctrl_free()
>> without INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work)
>> after ctrl was allocated (probably initialized with 0).
>> Will you make sure that INIT_WORK() is always called?
> 
> I cannot reproduce this issue. When following the code I don't
> immediately see how this can happen.. Was there something special
> in this specific test run? Is it 100% reproduce-able?

I agree. INIT_WORK is setup as almost one of the first items for a new 
controller.  Smells more like a double-free or a corrupt ctrl struct 
from the transport.

-- james


Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F9EC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 14:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C1B20859
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 14:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JetIVnWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfEDOqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 10:46:18 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:38108 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfEDOqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 10:46:18 -0400
Received: by mail-pf1-f174.google.com with SMTP id 10so4399733pfo.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 07:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KrYVIWeGk7qBqvHA6rNpWrRvfMfUKIOhNsH2mOO6/68=;
        b=JetIVnWaTXyB//mCEeSIJqg/XiUq5os7ckZOxNTNuhuPCnmqn7i85NV+L/w2vJbGHZ
         FKbVB3Psw3OS3ZbsvvlYcfUIvqzr5FlNs7vAY9mW8JdJ6AzA/zIrti5jbymXgfD7hl6K
         3ukTb6WR7/Yhm2qOg3jEq4pwh5wVfFuvAHcqoOIoq5+V2qXaIiuX4j7CCfMAwVCeTaVs
         AgZDMlXoL/jVkfSYIaOdGdzbEXv8Klo+TQYNLsqhUhwGfiNpVBFQ5imjDlBc2l7O5+ab
         epL2mOK8EfRiHT4z3KZgQJuMZkepdQjEgojI/lKNcCDDXCTyrI9DSzmerKg3axOU7Ucp
         4uiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KrYVIWeGk7qBqvHA6rNpWrRvfMfUKIOhNsH2mOO6/68=;
        b=QoLebC0ultdj0MwXb8tXk6MVJbqD9HkeNVPUsvS9c+JfTmWMdz22edAsUgXy1YdM2F
         GgXfrRcAnQzGjXSnO2TSQyV5ua3BZ7Xt6WWlsJXO2xFVWV9TXyeN2CEJHTw+d3vZtWa/
         SqZcseKHD4epom+FAmemQZdmwArXZqvF5N5dNzqXdlijZc/47CC3iq/3HFxP0kwhnpWI
         oOU9da/xGEEIkk9NFJiGN7hqUf4Dab4sGGlr/CPqCJUIfCbsqn2BMxk0Xhf/tqwl8sLo
         KCPLQ9Hzk4J4aUDXCGAzpt+0lEphqjV5/iiJjD2HGAlKi2xgtyI+Il5Ry4rtD9AyfEtb
         Rozw==
X-Gm-Message-State: APjAAAVmJdCu8dA8waAtW0NIRSB3ojLO3Ynr7sqdNEvu4Wwzf2NAjENl
        ctpnKerekTeG1PjvGTbk2yk=
X-Google-Smtp-Source: APXvYqxtTCMwWTttLXS3cTFa/NK+hcUWeBfu7VKsqDyDRIGs+h2SsYsWYBXJAacMVk+eTEiXjvm+fQ==
X-Received: by 2002:aa7:8c84:: with SMTP id p4mr19791233pfd.164.1556981177245;
        Sat, 04 May 2019 07:46:17 -0700 (PDT)
Received: from [192.168.0.6] ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id p2sm668679pgd.63.2019.05.04.07.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 07:46:16 -0700 (PDT)
Subject: Re: [PATCH 3/4] nvme-pci: add device coredump support
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
 <1556787561-5113-4-git-send-email-akinobu.mita@gmail.com>
 <66a5d068-47b1-341f-988f-c890d7f01720@gmail.com>
 <CAC5umyjsAh7aZ8JEh8=QMXpNwRdnxxfdPBDwmuVKfafG+rT-PA@mail.gmail.com>
 <d0de1c5d-1168-086c-cc16-7d33fd307cd3@gmail.com>
Message-ID: <13a4ec6d-e586-3879-d883-33bdbf90f294@gmail.com>
Date:   Sat, 4 May 2019 23:46:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d0de1c5d-1168-086c-cc16-7d33fd307cd3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/19 11:38 PM, Minwoo Im wrote:
> On 5/4/19 11:26 PM, Akinobu Mita wrote:
>> 2019年5月4日(土) 19:04 Minwoo Im <minwoo.im.dev@gmail.com>:

>>>> +     { NVME_REG_INTMS,       "intms",        32 },
>>>> +     { NVME_REG_INTMC,       "intmc",        32 },
>>>> +     { NVME_REG_CC,          "cc",           32 },
>>>> +     { NVME_REG_CSTS,        "csts",         32 },
>>>> +     { NVME_REG_NSSR,        "nssr",         32 },
>>>> +     { NVME_REG_AQA,         "aqa",          32 },
>>>> +     { NVME_REG_ASQ,         "asq",          64 },
>>>> +     { NVME_REG_ACQ,         "acq",          64 },
>>>> +     { NVME_REG_CMBLOC,      "cmbloc",       32 },
>>>> +     { NVME_REG_CMBSZ,       "cmbsz",        32 },
>>>
>>> If it's going to support optional registers also, then we can have
>>> BP-related things (BPINFO, BPRSEL, BPMBL) here also.
>>
>> I'm going to change the register dump in binary format just like
>> 'nvme show-regs -o binary' does.  So we'll have registers from 00h to 
>> 4Fh.
>>
> 
> Got it.
> 
> And now I can see those two commands `nvme show-regs` and
> `nvme show-regs -o binary` have different results for the register
> range.  The binary output covers just 0x50 size, but it shows all the
> registers including BP-related things in normal && json format.
> 
> Anyway, I'll prepare a patch for nvme-cli to support binary output
> format to cover BP things also.
> 
> Thanks, for your reply.

My bad, I misunderstood what you have said above.  Please ignore
what I mentioned. BP things are located from 40h. to 4Fh.

Sorry for making noises here. ;)

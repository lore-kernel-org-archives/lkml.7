Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D3CC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEB6208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbfEMRQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:16:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50850 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729468AbfEMRQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:16:29 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hQEYt-0005pr-0n
        for linux-kernel@vger.kernel.org; Mon, 13 May 2019 17:16:27 +0000
Received: by mail-pg1-f198.google.com with SMTP id 123so3760038pgh.17
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2WuRwt1BUMyiCONirk08ch3xQZwKTcRL8gA1P1lbcVY=;
        b=GqbBcdFDlR6XL+Fwt21cd0sSgFWw5wgnwKgfBaMKiziFd0eEdQuYnYBx8QLI++VUWa
         DAFf44KEWh3wKxartiZCiB4RnXIsQRdQx0p92N3lxPOD3llT/XALQPoYpbFbhbtsfKp1
         EDhvxhY1/j4Vduim9dzAfearc8dAjC8a+ocVNDr/s0U5ATOe4I8B4dy2VYe0tDUoEo9S
         fQDefkB8Pz39Ym+f0xBROzO8B6JMAZI08qj5Dmvv9luwagzpz4z9EYA8ukSxhNCGmsqi
         zdu7K5F3jLAna/cWBk7OnK0kx3mqkIGqQ37fSWtNgUcS8Q0CoZ/uyVzG0LEK2rD5qvR0
         I01A==
X-Gm-Message-State: APjAAAXtxvyNUMECF6m5fCvxpQ7UfDGFsBrMy2XA+dDJwFN1Fcb1dLtr
        YZAJ7ylY6QnfuHu1If9C569YvF17Xnd73PqXL9fDeqHaF/VEmcVxh9hdADuJ2ihyATH7qZIfDXr
        KMnrPfCCpOUELi7nHctK224eQW+7JeCwi1Gj/RtDslg==
X-Received: by 2002:a17:902:a415:: with SMTP id p21mr18635793plq.286.1557767785687;
        Mon, 13 May 2019 10:16:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwMpzkZBKa20L76h9qBox5leOqsefklOh+TGG6aIlOpne804YEEwfQcwN3ICe6Tsy0hWCt7CA==
X-Received: by 2002:a17:902:a415:: with SMTP id p21mr18635760plq.286.1557767785478;
        Mon, 13 May 2019 10:16:25 -0700 (PDT)
Received: from 2001-b011-380f-14b9-a00c-6f16-94cc-5640.dynamic-ip6.hinet.net (2001-b011-380f-14b9-a00c-6f16-94cc-5640.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:a00c:6f16:94cc:5640])
        by smtp.gmail.com with ESMTPSA id k3sm6695967pfa.36.2019.05.13.10.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:16:24 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190513151652.GB15437@localhost.localdomain>
Date:   Tue, 14 May 2019 01:16:22 +0800
Cc:     Christoph Hellwig <hch@lst.de>, Mario.Limonciello@dell.com,
        keith.busch@intel.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9AE4A3E7-CDB8-4730-8B4E-43C93FC0C47F@canonical.com>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
 <20190513143754.GE15318@localhost.localdomain>
 <7ab8274ef1ce46fcae54a50abc76ae4a@AUSX13MPC105.AMER.DELL.COM>
 <20190513145708.GA25897@lst.de>
 <20190513151652.GB15437@localhost.localdomain>
To:     Keith Busch <kbusch@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 23:16, Keith Busch <kbusch@kernel.org> wrote:

> On Mon, May 13, 2019 at 04:57:08PM +0200, Christoph Hellwig wrote:
>> On Mon, May 13, 2019 at 02:54:49PM +0000, Mario.Limonciello@dell.com  
>> wrote:
>>> And NVME spec made it sound to me that while in a low power state it  
>>> shouldn't
>>> be available if the memory isn't available.
>>>
>>> NVME spec in 8.9:
>>>
>>> "Host software should request that the controller release the
>>> assigned ranges prior to a shutdown event, a Runtime D3 event, or any  
>>> other event
>>> that requires host software to reclaim the assigned ranges."
>>
>> The last part of the quoted text is the key - if the assigned range
>> is reclaimed, that is the memory is going to be used for something else,
>> we need to release the ranges.  But we do not release the ranges,
>> as we want to keep the memory in use so that we can quickly use it
>> again.
>
> Yes, this. As far as I know, the host memory range is still accessible in
> the idle suspend state. If there are states in which host memory is not
> accessible, a reference explaining the requirement will be most helpful.

Disabling HMB prior suspend makes my original patch work without memory  
barrier.

However, using the same trick on this patch still freezes the system during  
S2I.

Kai-Heng

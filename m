Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C87C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 14:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F2220859
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 14:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCT1/s8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfEDOiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 10:38:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34905 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfEDOiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 10:38:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id t87so3814976pfa.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 07:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dxXlXPIHOiLEpa62Dvte4CGqyLQwPemJ6HrBcCCpswo=;
        b=gCT1/s8nmlYKVhGuab7b1b/q6N5FcSvjRhXig3XmZHCMS+n2uaBpRMEPH5K5RrCOjn
         RygCg2uYp+K4ALI+AYOXKkDWOomFpPyPYbFD8zy8RZ/UdU3OSZJ9YqnmKqlopSxbF32V
         RdPUeOh5gk0vk+zeHFufWbmCRYHflgYv1TXe+5taBhD8bhY47hKoCFIV7t/LhgxSStGA
         l7rU8kS5NbygAivqyXzIXkIqV9WkOf+Euq7L7PpZKFfKs+NjYfunkOPqneqLiqGfHGhx
         JMER+4zr3cl41pBuwswV/cY7giVmo2Dtx9SplATZeqcFpDUBbb0lrBFi48rLUajmqOPs
         tcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dxXlXPIHOiLEpa62Dvte4CGqyLQwPemJ6HrBcCCpswo=;
        b=Uea+tk4+jvhgc+gAPcS5byx0uPDikVmaLjzU36XcXFTCRaaZAxNI5d09OAJMii7gy+
         g6f0qZ7HuU8xLXsBt/N6sk7IOIBB6UfbrZ4rGDmsp+Y6ztlQa8HtSS1LerSaNex5Dnwq
         jGSU45rMjOh95vAoyB8EpSe1L0vhk4eBuRzD/t6mpANPKa6gcPuZhHiROddAqwbsbpGk
         1kz2EzDJyYdhGGUxE6Ayy2p2he4BKeKN/RWut5YzORZz4dUHvhheeZ4z8vXKtm0MfCfG
         jgjw5bI1vHX2eeJUUeM1rxRbeSb8yKO8Z4wfPT5glWjdWrhecfuh/dIDXecfxuG8rzpG
         PpNQ==
X-Gm-Message-State: APjAAAVL1noLMoFYJev54U9qlLi5Ub7lATKjmRhaGV84b/T9v1lRCVy5
        J8bKuJeaiy/Kgh+bCvdiAzE=
X-Google-Smtp-Source: APXvYqztLpaOJbeitHdyXx91AXCQ7vkzoCZ5cNm3xDxC29DA7atORy+tKhl/hAnuUM7vOrR9Mg0M9Q==
X-Received: by 2002:aa7:8458:: with SMTP id r24mr19709400pfn.231.1556980703466;
        Sat, 04 May 2019 07:38:23 -0700 (PDT)
Received: from [192.168.0.6] ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id p7sm6957050pgk.10.2019.05.04.07.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 07:38:22 -0700 (PDT)
Subject: Re: [PATCH 3/4] nvme-pci: add device coredump support
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
From:   Minwoo Im <minwoo.im.dev@gmail.com>
Message-ID: <d0de1c5d-1168-086c-cc16-7d33fd307cd3@gmail.com>
Date:   Sat, 4 May 2019 23:38:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAC5umyjsAh7aZ8JEh8=QMXpNwRdnxxfdPBDwmuVKfafG+rT-PA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/19 11:26 PM, Akinobu Mita wrote:
> 2019年5月4日(土) 19:04 Minwoo Im <minwoo.im.dev@gmail.com>:
>>
>> Hi, Akinobu,
>>
>> Regardless to reply of the cover, few nits here.
>>
>> On 5/2/19 5:59 PM, Akinobu Mita wrote:
>>> +
>>> +static const struct nvme_reg nvme_regs[] = {
>>> +     { NVME_REG_CAP,         "cap",          64 },
>>> +     { NVME_REG_VS,          "version",      32 },
>>
>> Why don't we just go with "vs" instead of full name of it just like
>> the others.
> 
> I tried to imitate the output of 'nvme show-regs'.

Okay.

> 
>>> +     { NVME_REG_INTMS,       "intms",        32 },
>>> +     { NVME_REG_INTMC,       "intmc",        32 },
>>> +     { NVME_REG_CC,          "cc",           32 },
>>> +     { NVME_REG_CSTS,        "csts",         32 },
>>> +     { NVME_REG_NSSR,        "nssr",         32 },
>>> +     { NVME_REG_AQA,         "aqa",          32 },
>>> +     { NVME_REG_ASQ,         "asq",          64 },
>>> +     { NVME_REG_ACQ,         "acq",          64 },
>>> +     { NVME_REG_CMBLOC,      "cmbloc",       32 },
>>> +     { NVME_REG_CMBSZ,       "cmbsz",        32 },
>>
>> If it's going to support optional registers also, then we can have
>> BP-related things (BPINFO, BPRSEL, BPMBL) here also.
> 
> I'm going to change the register dump in binary format just like
> 'nvme show-regs -o binary' does.  So we'll have registers from 00h to 4Fh.
> 

Got it.

And now I can see those two commands `nvme show-regs` and
`nvme show-regs -o binary` have different results for the register
range.  The binary output covers just 0x50 size, but it shows all the
registers including BP-related things in normal && json format.

Anyway, I'll prepare a patch for nvme-cli to support binary output
format to cover BP things also.

Thanks, for your reply.

Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC5AC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9E420651
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZuIvppsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfHSP5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:57:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34291 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfHSP5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:57:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so1466168pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 08:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NZ5M6FokMFIl6JI1d5V5fOCvvX0MiNcfS0qCjnnVOk0=;
        b=ZuIvppsHpIc2FmTrE/8f5vFkKWid4CEuZ+VUrkFzsyLTuaCWlcgIVqG1RmzwRqd4sF
         rFOqmcZazBJFJSd1BtLd39wbrnIAjhhJRttSk4bVUqCMcHf4HnejkI1q092sb5FUQZvZ
         1jeZW3vpwmUoDHJsRTfKjRdpfWGxPDuC53XLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NZ5M6FokMFIl6JI1d5V5fOCvvX0MiNcfS0qCjnnVOk0=;
        b=fTJ0NDvDjn/Nf2RbgUEITG0lgdcUTDZ7ckQoU8IgDkLq0m+LC0GOCRClMM1nDIzWMY
         CN8oaPktSVPkSTWfrVT378XPm2XPyxKWs+Pj0BqjMFbSOUAgDBsQVmnnNSltjQ67kVWN
         xIZpQ4WcctonPu39tF8P510rTNn5APu9ByGVi1AEccyTe8GjD06VFLsfhgmzS8wBJHoK
         4xpZiDVuFOquO4huUkbsIrIQuusc8CnTV089/OYdTrNsyRaTqJnDihtKZUiUOkzBXDUG
         RpZieAmI0X40LLH0WmZOnIrCDJD87/afa7uwo3tY2EaRQRzg2gVBrna+Y+m9l6ideP5m
         CQQA==
X-Gm-Message-State: APjAAAXYCYrFolwtTv4roXV1a2HUWJxwmSL75FFPICvE3ev3XHMsDgGk
        Wsvgz3zp2Dr2lIVffbzN0AYrleXejgU=
X-Google-Smtp-Source: APXvYqxNizINK4C3KjWAcmkjymtlIgjrPfi8J5R4M62aV8ysZ95ZCN8P/z5UWObOueWFqscMvfQeow==
X-Received: by 2002:aa7:8488:: with SMTP id u8mr25314824pfn.229.1566230230189;
        Mon, 19 Aug 2019 08:57:10 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n128sm15695152pfn.46.2019.08.19.08.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 08:57:09 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: allow 64-bit results in passthru commands
To:     Keith Busch <kbusch@kernel.org>,
        Marta Rybczynska <mrybczyn@kalray.eu>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Samuel Jones <sjones@kalray.eu>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
References: <89520652.56920183.1565948841909.JavaMail.zimbra@kalray.eu>
 <20190816131606.GA26191@lst.de>
 <469829119.56970464.1566198383932.JavaMail.zimbra@kalray.eu>
 <20190819144922.GC6883@localhost.localdomain>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <54e7a40d-a06c-a777-7061-0503051cc6bf@broadcom.com>
Date:   Mon, 19 Aug 2019 08:57:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819144922.GC6883@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/2019 7:49 AM, Keith Busch wrote:
> On Mon, Aug 19, 2019 at 12:06:23AM -0700, Marta Rybczynska wrote:
>> ----- On 16 Aug, 2019, at 15:16, Christoph Hellwig hch@lst.de wrote:
>>> Sorry for not replying to the earlier version, and thanks for doing
>>> this work.
>>>
>>> I wonder if instead of using our own structure we'd just use
>>> a full nvme SQE for the input and CQE for that output.  Even if we
>>> reserve a few fields that means we are ready for any newly used
>>> field (at least until the SQE/CQE sizes are expanded..).
>> We could do that, nvme_command and nvme_completion are already UAPI.
>> On the other hand that would mean not filling out certain fields like
>> command_id. Can do an approach like this.
> Well, we need to pass user space addresses and lengths, which isn't
> captured in struct nvme_command.
>
This is going to be fun.  It's going to have to be a cooperative effort 
between app and transport. There will always need to be some parts of 
the SQE filled out by the transport like SGL, command type/subtype bits, 
as well as dealing with buffers as Keith states. Command ID is another 
of those fields.

-- james



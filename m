Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F018C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60096218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WXDwEgqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbfCUIhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:37:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39385 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbfCUIhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:37:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id h8so3735741pgp.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 01:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=5YkU6H7pmtZlHKyyjpbxiy/FU2TIk4TMbEmP2AFCvZI=;
        b=WXDwEgqT1/AukBJYjY33gGrZU3CrvV2gJr+UKYbABaFcNfWDLwZyoLvB5hfZFO0C/3
         irenOEQp3fMs6w7bjpJkQffKWXdp3d5KcAipQBWvZ7as8ZyDP4uiSIgVL1uUUfOfoMVo
         DbnqTolXxjX2UpsiluTEn6E4QfcW3+0y5GQR9RU7WhP7Z6VSOtehnBcqrNcD6kFRkfTX
         8gzoeFZ1Gzy59SXMdDAIM6V6q26NJOuHHmTOs1RHNWroRtNrFPqE7jYAQ6K7VXHk81Og
         8o3FY+9wZcPHzwo48KlDHqCMLxBJtIiQYtq9wV6+P9vwrJ1G1sEEcFh5Hf0ZGT6jETyI
         NBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=5YkU6H7pmtZlHKyyjpbxiy/FU2TIk4TMbEmP2AFCvZI=;
        b=Ihp3EI5XXp1t8DIrOTQCnF2S6i0Lcg8dg+pFmaqHtEuWKoQnn/AMJ7jFqldH/GRinZ
         iwsslDwrJ6tns6sQ0z8ytbHhm0MGDWoFdZWGetZ3gECCLj65m7wszhp78DdiHD4AOqNS
         toFkuMF0nH4l8kta1EUrKJfwz9NmeXuDWovK1sZa5x8zpH9waGp2kpTFIodRsA+mX6uX
         qZ8bGwu3H9aLJ2gtkL/f6KQSISojQnx/2JJ+CjzndRp4Jy3w1cDyeY9jWGHLS/mE7j/P
         EA49EFoUkTbvZuzJs1IGHfasMp7epyPWBoNaFOoYVHhk1KLh2a4VZ9WGacRbjAuEC2j7
         J+lg==
X-Gm-Message-State: APjAAAXOqv60crm3qaBNX1YOO/ZvKFqMg837cwAZn5GIVZtL7nJCrmo8
        tzQMsAIEaa+aHrMYcT0rMtx8LQ==
X-Google-Smtp-Source: APXvYqwF+3EP5nW5RH56OwiEmGNwsz815VOto4U9Exy3fO9Ch6KdIf7kcuOUa12OtOrckAmP4DlElg==
X-Received: by 2002:a63:1b1e:: with SMTP id b30mr2283560pgb.180.1553157434004;
        Thu, 21 Mar 2019 01:37:14 -0700 (PDT)
Received: from localhost (2001-b011-7001-1ed7-23f1-a55b-5e6a-d75e.dynamic-ip6.hinet.net. [2001:b011:7001:1ed7:23f1:a55b:5e6a:d75e])
        by smtp.gmail.com with ESMTPSA id t3sm4856804pgv.39.2019.03.21.01.37.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 01:37:12 -0700 (PDT)
Date:   Thu, 21 Mar 2019 01:37:12 -0700 (PDT)
X-Google-Original-Date: Wed, 20 Mar 2019 23:46:12 PDT (-0700)
Subject:     Re: [PATCH v4 1/2] sh: mm: make use of new memblocks_present() helper
In-Reply-To: <9ac29b0d-4c25-3f5c-3812-44b42332447d@deltatee.com>
CC:     robh@kernel.org, dalias@libc.org, ysato@users.sourceforge.jp,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        sbates@raithlin.com, Christoph Hellwig <hch@infradead.org>,
        dan.j.williams@intel.com, Christoph Hellwig <hch@lst.de>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     logang@deltatee.com
Message-ID: <mhng-79bcf945-38aa-4ca5-82d2-eaa5b1286175@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 10:43:09 PDT (-0700), logang@deltatee.com wrote:
>
>
> On 2019-03-19 8:54 p.m., Palmer Dabbelt wrote:
>> On Tue, 19 Mar 2019 10:56:52 PDT (-0700), logang@deltatee.com wrote:
>>> Hey Palmer,
>>>
>>> On 2019-01-23 12:56 p.m., Palmer Dabbelt wrote:
>>>>> @Palmer: if you can just look at taking the second patch, I'll resubmit
>>>>> the first one to the appropriate list.
>>>>
>>>> Works for me.  I'll queue the second patch into my staging branch, targeted for
>>>> the next merge window.
>>>
>>> It doesn't look like my sparesmem patch made it into v5.1-rc1. Did it
>>> fall through the cracks?
>>
>> It must have, sorry.  Is this what you're referring to?
>>
>>     https://patchwork.kernel.org/patch/10754911/
>
> Yes, though it conflicts with v5.1-rc1 due to some code reorganization.
>
> I've updated it and we will submit it later this week as part of a
> larger patch set which helps enable p2p on RISC-V.

Thanks!

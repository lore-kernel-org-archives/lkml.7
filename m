Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F10C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BED21920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk975P4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbfIRSRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 14:17:15 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40516 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbfIRSRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:17:15 -0400
Received: by mail-ot1-f67.google.com with SMTP id y39so703725ota.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 11:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k2oOr71X6Pjfs9SNiCU0JrFU1FSbjiKu2U5QbxU1Pa8=;
        b=fk975P4WEJwwIbRGuJqSyHCBWsyh0aLwiOhzexuxZNdGsSsBvRxHViEfJ1ZPMVCd9n
         ZRndqvK0/xymsQvUMmllwrbL/SGnZp4EEKYo2LViilu2CdPO5S3skS47Z7aBD40a9hB8
         wNdan7JRG4vjc1UhnZQbFMqkxcA2wA3GtErly7V2srWHXeOaXXEgnIF+qVGEPTQ6kB7h
         RP7znsT3QwMVBSQlR/VQ6CSN5rGNNX3BJVpTwGaaD6H4kqMlPB4RdEg2c14Vna/cJnPj
         MkVQbhjX/55Lx1Y75NleAWPjEdJbzjCbcFiW7gmzEeXeSaDpduJcMPSoI+1QbdiNicd/
         YQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k2oOr71X6Pjfs9SNiCU0JrFU1FSbjiKu2U5QbxU1Pa8=;
        b=Pb8gRPkiwC5uMrVayT8FoOp0znF3j0SQJZYcngv2k+LWlhb+1/elNPISMLv1gIEMY1
         yhCv1lzTRuWUg/r3QsZY/AkmNkU7PkUslPNGj8L/q2TL2sEAYLhs8Btqxf9hYJFJZTJL
         JnTauK3hnk1xz5OjCtnudKi9nBDGSLPJY0BrhgHiRHCm68BnaZtdGXtIdwf8L+mjkNT0
         pEoMQl6bM3IYYRahkwfnah0kW6q8Gly96y0eECmonRZjpNvRY8oT6k7ZqdZJ+SeBZc3n
         vxtyemo1GMq1bazru17NkVEbqAwoybaWRI65zmboNrab4zINiCTf/ahs4ucvYxcM+bQY
         TwPA==
X-Gm-Message-State: APjAAAVq2Mbq/wRL2MVnQjXPvA6bfHnjkV9FkkM6HOaMtTNrJDknDLIb
        DIdnIcIR5Er5eHwi/M4NEfRYRxjX
X-Google-Smtp-Source: APXvYqxWi0FozWnf91Td1MObrICG4eRcWnlXvKPqPqPx+lyMdexoKjOuH9bqmqdWj5D08sxSYQhgkg==
X-Received: by 2002:a05:6830:16d2:: with SMTP id l18mr3823891otr.271.1568830634671;
        Wed, 18 Sep 2019 11:17:14 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id b5sm1971593otp.36.2019.09.18.11.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 11:17:14 -0700 (PDT)
Subject: Re: [PATCH] x86/mm: Remove set_pages_x() and set_pages_nx()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190918164121.30006-1-Larry.Finger@lwfinger.net>
 <20190918164518.GA19222@lst.de>
 <b4fa6ab6-ab30-fc05-0f9f-93c41e7e8c79@lwfinger.net>
 <CAHk-=wji2fMDpSwvR4U8FkKBx8=eZtg3CmWtH7hACzeHbBei8A@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <bd5684ee-afaf-a9ba-6c32-15d2aa94733c@lwfinger.net>
Date:   Wed, 18 Sep 2019 13:17:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wji2fMDpSwvR4U8FkKBx8=eZtg3CmWtH7hACzeHbBei8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/19 12:53 PM, Linus Torvalds wrote:
> On Wed, Sep 18, 2019 at 10:50 AM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>
>> Is there approved way for pages to be set to be executable by an external module
>> that would not be a security issue?
> 
> Point to what external module and why.
> 
> Honestly, the likely answer is simply "no". Why would an external
> module ever need to make something executable that isn't read-only
> code? That's pretty fundamental. Marking data executable is fairly
> questionable these days.
> 
> Instead, what might work is to have some higher-level concept that we
> actually trust, and that isn't about making data executable, but about
> doing something reasonable.
> 
> See the difference? Making things executable is not ok, but perhaps a
> "alternative runtime code sequence" is ok.
> 
>                  Linus


Linus,

Yes, I do see the difference.

The external module is vboxdrv, which is part of VirtualBox. The setting of 
pages to be executable appears to have been added in kernel 2.4.20.

I am now testing with the former calls to set_pages_x() and set_pages_nx() 
disabled. Thus far, VMs seem to be running OK. I will contact Oracle to discuss 
the matter with them and see if there is some special case that requires this 
facility. If there is one, then they will need to discuss it with you and Christoph.

Larry

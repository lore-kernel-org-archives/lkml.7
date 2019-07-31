Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76446C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4E9206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yl8AqYJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbfGaPVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:21:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40597 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfGaPVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:21:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so32048733pfp.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8Z0P5Wb3N6RNbSuxVxTxovjy+jlIt5UjpbTJFLTHGvg=;
        b=Yl8AqYJNSj8Uxqi6ahv+iq+Yf5YGpSzIGgio2doxdbl+ZbJpe2L80fRRMpzBWrHjSo
         JT2/+vjR5pjbF8HuSpNq+tjQns7I5KyAb6VSFhDyfI6IcRINOXrGX0Sx0+4152EVCKyi
         QG9CnJOjxyeAkcfsxwU4HM2nM4XLhiz6V/k1TyDO8nIicoOnaPi1q9KOJRYgf5cXpCDD
         SN0e7PyBSpRf/Xz+PSbwTQ5iYd/P/pK6KQ6Pv9XSpy9LgufVH4mgoSbdwRE89BK5kv7T
         Ebk/BY7eRL3FwpeM5CHABrx73aJnw/blKmMVxCyhz6czHFJoR5e1ZbmwEgZo0KCTjCd5
         2eYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Z0P5Wb3N6RNbSuxVxTxovjy+jlIt5UjpbTJFLTHGvg=;
        b=OdTYlZqtfoSn3IVGF/ws+R2JUgnVRqHSvEXQ3D0YxqvCjStF8/6zORt2V3Xbxz3V/n
         i6F4bTOVWJQ9xfYDazx28/5Bp9em1IOid1TUqTt722T3GNeXiIQoBoYXx4vX4vzi60AC
         DNo7Op9xAXjnNlJI/ahJYakXSa8oqilem55r9skyLkqOh9sbuFZa9DFo1eAtmfaPQ6tl
         AORw1zfDbHjoSgGNM/tToBEa5tyKLDQYRQ7zAkVTUQtqm4MZlZnS5YsqKMxP01VW6ps7
         kCE+BQoQrrC4UTcA/FhC44Ey7f+LC0vp69qVjZClo1H2/hdj2WwqyXT9IkclzpuI9nNM
         TCbQ==
X-Gm-Message-State: APjAAAUQN45xNUsREZooFbDJNwGfdWUqsYCAmFjkIRI2EFH6o5+5QEKr
        tiDxSQ2D0mXfks11Zb/6N6o=
X-Google-Smtp-Source: APXvYqxk/3mnPslHedIH4JtnaBWENkwBQDDY+6Lyxq4miRBwLaykFQeTXEDI0WyNnUgIF/fxXL2bXg==
X-Received: by 2002:a17:90a:25af:: with SMTP id k44mr3435781pje.122.1564586151955;
        Wed, 31 Jul 2019 08:15:51 -0700 (PDT)
Received: from [10.69.137.114] ([50.228.72.82])
        by smtp.gmail.com with ESMTPSA id c70sm23254601pfb.36.2019.07.31.08.15.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:15:51 -0700 (PDT)
Subject: Re: [PATCH RFC 2/2] futex: Implement mechanism to wait on any of
 several futexes
To:     Peter Zijlstra <peterz@infradead.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Steven Noonan <steven@valvesoftware.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        viro@zeniv.linux.org.uk, jannh@google.com
References: <20190730220602.28781-1-krisman@collabora.com>
 <20190730220602.28781-2-krisman@collabora.com>
 <20190731120600.GT31381@hirez.programming.kicks-ass.net>
From:   Zebediah Figura <z.figura12@gmail.com>
Message-ID: <306b3332-0065-59dc-e6d6-ee3c8a67ef53@gmail.com>
Date:   Wed, 31 Jul 2019 10:15:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731120600.GT31381@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/19 7:06 AM, Peter Zijlstra wrote:
> On Tue, Jul 30, 2019 at 06:06:02PM -0400, Gabriel Krisman Bertazi wrote:
>> This is a new futex operation, called FUTEX_WAIT_MULTIPLE, which allows
>> a thread to wait on several futexes at the same time, and be awoken by
>> any of them.  In a sense, it implements one of the features that was
>> supported by pooling on the old FUTEX_FD interface.
>>
>> My use case for this operation lies in Wine, where we want to implement
>> a similar interface available in Windows, used mainly for event
>> handling.  The wine folks have an implementation that uses eventfd, but
>> it suffers from FD exhaustion (I was told they have application that go
>> to the order of multi-milion FDs), and higher CPU utilization.
> 
> So is multi-million the range we expect for @count ?
> 

Not in Wine's case; in fact Wine has a hard limit of 64 synchronization 
primitives that can be waited on at once (which, with the current 
user-side code, translates into 65 futexes). The exhaustion just had to 
do with the number of primitives created; some programs seem to leak 
them badly.

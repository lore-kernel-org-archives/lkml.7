Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A532EC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 23:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6563E206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 23:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/uPHszh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfEEXyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 19:54:10 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38601 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbfEEXyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 19:54:09 -0400
Received: by mail-io1-f67.google.com with SMTP id y6so9687283ior.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 16:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=j3iAXrkonZmZ6s5g4mLaqH7grkCFn9NCr/nHQmcE/Ms=;
        b=Z/uPHszhv9FeBpTUexI1ln1daNoPISXTPWcICXcKyiq8TMUckRoVSihJViDMMv/ICz
         8pEAGPqjlTYCZnBYuIrMNEvD9aTCmuSXYbmdwbaXoV+SxXP7dLkmEm0/YiUWNs4DawT6
         TsSYTCGamVZCmRbU3N0p4iJ+qg7Tv/0Q4grFw7UgWuavKbmf0sTFgwwyldwXAzXMkiU6
         zVeDjsZ1Xl5iMTnTnjH9pqWXQuJs0YLU/DyTnDAzbWmYrXk+iT0A5KEOZA8Ba3PWKfpQ
         h89MaImm4CJNrSayJmSKQHV6BjBi3bf16wSIRtkzo9ZClZJHlCtZqUBEWb6eel7iwhYa
         yBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=j3iAXrkonZmZ6s5g4mLaqH7grkCFn9NCr/nHQmcE/Ms=;
        b=kMJTxUbvu5JMnYXCW7X890H5t3nZ3/Hc401MTW6VkqA8MLviW8ONNb8k2RBEKMc6RD
         9KR2ySJ3F7lIeBzdem+SDGCbvW0hEveEJpMS5QHS67SNOIeQfdYmQ/YbKB/3dIFbxVAa
         YJpobNnSJnEsi5i0sSanVRulMIYkV9gdTLyW4P9lcCTHLjfCeoOjRGEqUSVCgJzevWQE
         yFmoVAQNKthgxsXEiZAJXTlQ85fEOIKpjp+o024BTG06dpaL+IgC6jAv3rVjcZJ8WXcC
         M86EBJYVB/wDNxFCup/QUzwKnfShTxgJfdmVrs3/lHQOp0mVrdB53Jl4r7n80NgJ4Qa9
         +/Ug==
X-Gm-Message-State: APjAAAWdAXQNDtXNLtrHnASrXiQEt6JRM6YPIiusm+xBfCb3ZDdiGket
        EFM3CHQBdxCBiuu04/hB9bj9eks=
X-Google-Smtp-Source: APXvYqzlJjQD31LDWRVhWviklYdwimYOmZ/I1wHKAUBi4N4JUKAGQ3l/NF16/K65AwjukkTAa0qdCw==
X-Received: by 2002:a5e:d80a:: with SMTP id l10mr12481212iok.32.1557100448634;
        Sun, 05 May 2019 16:54:08 -0700 (PDT)
Received: from [192.168.1.99] ([92.117.170.52])
        by smtp.googlemail.com with ESMTPSA id q207sm4084238itc.37.2019.05.05.16.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 16:54:07 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] ftrace: Implement fs notification for
 preempt/irqsoff tracers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <20190504164710.GA55790@google.com>
 <20190505223915.4569-1-viktor.rosendahl@gmail.com>
 <20190505190133.49b5ea46@oasis.local.home>
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
Message-ID: <b415ea04-e078-a73c-3609-56fb195841c3@gmail.com>
Date:   Mon, 6 May 2019 01:54:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190505190133.49b5ea46@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/19 1:01 AM, Steven Rostedt wrote:
 > On Mon,  6 May 2019 00:39:15 +0200
 > Viktor Rosendahl <viktor.rosendahl@gmail.com> wrote:
 >
 >> Can you explain more precisely what you agree with?
 >>
 >> The general idea of being able to trace bursts of latencies?
 >
 > One thing I have an issue with the current approach is the use of the
 > trace file for this.

You mean that using fsnotify is kind of okayish but that it's confusing 
for the
user because only a subset of tracers would send the fsnotify event when the
trace file is updated?

 >
 > Hmm, what about adding a notifier to tracing_max_latency instead? And
 > do it not as a config option, but have it always enabled. It would send a
 > notification when it changes, and that only happens when there's a new
 > max latency. Would that work for you?


Yes, it seems to be OK since the tracing_max_latency is updated also
with the latest latency that exceeds the threshold when we are using
tracing_thresh. I will try to send a new version of the patch series
soon, with the modifications that have been discussed so far.

best regards,

Viktor

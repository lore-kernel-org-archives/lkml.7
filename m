Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90B5C468BD
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 08:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D7C212F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 08:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DjoWrOsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfFHIjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 04:39:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41268 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfFHIjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 04:39:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so4319790wrm.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 01:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J6Xt9h1a4Wghl2N6CbS4VR7OOrvB5+AthvQVEUPg01E=;
        b=DjoWrOsWVY/yC9JXffrTjpdqyGovJRi2Buug8N5SOGLhoS1LCUpAtYv9PesOQViJbC
         hOFboN/QlHdA/zBDZ80nYSDB5L4vTRpz9My5cgMRUI1xbL8rlAnhlS9+wX/Xa/skpfc1
         sRDDD28K/u7NL3Lgi5PURTUxf9DEDl0Ue7zA1A4uo8ltMNIVodqzxbCPKoos8hZ7sr/n
         ZQMdlgNBVCx/hwuofBC3pv5Lt28pAjkUNVjrxxpHCX39a5ApT/I7pPF2mvmlqNV2LcR4
         XZTxiN0oSjU10rLrPc4OXo7OBYSeEHsUET3Bhoa9EwAprRjWoEwejl+3bo41EqOBmxEz
         RGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J6Xt9h1a4Wghl2N6CbS4VR7OOrvB5+AthvQVEUPg01E=;
        b=lBM0cjM5hpBHNIYmCfGgbgBukXIr4PUaxCRhkYa4fjc248cvLFJI7KqHZKhG+V+EaH
         ktttIKhHu3XvL57Y2/xAMKn1gosymv95DECZYG2QXTCrLpSKNgOTNgmlX1/pD5H2+6mt
         DAHWhby6nclS1h54KvoIVzryoKTXSLZE9REkkytHO/r5bAiuqrBv0btzieNSSscDY55+
         pfbVyr1T26Lp+S3EVZ73akZZ4koj6bmvNigfsH7dFe+4U+5097rDkALX2ugyKfAtK931
         FZYNX+PBPMOnmXKYnonooF3A2WltnaEUiafGLP+Ijg6GhQlUCQrYyebeamSPZRDlv83G
         fysA==
X-Gm-Message-State: APjAAAWIwCHPYmVaciRghVAVDElkSg1yIWxbfOFOEkq4OA/lTbpDPZaz
        /Rtn9dMKo49oMBP9VdeEvu/u+ziLbGXNfb4y
X-Google-Smtp-Source: APXvYqy0hclAVRC3uhRV9+kiDoq5y/xu4oRXxLZnqP/wlFsxFYuIAZE/t6VVhRF/UOV3+UhOCrDfrA==
X-Received: by 2002:adf:df91:: with SMTP id z17mr30066569wrl.336.1559983175080;
        Sat, 08 Jun 2019 01:39:35 -0700 (PDT)
Received: from [10.97.4.179] (aputeaux-682-1-82-78.w90-86.abo.wanadoo.fr. [90.86.61.78])
        by smtp.gmail.com with ESMTPSA id z6sm4787119wrw.2.2019.06.08.01.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 01:39:34 -0700 (PDT)
Subject: Re: [PATCH] block: fix a crash in do_task_dead()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org, hch@lst.de,
        oleg@redhat.com, gkohli@codeaurora.org, mingo@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1559161526-618-1-git-send-email-cai@lca.pw>
 <20190530080358.GG2623@hirez.programming.kicks-ass.net>
 <82e88482-1b53-9423-baad-484312957e48@kernel.dk>
 <20190603123705.GB3419@hirez.programming.kicks-ass.net>
 <ddf9ee34-cd97-a62b-6e91-6b4511586339@kernel.dk>
 <20190607133541.GJ3436@hirez.programming.kicks-ass.net>
 <20190607142332.GF3463@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c0b19bdd-c68f-3f1f-2cd2-1732e8a508b6@kernel.dk>
Date:   Sat, 8 Jun 2019 02:39:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607142332.GF3463@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/19 8:23 AM, Peter Zijlstra wrote:
> On Fri, Jun 07, 2019 at 03:35:41PM +0200, Peter Zijlstra wrote:
>> On Wed, Jun 05, 2019 at 09:04:02AM -0600, Jens Axboe wrote:
>>> How about the following plan - if folks are happy with this sched patch,
>>> we can queue it up for 5.3. Once that is in, I'll kill the block change
>>> that special cases the polled task wakeup. For 5.2, we go with Oleg's
>>> patch for the swap case.
>>
>> OK, works for me. I'll go write a proper patch.
> 
> I now have the below; I'll queue that after the long weekend and let
> 0-day chew on it for a while and then push it out to tip or something.

LGTM, thanks Peter!

-- 
Jens Axboe


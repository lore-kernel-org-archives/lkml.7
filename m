Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44499C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1561120850
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cciq7szM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfEMTau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 15:30:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44815 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbfEMTas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 15:30:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id c5so16535434wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 12:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UJJzPiFDm2FxE5LRCDGQodMfSb99kuLW2iaHmJKN+CA=;
        b=Cciq7szMMk3GwQvboPZQ93QX6pGCfJCIy5Ivif2rUR+yvpK/ESTWGdHrkJhOQfxxjT
         ghsXGQYhzXlhomAUr/6ivalENG/Y2G3A3XKpIZkvdl4osXUQ38jGOII4Gn4RUNft2WWS
         5CASBVYG62R97+Oc7Z8XvmSA7Olj+RI7PHg8OWcB6tsXA+UlqMOE+vSYDJC1cv2tfZUP
         PoR0d2urk/QuBLIHfuF+OUbvUHhN6XAX9duRHFErGdA9vhk8isJMG2wbNqEFvUVxS4Kz
         HMTc/bcdBPHapE4qD9S5RusbEUKzsBAcw3XSoAaQ4o9tVdZIchsd+ncTvYzNqonkYJrp
         Yc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UJJzPiFDm2FxE5LRCDGQodMfSb99kuLW2iaHmJKN+CA=;
        b=ftWw1KvkbOZg8ny8RBVfw8rjVnTAD8mqTk+aMy+sKP3o+saFyFrAFg+d3YU4qwJZs9
         Ko0xDuX/5xlgH/CLHZz9X8DseTSPLU/qZTTCZVEUHlTQxUaYLACVU0VItAgnUatP4gn6
         KP6II4PkOzZgzQXoeKFDmXRkOONw6gTsRh+mUdJMu4g5xcPC05zmcBXyyy+tjj2FHwvh
         3giCQ4Exi2CBEkKSsVps/Jvmo2L3sTFIQotENJVTuKbR/IoX8+Qtn5piACiybFi9HwZW
         JpaaMJFJ9Xg8Lwq6D52sPKKwaHIjzUzhKtLkM5Elkw8BD239h8dm2BF5WCAOhJwNE5Zv
         9BWw==
X-Gm-Message-State: APjAAAUT/PmRuW1+cA7b1Sj2ytwhYNpcRcJ3h6nMTyyvYhVrdeoZfpMi
        676Wm4t1np4pNOerYD9d0x8=
X-Google-Smtp-Source: APXvYqy4eLsR4APPaSYFA1Wz0qR5e+YrpXRkNOHWnU33HTsg05HEE02VXpm3O//sdEZFdgHcqvIKQA==
X-Received: by 2002:a5d:4b0b:: with SMTP id v11mr18069022wrq.317.1557775846356;
        Mon, 13 May 2019 12:30:46 -0700 (PDT)
Received: from [10.67.49.52] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id c9sm9908542wrv.62.2019.05.13.12.30.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 12:30:45 -0700 (PDT)
Subject: Re: [PATCH] perf vendor events arm64: Map Brahma-B53 CPUID to
 cortex-a53 events
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Will Deacon <will.deacon@arm.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "moderated list:ARM PMU PROFILING AND DEBUGGING" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190405165047.15847-1-f.fainelli@gmail.com>
 <20190408162607.GB7872@fuggles.cambridge.arm.com>
 <46ac3066-fa55-9fb8-dd54-32fb702030cb@gmail.com>
 <20190502235725.GB22982@kernel.org>
 <60f367b4-1c5b-0778-eaa6-1a78d58f33a1@gmail.com>
 <20190513192224.GA2470@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <65e865be-8bca-c5c1-0272-ec15a91e93ee@gmail.com>
Date:   Mon, 13 May 2019 12:30:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513192224.GA2470@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/19 12:22 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, May 13, 2019 at 11:04:49AM -0700, Florian Fainelli escreveu:
>> On 5/2/19 4:57 PM, Arnaldo Carvalho de Melo wrote:
>>> Em Thu, May 02, 2019 at 02:28:02PM -0700, Florian Fainelli escreveu:
>>>> On 4/8/19 9:26 AM, Will Deacon wrote:
>>>>> Acked-by: Will Deacon <will.deacon@arm.com>
> 
>>>> Thanks! Can this be picked up?
> 
>>> Thanks, applied to perf/core.
> 
>> Thanks, I don't seem to be able to find it being pushed out to that tree
>> or in linux-next.
> 
> What tree? acme/perf/core? That is the one I referred to, have you
> looked instead at tip/perf/core? 

Yes that's the one I checked.

> That one still doesn't have it, as I
> was in LSFMM/BPF and then vacation and haven't pushed that to Ingo yet,
> look at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=c0c410e9c4f36972c393a4cc61368d92feb23d67
> 
> I can remove it and wait for your resubmit addressing the issues
> discussed in that other message, ok?

OK, let's do that then, thanks!
-- 
Florian

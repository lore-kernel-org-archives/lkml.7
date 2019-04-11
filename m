Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CD6C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FF92083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554961384;
	bh=HkAwMRSPPmkIScmQlrhpQ8ox4rf6Ah1bpfjlTSbtKk4=;
	h=From:Subject:To:Cc:References:Date:In-Reply-To:List-ID:From;
	b=nhrplP5ddF1EYPLQPgYXOyqtp3CvMKcmUxRfyvkV25yRlbIlB7cQwg3OOmfKhn93Z
	 yhn2C7iN1SdSzvYeTUJ5upgHE8nBEbKkte4QNF86eGtBvwuELUqE3F6lp6iO41Logd
	 5s91nKdEV06Juz0cIEH+zfUKpdES6wj8IW9c6OdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDKFnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:43:03 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45531 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDKFnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:43:01 -0400
Received: by mail-oi1-f193.google.com with SMTP id y84so3861647oia.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 22:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BxdDXI9Dqao/nHYZxtC0LI14vOTc/nZIsY56HA2TVW0=;
        b=BnpBrECiOeo5lNERUP+VwaYkA1YN/6f3z5i5cdxTOxgswLK7hqMDLWrlgqN9mi85Ec
         tsx7EsPdj+/eZNKX3Vbg6EbQr0QVsHZ6G+XPoNsPtJB+VkeAFKoM33I0X8IqJL6qO3tH
         +KRJR6h2FlsT/6x6Ht9CbirflHFe1ZryTpeenvBWz6PI4DS4zT9DKJWmSkx21AkrWHTW
         28LQpIQk2TGa1PQnuaptydHELYJC+vZO77AcT6Z/dOmttYdrz2PbqcS5/fGWEpz3XuVX
         7Eof7ftH7LoI06NXfrdNLfDmyW+370h0vdKbJWcV70jvECaETbzCUd4qCC3lAUOkBPoH
         hANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BxdDXI9Dqao/nHYZxtC0LI14vOTc/nZIsY56HA2TVW0=;
        b=YyLoAsR7rGVVvO1VuZvTgnwYR37aRO7A+noMiD8dF+5aj5Nurhqa5+S0UBUZtfmYgO
         alpk2D4ttNEmRwM59RyAi2B6Z+315QT/VxQyF2R+OOW+7Bp1aVHgMRKweIvFe02FLPPV
         NZYKXVOlUctm2kHZSG29MLE/tuIyaZXKdYZXR+exZL/fVPe1rf38gE+wYa0Wl+iXEBdH
         I+zDEV/ihaFXVm69OOfr1wcuQERD3DXAWKazGyyNLktS5nwf2yj0KcOdREI0f28MUky2
         QaeKtuaeLGwHJmbRRtD7iNQ0nEw8JAlvyJNBCEFPTmZE9yogOgtc3W1njDWz/gntHIOd
         aMhA==
X-Gm-Message-State: APjAAAUKAq45lFZDf00lE4wazxq9ywAJlAEheMdXvitqPkP9JmHjGBTI
        GNFKop33XHSAllZhHEmirQVQ9VizYfs=
X-Google-Smtp-Source: APXvYqwRgIrTdfKewfSGXDpLnP6HQ0z7MBgFbDnK0HEhM3ciUZrzgOhFYJMPKzeonCrr2gyCxHV6uA==
X-Received: by 2002:aca:b30a:: with SMTP id c10mr5053881oif.74.1554961380394;
        Wed, 10 Apr 2019 22:43:00 -0700 (PDT)
Received: from [192.168.1.74] (75-58-59-55.lightspeed.rlghnc.sbcglobal.net. [75.58.59.55])
        by smtp.gmail.com with ESMTPSA id n77sm18973907ota.77.2019.04.10.22.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 22:42:59 -0700 (PDT)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v3] init: Do not select DEBUG_KERNEL by default
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Changbin Du <changbin.du@intel.com>
References: <20190411005634.8495-1-okaya@kernel.org>
 <CAK7LNAS=G7-nXr=pT2EYExGNkCcOcd2NH1haaBMt+JsyhX2Z8Q@mail.gmail.com>
Message-ID: <c8babeca-2d24-4265-0477-0634d87efa70@kernel.org>
Date:   Thu, 11 Apr 2019 01:42:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNAS=G7-nXr=pT2EYExGNkCcOcd2NH1haaBMt+JsyhX2Z8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/2019 1:31 AM, Masahiro Yamada wrote:
>> t looks like CONFIG_KALLSYMS_ALL is the only feature that
>> requires CONFIG_DEBUG_KERNEL.
> Which part of KALLSYMS_ALL code requires CONFIG_DEBUG_KERNEL?
> 

I was going by what Kconfig tells me

Symbol: KALLSYMS_ALL [=n]
  Depends on: DEBUG_KERNEL [=n] && KALLSYMS [=y]




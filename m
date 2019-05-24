Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE09C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F81E217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KFY1fXNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390992AbfEXQAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 12:00:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37106 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390419AbfEXQAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 12:00:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id e15so10563482wrs.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 09:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X2BwS1gpGl6HYDbx0TXUpHhKzIpbXW6x1o3O2lZwflI=;
        b=KFY1fXNtnq+uWltNsrVdhaINSgJf0TC6voIV2LL4zUKlKWMdSg8a/ysRk3wAJ40r3a
         pCODygdDuMZDBmZ63W1Gr14NKJfjJgb2MV0oh1QRmPQNqr2h7fEOXSH/xeoxAV3tdfPC
         7EW2LOf+2LWnpwcnmXs4+dQJQ7DBocnRkOFAEbBjoHTcjEKf/0uaBy8a6APGxKKOrpnk
         TatCUOI/38IdvlEDP2PHWZfhCLI9yite9T7TmqxSgjEB79jdkp7iwHuBtR+9drWE4W7q
         dPYedZyvDkA86tsu1euFtPTdSsCjAE09+oxo9aPdi9sb6ahhTS0utQqgXlswZXHnLM8Z
         7+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X2BwS1gpGl6HYDbx0TXUpHhKzIpbXW6x1o3O2lZwflI=;
        b=VBredU3cV0gPyQmAMBqQKqPK09bRr5gnNtcTjkdIydBC9vOU2Fu1nvJld7PkAbj+AY
         v8tnXLgaclbFDV+Mbfc/KRna/xaXJc/p2c7/bTJpmr3gGxCCJpP2CuTt58nbAm2NffCe
         sOLaCpewrjxfoQhgbegugaw4PUxx1kceJVZV0pg34cQriMlxilqg43pZ78Qc/xNYXQpJ
         bV/j8dIaEQOP9lXrVX8MnKYPr1uICz/djP6YpVg/2za67Riw1SxeGpZnv0kxt8jiEAit
         NAXUczH+ylKlyS4npgS7cI5GBIvHHmafPD6v/aIpKf7/ADvqVpxUlgiy4pdImlBugecV
         ZAqg==
X-Gm-Message-State: APjAAAW2+3Yl4lbLWk/XQWYeBjQ2t8epxjNHT5u6bOdOFV+OWQP9w/yt
        DCdA/iCCf0fE2RJcWdiWwf5e3g==
X-Google-Smtp-Source: APXvYqwgfJenIySulYgsYuxksZKjLVSiyRTXe1N1Of2kVKYp9XYSE/PzK53wHSSs4dAYhaFT+LtDhQ==
X-Received: by 2002:adf:f74f:: with SMTP id z15mr37858947wrp.282.1558713612958;
        Fri, 24 May 2019 09:00:12 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id j28sm5438480wrd.64.2019.05.24.09.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 09:00:12 -0700 (PDT)
Subject: Re: [PATCH V2 7/9] genirq/timings: Add selftest for circular array
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Changbin Du <changbin.du@intel.com>
References: <20190524111615.4891-1-daniel.lezcano@linaro.org>
 <20190524111615.4891-8-daniel.lezcano@linaro.org>
 <20190524140045.GY9224@smile.fi.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b9a62423-7f33-8725-3459-24cfb84043a3@linaro.org>
Date:   Fri, 24 May 2019 18:00:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524140045.GY9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2019 16:00, Andy Shevchenko wrote:
> On Fri, May 24, 2019 at 01:16:13PM +0200, Daniel Lezcano wrote:
>> Due to the complexity of the code and the difficulty to debug it,
>> let's add some selftests to the framework in order to spot issues or
>> regression at boot time when the runtime testing is enabled for this
>> subsystem.
>>
>> This tests the circular buffer at the limits and validates:
>>  - the encoding / decoding of the values
>>  - the macro to browse the irq timings circular buffer
>>  - the function to push data in the circular buffer
> 
> Can it use kselftest infrastructure?

I don't think it is possible because it is 100% deep-internal test, no
cooperation with userspace.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


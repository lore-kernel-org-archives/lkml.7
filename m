Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76697C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406EA2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBHNY8Bi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfFQRhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 13:37:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46834 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQRhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 13:37:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so10862947wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 10:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BFDjaDpazqcsGofhS5TCdjo24bfLT4oCxcdL5isQMbI=;
        b=lBHNY8BiwC4Bf/7VN2viRpimdosUjbg1o5FRvZb7MO1YfYFRg1sWzf6ZX7t8yesMy4
         E3r1Fj79cK5BL+0J3ffOcrJfRaoArfEAsR6q0HOEbUw/V5eVsPylYy05rrAQgYQmJj2T
         X6UPwjL6kCTo6bANp2Su79K+/sViysr+srxEznPumbyv6DUu8LlNawqk6p/vAuInl0rK
         swYYXwp4cTVt74zEUXL6dzN6YduvFs1RCEclKGwpak8Uk+g+O7ewDbhsT/tGARE1pGNc
         L710E6ZgRrVx20K1wyQPeRPbYIbL3JReFbH+h07k1pBkS7ysVT+t1dGnCIOogXaFl9n2
         4HSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BFDjaDpazqcsGofhS5TCdjo24bfLT4oCxcdL5isQMbI=;
        b=cOimEv3WyLskHosvl/vOmxIGzJjL7RC1ea9RHQJyC/5Bp5MoBWrmdz8lLrbdOJXogr
         EERwELQnxOKeNZ0eCKG17ftARs+cvtGac6AFuLO8PaaToceWB99T2ieR95IO7jYdB5iP
         vmcEwT140HQCCdf+xgfEuo0J7rGoEZtXD9drDTUVLyCRZCOX12dXJIzA2OIFQwySeFuH
         Ic3C5JY0D9NDS88KJ3TN3TyVDK5FeJ8eojuz4DYm9gmww4WNHQlTDl+kOTp90lmiQgHc
         OFGpDIcJu9ti30kvnZcHoo/n9wblrKU+rm1wDojwwuJdvusi67nTuiqD7WB+htvRUeaC
         YtLw==
X-Gm-Message-State: APjAAAUyiqaBjlXT7J6cCYq9Q0jkjXutNZGHoVq4whDNVhicQdfToS1k
        uR5mTUmsLPVK1VtZAZNc+Pc=
X-Google-Smtp-Source: APXvYqy0s5odpSnEXYthY63aHpLspheChg16O1xYNw5u0s3i0F1CPUayeAvUt/QxNB2+wh5MsP8jvw==
X-Received: by 2002:a5d:554b:: with SMTP id g11mr61494905wrw.10.1560793061930;
        Mon, 17 Jun 2019 10:37:41 -0700 (PDT)
Received: from [10.67.49.123] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d18sm15185075wrb.90.2019.06.17.10.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 10:37:40 -0700 (PDT)
Subject: Re: [PATCH] perf: Don't hardcode host include path for libslang
To:     Jiri Olsa <jolsa@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Stanislav Fomichev <sdf@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
References: <20190614183949.5588-1-f.fainelli@gmail.com>
 <20190616094605.GB2500@krava>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <6ac811c5-477f-eb8a-ff5f-1f95b009714e@gmail.com>
Date:   Mon, 17 Jun 2019 10:37:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190616094605.GB2500@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/19 2:46 AM, Jiri Olsa wrote:
> On Fri, Jun 14, 2019 at 11:39:47AM -0700, Florian Fainelli wrote:
>> Hardcoding /usr/include/slang is fundamentally incompatible with cross
>> compilation and will lead to the inability for a cross-compiled
>> environment to properly detect whether slang is available or not.
>>
>> If /usr/include/slang is necessary that is a distribution specific
>> knowledge that could be solved with either a standard pkg-config .pc
>> file (which slang has) or simply overriding CFLAGS accordingly, but the
>> default perf Makefile should be clean of all of that.
> 
> fedora 30 is ok with this, I guess acme's distro test will
> tell us about the rest ;-)

If this patch somehow breaks a particular distribution (I could test on
everything), the following might be more acceptable:

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 4b8244ee65ce..eefeaa9aa208 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -71,6 +71,7 @@ CC ?= $(CROSS_COMPILE)gcc
 CXX ?= $(CROSS_COMPILE)g++
 PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
 LLVM_CONFIG ?= llvm-config
+LIBSLANG_CFLAGS ?= -I/usr/include/slang

 all: $(FILES)

@@ -181,7 +182,7 @@ $(OUTPUT)test-libaudit.bin:
        $(BUILD) -laudit

 $(OUTPUT)test-libslang.bin:
-       $(BUILD) -I/usr/include/slang -lslang
+       $(BUILD) $(LIBSLANG_CFLAGS) -lslang

 $(OUTPUT)test-libcrypto.bin:
        $(BUILD) -lcrypto
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 85fbcd265351..df3022b213b3 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -636,12 +636,13 @@ ifdef NO_NEWT
 endif

 ifndef NO_SLANG
+  LIBSLANG_CFLAGS?=-I/usr/include/slang
   ifneq ($(feature-libslang), 1)
     msg := $(warning slang not found, disables TUI support. Please
install slang-devel, libslang-dev or libslang2-dev);
     NO_SLANG := 1
   else
     # Fedora has /usr/include/slang/slang.h, but ubuntu
/usr/include/slang.h
-    CFLAGS += -I/usr/include/slang
+    CFLAGS += $(LIBSLANG_CFLAGS)
     CFLAGS += -DHAVE_SLANG_SUPPORT
     EXTLIBS += -lslang
     $(call detected,CONFIG_SLANG)

> 
> jirka
> 
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  tools/build/feature/Makefile | 2 +-
>>  tools/perf/Makefile.config   | 1 -
>>  2 files changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
>> index 4b8244ee65ce..f9432d21eff9 100644
>> --- a/tools/build/feature/Makefile
>> +++ b/tools/build/feature/Makefile
>> @@ -181,7 +181,7 @@ $(OUTPUT)test-libaudit.bin:
>>  	$(BUILD) -laudit
>>  
>>  $(OUTPUT)test-libslang.bin:
>> -	$(BUILD) -I/usr/include/slang -lslang
>> +	$(BUILD) -lslang
>>  
>>  $(OUTPUT)test-libcrypto.bin:
>>  	$(BUILD) -lcrypto
>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>> index 85fbcd265351..b11134fdf59f 100644
>> --- a/tools/perf/Makefile.config
>> +++ b/tools/perf/Makefile.config
>> @@ -641,7 +641,6 @@ ifndef NO_SLANG
>>      NO_SLANG := 1
>>    else
>>      # Fedora has /usr/include/slang/slang.h, but ubuntu /usr/include/slang.h
>> -    CFLAGS += -I/usr/include/slang
>>      CFLAGS += -DHAVE_SLANG_SUPPORT
>>      EXTLIBS += -lslang
>>      $(call detected,CONFIG_SLANG)
>> -- 
>> 2.17.1
>>


-- 
Florian

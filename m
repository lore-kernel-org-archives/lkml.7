Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22181C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59A5215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="RP9ClfqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfH2JBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 05:01:03 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43913 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfH2JBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:01:02 -0400
Received: by mail-lf1-f68.google.com with SMTP id q27so1869511lfo.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 02:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GflFtIVZM88+m/b3O03bHRfVUBRCQA10rQsteTPRKU0=;
        b=RP9ClfqOBQdl68pRWDcY1JCCs1Q5wuSwXqTQrxZa5L9iq2jlLy/LK7xGMohK9vjwrI
         8QanvCJNGjB66AKh+egkfLNnsxAPiDwz0oIhnJxN/4upQRp6I9mgP6GbkpjEaklkyWNo
         f5ODkjYbir1wzaER7e4PsqFQ0LVLKue9Tx9J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GflFtIVZM88+m/b3O03bHRfVUBRCQA10rQsteTPRKU0=;
        b=X9SbVayNTTFRV2Dc8z5Kasg+G4HEFqTDIs5z3BIznmNfs43/Q5NMyuPJDHonpVtXEx
         JU5wOhRHqaKHeuPCep/o6SnrnNNifIcY1UNXwX8Qv6SOUJoCFdY3WvUJVVNhkZ0cH8yd
         vnhEIdbe7vBNpSrvj3mtaTgzrs+atj9snLLVX5ALNTSGBUx5vd4HZo3jcsmJa0laKkuQ
         WAfUvjCPbtAWJWYYJ4R8gbErrxsBw9W+/kyF2vJ0pFZXV/zxOnrMADw5HZmFqevy+Tc2
         PnYv+9CsfMdJOM//z0XKKKk/Q1hL2PtPewc1X4Bc6BF2vQ9XCThox/w9Z/WrPqUlDUGk
         nUZQ==
X-Gm-Message-State: APjAAAU/mIL4iA7JNxr2Cix8MY/DqnsZpfbvjz/+Sz8To24UdPJi2Tw1
        tF9SuLynxQ8KhYJbnsEVFqf9AAxxcS3WxGv7
X-Google-Smtp-Source: APXvYqwjN+5W4ntXA7MNnNHNpk1WEY6DjWz1C1dmXfCEJi7QBlRTnI4JIU6BGp373PYAFgm2lm4kVw==
X-Received: by 2002:a19:6d17:: with SMTP id i23mr5440814lfc.44.1567069260255;
        Thu, 29 Aug 2019 02:01:00 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l11sm293261lfh.48.2019.08.29.02.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 02:00:59 -0700 (PDT)
Subject: Re: [PATCH v2] vsprintf: introduce %dE for error constants
To:     Petr Mladek <pmladek@suse.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        metux IT consult Enrico Weigelt <lkml@metux.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190827211244.7210-1-uwe@kleine-koenig.org>
 <20190828113216.p2yiha4xyupkbcbs@pathway.suse.cz>
 <74303921-aa95-9962-2254-27e556af54f4@kleine-koenig.org>
 <20190829081249.3zvvsa4ggb5pfozl@pathway.suse.cz>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <39eda8f7-8c39-f899-075f-b4abdefe0098@rasmusvillemoes.dk>
Date:   Thu, 29 Aug 2019 11:00:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829081249.3zvvsa4ggb5pfozl@pathway.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2019 10.12, Petr Mladek wrote:
> On Wed 2019-08-28 21:18:37, Uwe Kleine-König  wrote:

> BTW: I though more about generating or cut&pasting the arrary.
> I can't find any reasonable way how to generate it.

Something like this seems to work, though it probably needs some massage
to be accepted by kbuild folks:

define filechk_errcode.h
	echo '#include <linux/errno.h>' | \
	$(CPP) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) -dM - | \
	grep 'define E' | sort -k3,3n | \
	awk '{print "errcode("$$2")\t/* "$$3" */"}'
endef

include/generated/errcode.h: FORCE
	$(call filechk,errcode.h)

Then one can just #define errcode(foo) ... right before #include
<generated/errcode.h>. It cannot be used to generate cases in a switch()
because some expand to the same number, but that's ok, because I can't
imagine the switch actually generating good or small code. I haven't
checked how or whether it works in a cross-compile situation.

Rasmus

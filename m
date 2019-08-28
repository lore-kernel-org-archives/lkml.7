Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D121EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E072173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNevBVC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfH1Jtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 05:49:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37260 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfH1Jte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:49:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id y9so1377995pfl.4;
        Wed, 28 Aug 2019 02:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H9qTuXYwqZLDg1PwjPrbon+pf8OaOqm2VC7Mf5a70pw=;
        b=lNevBVC2SXUBMPDCPlOyjPp24N+F341HJEFOMyCyD8OhnXgHIOg9PiKbY1LOQ7XI+e
         howHZCbR7GZpY2B7gHriw4jXLSl0yK8RrmhzJxBgkziyHi3hkF5krMGjF1ytKo0T7GTz
         Wyyn94Mzvqskh//k9PkYAF4vX4PZ+MnE915U6UlTXWr39tQSszoqfnS0INjQaEcOtcva
         GoMT43bAUsAIjmBpVf0h7HqCwx/KmeOYjCqgfeqFNZ9Rms3fyHwOOk5XVxYLx4KfpW6S
         eZnP4zscYLzMvrb8BsTJv8Ve2Uh/g6++G/18rWW1b3+BUghz6AV0GPwV5KT2LwPcpgfI
         KgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H9qTuXYwqZLDg1PwjPrbon+pf8OaOqm2VC7Mf5a70pw=;
        b=l+VXs8RujL+20WxwoKzwepT9en3RzgsZB8UYvd5EUo2WbsBzEmmV8VvjsWk0kkT2sy
         PtOUDg6ncsyZ/dh0oQKV1SeIAayclE0bUi9f3u32RERUUHdYyV2Dgzq1GwEf0F7VZovI
         K1ua+/31RJK7kXsyT4WHROjOg/tVCAyv2kdGZ4a6RM1Bqz89hzmtevIR5DKxc9RJDcOs
         l0EeBr9TUmiYjYoT/02YZgDabTICHVENdigXYcAwXatnAPH4njl2+h+9OwROSmxbBtBE
         Z6zKXgQPGfKAyAQHDUyXucGyTimnxmH5gwaqClwS5/4WqKsKd0Swq+sUYQlNBjVjiAM3
         7ong==
X-Gm-Message-State: APjAAAUzOVmUYpoSyxwsvrk+E67XyKJXzxUUwjmxVBVBKbu48093o5N/
        wUEfxs15lOZ0klJmxreOtlg=
X-Google-Smtp-Source: APXvYqzFP9rP61jiKHwk+2eBGeOfAFashAvw/Nfkd0rLXfSXzwc/mugeB8P4IKNb4MHNcMBWJ9D/6Q==
X-Received: by 2002:a17:90a:ba04:: with SMTP id s4mr3440843pjr.73.1566985774011;
        Wed, 28 Aug 2019 02:49:34 -0700 (PDT)
Received: from localhost ([39.7.47.251])
        by smtp.gmail.com with ESMTPSA id k14sm2051086pfi.98.2019.08.28.02.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 02:49:33 -0700 (PDT)
Date:   Wed, 28 Aug 2019 18:49:29 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah@kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        frowand.list@gmail.com, sboyd@kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v2] kunit: fix failure to build without printk
Message-ID: <20190828094929.GA14038@jagdpanzerIV>
References: <20190828093143.163302-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828093143.163302-1-brendanhiggins@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/28/19 02:31), Brendan Higgins wrote:
[..]
> Previously KUnit assumed that printk would always be present, which is
> not a valid assumption to make. Fix that by removing call to
> vprintk_emit, and calling printk directly.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

[..]

> -static void kunit_vprintk(const struct kunit *test,
> -			  const char *level,
> -			  struct va_format *vaf)
> -{
> -	kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
> -}

This patch looks good to me. I like the removal of recursive
vsprintf() (%pV).

	-ss

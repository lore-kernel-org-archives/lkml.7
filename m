Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AEFC2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA182073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576024068;
	bh=i3i/OOd/yLvu9iRSyxFuS5XThvDR5pjKCGsACjw4ywg=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=wGlTbB0kTqWveA7313DW1S3pQCxn+MVzT15YQCgVfQmrVsO351GKtbTKe7WTfjCO+
	 jf+wQKXwBtvAjCjJd+nLwqbhKr66HC1V2c5PkcuerIjV1sxV/DS/0IcBEkSj+kFlX0
	 slmQolmf2IrAgETCEQz+orwqf2Q3txDCmpAEl9Io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfLKA1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 19:27:47 -0500
Received: from mail-il1-f169.google.com ([209.85.166.169]:36188 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfLKA1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 19:27:47 -0500
Received: by mail-il1-f169.google.com with SMTP id b15so17878897iln.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 16:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+LjSD6sVRfH2//hYMsY7+rgc6dBShfyt7VWRkvvmBSw=;
        b=VzkfbA3JJVNZR2NqBWHOvSAOAEe3oUB5+qdGJh76ZlosSggwxkVIi1akfrjGwluYWI
         DtnR0OQfOHMR2lZf7vx+D5ACoQ8Ibrs8d6Y2R/dkLeCSWpoTirv+H8IwquERWvLsch1z
         BQpqvhvLtPvRfhAG1C/OU6PiObA9EjcuoOQOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+LjSD6sVRfH2//hYMsY7+rgc6dBShfyt7VWRkvvmBSw=;
        b=N1OWUA19wzRYOzrcxjMAcutpUIXXio+zxmAkDcNtk5zy1EQ/E15Pj8+60GgdXx/32m
         iyqSFHv31U27O2rZ3iJVzX9nYiB6P9JQlnhAeNw/9ZwV+0tsCBuKEr8/f/VMfFCd0Hwz
         fMW1oN9e6+eDgj0NlotVeemTXltohrPRNqSgWlSzCgQxtHnm0DTFY9ieT9AfG87BmafP
         6RFaIJLv7UUUspxH+D+6OyeAnvgUxDQupHqW2clwNBCBDge5dCWtTvGfrAKwErFY3TwQ
         3rUqyD/SM16QRyAqhGOJqUjMAndji7rQeCveSCGT8sSRuBSEujdinpAao6zuwkh9JuE5
         /nnA==
X-Gm-Message-State: APjAAAVDR2COzQ2/SmBIIdm86JW8B4GsEuePPj7ALA7zAwODSDWxJavu
        m8NC6YPqQcXG8KzR9z96eG3XkRpLQKunmQ==
X-Google-Smtp-Source: APXvYqxMXre2lYtjHVTpvGNDP8qoZJnxHDDjM1l1v2+ZDWv9h6fWOXfMCkZNJWiclb+chQl/adutkQ==
X-Received: by 2002:a92:d609:: with SMTP id w9mr514333ilm.46.1576024066088;
        Tue, 10 Dec 2019 16:27:46 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c4sm164062iln.24.2019.12.10.16.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 16:27:45 -0800 (PST)
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: Linux 5.5=rc1 kselftest rseq test build failure
Message-ID: <2d53b409-31e0-2245-e163-1ab26f52c841@linuxfoundation.org>
Date:   Tue, 10 Dec 2019 17:27:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

I am seeing rseq test build failure on Linux 5.5-rc1.

gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./ 
param_test.c -lpthread -lrseq -o ...tools/testing/selftests/rseq/param_test
param_test.c:18:21: error: static declaration of ‘gettid’ follows 
non-static declaration
    18 | static inline pid_t gettid(void)
       |                     ^~~~~~
In file included from /usr/include/unistd.h:1170,
                  from param_test.c:11:
/usr/include/x86_64-linux-gnu/bits/unistd_ext.h:34:16: note: previous 
declaration of ‘gettid’ was here
    34 | extern __pid_t gettid (void) __THROW;
       |                ^~~~~~
make: *** [Makefile:28: ...tools/testing/selftests/rseq/param_test] Error 1


The following obvious change fixes it. However, there could be reason
why this was defined here. If you think this is the right fix, I can
send the patch. I started seeing this with gcc version 9.2.1 20191008

diff --git a/tools/testing/selftests/rseq/param_test.c 
b/tools/testing/selftests/rseq/param_test.c
index eec2663261f2..18a0fa1235a7 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -15,11 +15,6 @@
  #include <errno.h>
  #include <stddef.h>

-static inline pid_t gettid(void)
-{
-       return syscall(__NR_gettid);
-}
-

thanks,
-- Shuah

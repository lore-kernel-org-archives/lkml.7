Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2F7C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F30222C6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569519691;
	bh=nqrjDYO5NaGYDCoJ4hSuDL+jXbKerkXvYaeQofzvXtA=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=bU7+NyXxzBL2e4Mf4KZKx86M3Fs/HudcMGMthSW0hzADag/+IjX5hzXon5akhJAN5
	 Z+HEw/x5MSYjqn9P0M4DVdJg/1gGjZ8Zve5GNHw75yxIJhdYZ3GuB9RhtCNUzZbSe/
	 X+TW3J0dxGzvnyfCS3+ug+sXaut3o414M80SaDJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfIZRla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 13:41:30 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:42213 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfIZRl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 13:41:29 -0400
Received: by mail-io1-f45.google.com with SMTP id n197so8704053iod.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 10:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=XCD2xeyPn+9SlMl+6tWPk/w4mgLYZgUgG9fP/+jHp2o=;
        b=baxHxB4Rlw7tG/EPVqBEdgNik5cSRnK+RIlWcRHg0973CSvw2W88u9DHRyBuEof7ej
         tL3T3T4fJ6IMo9CfD6wmUKHCvF1emLTG/QNyawFrUqnltB2yX7abe09yCsnzpSHk5ZnS
         vbtu/UZ0CAQWR0NGpPKm6yanDn4gy4jDd5/n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=XCD2xeyPn+9SlMl+6tWPk/w4mgLYZgUgG9fP/+jHp2o=;
        b=diMEUYZHf7qLnWWHhj13spi1rmLtPU6LoKd7kBbUGXiaL1rqGFaIYsp+H4GdSle2tS
         lvzT5lHlh5whdRPcZHVIjVjXqH1/ch9lTx9e8SCnOcUnEs/GupgJ66G2hamOGujDp8VN
         X9EYM7ltVcPsf8nRjYpb4IK6/mApXyCX1Y+gW9d5/qwb2c8cjsYluTyCObTK8FCfI0/x
         EUd11+hFRm4HJ4QwhpP4wwgCBEwl+APmH7PWs8dVp+lVQjquKGmq/lpFSqZc7n7tg/ko
         EsqDKou9Ol5guQLj6WQmmUyU2Uimjcugc7we934HjUC/xTBwSbAl4aIvp+aT7HMQ9bkq
         XuIA==
X-Gm-Message-State: APjAAAWpNozQA1+BQxvINPJxQ9hAMW6HNDVlNrN09Pz/NV5au8PwaHeX
        zFB4f8zZwx3QDsg0UHDLEPBUs5B56mk=
X-Google-Smtp-Source: APXvYqx/koFgVWPKTpLAEmigcGzPpnXH6yWphZJAuo49B1qLun85bmt3YrE2S6vhKb7Cq/R+XIbwAA==
X-Received: by 2002:a92:1794:: with SMTP id 20mr3547589ilx.62.1569519686624;
        Thu, 26 Sep 2019 10:41:26 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r141sm1628669ior.53.2019.09.26.10.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 10:41:26 -0700 (PDT)
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: Linux 5.4 kselftest known issues
Message-ID: <a293684f-4ab6-51af-60b1-caf4eb97ff05@linuxfoundation.org>
Date:   Thu, 26 Sep 2019 11:41:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the know kselftest issues on Linux 5.4 with
top commit commit 619e17cf75dd58905aa67ccd494a6ba5f19d6cc6
on x86_64:

The goal is to get these addressed before 5.4 comes out.

3 build failures and status:

pidfd - undefined reference to `pthread_create' collect2: error: ld 
returned 1 exit status

Fixed: https://patchwork.kernel.org/patch/11159517/

bfp (two issues)

1. "make TARGETS=bpf kselftest" build fails
Makefile:127: tools/build/Makefile.include: No such file or directory

This is due to recent kbuild changes and I have a patch ready to send.

2. Related to llvm latest version dependency. This is a hard dependency.
Unless users upgrade to latest llvvm, bpf test won't run. The new llvm
might not be supported on all distros yet, in which case bpf will not
get tested in some rings and on some architectures.

gpio

"make TARGETS=gpio kselftest" build fails

Makefile:23: tools/build/Makefile.include: No such file or directory

This is due to recent kbuild changes and I have a patch ready to send.

kvm

"make TARGETS=kvm kselftest" build fails due --no-pie flags.

I am working on a fix for this. no-pie-option defines aren't working
correctly and I suspect try-run miht not be defined in this kselftest
build case.

thanks,
-- Shuah












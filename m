Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029E5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B742F218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIPAYTNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfCOGaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 02:30:21 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35836 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbfCOGaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 02:30:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id h6so6028405lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 23:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:openpgp:autocrypt:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1OLCgPWC7DY64vnVYhVyW7QE1jsCc5j5JRAu+Ed+wM8=;
        b=kIPAYTNA2L/rtHrAT18Vj5zZbv9YzyhxMMpqVmEWl8rtCXTdpMnyooHvKr7tcw4h2U
         Dt82SCYBGdB+3HPVAJ6ThhWcmvkzFpWZKPlJyz1x6p255WTlVAmkHAHgtwFymGR7cO+u
         JqGwNuc+YSWlI61g6M+lJ+MF8jVKhT8k2gkgrv7F0nOtI7NFPGcU4JCr3ZHzhCve68in
         lsx21BHM38I5GjYWJjmYPLBTtYUftrZpzmncKRrOpqU2lFhq8pxOUp1VjvlU23mfSD0b
         KCvCJPCtjPItdN60C8Q/z13DzP1oC18XRSa+B7W5TnU/VWbsASZ5QvznnWq0fq/LdkB4
         CR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=1OLCgPWC7DY64vnVYhVyW7QE1jsCc5j5JRAu+Ed+wM8=;
        b=f1bZrNRhNVamQYEm59UPW7vtyev4ruWevy6pqkQqWjDGHbTBfX7b2fe9UBa2FKpQor
         9itgAE2p0An0ss2r2P6nuCT5All3f+fEcufRN44aYAZRSj/hCMq+jjTR+DYkqI15/sre
         RS6431Yj6zMt/5oUsCkpHwnK7SnbjoPQv4oGUJegukCT/NrFykciEX4POqpk9MFoOA++
         tBb+J0qsB3kF7V9NqHUoh/b49BZEmpEGcMdn75MRkaGBPFyD3QEVv+OyaUivxpzCpTGJ
         mKGAxMgBa4BcaQUmCq07eqe1Be5kBsVbYD99U0YKAP/XfnaLPXHSjWeXjM95gRTOX7Fo
         8brA==
X-Gm-Message-State: APjAAAUOYnvQ48D0XcGwA4KuVNzsCkNIpcwrHvqAWpai5mKabWdsaxxV
        2zh95o7DTXI48jBfGV6kNydYOzCF
X-Google-Smtp-Source: APXvYqzIT9inHKDWb2rT8CJo1gTxUebm/rbxA6ejnk46+PoQNJuwpj2ZTzy7BkfHx/jlHn8dJjc9jA==
X-Received: by 2002:ac2:548a:: with SMTP id t10mr1113973lfk.115.1552631418122;
        Thu, 14 Mar 2019 23:30:18 -0700 (PDT)
Received: from [10.254.0.22] (81-18-201-214.static.chello.pl. [81.18.201.214])
        by smtp.gmail.com with ESMTPSA id b64sm224600ljf.82.2019.03.14.23.30.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 23:30:17 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
From:   Adam Romanek <romanek.adam@gmail.com>
Subject: tmpfs - what portion of a tmpfs partition is swapped out
Openpgp: preference=signencrypt
Autocrypt: addr=romanek.adam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 KkgCY1AxMySCSuuaJqk=
Message-ID: <621914d0-504c-aef8-895a-2dcaa10e5456@gmail.com>
Date:   Fri, 15 Mar 2019 07:30:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an embedded platform running Linux 3.12.x with rootfs
uncompressed to RAM and using a tmpfs partition. I also use ZRAM on this
platform, so I expect parts of the root filesystem to get swapped out
over time. I'm struggling with poor performance which I believe is
somehow related to swapping. I'm able to measure the number of pages
swapped in and out, I'm also able to measure the amount of swapped
memory for user-space processes (thanks to Android's procrank tool).

Now in order to fully understand what happens within the system I'd like
to measure what portion of the root filesystem is swapped to ZRAM.

I found that include/linux/shmem_fs.h contains 'struct shmem_inode_info'
which on the other hand contains 'swapped' field. If I'm correct then
iterating over all inodes from the root filesystem and summing up the
values of this field should provide me with the result. Is that correct?

I'm not a regular Linux kernel developer so any help on implementing
this would be appreciated.

Best regards,
Adam Romanek

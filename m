Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6876BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395B423431
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lonelycoder.com header.i=@lonelycoder.com header.b="UgVPPHBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbfICPuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:50:37 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:42244 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfICPug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:50:36 -0400
Received: by mail-ot1-f47.google.com with SMTP id c10so5877465otd.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 08:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lonelycoder.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=i8XrzJqX/k14d/NNyJqP2fuyq+Gn/gMNB5vapsoUn58=;
        b=UgVPPHBy7wPMXgWT0jSZjefR28XGx4gtdEcliXDELdGOyuWUfLGaQi196Es/6Aab7e
         UCaGsyvJgZ0adWE8GYH9jZFJ10G6e73ruDZeGltRV3bRc3Szj9eH8BAjef7iBIBZG3sT
         Ilc0DG0V3WcdWZXcwKOl83ia5gb3U5Xdwl1DWM5+FKF8P/R7sVDHG1NkvkbgZquVrhKi
         G+vM4/VrdK8HA2AimQnFyz5sfIiPubj6M4PoBt9YWxYO5YuaAjf+MkuF8bU8LD2QOmrH
         Jr/yQP6SdiegTLH++cc4BWfHCTmDjoRJZh1+bQZQNowRYkl43A/As+siwv/Z/00K9AV0
         ywgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=i8XrzJqX/k14d/NNyJqP2fuyq+Gn/gMNB5vapsoUn58=;
        b=geKtE6eK3acdyUnliglqR1HRVcBYs/ScD5S7/iermqRPY5wsdfZhedjkEPvj8q5JBY
         KyBb3RP7WH5cRwBj7UTuQmX1IhFOdD95aTb8NV/EqJR2/1HEpE9L+pRSLhIuZyBP2zX9
         4KWcJ8YBjUt17gWSWDJ9R2iE7m+tTTNhdU+FXM4gO+TsnRlNFNcoowrcL0h5WN+aS9r1
         nKGA5i/IC97NU6no3uMJwR2fkzLRk7Rd7szOdM232zFXMM+FPlYxw/HhcGsNxO0FCaYd
         0x+rmjpdXikM1HoyHbBXpo1+9pjhv6cgnykd2hquPQZ7KW/Wnk0WKyf3/K9t8qmgcy8i
         w5Uw==
X-Gm-Message-State: APjAAAWudf4mkN86BdBkNO6aur8+pVhx/za9gCyGPG0uGsyINM2UMGEJ
        FgL2YeDHpa+OXxwgr85FU7Z/M0D+XyiqpzcvunCtvSFS75w=
X-Google-Smtp-Source: APXvYqyN6cw/+flwkfGoM7u8JTsci0bUsTH1m0MnvNpbSpg1XPjL7sEB3w8MODkSqhhPK+wbj5t5VK3b3aWzlUh2h+4=
X-Received: by 2002:a9d:4d0e:: with SMTP id n14mr4209186otf.285.1567525835588;
 Tue, 03 Sep 2019 08:50:35 -0700 (PDT)
MIME-Version: 1.0
From:   Andreas Smas <andreas@lonelycoder.com>
Date:   Tue, 3 Sep 2019 08:50:25 -0700
Message-ID: <CAObFT-SqdcM2Xo7P3FqgwTABao5uoWrb+A3bXy9vKt5rBffSwA@mail.gmail.com>
Subject: x86/purgatory: undefined symbol __stack_chk_fail
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For me, kernels built including this commit
b059f801a937 (x86/purgatory: Use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS)

results in kexec() failing to load the kernel:

kexec: Undefined symbol: __stack_chk_fail
kexec-bzImage64: Loading purgatory failed

Can be seen:

$ readelf -a arch/x86/purgatory/purgatory.ro | grep UND
     0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
    51: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __stack_chk_fail

Using: gcc version 7.4.0 (Ubuntu 7.4.0-1ubuntu1~18.04.1)

Adding -ffreestanding or -fno-stack-protector to ccflags-y in
arch/x86/purgatory/Makefile
fixes the problem. Not sure which would be preferred.

Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F327C0650F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 00:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343DF20880
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 00:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565568058;
	bh=1VR2kDuTcJAzssZCyY55GyJV2FkB68whuLXiv4whc9A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=a+yVoNmwS3JTR9qh7fgNCBaHLmm3wRWM0nMgr9SYvI8qEmYW44hTmfxOSZIggpCWv
	 DGceRqaLG/2nDg9gGIcx9U7EBsyeAVsCvhXwC37byAGU6DOdkH2IjdrLm5Vk29pMCI
	 dBR7hX26Dvrll//XfqhmBv0kvMaxOQBcfwPu43A8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfHLAA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 20:00:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfHLAA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 20:00:57 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1172A216F4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565568056;
        bh=1VR2kDuTcJAzssZCyY55GyJV2FkB68whuLXiv4whc9A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LpkknFfY58iEyc7Jqk2kqb1GAXOc7eyisIuALiBgT8Bdi33PLBiYPLo/qsBezUMyw
         SMn7/VPPe3SBiuWN9Hq//SXnsr56BqwaIbiV3QUI/k5k98qODJc1SOtAhxA4njW05o
         J8UfnuJbqRStWzFmsh8fRxWP61kBx29lBfPsJ6Qo=
Received: by mail-wm1-f50.google.com with SMTP id u25so10226519wmc.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 17:00:55 -0700 (PDT)
X-Gm-Message-State: APjAAAUIwPqBMID6CkyBMjCIdFNdsaO7amYAVKL8wUDHv7gMwN1vx1Vp
        PfORi2dxhagrDTJmxjOvKSRgEzb1ThAovkVwYzMTgQ==
X-Google-Smtp-Source: APXvYqzuNwp2LQBs/96UiHIoYBwZub/GPOLZba9N3shcHjXJ8lEROLaY3m1CuSYllFzvwevDON938nGwCaaJofXYIBY=
X-Received: by 2002:a05:600c:22d7:: with SMTP id 23mr11820267wmg.0.1565568054462;
 Sun, 11 Aug 2019 17:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190810010758.16407-1-alistair.francis@wdc.com>
In-Reply-To: <20190810010758.16407-1-alistair.francis@wdc.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 11 Aug 2019 17:00:43 -0700
X-Gmail-Original-Message-ID: <CALCETrVArr5TTbXayDZ9rz90iGoytGW2bnV5_ZOunhOsPR1u4g@mail.gmail.com>
Message-ID: <CALCETrVArr5TTbXayDZ9rz90iGoytGW2bnV5_ZOunhOsPR1u4g@mail.gmail.com>
Subject: Re: [PATCH] syscalls: Update the syscall #defines to match uapi
To:     Alistair Francis <alistair.francis@wdc.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>, alistair23@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 6:11 PM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Update the #defines around sys_fstat64() and sys_fstatat64() to match
> the #defines around the __NR3264_fstatat and __NR3264_fstat definitions
> in include/uapi/asm-generic/unistd.h. This avoids compiler failures if
> one is defined.

What do you mean by "if one is defined"?

The patch seems like it's probably okay, but I can't understand the changelog.

--Andy

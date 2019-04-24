Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81517C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427A02148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgMunM/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbfDXQ7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:59:22 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40993 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730844AbfDXQ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:59:21 -0400
Received: by mail-io1-f65.google.com with SMTP id r10so12538841ioc.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=lZw1w2iC+8EBuaczyMprPgkKgivlgViKX3QQst1LzcA=;
        b=VgMunM/cgEbPXCFOPZ3tHsEieHfYavrx6UzM6NZhxNM3edemvDdWhCDk0Yufw/Rg45
         c35UeE3B/MgP2jpw25Ddu07vDxsmnnsx1OPg1tPrKkhTBuSCSmqLS59n9ktJWVywI2Dn
         M8l6a3DFG7RRqCBdvFQFpqzrmzQRAfK8fMfJjxz2BReUhTEN4FQaXweXKkHN0LfHx0s7
         d2c70GH+9DotyBK6cJQf8d34b9UKJX8QyglnUCBHC0zAFE5imX9/QuP7anFB4704r3aB
         nc+x5pGuBP9vZ09KjV2p4LypZNPevG+CW9AAZ/dLv/O77cUN6nxqUQh5qWazQgecjX4W
         9HYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lZw1w2iC+8EBuaczyMprPgkKgivlgViKX3QQst1LzcA=;
        b=XE61XPoeHH8WUrqj1GnV+/4RrwT1Ip+Oo4R1Ke6ARjuU6ez/QRFpw4EXH2ngXXYvSo
         ZUJW8RC+8eW3vstrBeIus8Ke2/x6ZcgBitEZuSkR0S/PH8l8gR+qla8I2jBP4Wps+R5V
         dt1rXXPNP9ClsI2JbhUWtAt9z7em4BTdYblfb+PTx0Tx2PAz6WaNGiYMEaKC3kA+W2Gv
         ZgQJ3pIlJJqi5KTszKL9wVkMxDB2yC/RDQO284heFfCerIIop2TDmBjP0pbURYtlKfv+
         gJjS3FLbAJ0/o671wDOYSwIMreDfW26E5QrctlWYNsvtYBf0jFT9JW2PAiWK2YybgKUm
         WRhw==
X-Gm-Message-State: APjAAAXE9n+lw1wy2nyQKBfmopFcj8/c9A6nhZtNd1LAlXn3nmmzJRcD
        0HcuaupJYwUUNKQUF9gsALCfFcwqIkItxKOoM1E9yorE
X-Google-Smtp-Source: APXvYqxC/NMP7dOMltc8/ruljb8OlrCO9iCgB6F7o2r0IkrJ0HIJFSZ59E6ggytRct/A6pITEC45IRoGKwK5bQaGUz4=
X-Received: by 2002:a6b:3b53:: with SMTP id i80mr3774004ioa.142.1556125160968;
 Wed, 24 Apr 2019 09:59:20 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Ambro=C5=BE_Bizjak?= <abizjak.pro@gmail.com>
Date:   Wed, 24 Apr 2019 18:59:09 +0200
Message-ID: <CAJ4FQ9AczEXM27=Pn_5iaaAXZ=nA+6FQu7_TRdcC=5RHpDFx4g@mail.gmail.com>
Subject: Re: Oops in current tree in i2c
To:     linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This buggy i2c patch (see https://lkml.org/lkml/2018/10/27/248) has
just landed in stable 4.19.36 without the appropriate fix, causing
oops on boot on many machines. For example we're experiencing this
issue with the NixOS distribution
(https://github.com/NixOS/nixpkgs/issues/60126). I am currently trying
the fix (https://github.com/torvalds/linux/commit/b59dfdaef173677b0b7e10f375226c0a1114fd20)
and will report if fixes the crash.

Best regards,
Ambroz Bizjak

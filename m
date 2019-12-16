Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8863C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 02:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BD22465E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 02:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK35t7gn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLPCsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 21:48:04 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:37798 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfLPCsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 21:48:04 -0500
Received: by mail-ot1-f43.google.com with SMTP id k14so7151722otn.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 18:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=b2KgFqe1PVkiPaZCp+jLHjtFLk8rD2yySP0eLQBtgks=;
        b=gK35t7gnezeEFtlXg4Pu8X48qf4LFyQbb8jmVIlYgstXPbj8NPkG3OxhwgRPl/ZbzJ
         /5dzsoj6PMmnkPPsD2qGm7EUDbsrnapvPi0FiOqLQB3nXMabg2tnMKhgxhO8K1ptMvmx
         Xi0OS4CTl/n+Eo93IoZ3ESgps/i765xBMQ+Dp9lso9Z4HnyN+VnnS1ualaMOv5N2zY0B
         bn+14hWpD3ZTHGQv1/WIc8lBWuYmr0Wcub05D46VBFwxEBiJcdeDGJkQLU7/j35RUiKz
         F1eEIYD0OoPvY9iV2FZxJqQBAnGHnqel4VRZ9O6tPZmbWkMN81wZNtAXRAm0cW4aRYlU
         fnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=b2KgFqe1PVkiPaZCp+jLHjtFLk8rD2yySP0eLQBtgks=;
        b=ry5TLpzz7udXm3M/uxNHlaBEZevhkr5Xt5ApAgZEhpBQQq+hK4DEMiOVQFitgB1yae
         /wAR7y8cDJzj9ubVDYUAZCgm7HDZBdpNlZsc3g5dY39FMh0lm5kx5j40YO/+EKmRU4j/
         qdnWel824HJSYXZtwcNx9y0JBNkuJqksiEipjeddEwxsQYZi9Kt1U6daZ6nLFOjoAP0+
         4q5MKNLi2GnaQ53D5OSEuZj7+B70NjPZMjY0yUiMRARpch5TTfmDrU/du+zpPy1FcbGk
         VJFIMrdtQne1jmBE9KazKQm7BLFe7jkfs6e2igo4nmXywUZ9TYWFX06UPOJ30MgoAZ9J
         m+3A==
X-Gm-Message-State: APjAAAUATKxqXaFsMbPny1KtIeYhmtAuTG5OhGZdqGSo/mycst2bdUpP
        JB5UBRcueYQHdXuN5ofDAzc=
X-Google-Smtp-Source: APXvYqyGBHlvaUtx0XGvLhcIGX1AVUbAzBj9XK1yL1TDXPx+0ujGBm1o3KFYtTc0dLFlOSm9XhpUdA==
X-Received: by 2002:a9d:2264:: with SMTP id o91mr20785913ota.328.1576464483451;
        Sun, 15 Dec 2019 18:48:03 -0800 (PST)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id s83sm6234603oif.33.2019.12.15.18.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2019 18:48:02 -0800 (PST)
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: VirtualBox module build breakage since commit 39808e451fdf
Message-ID: <392d86d2-76a4-03d2-5517-3c22bcf3e535@lwfinger.net>
Date:   Sun, 15 Dec 2019 20:48:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since commit 39808e451fdf ("kbuild: do not read 
$(KBUILD_EXTMOD)/Module.symvers"), some of the modules for VirtualBox have 
failed to build. There are at least 3 such modules, namely vboxdrv, vboxnetflt, 
and vboxnetadp. The latter 2 require linking to routines exported from the build 
of the first, thus file "Module.symvers" is copied from the build directory of 
vboxdrv into that of the other modules. Even though the documentation says that 
this method should work, and it has in the past, it fails after this commit. The 
necessary external symbols are not found.

Am I missing some step needed to make the copy of "Module.symvers" method work? 
I understand that the method could lead to stale values; however, the build of 
vboxdrv immediately precedes the build of the others, thus the values are always 
current.

Thanks,

Larry


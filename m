Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B834FC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912D327A87
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="fHnCkh64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbfFCPJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:09:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46689 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbfFCPJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:09:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so7225704wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 08:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=Vqm1HfyKlx7kXvXfV/7917TkSslzuRGRJYlsCpZ14dM=;
        b=fHnCkh64opjMDENTgwjQ13bgW0T+1YoOzZowkcdkniBNVXm8aGFQDtJj4HlKZKRAFU
         hN6AEfR1z1NueaPGflcdbBVgeDT0UggM8NP4ipfGyaYPuZO2XQtuwnfEomt/a8JcL3sN
         jB2mKZ1hk93hJUcZQDMUMa+Tav97VD1OKkWSVhCTGPaZLxJiJ1lBtpnwFJQvTyOPjeIW
         DtcgPKo56GFWK7+yvS/Yr3EH418gsFv8dxe3nXW3JquC39gPHz+GSJir8Voot3XO30ee
         FCquu6dmUxV3rmTMp7TGefhnBkLW9ePQFiZn3LtpQzSv4PRUX0+f6EwXS/XvgG9vjWif
         OsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=Vqm1HfyKlx7kXvXfV/7917TkSslzuRGRJYlsCpZ14dM=;
        b=DjOk1FLIoJBw0NtfoVYcJFbF2NgXkI4rh4ztNhg4/IGIindKqFyTUrrgolligq47tn
         xvKcIACmupf0jYGy7qqT//3Rt7Cc6iIjPNF+Wkh8+AmQZtu/n5WlN+tfM4Gw2B/Z+p+9
         8nIOV8uT29fT531ek7e6ZswD31FCcpNSz88+lfjjVJH2a5dyP50eq357t1kA4iTAry6R
         8oDEzESI08CPKRAiUjpbjjCa1dlc/UnV8WixWro6h2UAmbnwfLPd6je+WmkVgZvAbEMe
         OIAll5Usa9rVRAJIiWpL5UJfIkJqXypwP8JXqaTswDEdDg8stIWYKu4g33nK0GGqn8XE
         7X0A==
X-Gm-Message-State: APjAAAU9aIrLfDx2TBGZkluFyPfqo1iecp064BZWOonxnm8UHxFbOkZo
        vq8hHmAGeCmlsVYkfIuPGmqFrg==
X-Google-Smtp-Source: APXvYqwU0lVglIFJfMRaSFftIxmyAjZdMht92axgOZOB37s5N3QdzwpNosqv4p6DZN+PAalximQWFw==
X-Received: by 2002:adf:9791:: with SMTP id s17mr2904169wrb.274.1559574568930;
        Mon, 03 Jun 2019 08:09:28 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 65sm30009471wro.85.2019.06.03.08.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 08:09:28 -0700 (PDT)
Message-ID: <5cf53828.1c69fb81.8054a.1e80@mx.google.com>
Date:   Mon, 03 Jun 2019 08:09:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.19.47-33-g322f4070727b
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190603090308.472021390@linuxfoundation.org>
References: <20190603090308.472021390@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/32] 4.19.48-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stable-rc/linux-4.19.y boot: 126 boots: 0 failed, 126 passed (v4.19.47-33-g=
322f4070727b)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.47-33-g322f4070727b/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.47-33-g322f4070727b/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.47-33-g322f4070727b
Git Commit: 322f4070727b6cedd9f682203efe5b910b4daceb
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 68 unique boards, 23 SoC families, 14 builds out of 206

---
For more info write to <info@kernelci.org>

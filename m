Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E038BC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5110207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="xBJv0v0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732840AbfFMPAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:00:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35012 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732593AbfFMOu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:50:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so2135328wrv.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 07:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=+RVryizvvLr6nOq3Y01zEZUNig98tyiJRX4i4NCALjE=;
        b=xBJv0v0TSyN8bw8PWIksiodNdVnS0bNOdkdaPCTrqfBtTUc/nGc7nWBbWif5k6JkXq
         usFYBwUlCOyMbDlh/FoSW9XPYjS4T230SW6n9glJj8zd5JdGL+GgQWRqNOvfecnA76gv
         6eOjIzXDXOs+yI9wxF61TSNQmk+Dle+G2T5o8kb0NZrAzMmngu8iOLmOkjEK49lMI4Io
         zdnTk84Bb3fx69dbQ9/Fn2Z2FpdvWpDdh+x02D6nyiegk/N69uYDNWkhDxMEvBPqyiDz
         FDXbZFHu8L6A4PJ4w7kFm8OQCfuuagTkO4ZSAHMS/2hCdvSIAqCXPk4TiTg+2fd06jFg
         yAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=+RVryizvvLr6nOq3Y01zEZUNig98tyiJRX4i4NCALjE=;
        b=n3zib1zGAxk6dUTeEgIkBK5Dvhw7iXNUIGzJe/rBGeDS3ixAgSC0OXRkvj2D3b9kpg
         rqTfkeVgjrFWGznmSdhpHOzy13oegiRC+rypTv2wP3l5tBYpN7xAWGZYMagiWmsNIzP0
         cr9NtsFTiRQfBClFzaq5ddRJYA/48jQG6GuccG2Gj+6ffg1dMdYoKN49DQrsd7120h8t
         8DQiSRs3KOXMSUDvt5fKDOdStp8ki/ShHbYBR8Dq63rqefZ+lzuBdUdGNhOqAIpM73ym
         G8EcC18L/q2Oc1ZW/KBnGR89zk7iJ+2UfplOWM6D0pDjcQPWL6mflViDMwIdNJReAf5m
         Xy7g==
X-Gm-Message-State: APjAAAWTxW4vymb0jyR7fdhMT4O4rALSp3Nx0RyxCu3Xu6jA3lrsxnG7
        v3FstbjhXeO3iPjNeKThX9wrpQ==
X-Google-Smtp-Source: APXvYqy/bH48WG2Ohg8ojqkK4a5frK9X1C6pgGv/KXkJRNWsBDmprDYicYLILR5YpvGxfREuljEXdg==
X-Received: by 2002:adf:f709:: with SMTP id r9mr28995624wrp.281.1560437425787;
        Thu, 13 Jun 2019 07:50:25 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id j7sm5185106wru.54.2019.06.13.07.50.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 07:50:24 -0700 (PDT)
Message-ID: <5d0262b0.1c69fb81.7fca4.cf70@mx.google.com>
Date:   Thu, 13 Jun 2019 07:50:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v5.1.9-156-g10f90b20eaf9
X-Kernelci-Branch: linux-5.1.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
Subject: Re: [PATCH 5.1 000/155] 5.1.10-stable review
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

stable-rc/linux-5.1.y boot: 59 boots: 0 failed, 59 passed (v5.1.9-156-g10f9=
0b20eaf9)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.1.y/kernel/v5.1.9-156-g10f90b20eaf9/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.1.y=
/kernel/v5.1.9-156-g10f90b20eaf9/

Tree: stable-rc
Branch: linux-5.1.y
Git Describe: v5.1.9-156-g10f90b20eaf9
Git Commit: 10f90b20eaf9cf31c4ea0cbaf10dfdd807834a6c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 29 unique boards, 14 SoC families, 11 builds out of 209

---
For more info write to <info@kernelci.org>

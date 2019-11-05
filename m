Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBF7CA9ED5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 05:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756E820818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 05:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="0izHWH9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbfKEF4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 00:56:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45866 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfKEF4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 00:56:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id q13so19824927wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 21:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=4SOW2PoFDC+5EU9P1L5VhY7dqUymZAfiXnqCmxEB2J4=;
        b=0izHWH9lH+4BPhxa7PNCyGjd+TiBnBvvNvn04GwgAtHIIsuG71SvFiWtlpL3GM5Ehq
         ROXRRS7jjY5pDl/ubT4QWMVcUWZ2aTAA72R8niXK9JptleSx8G/rZQmuO8m/nODUD/YF
         SbvOLH7QOWDDvLTJXrtaPLY9OqyZ38L8Q0o9M85aXGPoswygpToQnf/9kGdiyTpB9h19
         PSgG0Pws3vMSMP2epAZAHDjhdsyl4qSvOOzjTnWf7x9+ohGoVbLyQ9oc13QBicJ711VK
         j+t+exEhv7CfsmoG7k2tAssVNCitTiqangSir41jrXs4Ro/ogQk78IjE4OgPoZKAmhtM
         uOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=4SOW2PoFDC+5EU9P1L5VhY7dqUymZAfiXnqCmxEB2J4=;
        b=sWF7/joh9ml4i73BYLYDAgZGIByCSWTCTOrpBYgeadz1uqN1RD4N2cVCf/SKBuDaN6
         jtM1MgVIH4MKCQGmhvQ8ZONSPATVlZSL0EZ57ab8kjgkoHCNHcBsbODH9hwPlMCWcWN6
         OponInvLeQh7q9FAhX+7irOhCNQaKvGFZnEdsqv/4WqN04UHtE6GK0KvOk2oaVg4USP2
         alxIwxERSfXQdUAXhK4xXI5uvro3be72JhfYr8r7gnwRIXZk16Vq2QefX12UVij/5c6g
         PcMKosiKwaGmM+Lr7QHvwspUhMS+ZGf0OPNm+0lUDQQNUBfWTm9wM462npx42+mxItKy
         oR/w==
X-Gm-Message-State: APjAAAUT4WZMKmyYCKDbb8v8QieAEIzDB+KQvPuy+x5wqp4J7GeXUHXo
        Sy3rh7lBeaezk8h/De9qXFaelA==
X-Google-Smtp-Source: APXvYqweSIUhVVEPRZ4zXwvulFNEUKw1P+l8RWgUsliVOtATLOZL98k/1VPXRk9hEohT/pv3P3EzKA==
X-Received: by 2002:adf:c58f:: with SMTP id m15mr25805904wrg.362.1572933403002;
        Mon, 04 Nov 2019 21:56:43 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id w8sm25005215wrr.44.2019.11.04.21.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 21:56:42 -0800 (PST)
Message-ID: <5dc10f1a.1c69fb81.a2525.0027@mx.google.com>
Date:   Mon, 04 Nov 2019 21:56:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.198-63-g1787d5fb47ee
In-Reply-To: <20191104211901.387893698@linuxfoundation.org>
References: <20191104211901.387893698@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/62] 4.9.199-stable review
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

stable-rc/linux-4.9.y boot: 93 boots: 0 failed, 86 passed with 7 offline (v=
4.9.198-63-g1787d5fb47ee)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.198-63-g1787d5fb47ee/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.198-63-g1787d5fb47ee/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.198-63-g1787d5fb47ee
Git Commit: 1787d5fb47ee9c16fabc1473a713bfe3f3af7df7
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 49 unique boards, 20 SoC families, 14 builds out of 197

Offline Platforms:

arm:

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    davinci_all_defconfig:
        gcc-8
            dm365evm,legacy: 1 offline lab

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab

---
For more info write to <info@kernelci.org>

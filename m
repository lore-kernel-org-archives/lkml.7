Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DB4CA9ED5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2073C214E0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="XryC2/z8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbfKEBgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 20:36:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45657 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbfKEBgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 20:36:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id q13so19358185wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 17:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=w7r0LjzllQQTwysTmv6X/IPV8I2SxJrnfllR0KsPQJ0=;
        b=XryC2/z8lUj8e7WOUTT/TqqmRfs7C1rwpnm87xiie31TV7hnQBSoqNBWvnDuEG7qOV
         TdMPmrTWssPpqBW6i9uUYCcHLtJjAe+twMcHcKvycO4kztxFAXR9VG8bpD/g5FSJvz/Z
         oRHyKx5j2fs40hswstx0OEP8SP7mWPfC69A1mUVy2HpvT1zkMASGUDmm5jB9dZZMxVlw
         Ux6Juedo80K2GPm+RK5C23TgHqKJ45uweWIFeLvriJKzx+daKuP61KZU6puuZvD1X+MK
         80nADeBSrULSytPOE8TbhwqVlILhnq6lArVoyiUTU4vP2y8wLtARy3eOhu+GJ38so07v
         J2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=w7r0LjzllQQTwysTmv6X/IPV8I2SxJrnfllR0KsPQJ0=;
        b=hkqZTdoOlvC225CyxLzTVjdj8HPeeUG/TChsXr6xbmWL4sgrtnlX/TXns1T9FggHZu
         nMMjqey2iXVkkXMsxDnhOYlDy/IRify1EPqp0lmwkeAnznk38AlPCw9YL4lUpwj1ljKL
         28T0BzAC9iLgJN/Py+dhJjyKC7RcKjhCNcJDuSt/GwvsWxZyIrK1UZeMZJBqQnehFHMQ
         S6FjMYuLMzf2uveyyD80xfv2BS8o1AgCiJXTUWXmupxXTK1j79BBl8mYy/6guK4EJW5n
         FBaF5y4+LdrdAq2VDCzCEJMt3mv1jUw26FMhFGfBXpJvMUuklbW6dgYBTVU5I8B5K3OW
         HStg==
X-Gm-Message-State: APjAAAVoHp2BuN6vxAPBNrEEBKQHmi7yH8rkT3Ig8S9S/UupeArKlED6
        K4+1oAEmc/YRrep7dN48kuMnkA==
X-Google-Smtp-Source: APXvYqxULyJViz7Yz6PvLQAdOWPaiGgeJKdEMg1tOfT4wuf/6bSCkhDmNXoPivBDshX+keDiU7bynw==
X-Received: by 2002:a05:6000:14a:: with SMTP id r10mr24868855wrx.310.1572917801322;
        Mon, 04 Nov 2019 17:36:41 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id u203sm13008917wme.34.2019.11.04.17.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 17:36:40 -0800 (PST)
Message-ID: <5dc0d228.1c69fb81.7f1dc.9272@mx.google.com>
Date:   Mon, 04 Nov 2019 17:36:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.151-95-g3f14236a3fe8
In-Reply-To: <20191104212038.056365853@linuxfoundation.org>
References: <20191104212038.056365853@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/95] 4.14.152-stable review
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

stable-rc/linux-4.14.y boot: 11 boots: 0 failed, 8 passed with 3 offline (v=
4.14.151-95-g3f14236a3fe8)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.151-95-g3f14236a3fe8/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.151-95-g3f14236a3fe8/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.151-95-g3f14236a3fe8
Git Commit: 3f14236a3fe8cfb5c238b250eee737f9c78c402d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 10 unique boards, 2 SoC families, 2 builds out of 201

Offline Platforms:

arm:

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab

---
For more info write to <info@kernelci.org>

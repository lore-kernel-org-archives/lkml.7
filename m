Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD7EC04AAA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371BA2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="STP47j7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfEBTqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 15:46:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42231 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBTqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 15:46:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id l2so4992465wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 12:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=PPKlM6ilF+RkuSDVJ6SNKmbFhrwgZfo86vIcplrjIGs=;
        b=STP47j7HepJrq5qfRhipbbid6HfvYjzUCDuJcAIILX41LHI+xjdk6K0wo3HXdkRCBs
         OHkq0ljl+VlIv3r94Ba3rUI0vZMcge/amtHsGcDlrBh2tAwqDZ1VZVYjvTlKQ+/AiR6v
         FPWWa0mjK3LTf3JOqjwp1wbWvuVZlm6/UlkI0W1G0HYh1PRuXAPfPsQzoMhTkAf63Huh
         030xSj4/LYs8YysWuvp9euWI9KEPNyWmMa4LNTDyn6Z+kUbxlZjDAup+rqTkQq/Bp40l
         6jsWkexImXi3uS2jhYaLg1BnBa4Vr3Eo+Xpfeqobq0i+Xy5ah3VyL0r7ud1BiH8KxTW1
         vmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=PPKlM6ilF+RkuSDVJ6SNKmbFhrwgZfo86vIcplrjIGs=;
        b=cS67Isu4ifR8FxGhfqCETNQPGXVjdcZ5ZIClsN8FRkWBkdD1jUs5gcmYzO1AWH0XbF
         pt0RXT980/BLnjF9I1pjd2yLY6cAn+JjrQ8vYg9ROnV+4eI55CteXFP1RjCLXQ0nDnqp
         KynW3WoZWT79XYld8qDqGqGh6cVuChGE3fvgo+KrQiUN4Q59AeMJzgRdgwam5lkMJLID
         Nq2gaSWXzFqO8GBFkVaybUVQrP0Voruu3cr8HI04CqCfQwHtJBKg+zvSBo5sC26IS+7x
         4X1XqaFz1+qYrVv5U0Y+EtzyKkstM49jjvaYOra+Txxg50QYgj0AoZGVWTGup9rcXjsA
         fJ2w==
X-Gm-Message-State: APjAAAX2CtVpoTEtfduF9BfT8/QzXjFUAqCWGMhgf/S1C4zCv46kT5PO
        gCMprrWrbKuhqnviQwfFgOkQvQ==
X-Google-Smtp-Source: APXvYqyMHUSSVqgm9gT9+BCN718D5XJraPqR9H8SNJ1JKGaMYWhGx9TQ3dWcLx2S6YDwFfKYUdSdiA==
X-Received: by 2002:adf:eb87:: with SMTP id t7mr794403wrn.39.1556826389212;
        Thu, 02 May 2019 12:46:29 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id s12sm81242wmj.42.2019.05.02.12.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 12:46:28 -0700 (PDT)
Message-ID: <5ccb4914.1c69fb81.e4b8b.084c@mx.google.com>
Date:   Thu, 02 May 2019 12:46:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.0.11-102-g17f93022a8c9
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-5.0.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190502143339.434882399@linuxfoundation.org>
References: <20190502143339.434882399@linuxfoundation.org>
Subject: Re: [PATCH 5.0 000/101] 5.0.12-stable review
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

stable-rc/linux-5.0.y boot: 129 boots: 4 failed, 121 passed with 3 offline,=
 1 untried/unknown (v5.0.11-102-g17f93022a8c9)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.0.y/kernel/v5.0.11-102-g17f93022a8c9/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.0.y=
/kernel/v5.0.11-102-g17f93022a8c9/

Tree: stable-rc
Branch: linux-5.0.y
Git Describe: v5.0.11-102-g17f93022a8c9
Git Commit: 17f93022a8c96d740be0f8dfc01e1ccaa70eea5f
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 74 unique boards, 24 SoC families, 14 builds out of 208

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        gcc-7:
          sun8i-h2-plus-libretech-all-h3-cc:
              lab-baylibre: new failure (last pass: v5.0.11)

Boot Failures Detected:

arm:
    multi_v7_defconfig:
        gcc-7:
            bcm4708-smartrg-sr400ac: 1 failed lab
            bcm72521-bcm97252sffe: 1 failed lab
            bcm7445-bcm97445c: 1 failed lab
            sun8i-h2-plus-libretech-all-h3-cc: 1 failed lab

Offline Platforms:

arm:

    davinci_all_defconfig:
        gcc-7
            dm365evm,legacy: 1 offline lab

    exynos_defconfig:
        gcc-7
            exynos5800-peach-pi: 1 offline lab

    multi_v7_defconfig:
        gcc-7
            exynos5800-peach-pi: 1 offline lab

---
For more info write to <info@kernelci.org>

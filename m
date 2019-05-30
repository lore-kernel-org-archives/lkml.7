Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED51C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E5E24F8B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="grcgzb/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfE3I3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:29:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43801 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfE3I3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:29:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id l17so3549134wrm.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 01:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=WtCAXTwAkrdeG9KNtGkpEqVQZWYFaR0KgJ5gewK+STA=;
        b=grcgzb/UzF2ls0EnJzcideiHokQRVDVYCYGmMCvfKcs+7W39Tnj+o0pIyS0Bm7y075
         /Pug7pPRpNyr49yzNY/9ZbGHvcPqv5d2rAkktHJjZvu54/iPW+myVW67C5iqzoK1b1fG
         t4gURqB2gHjljY/+86c6Y5Gx1AvSaC+Scwn4xvd7UcfDgXlWKCefPOEMhfeDDXEq5Sq+
         rqlkHuhJ3hdjWZiA7UQ9w9T8Mik0sN4jWOMlOcH4qXxa/s+TO2xBm+/hpRB02CwpBHwx
         bO+mi8T89eDPdmRs8x1C617mGH91oIX1LtR+De14ASMwR+t8Fqgiz+CA+NaRvgleGa6h
         9uGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=WtCAXTwAkrdeG9KNtGkpEqVQZWYFaR0KgJ5gewK+STA=;
        b=I8zbZ4FzIjS+QB5YJb7T9nsAHhEtOciBdUTCfaShpA+lsluFVmH1nfEMnugo/tMzhE
         +P/FBtnHcWrvgH1AWdWG+TTZBKgnyZHwLRwdsDPeTwaM/ZbQKqIKhQ5FtLuiLFaLB31i
         uqI0Mt+a+GRIP9pqU7mw9Pj5X6O3ug13UrDCVCMLZSnlS/6aER9IKvSJCnq5t2fRVhyF
         j0ZuM+1bsrAYFC5A9NXSUFILuugSpZyUpp36kHbS2RShVXvwRttAuTDkUmYsefuu1op1
         3duzhRhnr90aIVqirFHTdY51yqIGvau+ISYefcVwCtX7Ewi50mSa+D3NqYsXF6xunAtw
         YMYA==
X-Gm-Message-State: APjAAAXP8vfpHpFfPpm38L2GOLn62ll1cMqfwAb8Vg6zrAS49XP9Hjxf
        qFROSX8FeQ5nLz3SJnhfi/8Upw==
X-Google-Smtp-Source: APXvYqyDX0g+5H2piWndoNx/n2oKxpNw4/2WQvGSl3zp6MJmpGEElf9g+/b63V7Al/iOEXPiwO2cxg==
X-Received: by 2002:adf:e705:: with SMTP id c5mr1736190wrm.270.1559204946458;
        Thu, 30 May 2019 01:29:06 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id h200sm2849400wme.11.2019.05.30.01.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 01:29:05 -0700 (PDT)
Message-ID: <5cef9451.1c69fb81.5e0ac.e557@mx.google.com>
Date:   Thu, 30 May 2019 01:29:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Kernel: v4.14.122-194-g0352fa2fdaa6
In-Reply-To: <20190530030446.953835040@linuxfoundation.org>
References: <20190530030446.953835040@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/193] 4.14.123-stable review
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

stable-rc/linux-4.14.y boot: 115 boots: 0 failed, 115 passed (v4.14.122-194=
-g0352fa2fdaa6)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.122-194-g0352fa2fdaa6/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.122-194-g0352fa2fdaa6/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.122-194-g0352fa2fdaa6
Git Commit: 0352fa2fdaa68f3e27866e6f6a5125aa9efcefe4
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 59 unique boards, 22 SoC families, 14 builds out of 201

---
For more info write to <info@kernelci.org>

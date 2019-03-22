Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45524C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7CB20685
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="g4U7ide2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfCVXCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 19:02:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34509 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbfCVXCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 19:02:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so4034722wrq.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 16:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=8rL+UMP6TAtciLpXnQ+tA4tl+u/Pl2k8WccePLxJ8rI=;
        b=g4U7ide2Q8EWR2SBMY1qgrRtT1wX3xLCAc94pQFot1WAawqoD2AVN3MO47YJdrUwZF
         +4F8J+i5ae68GvNYhAgcpt9F7RZA/2OpOueVSBgTpC+wWdo49GjxQlnEhmz3dXmYrmrF
         37SeIsb204OO89kMv5EdaJoUYA9B4yFToVygpE+rQsdlcDo7RimpJsFAiVeubeXExCYj
         Tj4mYaWKaq1Nb2Q4xHQWXHdKM/FoawgIs1+K1/b6uKRb3YPg0qZ5hnGZVO7Fba2pIhcA
         RkxTAv56Os4pse08YQdPuUqSd3PscyYeAw2JfqxyoP7QB3emXEsnrxSzMN5iA2PxWWfp
         1eQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=8rL+UMP6TAtciLpXnQ+tA4tl+u/Pl2k8WccePLxJ8rI=;
        b=Xjx9GSFxRrhzk0tmxOJ+NrLYT0gzKLmJqYjRWcITECDpcrp/6nyNfQJtSRHs6zAl07
         7xUcnoKeyqzvWJNpaRF2q8qNIYBP658t4lGXc1yTnzCHhNIdaYD36mFhz2SRxSjEMGKk
         ETU2HCfwwHb4mzvGUWZ6RnO2HRUKqqJsgm9u6N20nYzApEl3kbGvOHKggnHPDlkbQYsG
         hdq+XQiF8x8guDjfeLGEzBs5yc7vOH3AIt/fQ5ZV9BpUYLraSSUrUH2sOCO/oLm8xxcy
         1QYVHH4C/xAkQakkMMCz4V4co0O1Fx7XuwXGORfgx7rCpDD8jE5bbG+4UC3Pcb3UfUbm
         C4Dw==
X-Gm-Message-State: APjAAAX4KdggXeM7XquLW8B34qC0hOFLj+HURnAMDv7MzjzK+VU3ql7D
        8dc5433RFjWDjeZB70VZfkAVYg==
X-Google-Smtp-Source: APXvYqz1xX9MdwmJ8RVJoOir1A77emNqPTzNTtu/7V2zB0Ul6RHg4F3YgJDhyWmEvHS2jwpd5/YIrw==
X-Received: by 2002:adf:f10c:: with SMTP id r12mr7857581wro.216.1553295773119;
        Fri, 22 Mar 2019 16:02:53 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id x17sm19757546wrd.95.2019.03.22.16.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 16:02:52 -0700 (PDT)
Message-ID: <5c95699c.1c69fb81.a2922.0a2f@mx.google.com>
Date:   Fri, 22 Mar 2019 16:02:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.30-281-gf4bc3dea377c
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
Subject: Re: [PATCH 4.19 000/280] 4.19.31-stable review
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

stable-rc/linux-4.19.y boot: 59 boots: 0 failed, 59 passed (v4.19.30-281-gf=
4bc3dea377c)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.30-281-gf4bc3dea377c/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.30-281-gf4bc3dea377c/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.30-281-gf4bc3dea377c
Git Commit: f4bc3dea377c7afbfe0a36d2c72e9031910349e9
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 34 unique boards, 16 SoC families, 10 builds out of 206

---
For more info write to <info@kernelci.org>

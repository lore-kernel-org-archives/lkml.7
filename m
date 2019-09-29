Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E32C32793
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 19:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5194D21835
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 19:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="KNvLuqg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfI2TAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 15:00:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53918 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729143AbfI2TAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 15:00:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id i16so10897013wmd.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=edoAIkAZL7speqG34C2NioOQY0eVyzL3Fpq0+FfX9zU=;
        b=KNvLuqg3QGY8t5gAOq9u5CsuTAgMa3ulmWeDdjOmanLRpBARGtuGg4nF8cqri3YAZu
         fRdKDe9QkD8k83tKkYjhpeOn/xkf6ub1L1Oj3Hrp+czQCH73gpJnVi8gUNFZo9Vql5GN
         sIuUpQxSnlxzyAVcUaVRBTdRH34/s0W4fjKTDjWVMGq08D/POKiHlxd4AkqsyfZUnYji
         s1QmfQAWTV6z3PXHl8VmCCJzxYFvJ3+zf10piDeNU5emq/3bt+lqSeTSl7wows2whsWt
         0rhRSymiEzq28lE9MbkiOS4CgkOufC2WyiUZst+/5LcRaxbCpeetvwQg60siSXUiRL6r
         +OxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=edoAIkAZL7speqG34C2NioOQY0eVyzL3Fpq0+FfX9zU=;
        b=GoPNKQNehLCYMjdXqsEbpsNbX1tRw6XIBwIBrCEPGY+gRFEc/OQGpnI9rPDvaWYylN
         zc66uvH5j2zKWuuS1LkasO08yyWOysuXNwYQTSpK95DT2DbZ8XnQgjt/q8YTafbnutQc
         Z3fyIGnCbJOEeV1cyWujju8fkm0ACOHYD15WEqjYD2iO6BMUjJg6vFlWAd2m+btqHx6E
         7YfN5u3VY3v/U8AoWMGDIgetsuRwNifINlXIljKhnKOSJeTj4yPB7vNTzzfyXpsFd5s9
         63m2s7aP9Xj0zG0IGswkxOixCbZmrNxzCFb8Or9XsTKlGggfFw7M4I7edN46hqH2te4j
         alrA==
X-Gm-Message-State: APjAAAW4mmGXPHaNJlkjhniURD+26DHUCmUfFAoxLuaWCz5nZavZwhLX
        duZa59nlG3ghr7H7g8kY8ZpFo4ZI4zA=
X-Google-Smtp-Source: APXvYqxMeO6G11rp6qRCQeMh5IaoEORNbCWi4jK+isZNREj9LgscjRmspfYHEwL9IFtK7dwaXM/Hqg==
X-Received: by 2002:a1c:2501:: with SMTP id l1mr13368399wml.74.1569783632235;
        Sun, 29 Sep 2019 12:00:32 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id a18sm15838475wrh.25.2019.09.29.12.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Sep 2019 12:00:31 -0700 (PDT)
Message-ID: <5d90ff4f.1c69fb81.c48de.7865@mx.google.com>
Date:   Sun, 29 Sep 2019 12:00:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v5.2.17-46-g70cc0b99b90f
X-Kernelci-Branch: linux-5.2.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190929135024.387033930@linuxfoundation.org>
References: <20190929135024.387033930@linuxfoundation.org>
Subject: Re: [PATCH 5.2 00/45] 5.2.18-stable review
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

stable-rc/linux-5.2.y boot: 83 boots: 0 failed, 83 passed (v5.2.17-46-g70cc=
0b99b90f)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.2.y/kernel/v5.2.17-46-g70cc0b99b90f/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.2.y=
/kernel/v5.2.17-46-g70cc0b99b90f/

Tree: stable-rc
Branch: linux-5.2.y
Git Describe: v5.2.17-46-g70cc0b99b90f
Git Commit: 70cc0b99b90f823b81175b1f15f73ced86135c5b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 46 unique boards, 15 SoC families, 13 builds out of 209

---
For more info write to <info@kernelci.org>

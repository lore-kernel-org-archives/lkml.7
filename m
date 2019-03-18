Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7638EC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E16206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="fcX4QPc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfCROC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:02:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37155 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfCROC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:02:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so4409494wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 07:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=vB77Id3cZm7AQ29bN6vF5rqmcVnasmam3pC7bJc2CDQ=;
        b=fcX4QPc53MBgU7+YnAALW3gm7j6GA4jYvpIWsMoEpgCAjKuFT+sagOH2wWTOCvuBQi
         1UrFzbd5z90c1drgfv1fmf47ltN+rXwnxr38TEXuO1TzrJbyo4V9vrKNHeNMB4myGBwF
         WJtHZ8yPy4vYIZVJxm+onqlxcnBgRwmcjjS4gEX7n2RcDNRQayFLbFZFEWj6W4zI/pA3
         iWPWoebsTpMpqNNv1P9gNdkurMqhndzeTIMILaY5CraKDZ/XqoAhOowjLI7iGiIRYJ0Z
         5Mlk+yQSFQHVATNrIernC4QIpWG1G7VutzqpDSblDPzjnNA8OUjSG/rviprdIfc6+hYe
         5rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=vB77Id3cZm7AQ29bN6vF5rqmcVnasmam3pC7bJc2CDQ=;
        b=nhkzZj8CkECKeNXYx5TO8Zh0nqYKzN0o+5pCv6evfVeuFmPTXabkKLTsUTN4L1dpwi
         MozLe4+j5KtSnOqvY6qJ4vwEzvHe1P7du3/fIm4X7rrtTimdBEnQus+0c0fzlpH4GFS7
         0xjfIC2FOSogPYKeC3wDnZpCsk3E+szw+7Fj6Uakh2Ma3P7UXVN0F9B+9w8Mv3VQ76dV
         JY5PMllsF/4ca/Jofzf1Ewi44P8tDT15D0a7foWyMu8iAR2jkN3aACxrnN95I8T787Xy
         ZwWLgNxD8ZDyCpG4tEF35QXBR5WAtJlthKA/nTBAtj8RwWyDU83+7B78hSAXVK5a1XLC
         e5sg==
X-Gm-Message-State: APjAAAVPlP6wJNqlNNgzfQZjb1gnemSynHgBnpdXTEK4ps32plSwt990
        agZzbMw/QPNiwr//FB7DFXNUVg==
X-Google-Smtp-Source: APXvYqzTyDI/5ccC/xRewsw/uV/05WfECRLfZPdyvXeB+yzcktNL2bEd7YKmmCWW5Ndh1UeWpsZn8g==
X-Received: by 2002:a1c:e90f:: with SMTP id q15mr11055496wmc.112.1552917746393;
        Mon, 18 Mar 2019 07:02:26 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id y140sm40319925wmd.18.2019.03.18.07.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 07:02:25 -0700 (PDT)
Message-ID: <5c8fa4f1.1c69fb81.76d31.d2b3@mx.google.com>
Date:   Mon, 18 Mar 2019 07:02:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.9.163-32-g631b5fe18b59
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
In-Reply-To: <20190318084210.397476003@linuxfoundation.org>
References: <20190318084210.397476003@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/31] 4.9.164-stable review
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

stable-rc/linux-4.9.y boot: 94 boots: 0 failed, 94 passed (v4.9.163-32-g631=
b5fe18b59)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.163-32-g631b5fe18b59/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.163-32-g631b5fe18b59/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.163-32-g631b5fe18b59
Git Commit: 631b5fe18b599ae5cdcb38801e9581e46fcccd76
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 50 unique boards, 21 SoC families, 15 builds out of 197

---
For more info write to <info@kernelci.org>

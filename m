Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3690C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8409720863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="xU3gedM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfCRNm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:42:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33443 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfCRNm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:42:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so1436282wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 06:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=4YQl6kiQNUOV3d5w1gn4owunH/IL9a5xVBd96ohZtzI=;
        b=xU3gedM4RuPn4iFlYfm8lzTEygu6skoDVdsSw6ZbUbgzn3hMaQea8X4OfLE4z5yayy
         /uEFX8LDxRaUMdEMEbeKwr0sV1kiqmRPkPrPYwYq6tmoVifhRLUI6XJW8sQF9oRaZYK3
         RA3AsX4I7IIC7HQ/4DxCsL99UiPWNEwmewzrmgSnJaAhvf9d1wYB3n5fiuJK4jj78bTK
         h8nPR0aB9U7TO0dwsbVdqwbG+giMlvrKAEY3pM/GZHttHxn26LqZaHAuOeo2JWTHsdG7
         qp/qR/qVbe+++shZQeTat2Mxfihzu4l3+/rvpYxgTDj5Jq96hineRmy37Tf3zOgI8xeV
         UyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=4YQl6kiQNUOV3d5w1gn4owunH/IL9a5xVBd96ohZtzI=;
        b=dztsDIhIb8UqQzwhbRfWw+mms9ubcCKIR+wuJBTniQw7BS+UHc46yrvZW6Lf4+l2GO
         dIGxsBdkdsvQ8DFUOYZtEnJAsJL2zXcAES+oHjQCPQFw5LumO8N89FAm01+oSbt8dowA
         gfm2QnkjsHX+3myItD+Mg051N7A8NXwOd45eAQWDaE3YiMFuF2axTUHAn0Yjr/ubqw4O
         RfmoCM+8weSWn0nJv4R2gIzm/hrs+gStGa0fmlOUfn6oVGqQqucUqhNDxNZnhUcd3HTd
         AWPJiCxpx/S8w8nctbOT8OhKzh4IJEHy9+LKCuWR3ZyHXsB0tKx9zZvF6iC4r5x5+42K
         95fA==
X-Gm-Message-State: APjAAAXYJeQOcCuxZHCu7JgEvklPTJuEkI5xxALw57LSkvT1heUdI4sm
        LTqnimTN3/HgYB2D7D3n3QBWkg==
X-Google-Smtp-Source: APXvYqxScUEPjETWgJHXLUpyMFJOvipFgVP81OTU6vrg+zaCKfLuy9SPceZu9Y6YhtS6YFqrSdgtAA==
X-Received: by 2002:a5d:40c7:: with SMTP id b7mr134888wrq.311.1552916545469;
        Mon, 18 Mar 2019 06:42:25 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id y140sm40208609wmd.18.2019.03.18.06.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 06:42:24 -0700 (PDT)
Message-ID: <5c8fa040.1c69fb81.76d31.c89e@mx.google.com>
Date:   Mon, 18 Mar 2019 06:42:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.29-53-g80fa0a60fe1b
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
In-Reply-To: <20190318084013.532280682@linuxfoundation.org>
References: <20190318084013.532280682@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/52] 4.19.30-stable review
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

stable-rc/linux-4.19.y boot: 103 boots: 0 failed, 102 passed with 1 untried=
/unknown (v4.19.29-53-g80fa0a60fe1b)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.29-53-g80fa0a60fe1b/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.29-53-g80fa0a60fe1b/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.29-53-g80fa0a60fe1b
Git Commit: 80fa0a60fe1b921d079c6ce09b0271123ea9af4d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 62 unique boards, 23 SoC families, 14 builds out of 206

---
For more info write to <info@kernelci.org>

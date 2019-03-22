Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56399C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E4B2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="h6oxA/R5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfCVWm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:42:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41246 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbfCVWm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:42:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id p1so3946932wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 15:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=641pbI5vs+xiuSa2Ixs0kOFROfFfVTwFZm3d/B0niLc=;
        b=h6oxA/R5eQ9GyhUpaJQQI+YEwZcOFlADxqprKMA99Q4oXlcs6qu/M7HkGI0+QUOXVx
         PbqyOTbRs+grL4Z/WSANXm3zRjvA8MT+cGdcp0prvNpWRgE5M2UY1Fl4n1eBZfyQGkMG
         /z6cKpridJXuy4RmlSVm1+VWSBvGBVGdbeBz4IjMZm3ULYJ+tKrCmM+3wY4LyHRTG6AE
         g3j0BA070AzdGRP/ganCVuaiYfp1RPmAER6ACfIU2Prt0/WPMLYWCRceFzOHaokwvdT9
         iNLnliXH4pog5fhnZqoT0bZ/OH9l952LkE9cDfwl1SUZlhSy4fS1VnnMixltB/X2U6+H
         70LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=641pbI5vs+xiuSa2Ixs0kOFROfFfVTwFZm3d/B0niLc=;
        b=tPl9MxDDn+nGdPCFNDC3R9ZacKA9VNJI2oqQyNTxXRu6wlGVuoTMuCTYm1Hyoxub4u
         5VoTFmccPQcTjXeU9kCw3gfJY/BH1qIExcRsIBdX9No0ej36E5e/1vxC8w6DIhEe99ac
         gpurzAgqITc8QsvKm1BRqRSdNjLDGVF5ozqZVdRoJOq95o8LXV73AtGtBMTshkQ5a9aF
         TyhKdbsLqjtnvyZPXsOOSg15x76agUUQEzhijKWXvid7QXgY7bYvY7e6jh3RqqfIo+rV
         8oysc7ewrFbNpFgQ7eEicA2K3Ay70Kb6ZVzMfdfUS3iOWYu2rwn2aAq5z1Q2oa1lBhzr
         Wh9A==
X-Gm-Message-State: APjAAAUoQrvW7OdvAyAPP1MgG9vtQDt0AoN8RPU+iV5iP7sufJwEPUFv
        l56MNOxF9mNejEn/4qXFA90MMoySRxc0nQ==
X-Google-Smtp-Source: APXvYqyDutaZR7fO1oRggdVXIiU8GHXovkNtAkFnky+1HkmYe21F3PwYabDTF5lRQTBY3y40z/6Icw==
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr8103974wrx.32.1553294576210;
        Fri, 22 Mar 2019 15:42:56 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 132sm16934830wmd.27.2019.03.22.15.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 15:42:55 -0700 (PDT)
Message-ID: <5c9564ef.1c69fb81.d05cf.2db8@mx.google.com>
Date:   Fri, 22 Mar 2019 15:42:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.14.107-184-gf85b59a43475
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/183] 4.14.108-stable review
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

stable-rc/linux-4.14.y boot: 52 boots: 0 failed, 51 passed with 1 untried/u=
nknown (v4.14.107-184-gf85b59a43475)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.107-184-gf85b59a43475/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.107-184-gf85b59a43475/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.107-184-gf85b59a43475
Git Commit: f85b59a43475b5bcca299c897549d4aff496dda2
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 29 unique boards, 15 SoC families, 9 builds out of 201

---
For more info write to <info@kernelci.org>

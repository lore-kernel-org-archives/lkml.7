Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053BCC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 03:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11D821929
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 03:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="D11uHMYn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406539AbfITDTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 23:19:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33812 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406268AbfITDTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 23:19:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so8506868wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 20:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=waLXcJR0MnGH+J0ksYnKyGL1oEhoforOspZHaRd7yEU=;
        b=D11uHMYnAmmc7syykmGAgKusJ2uBjroZgCrCHvc0pgVYywZzPAi7zR9+nbXnW0eaKO
         b+GvGOcUmzzJOxkkVdcr8sDdRl+zO/8bJtzrMzfXhskQxzCTI/Elu9Y4TadrQrESft+G
         VnjT4cjPOFAOjlCoYv19c+f9gSJxc66tumXdV8r1eIlFvznOtBGSu0wmd5Bs++ZlWECq
         pMt6xS/+Cmxsu9VLb7t6TeXU096ffcxiXfPRRjLJG1TXeyT1G1VvZ5kpweyBPZD4OK9B
         1ph1Em89JA1M2KSX8eW2ez4PO/u91prePDd4UynTyxHtWct5f6ePD1HskycUKUpS3DQD
         ZQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=waLXcJR0MnGH+J0ksYnKyGL1oEhoforOspZHaRd7yEU=;
        b=cVLJPzfVkB2/JSny7dOLebPfAwdnaB7NkrEUCsuwQcI/kgOZfqxKIYjolKohwnlaX/
         2HDi2HzSGejuqLVnLdunQhZcpBzIvd3klyBthWSww7j0dQOFAW80HX8TtnF6SkjKgoH/
         ptZYcmyB9edU9u396zpSVFc120YmcOBhbqODl/E4TQJDBVDC5synwuDrimOfpgSdmaFp
         W2CPGj9q7fRS47HunTGF2WNMxfsKM0oeCo3NjgSzWAyEuUSTNILsz233jd3ZPmmiOIEr
         87+wHifLnZdHSXpHiccicaASVkpwqNhe9uaQYbo8YVYe/wr9OsjlOOj3BLeGnVypTZOt
         B3GA==
X-Gm-Message-State: APjAAAUga3IpOW0TrC3Bc8u/yCAQ6f2q0EFMg/MSjhOvCQoda1pU+1Tk
        1kLZ0GU4PHFCuzm+/gDGXYvGd7tmc62gnA==
X-Google-Smtp-Source: APXvYqxChL6xdim29b2yAZCnRM9SfgPdyGIKCph4veIJvDRL52fi1uhEEMQ5WVrvB7p57SUR95rYvw==
X-Received: by 2002:a7b:c44e:: with SMTP id l14mr1134742wmi.54.1568949580592;
        Thu, 19 Sep 2019 20:19:40 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id y14sm726913wrd.84.2019.09.19.20.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 20:19:39 -0700 (PDT)
Message-ID: <5d84454b.1c69fb81.46e54.2a65@mx.google.com>
Date:   Thu, 19 Sep 2019 20:19:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.14.145-60-g981030d9563c
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.14.y
In-Reply-To: <20190919214755.852282682@linuxfoundation.org>
References: <20190919214755.852282682@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/59] 4.14.146-stable review
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

stable-rc/linux-4.14.y boot: 65 boots: 0 failed, 65 passed (v4.14.145-60-g9=
81030d9563c)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.145-60-g981030d9563c/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.145-60-g981030d9563c/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.145-60-g981030d9563c
Git Commit: 981030d9563ce66bc738ff8fee0ed8c81922904b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 32 unique boards, 15 SoC families, 10 builds out of 201

---
For more info write to <info@kernelci.org>

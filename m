Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC3FC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 23:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75588213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 23:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="wgk0KgIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfCLXCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 19:02:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45716 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfCLXCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 19:02:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id f19so3739304eds.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 16:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=TukHVb3WaEgxLt7yExeUDi+K7VyxiTEJd8lYQFTKbHQ=;
        b=wgk0KgIe+gE8hguSfD+TtgkisgBQohZMnlPsDtGJ2Xc/Vr3zMi8WjfUQnlzikS/cxb
         24eZLuKGGuVdNte67oiHSN3bJWzcFJ9lib+yfdKVh16OGRAr9ucvo2NI3nGJwk6BBVpd
         xysG4/5vUZyR35sbhvESTCeCA+tWpANhtP+M8IJN9OD/o4xsb00VLXpR6CuEdZCwfNeu
         nzceFkPCdUlI34ddYwqYe+JNrGfSFsSR838mVeZxlh8Ykf8PlpTylgAO4HUwOLihZx4F
         H257Ao8VJ8PLYwZeIrsrjKhXJ4+NcGIyD9HzKKxH6pXu6aRK7EJEQXY+0XlmNAPynqL5
         hCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=TukHVb3WaEgxLt7yExeUDi+K7VyxiTEJd8lYQFTKbHQ=;
        b=cJtZHzOv7AR1ucgEfvWD0IeVji1PoPeKncDvXTgyYFEARCr2LT8W0eA183gcyrWWUh
         zmiPhQZsP4G6dKpymr6GYnC8AOiTzy4LAJz6s+3vUYttS7HsysnXBn1ZkW7l0uixFJ/9
         sIWWZI/zmPzwONouNPDiJJN1VMy/bujtfAhn2n9yu46tfyLulCDVc5sRVc87juHPfJym
         1/0auRnw+7Rket/TGcH5bHiccu0tMRP6c0OoW9AVdQI+ZXRgrIEYb35ujI7/vAlY3YUH
         sS/9iJmeWU5FYnU56Jfv7j1jbEBI0A9Z0K1fLK5o3YJE8qt5FcffNSUD9nJ+JWTeghzH
         BByw==
X-Gm-Message-State: APjAAAUMbcnyVx9fHY7ZO8Zx4eDPUjf8G9+yOnTZ1iYh5kEIHs3FXHzc
        5AH3yN+pFqEu3ZTJCrSJ2rK43A==
X-Google-Smtp-Source: APXvYqxTGcYwvOVVikbTVHXiSDi7Qcg+1iTm0iA7FhOXGJ//CHBCYGNnhR5YWgM6DeOCXnTXr+DuTw==
X-Received: by 2002:a17:906:c38c:: with SMTP id t12mr6841579ejz.142.1552431731572;
        Tue, 12 Mar 2019 16:02:11 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id a9sm29047eje.37.2019.03.12.16.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 16:02:10 -0700 (PDT)
Message-ID: <5c883a72.1c69fb81.b8e2e.017f@mx.google.com>
Date:   Tue, 12 Mar 2019 16:02:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.9.162-97-g605129cbbd38
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/96] 4.9.163-stable review
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

stable-rc/linux-4.9.y boot: 92 boots: 1 failed, 91 passed (v4.9.162-97-g605=
129cbbd38)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.162-97-g605129cbbd38/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.162-97-g605129cbbd38/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.162-97-g605129cbbd38
Git Commit: 605129cbbd389949c754d0a23ce49030adae8f17
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 47 unique boards, 21 SoC families, 13 builds out of 193

Boot Regressions Detected:

arm:

    qcom_defconfig:
        gcc-7:
          qcom-apq8064-cm-qs600:
              lab-baylibre-seattle: new failure (last pass: v4.9.162-94-g03=
84d1b03fc9)

Boot Failure Detected:

arm:

    qcom_defconfig:
        gcc-7:
            qcom-apq8064-cm-qs600: 1 failed lab

---
For more info write to <info@kernelci.org>

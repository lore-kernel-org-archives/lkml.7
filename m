Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1DBC4646C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3956F206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="adCZ7DlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfFTVvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:51:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33331 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfFTVvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:51:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so7786706wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 14:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=HdKRiSB85LvUCFRxbPH+qwH2+8l2OVBBu3iiAsp64IY=;
        b=adCZ7DlLhDJnuCuFWtzZ2dd/AJpf6b3LITsDlPVoauW3kEDPuqHPRP3FngEI3tkPiB
         r9zIeW5QyGol3X6HlR/TP04jw+ZhUkAemCDMJvI3U/C2QtGZaO7bgaCFpsRdgmDPpovp
         ybU6WWH95MHjIioR14e7xPbJHzfSkS41aYiheb6wCQof5lVUD03rGKbGk+euJeWX8d0J
         vVpWe6C8voK2Zecb5Uvg92JOoapfj1Xz8s3LOuwStrpIw6wl0jq+Gd1fiPNctLVaqe1m
         6WLZN5GXQaxQ328jUSZlC5dYaVsRnQhtfKbtRr55M6W7qVrYxKyS2y0NcB+20Otn3x7i
         NB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=HdKRiSB85LvUCFRxbPH+qwH2+8l2OVBBu3iiAsp64IY=;
        b=f/Zxk9a3XyEwNtPTyAhkSBcofRHw9+gwpUsWeJeZYmKnS1KGX8ds0Osbvr8CtM5U24
         +1s9CEUqBGY7t7siXUvYP0qrtF2LSm0GeaVBDhkWXD+zN108MM6suJiyLCu+QOm/o9li
         wZIv1UB6n6be8HEGWG3FMA85qcMMR8BGmpX8oluAzcPGfcUsx7SYGqI9FCdKj7g+ha4M
         mXIE+OJZby8ijTO+lfYHKA1xLIx/BGkX3rh2W91LDzXw6J+XrW4D7HiGuYO3IMcKu9N1
         JiwbByucAY5dsBqvWsds/u9ZeXwlAzi9xHYNHzauL33w5aoe4iPdOoqH0pfafM+j5ds7
         2fxw==
X-Gm-Message-State: APjAAAVTGJGm3wOFLmVrvXwO8SLefytWBx5xKY/f+FiR88riS5Pnh9+s
        qRXlGKINEdsO8bJypHTXkoWXRw==
X-Google-Smtp-Source: APXvYqxE+fMhvRwwGs/E8tt4mvpclneumNMW2tbRUdT2KOqS4Iaz0JpzFG+gGiH9wHN1UcMnYIxQ2A==
X-Received: by 2002:a05:600c:114f:: with SMTP id z15mr979377wmz.131.1561067462667;
        Thu, 20 Jun 2019 14:51:02 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id e21sm1414724wra.27.2019.06.20.14.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 14:51:02 -0700 (PDT)
Message-ID: <5d0bffc6.1c69fb81.a28a3.8deb@mx.google.com>
Date:   Thu, 20 Jun 2019 14:51:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.19.53-62-gf22a520163d3
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190620174336.357373754@linuxfoundation.org>
References: <20190620174336.357373754@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/61] 4.19.54-stable review
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

stable-rc/linux-4.19.y boot: 65 boots: 0 failed, 65 passed (v4.19.53-62-gf2=
2a520163d3)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.53-62-gf22a520163d3/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.53-62-gf22a520163d3/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.53-62-gf22a520163d3
Git Commit: f22a520163d30baac515fcced7eb7ae13dc78c89
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 36 unique boards, 17 SoC families, 12 builds out of 206

---
For more info write to <info@kernelci.org>

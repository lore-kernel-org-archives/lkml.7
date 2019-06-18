Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA13C31E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09A420861
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="Fw0s+dnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfFRCKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 22:10:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42100 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfFRCKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 22:10:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id x17so12072309wrl.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 19:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=QdfSFaHZxqOQnZpuak6zWlNXji2dmIrBwGxFI1wS7+U=;
        b=Fw0s+dnSWgRsdQoysGIzRfeT9dEE8ID/HRqXifdScAg7DqiDZUMOZOPh3S6UNzfQJ/
         1yIGUsHpdj7keHXtJAhZPE8A0//qyEE7l7HqzRNfVAX0PHT57SEtncquYXf7xw5bbSLd
         CajeIfj6kJhBa8iSERlLDdalHh62z5G/iqgKBiEXfDZf2DqKQS62rMb+GmWB2V/OpK3O
         Bco8MgZoRJ7lCOJ9aIIprgtT6d9mk85O+sTrG9/VPhyOUnnC0u25A3HcZznwINj9PNAF
         TEcXr7mXxTI70faNGnjCfPy6RpIXSzKFmbHZncPdzUalg4UJQghP2j5N+n3OpkFzGguE
         qNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=QdfSFaHZxqOQnZpuak6zWlNXji2dmIrBwGxFI1wS7+U=;
        b=EsbI3Kgq8LrWWt6XOfQKSK+wFZVu2Log/D332BZC1OaGRC8p7fQCb/wJaJBfXzrYVS
         IAFFx4fNOeELae232imwHWn2PT/ZwHJoLs6PkjbimJgoAtGO5RKwgN19D6MngkxTNpBE
         3zKpMhqGg1ioxf2VgrZsYb58Euzdn/dK4U71sqRqaAla9Fm4aHSHQ+FhjvJOVxWzVg+s
         bpatkwz1VOB9LPxOEnwV0YS2K7vzPoYuzHSS8BTkdmigZRl4lpHRT4Sx4ReyMEmHgl/X
         +6uOp1BLbPU5e5t+nQzMSZKyrvh3aGo5QCqz35PdWH8L5NqcvV7XeIdZ6dO8XD5ea5Bm
         ocww==
X-Gm-Message-State: APjAAAVmDTJplS4fVvCWFi/sKQbd2a1+8HzwfBfXMLMd6LxnoRKWJYGn
        5ydDAGleQOfh6YgZju7tB6KtZw==
X-Google-Smtp-Source: APXvYqwiEm9DoQKukITRWUaxtn9MCgqVmFdfUDHUEROyISBlo+VsmqW/yQv5WUyH+DqEyHEmQ3xN8Q==
X-Received: by 2002:adf:afde:: with SMTP id y30mr17706287wrd.197.1560823847856;
        Mon, 17 Jun 2019 19:10:47 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id j17sm11538710wrw.6.2019.06.17.19.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 19:10:47 -0700 (PDT)
Message-ID: <5d084827.1c69fb81.708ea.ca74@mx.google.com>
Date:   Mon, 17 Jun 2019 19:10:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v5.1.11-116-ga1610563f19b
X-Kernelci-Branch: linux-5.1.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
Subject: Re: [PATCH 5.1 000/115] 5.1.12-stable review
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

stable-rc/linux-5.1.y boot: 118 boots: 1 failed, 117 passed (v5.1.11-116-ga=
1610563f19b)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.1.y/kernel/v5.1.11-116-ga1610563f19b/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.1.y=
/kernel/v5.1.11-116-ga1610563f19b/

Tree: stable-rc
Branch: linux-5.1.y
Git Describe: v5.1.11-116-ga1610563f19b
Git Commit: a1610563f19b8c84324c5b490e57ffd1f1bb62be
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 70 unique boards, 24 SoC families, 15 builds out of 209

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm4708-smartrg-sr400ac: 1 failed lab

---
For more info write to <info@kernelci.org>

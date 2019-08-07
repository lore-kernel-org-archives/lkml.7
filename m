Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CA3C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA50F21738
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ljHODMp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfHGAqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 20:46:23 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34623 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbfHGAqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 20:46:23 -0400
Received: by mail-qt1-f195.google.com with SMTP id k10so17476505qtq.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 17:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=+nZvNNbEUa3hT+1r/NMmepJfUlIswUH5GSUBiFbLimc=;
        b=ljHODMp9DZCsdja6NR6A7nf3q2kLMF/lCltRfg1f0HZyEoXSkcmg73nt7DK7RxaOlJ
         +CAHCuqZ8D0BABrcP1lImp4Q5ANPhJkTRvY0WmrwTa66DQA+bAeBqAPzntQJZLsUMrnk
         YvfK/fezKA3aU8oQshm1/gaBqiZpPGP/v53GY9Oufq80wrlLfoX2SnQQSApqhIoRh2yT
         zlKiaHB6ulXLqkGaUOs9N244Yj0NYr5ZrNX1xt5przHXG34BBzwQjxtHuHCUMJUbGemy
         7kffk+msubnkM9Ooeo10Rqip+wASxJuyaiZdR43KVXoqBK6mKGHRuakCyB0jBFQubvrC
         enyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=+nZvNNbEUa3hT+1r/NMmepJfUlIswUH5GSUBiFbLimc=;
        b=Tnv+3jYeqzm/qWqp9c6BT3Cmk66lxcJ/PtLCoahGxc4Ws8Tc4jeW73ZCDuC/qwisOG
         A6vCpQ9gbalzG8+hQ0HWLAuYd8nygHdNIodH1frHG3Y5/u/UuD870PjwWhl/rm4FCltr
         mx9zWwKT/ahHhSdpdTomaYpsuRpTofePT5ccUr3IUkR+YZ1MDNIzab2imPVo3nTolEux
         Za39k28BIh44fJAar0eliLrFw9De7jQ2RHUXkDSLZSWt0t7PNmKIlzmNSXnY6swvg7ZC
         qzLji95iDQF4pURHBWqUvrg15ZZy0jUJl9ig6iHUzwmyh9kvKaErgCquar7aJYk1pwX3
         jNkg==
X-Gm-Message-State: APjAAAUPx+5ZcgT2CetMPQg+tajuakDnQbb4TeHVKcUhIXJ/BM/hkOaO
        q3YKhwEXU2ZxveWsAXQVmgaDIw==
X-Google-Smtp-Source: APXvYqzfn3s4HDkpVhIAkiGkxMbioyoRgDU/o7hx7RXiLskgv/KOyg/Yc93FNgn8l7xpAog6HFdPsw==
X-Received: by 2002:a0c:ae24:: with SMTP id y33mr5812928qvc.106.1565138781643;
        Tue, 06 Aug 2019 17:46:21 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l19sm49124940qtb.6.2019.08.06.17.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 17:46:21 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: "of/platform: Pause/resume sync state during init and
 of_platform_populate()" with a warning on arm64
Message-Id: <B4B0AD7F-FA0F-4DA0-9A8B-EAE1CEE11759@lca.pw>
Date:   Tue, 6 Aug 2019 20:46:20 -0400
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
To:     Saravana Kannan <saravanak@google.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the linux-next commit =E2=80=9Cof/platform: Pause/resume =
sync state during init and of_platform_populate()=E2=80=9D [1]
Introduced a warning while booting arm64.

[1] =
https://lore.kernel.org/lkml/20190731221721.187713-6-saravanak@google.com/=


[   93.449300][    T1] arm-smmu-v3 arm-smmu-v3.4.auto: ias 44-bit, oas =
44-bit (features 0x0000170d)
[   93.464873][    T1] arm-smmu-v3 arm-smmu-v3.4.auto: allocated 524288 =
entries for cmdq
[   93.485481][    T1] arm-smmu-v3 arm-smmu-v3.4.auto: allocated 524288 =
entries for evtq
[   93.496320][    T1] arm-smmu-v3 arm-smmu-v3.5.auto: option mask 0x2
[   93.502917][    T1] arm-smmu-v3 arm-smmu-v3.5.auto: ias 44-bit, oas =
44-bit (features 0x0000170d)
[   93.621818][    T1] arm-smmu-v3 arm-smmu-v3.5.auto: allocated 524288 =
entries for cmdq
[   93.643000][    T1] arm-smmu-v3 arm-smmu-v3.5.auto: allocated 524288 =
entries for evtq
[   94.519445][    T1] libphy: Fixed MDIO Bus: probed
[   94.524649][    T1] EFI Variables Facility v0.08 2004-May-17
[   94.601166][    T1] NET: Registered protocol family 17
[   94.766008][    T1] zswap: loaded using pool lzo/zbud
[   94.774745][    T1] kmemleak: Kernel memory leak detector initialized =
(mempool size: 16384)
[   94.774756][ T1699] kmemleak: Automatic memory scanning thread =
started
[   94.812338][ T1368] pcieport 0000:0f:00.0: Adding to iommu group 0
[   94.984466][    T1] ------------[ cut here ]------------
[   94.989827][    T1] Unmatched sync_state pause/resume!
[   94.989894][    T1] WARNING: CPU: 25 PID: 1 at =
drivers/base/core.c:691 =
device_links_supplier_sync_state_resume+0x100/0x128
[   95.006062][    T1] Modules linked in:
[   95.009815][    T1] CPU: 25 PID: 1 Comm: swapper/0 Not tainted =
5.3.0-rc3-next-20190806+ #11
[   95.018161][    T1] Hardware name: HPE Apollo 70             =
/C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
[   95.028593][    T1] pstate: 60400009 (nZCv daif +PAN -UAO)
[   95.034077][    T1] pc : =
device_links_supplier_sync_state_resume+0x100/0x128
[   95.041124][    T1] lr : =
device_links_supplier_sync_state_resume+0x100/0x128
[   95.048167][    T1] sp : 34ff800806e6fbc0
[   95.052172][    T1] x29: 34ff800806e6fc00 x28: 0000000000000000=20
[   95.058177][    T1] x27: 0000000000000000 x26: 0000000000000000=20
[   95.064181][    T1] x25: 0000000000000038 x24: 0000000000000000=20
[   95.070185][    T1] x23: 0000000000000000 x22: 0000000000000019=20
[   95.076189][    T1] x21: 0000000000000000 x20: f9ff808b804e6c50=20
[   95.082193][    T1] x19: ffff100014a6e600 x18: 0000000000000040=20
[   95.088197][    T1] x17: 0000000000000000 x16: 86ff80099d581b50=20
[   95.094201][    T1] x15: 0000000000000000 x14: ffff100010086d1c=20
[   95.100205][    T1] x13: ffff1000109d8688 x12: ffffffffffffffff=20
[   95.106209][    T1] x11: 00000000000000f9 x10: ffff0808b804e6c6=20
[   95.112213][    T1] x9 : 4b71ad522c851d00 x8 : 4b71ad522c851d00=20
[   95.118217][    T1] x7 : 6170206574617473 x6 : ffff100014076972=20
[   95.124221][    T1] x5 : 34ff800806e6f8f0 x4 : 000000000000000f=20
[   95.130225][    T1] x3 : ffff1000101bfa5c x2 : 0000000000000001=20
[   95.136229][    T1] x1 : 0000000000000001 x0 : 0000000000000022=20
[   95.142233][    T1] Call trace:
[   95.145374][    T1]  =
device_links_supplier_sync_state_resume+0x100/0x128
[   95.152074][    T1]  of_platform_sync_state_init+0x10/0x1c
[   95.157557][    T1]  do_one_initcall+0x2f8/0x600
[   95.162172][    T1]  do_initcall_level+0x37c/0x3fc
[   95.166959][    T1]  do_basic_setup+0x34/0x4c
[   95.171313][    T1]  kernel_init_freeable+0x188/0x24c
[   95.176363][    T1]  kernel_init+0x18/0x334
[   95.180543][    T1]  ret_from_fork+0x10/0x18
[   95.184809][    T1] ---[ end trace a9ea68c902540fe5 ]---
[   95.269085][    T1] Freeing unused kernel memory: 28672K
[  101.069860][    T1] Checked W+X mappings: passed, no W+X pages found
[  101.076265][    T1] Run /init as init process
[  101.186359][    T1] systemd[1]: System time before build time, =
advancing clock.=

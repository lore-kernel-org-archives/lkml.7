Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D224C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8AB233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="PLrk8H2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390752AbfHVVd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:33:28 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:44581 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732656AbfHVVd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:33:28 -0400
Received: by mail-qk1-f178.google.com with SMTP id d79so6473127qke.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 14:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=vxPfoC0K37mnp3V+GpCj023qxV0rNOwXkgRWVieVWW8=;
        b=PLrk8H2BymBEZahoF59hFB0vu+Rlj3dcFORH8U/VLQz5lmfldbLWbXm5lPRI6y9DaB
         jdBGob2L93ac72r5a/vhZb9zgfuo1Clq/S/LtTzt8w2WPtEnU6gy1WkFc9HR42wqI7YN
         Tq+AKWjKxwpEHbNANfdNs5d6ojZDpSNbNVIdZXUTOMG/ErQlEKVf4duJgz2baPpBTh2u
         TeFyb2MXctxh3mP0iZ1K4sL9dAYSsO4AB8wRnJ02EguJTYDH6oJG/f5g0oA1k5Uv301F
         Y6jgIPWhTtznIskycpFi+MFl7G6b/IpyAhufT1Kf6kY3Q2Zxykt4TJDaQm0MqRJ82jFW
         OzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=vxPfoC0K37mnp3V+GpCj023qxV0rNOwXkgRWVieVWW8=;
        b=c0MMF+twbytHHLGVcUYqyXSJhozem5pzu5mpqybTb+QWJyT/RI4d+7zLKZUAKuDEQK
         mUG4/PM0u6IFqgUw/lau3NjHN5QBe6ye4oZHOI2lTfHBqVS/Dc6urLkuoMn357zI1q6u
         yS/pSF5swifARsgIymB5xbtfoH5elZJXusPVNlkT5oSHC6j2USR1cdJaUUu3KvEZUc9x
         AGZz7iVe37l41OLourdPCcqHgSryoj4gyfhavJz4DFKlUtJ4ntJNjkWJKp1nAw6eLCd9
         V3hoFi4MLcr8su6qE2Xv4fio9zalYG5lHK6ZHnsigfkFcO01T4Rs3SR4mYjsEp1op7kJ
         t06w==
X-Gm-Message-State: APjAAAWuRVUjxt2tXpAF1xWtc5/du6Z4a99V1vLije/Hbj7Ty7nmMknB
        rtmRA86xopFoN/BajgcrYHrT1fRY4/0=
X-Google-Smtp-Source: APXvYqw9aoi8o93EJ/4REoOn/hD2msEp2fczdUdvUxTwn60eP5eTFH72s4ltjGJlxU8gy3C+4KkWrw==
X-Received: by 2002:ae9:dfc3:: with SMTP id t186mr1144058qkf.322.1566509606883;
        Thu, 22 Aug 2019 14:33:26 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u187sm493578qkh.110.2019.08.22.14.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 14:33:25 -0700 (PDT)
Message-ID: <1566509603.5576.10.camel@lca.pw>
Subject: page_alloc.shuffle=1 + CONFIG_PROVE_LOCKING=y = arm64 hang
From:   Qian Cai <cai@lca.pw>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>
Date:   Thu, 22 Aug 2019 17:33:23 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config

Booting an arm64 ThunderX2 server with page_alloc.shuffle=1 [1] +
CONFIG_PROVE_LOCKING=y results in hanging.

[1] https://lore.kernel.org/linux-mm/154899811208.3165233.17623209031065121886.s
tgit@dwillia2-desk3.amr.corp.intel.com/

...
[  125.142689][    T1] arm-smmu-v3 arm-smmu-v3.2.auto: option mask 0x2
[  125.149687][    T1] arm-smmu-v3 arm-smmu-v3.2.auto: ias 44-bit, oas 44-bit
(features 0x0000170d)
[  125.165198][    T1] arm-smmu-v3 arm-smmu-v3.2.auto: allocated 524288 entries
for cmdq
[  125.239425][ [  125.251484][    T1] arm-smmu-v3 arm-smmu-v3.3.auto: option
mask 0x2
[  125.258233][    T1] arm-smmu-v3 arm-smmu-v3.3.auto: ias 44-bit, oas 44-bit
(features 0x0000170d)
[  125.282750][    T1] arm-smmu-v3 arm-smmu-v3.3.auto: allocated 524288 entries
for cmdq
[  125.320097][    T1] arm-smmu-v3 arm-smmu-v3.3.auto: allocated 524288 entries
for evtq
[  125.332667][    T1] arm-smmu-v3 arm-smmu-v3.4.auto: option mask 0x2
[  125.339427][    T1] arm-smmu-v3 arm-smmu-v3.4.auto: ias 44-bit, oas 44-bit
(features 0x0000170d)
[  125.354846][    T1] arm-smmu-v3 arm-smmu-v3.4.auto: allocated 524288 entries
for cmdq
[  125.375295][    T1] arm-smmu-v3 arm-smmu-v3.4.auto: allocated 524288 entries
for evtq
[  125.387371][    T1] arm-smmu-v3 arm-smmu-v3.5.auto: option mask 0x2
[  125.393955][    T1] arm-smmu-v3 arm-smmu-v3.5.auto: ias 44-bit, oas 44-bit
(features 0x0000170d)
[  125.522605][    T1] arm-smmu-v3 arm-smmu-v3.5.auto: allocated 524288 entries
for cmdq
[  125.543338][    T1] arm-smmu-v3 arm-smmu-v3.5.auto: allocated 524288 entries
for evtq
[  126.694742][    T1] EFI Variables Facility v0.08 2004-May-17
[  126.799291][    T1] NET: Registered protocol family 17
[  126.978632][    T1] zswap: loaded using pool lzo/zbud
[  126.989168][    T1] kmemleak: Kernel memory leak detector initialized
[  126.989191][ T1577] kmemleak: Automatic memory scanning thread started
[  127.044079][ T1335] pcieport 0000:0f:00.0: Adding to iommu group 0
[  127.388074][    T1] Freeing unused kernel memory: 22528K
[  133.527005][    T1] Checked W+X mappings: passed, no W+X pages found
[  133.533474][    T1] Run /init as init process
[  133.727196][    T1] systemd[1]: System time before build time, advancing
clock.
[  134.576021][ T1587] modprobe (1587) used greatest stack depth: 27056 bytes
left
[  134.764026][    T1] systemd[1]: systemd 239 running in system mode. (+PAM
+AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT
+GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-
hierarchy=legacy)
[  134.799044][    T1] systemd[1]: Detected architecture arm64.
[  134.804818][    T1] systemd[1]: Running in initial RAM disk.
<...hang...>

Fix it by either set page_alloc.shuffle=0 or CONFIG_PROVE_LOCKING=n which allow
it to continue successfully.


[  121.093846][    T1] systemd[1]: Set hostname to <hpe-apollo-cn99xx>.
[  123.157524][    T1] random: systemd: uninitialized urandom read (16 bytes
read)
[  123.168562][    T1] systemd[1]: Listening on Journal Socket.
[  OK  ] Listening on Journal Socket.
[  123.203932][    T1] random: systemd: uninitialized urandom read (16 bytes
read)
[  123.212813][    T1] systemd[1]: Listening on udev Kernel Socket.
[  OK  ] Listening on udev Kernel Socket.
...

Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9EAC00306
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081C120825
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="RE1kQcFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391756AbfIEVIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 17:08:04 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44043 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391745AbfIEVID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 17:08:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id u40so4572196qth.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 14:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HvoJM9sMGq5xI3RwMvugcMXuusxVFzNWPQZRfU0rEf8=;
        b=RE1kQcFxWLO+aub3BJU/i/hazoxxbNU/KRFZj4Yf4mDb4K8zmul3vWp/RDVVFMnCaV
         QX7/TnC7DuZWGLudP8Vwi+KwuJBCSIwq9urMjeXsLuP8SZWja6CfE7N8GK2kQx7f/BCu
         iAVspylz/WJ1PGnD/M1oDkyUKErs8+PtG8mdpd0mxQefo3dPEcIgsnJvD3ryXtj/LB9r
         IN0zb+7LzqSvm9a2uSNuUnZ932xeKnGAccrllI9cX+YSR+nlBkR5aQMj6lO2Pa6n9n51
         /AUIzWhaVCT5TeZcRUkT7uLoxe9JASdBGMnKn3LJ6O9CSsJvlEywBPIqtAoEGHRFAz69
         TiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HvoJM9sMGq5xI3RwMvugcMXuusxVFzNWPQZRfU0rEf8=;
        b=Dy6oYIX49a4CTXvsjzjo863ANOXD/r5I5+uRSnNVCEF67DD6o5XOb3I7b8Vu2YBDX/
         1KDCQ6LsSGxBqJbk10vsZ//G7rnkL2kzD0eMNtZiSaR1QRllCD4QRSTxb+XJTgxWVXQU
         np9V3wY8oFesLad/tAbBM3rAoiXEjD8kPt1HUcRkdUiLu3p8vb0Qj24CBfCaY/oMY8uO
         CbJ20eLfO2WSdUt5BOelJn81jqdezIrn9NgdpAhPIVjlaldOY7yVoJ/bc9O4fW+HPqmk
         i/v875wmsC3CaKpx2U44KoWuDqfZodsGoPTvIwdf78dIK3DshsmIq0eNt5OLnE8jsMo2
         4GeA==
X-Gm-Message-State: APjAAAXH/DI7gvqEMEdmvMq/mPwjdI/CQPtRKwNNp3WWwY3fbGnQVj0Q
        iGtinXpz9fmEggOuHvsGGNVraA==
X-Google-Smtp-Source: APXvYqxY2ypIf1XfIoVNJF4qwIapFtfKnB7Ak69TdLWw2rUBh9E7c/fsOawf0Iylhmq8cCiBqn8CyA==
X-Received: by 2002:a05:6214:16cb:: with SMTP id d11mr3355475qvz.241.1567717682191;
        Thu, 05 Sep 2019 14:08:02 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k11sm1510843qtp.26.2019.09.05.14.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 14:08:01 -0700 (PDT)
Message-ID: <1567717680.5576.104.camel@lca.pw>
Subject: Re: page_alloc.shuffle=1 + CONFIG_PROVE_LOCKING=y = arm64 hang
From:   Qian Cai <cai@lca.pw>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Thu, 05 Sep 2019 17:08:00 -0400
In-Reply-To: <1566509603.5576.10.camel@lca.pw>
References: <1566509603.5576.10.camel@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another data point is if change CONFIG_DEBUG_OBJECTS_TIMERS from =y to =n, it
will also fix it.

On Thu, 2019-08-22 at 17:33 -0400, Qian Cai wrote:
> https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config
> 
> Booting an arm64 ThunderX2 server with page_alloc.shuffle=1 [1] +
> CONFIG_PROVE_LOCKING=y results in hanging.
> 
> [1] https://lore.kernel.org/linux-mm/154899811208.3165233.17623209031065121886.s
> tgit@dwillia2-desk3.amr.corp.intel.com/
> 
> ...
> [  125.142689][    T1] arm-smmu-v3 arm-smmu-v3.2.auto: option mask 0x2
> [  125.149687][    T1] arm-smmu-v3 arm-smmu-v3.2.auto: ias 44-bit, oas 44-bit
> (features 0x0000170d)
> [  125.165198][    T1] arm-smmu-v3 arm-smmu-v3.2.auto: allocated 524288 entries
> for cmdq
> [  125.239425][ [  125.251484][    T1] arm-smmu-v3 arm-smmu-v3.3.auto: option
> mask 0x2
> [  125.258233][    T1] arm-smmu-v3 arm-smmu-v3.3.auto: ias 44-bit, oas 44-bit
> (features 0x0000170d)
> [  125.282750][    T1] arm-smmu-v3 arm-smmu-v3.3.auto: allocated 524288 entries
> for cmdq
> [  125.320097][    T1] arm-smmu-v3 arm-smmu-v3.3.auto: allocated 524288 entries
> for evtq
> [  125.332667][    T1] arm-smmu-v3 arm-smmu-v3.4.auto: option mask 0x2
> [  125.339427][    T1] arm-smmu-v3 arm-smmu-v3.4.auto: ias 44-bit, oas 44-bit
> (features 0x0000170d)
> [  125.354846][    T1] arm-smmu-v3 arm-smmu-v3.4.auto: allocated 524288 entries
> for cmdq
> [  125.375295][    T1] arm-smmu-v3 arm-smmu-v3.4.auto: allocated 524288 entries
> for evtq
> [  125.387371][    T1] arm-smmu-v3 arm-smmu-v3.5.auto: option mask 0x2
> [  125.393955][    T1] arm-smmu-v3 arm-smmu-v3.5.auto: ias 44-bit, oas 44-bit
> (features 0x0000170d)
> [  125.522605][    T1] arm-smmu-v3 arm-smmu-v3.5.auto: allocated 524288 entries
> for cmdq
> [  125.543338][    T1] arm-smmu-v3 arm-smmu-v3.5.auto: allocated 524288 entries
> for evtq
> [  126.694742][    T1] EFI Variables Facility v0.08 2004-May-17
> [  126.799291][    T1] NET: Registered protocol family 17
> [  126.978632][    T1] zswap: loaded using pool lzo/zbud
> [  126.989168][    T1] kmemleak: Kernel memory leak detector initialized
> [  126.989191][ T1577] kmemleak: Automatic memory scanning thread started
> [  127.044079][ T1335] pcieport 0000:0f:00.0: Adding to iommu group 0
> [  127.388074][    T1] Freeing unused kernel memory: 22528K
> [  133.527005][    T1] Checked W+X mappings: passed, no W+X pages found
> [  133.533474][    T1] Run /init as init process
> [  133.727196][    T1] systemd[1]: System time before build time, advancing
> clock.
> [  134.576021][ T1587] modprobe (1587) used greatest stack depth: 27056 bytes
> left
> [  134.764026][    T1] systemd[1]: systemd 239 running in system mode. (+PAM
> +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT
> +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-
> hierarchy=legacy)
> [  134.799044][    T1] systemd[1]: Detected architecture arm64.
> [  134.804818][    T1] systemd[1]: Running in initial RAM disk.
> <...hang...>
> 
> Fix it by either set page_alloc.shuffle=0 or CONFIG_PROVE_LOCKING=n which allow
> it to continue successfully.
> 
> 
> [  121.093846][    T1] systemd[1]: Set hostname to <hpe-apollo-cn99xx>.
> [  123.157524][    T1] random: systemd: uninitialized urandom read (16 bytes
> read)
> [  123.168562][    T1] systemd[1]: Listening on Journal Socket.
> [  OK  ] Listening on Journal Socket.
> [  123.203932][    T1] random: systemd: uninitialized urandom read (16 bytes
> read)
> [  123.212813][    T1] systemd[1]: Listening on udev Kernel Socket.
> [  OK  ] Listening on udev Kernel Socket.
> ...

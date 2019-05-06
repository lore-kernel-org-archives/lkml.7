Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A344DC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767492082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557140163;
	bh=x3rg3NhokaRryuw8g51JUPCoblLJP2TxV4w0LauUpvs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=d/UwYUoDSovu21ZHKy3e3ip/9pjbN+JnCUpxaDnjCYWKpwELsrLqnRUC+ZCQjO03y
	 a4njm+NWGLe7VIjUlhWruRH0tMFB0TZ9BR0lHRoYdAFrfwDLs5/pgy4Y/paAaKgLob
	 +BjpDc4NvK4f71LnnE+fRFjU1m/4Ta5AqPkiVA+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfEFK4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:56:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52905 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfEFKz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:55:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so4062409wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 03:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZyOCX6SJM9uDIrHF8mFcZJhvJSqc64v/9SiyLVN1Jx4=;
        b=aKCEzVIhgsKYynQjmrT2gBIZ7xlBqNEDqvhl341pYylRair9vaZJUSQjX3Ivc//xL/
         +X18Vn2LxWoK27VbGP9j+ZWHhw/PAPwLa2jZHnT+gc+AlyZ3s4XxDB83Hwupg0QCDAE2
         WWVbMfBhIFUlxxvbs3Qb/WWezC65iLsEzYwkPX8MsQz3yzbvGICLVAQHSqK9RrT+OIzU
         ImaxfmyqBpSuujyq5WGaZYYdP2HxaVScblj7TWpxNFj5zHWN1ebXgMpNUqjjyOnc+hQ5
         6snq9MT+NlBlp6Qt3BhpYGRqf59hr75/3ixXINZbrcCux0SBz9VSd22cQOMFmE+EwzKj
         OjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ZyOCX6SJM9uDIrHF8mFcZJhvJSqc64v/9SiyLVN1Jx4=;
        b=NZHcjvc1NVWgXKKWVtu9MN8E8sw+yZdfBfyBcppbkNooZi7Yt7fd4GK4qzKsrZTgto
         mKYjYZso9huCTBHn48xaQZGMPeY0BhEsLIWefNAeI+ZvP8uyAOSA96fd25w8U9PC70Tl
         Ac7iDUv5LrBIalTqxD+TQScKpKAYc9VtPG0hY6cZosPao7CHDNh5sCw+TBNNVgDo3OdZ
         7SlMiYGPA/lCcGeB1Ewt9xiSWI0oEQfKFrm1RrHJGfZPIKyI3GaAiMe1EVTLB7Ze9w8D
         /zBWJRjqeS9DJwABMHD79EiugRyFDFbJVCtvqyq3SQF/9bxy4nwzr8MwWwJQJtzPP3Kl
         M0lQ==
X-Gm-Message-State: APjAAAU/U1m+B1Q851TPzGxH/CfppNkrVq05+BvlZf0rkUwkDSHCMxH5
        E2qz2+5v2CmM1xq60rbUOcM=
X-Google-Smtp-Source: APXvYqzJEU4on1qCD6Yu7pkH20vcto0LpJr0qrnP6EAXH2ioanm74CgvI2Ce0hoIiKLwAyzadHTm8Q==
X-Received: by 2002:a05:600c:114e:: with SMTP id z14mr1413762wmz.92.1557140157838;
        Mon, 06 May 2019 03:55:57 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q2sm12269467wrd.48.2019.05.06.03.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 03:55:57 -0700 (PDT)
Date:   Mon, 6 May 2019 12:55:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/topology changes for v5.2
Message-ID: <20190506105554.GA71356@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-topology-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-topology-for-linus

   # HEAD: 8fea0f59e97df3b9b8d2a76af54f633f4586751b x86/topology: Make DEBUG_HOTPLUG_CPU0 pr_info() more descriptive

Two main changes: preparatory changes for Intel multi-die topology 
support, plus a syslog message tweak.

 Thanks,

	Ingo

------------------>
Juri Lelli (1):
      x86/topology: Make DEBUG_HOTPLUG_CPU0 pr_info() more descriptive

Len Brown (3):
      x86/topology: Fix documentation typo
      topology: Simplify cputopology.txt formatting and wording
      x86/smpboot: Rename match_die() to match_pkg()


 Documentation/cputopology.txt  | 46 +++++++++++++++++++++---------------------
 Documentation/x86/topology.txt |  2 +-
 arch/x86/kernel/smpboot.c      |  6 +++---
 arch/x86/kernel/topology.c     |  2 +-
 4 files changed, 28 insertions(+), 28 deletions(-)

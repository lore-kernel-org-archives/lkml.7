Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AB8C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDD320740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574692496;
	bh=y1ldojMJX5MFRGBuDlmJDHo7qG4uS3dd9JPM3yhfOYI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=KNy0BkmscWzIvX2jUDKRlyIWXh2Ep4cJDrHeSif9gPZLEGBTywJtSyijz+uDgMXRz
	 4E5heRJwYahnfP22fGzTj0p9bfCZSx3e/NVJVXjNL9/5gws4n4yfoUkCvvpMmHTx/H
	 rSp5Vr90Xkzvkbnxaw9Br5lbFrZGAd7ZwfNCgRec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbfKYOez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:34:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38492 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbfKYOez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:34:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so18394950wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 06:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hsCHkSe4yiTHlZ/ob7mBGFXAFtIdPFWVmJbJbHu7lhM=;
        b=tUY0HhjpdqZHcU+HA7gBU0/ljh1Owrz2Z+p4NlGH5hwUe1I7ve2QaBGuhPmTbH7R0w
         hcqEhdjGPRB1aI1N8mimEiJLuXbgVX0QMH09li38ZQrGvnbe+68cGQcE3BW0aqPgB/UZ
         Sqt01wbICVRYnP+oRl90Ic4JTckXKVUnc0WEMiMuVD0Da84I+bfXBGQIQ+LkkV+qpM2D
         lOcA6eX/WGWfem4alN6zzSStCUnwN108XkRaoYXtACeNL9jA+SS8sIPwKm7ZCBweho2f
         /DVC0zColrht2J9qU+DgrqBxhxNZBRh2ksQbvowc0Ls19c2r80kbtP5ymY74NfkRuC8W
         TM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=hsCHkSe4yiTHlZ/ob7mBGFXAFtIdPFWVmJbJbHu7lhM=;
        b=cnoUyy1TzcIjpWpuKrkuWDLqEC8YCwBjYYzahMuL4Vgw0tiClJF6JLbUa9rs9TqU+Z
         VNT3OLfpAWKRbi9YNtowhATTyKaF5UWJbmdlRxU1Ww5MDOBV8Z7KtcBEFE56G8Aq0PY1
         YDKLGFdD+rSK4UFbz1daTnB/z6h0r5moxDsnU/7D/P7l8bJI7nQlZV35bHyhsU2ggRIq
         CpbRg0N8QHEqxzwy0dYoF0WMivliOTZ2omWEoGiDjELMIYgdHefeeDwLa8nV/C3a0T3G
         /dP/BB9+utS3YI1A/koWYb2KIC3va7WcWr1XyHNTcZxeTkgbJmGwsPOcl+q7lkaciKGH
         BXhQ==
X-Gm-Message-State: APjAAAWn8/XQO8cA7eEf65nok3YJwlaWbngeix17Y2QmubElnktw4ywU
        CSqBW9sz4lsUWazrMV4ZBKo=
X-Google-Smtp-Source: APXvYqxkF2bbo30zFdGa2V8H2D3/2pEeZM5yuPuhMBugBdPyuFxrGtn+xmiF3Km3vd/kucUUukwmAw==
X-Received: by 2002:adf:f445:: with SMTP id f5mr9495913wrp.193.1574692493298;
        Mon, 25 Nov 2019 06:34:53 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id t185sm9039620wmf.45.2019.11.25.06.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:34:52 -0800 (PST)
Date:   Mon, 25 Nov 2019 15:34:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/pti updates for v5.5
Message-ID: <20191125143450.GA26649@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-pti-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus

   # HEAD: cd5a2aa89e847bdda7b62029d94e95488d73f6b2 x86/speculation: Fix redundant MDS mitigation message

Fix reporting bugs of the MDS and TAA mitigation status, if one or both 
are set via a boot option. No change to mitigation behavior intended.

 Thanks,

	Ingo

------------------>
Waiman Long (2):
      x86/speculation: Fix incorrect MDS/TAA mitigation status
      x86/speculation: Fix redundant MDS mitigation message


 Documentation/admin-guide/hw-vuln/mds.rst          |  7 +++--
 .../admin-guide/hw-vuln/tsx_async_abort.rst        |  5 +++-
 Documentation/admin-guide/kernel-parameters.txt    | 11 ++++++++
 arch/x86/kernel/cpu/bugs.c                         | 30 ++++++++++++++++++++--
 4 files changed, 48 insertions(+), 5 deletions(-)


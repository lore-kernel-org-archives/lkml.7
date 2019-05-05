Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCE0C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 11:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E64208C0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 11:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557054164;
	bh=z1IRzTc8v8psDgdcW4KVCs5k+cx5NY8YHO18lXbsbj0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=MXxlQYsRx85uMy0PNZRaNsqlh7ZPWWJ/vAICRNQT2a3h/cP7gdsgE2AI4c7RD5d9W
	 BsL/AHE/uZclT4aP2R6f6E33Jt0M15bk7ZeXCgsV8JEX0gOtCO2nkdXVvw4BfBskwc
	 w9bQPPWPReZq74X/1+cb/Kj5IPbwn0jhWaidG+g4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfEELCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 07:02:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38643 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfEELCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 07:02:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id f2so6818162wmj.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 04:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=x8mV7x+FPIFvdsLXVSM2HKi4CxbkEk7BDJY8c/xlocc=;
        b=WLx9vmMlh9e+VhhaoDn+Jm5ZDbQXaaC7I4RElCRhfE6/ZCclY+csvwos7VsZQXOHcS
         X+YAxWd7oYjzmfKRqVrTXSSdxoPV/v9u/pSFzjKtm73IjysZeXUwfi1ByjjsYwSTeOqA
         tHYAVEpURPgphLfiMh8QM6FPlTeLdZ34IEIM3d3G4SCKU6dm6a1Knu5CB1kYewyDYey7
         e1V6eE1KRcr9G5xWh7rvULQLxGR3sFG/YEANU+EZv28SpTiou2HjThw0F47GuGwo3Ab5
         QXLkX+NNt+q3mFlGV298XksXwC3jz98ffdOLHbZeb4MPu7Gsqxy9X53CNn+J5sgZPecd
         NryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=x8mV7x+FPIFvdsLXVSM2HKi4CxbkEk7BDJY8c/xlocc=;
        b=MNAE/M1vTRH1sDk8gZvV+lDsjjDBCXr2Xy7xmAZM5cf9CV1G5blg/6NwPvd392Gddv
         e2zyneQ+iO9b6s5GiXyeMEvrPlFtFVZurSOWgPyJzR2slM+WeM5kW3BG9tdn3wBYj5AW
         79HTbM2RNhvoBWwwHkUfUM78Q+jR4HLl6QBY3fuzwkz5TPertFPYayzi5j7h80fp7Z/t
         z+7mqBooh62lizpYvM13Xi7MdnWG9iWlOpt/wagkCTXlhVRCQZrzxFcG78wctPnuWDUe
         cv/aQWkMRgNqhO/goNLO+E+0k60yZ69WVChEj4YiWk8JWmtOLMquuqm1nZ95hvf1RKxQ
         l4wg==
X-Gm-Message-State: APjAAAUJB5e0zseBdYmbTtW6TXBlEnIk/2LHKhj7q7iZAQbDDeymKVk9
        xACZlKLGfgVu8Ak3QnZcy1I=
X-Google-Smtp-Source: APXvYqwQQi+sAdhJ6+icKFi7CVgUIRwHua7GljWVzqTiB5DckT1yxoPoS2oF3NfVJzVaSvmm9B/+Lw==
X-Received: by 2002:a7b:cb4e:: with SMTP id v14mr12282053wmj.52.1557054160829;
        Sun, 05 May 2019 04:02:40 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c4sm6547587wrh.10.2019.05.05.04.02.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 May 2019 04:02:40 -0700 (PDT)
Date:   Sun, 5 May 2019 13:02:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fix
Message-ID: <20190505110237.GA5049@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: 9a4f26cc98d81b67ecc23b890c28e2df324e29f3 sched/cpufreq: Fix kobject memleak

Fix a kobject memory leak in the cpufreq code.

 Thanks,

	Ingo

------------------>
Tobin C. Harding (1):
      sched/cpufreq: Fix kobject memleak


 kernel/sched/cpufreq_schedutil.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 5c41ea367422..3638d2377e3c 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -771,6 +771,7 @@ static int sugov_init(struct cpufreq_policy *policy)
 	return 0;
 
 fail:
+	kobject_put(&tunables->attr_set.kobj);
 	policy->governor_data = NULL;
 	sugov_tunables_free(tunables);
 

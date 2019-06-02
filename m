Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF0AC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D483273A0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559496759;
	bh=X7BkSitWUo5k9Gw8U65tfTl9Ch7l6XUzmjKw/8AXJiU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=XbdqJlimpp48eogiFQyds5ruj3R1uOZH9d3XeTdsTSAG7D6JpaiKhrJF5D9ccoKm0
	 gXy27WwRwXNLcqa0DmjDKeOB8d09bmlkBoiSK8WzWlIbuYqCfWfCGhYErs12Qbbatg
	 rsPS8YbHrgOL8U43nQIovPkWG4pvlNN41CxivChg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfFBRci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 13:32:38 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:40741 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfFBRci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 13:32:38 -0400
Received: by mail-wr1-f51.google.com with SMTP id p11so4915993wre.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 10:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=uGhq/DFCmh9x/QiI3c2FfenegvK+p86vibxoOmRXfhU=;
        b=SW/xbczif2gORIFVFSCqoLa80ZqwatuR+jUduYVGA4F9dS4W7ECvQ78QB48RXfOxro
         XmLym4C6EnhrBpsdny3ijIkZ1Y5wEefe61YHAoQpUyz92Vqt7uM1Yb4BGujL83C/iY8D
         nSnlTRItSPQCQTIv0pATssE+3Chtz15ij5vrG3faOzt3tsXuQSImtmea70jvz8kRqFSr
         n+RifK6NBxzDp+0jDO5Nwm/s4S1dO0obCqzGnVu1Sj5ug+eI5lCHqncUL+dy3rn2ZtuY
         9BrFA1JBZIn7KQrPOTe7snDrVXuU14NSqEcAOq7wH56qmRKAqeVi4hpc9sQNzttdhK/P
         KFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=uGhq/DFCmh9x/QiI3c2FfenegvK+p86vibxoOmRXfhU=;
        b=sZobTi+ciZI+PaFUIoZrT3UMFF2LI+sPEyWDslVQDLvKaKDdzSOKPIfMY7Z7BZdTLR
         lJpVW5GJzHQmaO9oD/jkfrATaK+bvPZND9iKeUkCfTSYizaTOfWr5QehgRKxoGlTiuyy
         HTdWzfg8VZvEvl1+Nclw6J6K74IBVlRBdORJx9615sS+U+ZaE3mXHWfJPGcBuoNnjnUS
         Ew3jJeLbJWwsDZQbeSNmxknrqSvwQu/u056qpXjKmP/G6FWC90VIFAfW94IOxxScFueT
         1dU1fwwRB5+PkpL3ol3725lU5k9UshyFNhnVlvElpTsl22OZVuHMHGa+G2Yt07l20uuc
         MH1g==
X-Gm-Message-State: APjAAAV4EQ6W3QOw9D2jqOcUQoOoW7r7jAoXHEror7ws6FpL5/1rr3wJ
        PLSIs1sif94MODPbOx7kOjA=
X-Google-Smtp-Source: APXvYqwAFHMKT8Ae8jYnFwsF8veIgv1hO8aDPTodkms8Hk4ydrOHZvH156oJEenPcf1WDUnshslpJQ==
X-Received: by 2002:a5d:4141:: with SMTP id c1mr5051013wrq.159.1559496757052;
        Sun, 02 Jun 2019 10:32:37 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i9sm8819311wmf.43.2019.06.02.10.32.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 10:32:36 -0700 (PDT)
Date:   Sun, 2 Jun 2019 19:32:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] core/urgent fix
Message-ID: <20190602173234.GA126544@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

   # HEAD: 7eaf51a2e094229b75cc0c315f1cbbe2f3960058 stacktrace: Unbreak stack_trace_save_tsk_reliable()

Fix a stack_trace_save_tsk_reliable() regression.

 Thanks,

	Ingo

------------------>
Joe Lawrence (1):
      stacktrace: Unbreak stack_trace_save_tsk_reliable()


 kernel/stacktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 27bafc1e271e..90d3e0bf0302 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -206,7 +206,7 @@ int stack_trace_save_tsk_reliable(struct task_struct *tsk, unsigned long *store,
 
 	ret = arch_stack_walk_reliable(consume_entry, &c, tsk);
 	put_task_stack(tsk);
-	return ret;
+	return ret ? ret : c.len;
 }
 #endif
 

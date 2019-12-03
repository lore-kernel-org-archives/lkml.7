Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D75C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30EC120684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575353174;
	bh=W/lb+NDZ3JWiJq6DDrWZRc4hcbXek1SBpW1hjxThmA4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=cAldQ5xRT71P8wODgQbW90a9CNQnAh4b/nKRvq91Bmo/rDEsTm/jGisKJ0SxO8+zy
	 YKcU6mQzpGBg/qJEQcJflSokyq7bR//e6eE4J4VCQ71Tik7DRBlMe7HgES30hEaOPQ
	 WiVZS7EnMPmRZGL6EBzK0c81I90BoGDHtlh/hkFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfLCGGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 01:06:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfLCGGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 01:06:12 -0500
Received: from localhost.localdomain (unknown [180.22.253.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 068A120684;
        Tue,  3 Dec 2019 06:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575353172;
        bh=W/lb+NDZ3JWiJq6DDrWZRc4hcbXek1SBpW1hjxThmA4=;
        h=From:To:Cc:Subject:Date:From;
        b=i3bXmiWXAL1sAe23w9MGnFtZNhj785YTxyIcIEcw7mrex6lmOvvEX4o2TcGKgen5s
         HP2oIi871FWQxK4bEuQLhQXDdHhkDrLy4EDkwJe0+RZVmJDIF1KLGL5gl71MSEVub4
         HTntmb+JqgwOdqC0hjGx69fiElhlb9UMbZWSkl4w=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH -tip V2 0/2] kprobes: Fix RCU warning and cleanup
Date:   Tue,  3 Dec 2019 15:06:06 +0900
Message-Id: <157535316659.16485.11817291759382261088.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a couple of patches which fix suspicious RCU
usage warnings in kprobes.

Anders reported the first warning in kprobe smoke test
with CONFIG_PROVE_RCU_LIST=y. While fixing this issue,
I found similar issues and cleanups in kprobes.

Thank you,

---

Masami Hiramatsu (2):
      kprobes: Suppress the suspicious RCU warning on kprobes
      kprobes: Use non RCU traversal APIs on kprobe_tables if possible


 kernel/kprobes.c |   32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

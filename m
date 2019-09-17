Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B55FC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 10:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63DD21852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 10:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568714637;
	bh=raF3m7RsQSf+ERxtv4KxiA2UQ2mBAxKtPRp2HuXfwC0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=HyE6z/T4x+hwMM60pgfF+jj26kI9mVQofyLfwGei1l0utQNwH1M0Ja+STKeiHFtYQ
	 uN+dKnMz1XyJLkheJvkU5bUN58RR85nh2HcbiX3EduTfNqNOufE2Gxh/BEoj9+EMwY
	 Vc4P4Yyfw2SMyUE4oIM+O//I5MPKqyOk5J3qwTmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfIQKD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 06:03:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:58322 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726688AbfIQKD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 06:03:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68372B634;
        Tue, 17 Sep 2019 10:03:55 +0000 (UTC)
Date:   Tue, 17 Sep 2019 12:03:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: threads-max observe limits
Message-ID: <20190917100350.GB1872@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have just stmbled over 16db3d3f1170 ("kernel/sysctl.c: threads-max
observe limits") and I am really wondering what is the motivation behind
the patch. We've had a customer noticing the threads_max autoscaling
differences btween 3.12 and 4.4 kernels and wanted to override the auto
tuning from the userspace, just to find out that this is not possible.

Why do we override user admin like that? I find it quite dubious to be
honest. Especially when the auto-tunning is just a very rough estimation
and it seems quite arbitrary.

Thanks
-- 
Michal Hocko
SUSE Labs

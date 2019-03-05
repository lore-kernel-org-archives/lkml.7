Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564AEC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DE7205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551815167;
	bh=1uUV01IE1L5v5w6djZxxr2wlcMlt+na0sjW20kk0xD4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=pcQr27yvOFos19eSjej5K1havvebbKwLOQHI/++RbkMuXdjd2Pj7zlaasS23EX1ju
	 Drm3Z1fXZ9v9+Nv0lNQ3+edan5B78/W/srtniqb/ClOQK4WVBzPLaqzQnb4mReYR0X
	 lrDx5vnuuTELOTCeFGxYpYG06D/7fBCIc8yOi8JE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfCETqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 14:46:05 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44122 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfCETqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 14:46:05 -0500
Received: by mail-yw1-f67.google.com with SMTP id x21so7922564ywx.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 11:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ehdkH0KE6+YH0FPchCPYSb07PtIF6/HuwVRuSu2qWlY=;
        b=pzHIgJOdrjsRPtyr8W4fLUBAv1MTzASOdtgcbEqqRVrECMQxWVSvrP38WebbfgqBqO
         IHBHsGhy08dSFo5LR4Vdwg3xNOELKekdsL67SfJ7l6cY7fPTBiEocH1YIifnYrmzcEa3
         nQR0T7K1eKEZ0tj8oX6Bua2kxASG9+0e89Hu0JmdhygMEqnaVMUz9G0i/FbklZDKIQ5M
         nbRzOgiMRdAu2lTMuEr/IGiMPUWlDmsYXDA9BZgKvx65qOC8xaY5PeV6Ia8ikhPk2wFT
         zUfQF334o/u8MCGh+BlDJ0Nt0ZT1IAfdm2Y90zROR+UiDLWfdbV7IMemHDr5W2DEN7Bs
         xTkQ==
X-Gm-Message-State: APjAAAVSiim1/46S69feLrgPGEbqhgjvlO+1iPnNQ/fJfWhridNKccWC
        0+jBVTVC2OmLUdDu/E9zRmrl0GwF
X-Google-Smtp-Source: APXvYqxew+1dp6e80t3H8ok2ne4qk+G57EAJiEo5luIxPnWaI2sIqynB6SS+98pSu+KsuXVZQrEFSA==
X-Received: by 2002:a25:2406:: with SMTP id k6mr3665144ybk.281.1551815164248;
        Tue, 05 Mar 2019 11:46:04 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::ff62])
        by smtp.gmail.com with ESMTPSA id 205sm3462140ywd.15.2019.03.05.11.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:46:03 -0800 (PST)
Date:   Tue, 5 Mar 2019 14:46:00 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>
Subject: [GIT PULL] percpu changes for v5.1-rc1
Message-ID: <20190305194600.GA4595@dennisz-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

There are 2 minor changes to the percpu allocator this merge window:
 * for loop condition that could be out of bounds on multi-socket UP
 * cosmetic removal of pcpu_group_offsets[0] in UP code as it is 0

There has been an interest in having better alignment with percpu
allocations. This has caused a performance regression in at least 1
reported workload. I have a series out which adds scan hints to the
allocator as well as some other performance oriented changes. I hope to
have this queued for v5.2 soon.

Thanks,
Dennis

The following changes since commit a3b22b9f11d9fbc48b0291ea92259a5a810e9438:

  Linux 5.0-rc7 (2019-02-17 18:46:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.1

for you to fetch changes up to 1b046b445c0f856c3c1eed38a348bd87cc2dc730:

  percpu: km: no need to consider pcpu_group_offsets[0] (2019-02-26 13:47:58 -0800)

----------------------------------------------------------------
Peng Fan (2):
      percpu: use nr_groups as check condition
      percpu: km: no need to consider pcpu_group_offsets[0]

 mm/percpu-km.c | 2 +-
 mm/percpu.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

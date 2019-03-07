Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86E1C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CF620449
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551986592;
	bh=jdYQrUmMLqF9kubl5TC71vseG4ARLU1lrulObhBhZIM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=P2t4d5objNHWk2Xl49/BqrNRWIWxtbIEG3SnWNiTpMQtP2T9rkhyFkQZ0XLSCwGoO
	 zyPOubnp7HxI8TlXSailrfKV5bU9RFi8SKQwruMRlDWrsdQnvlM5P9ro4oilCVjrbp
	 aiknEOE+iMh+GBoFpNQdoz+1+xwBnUINnlvXt3LY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfCGTXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:23:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33683 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGTXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:23:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so18788957wrw.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 11:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yDxD3XRdKqaq0labhy2zx3dkWl61h1ZKwbUIxM/vgqc=;
        b=aMFxp0S6ZAocvhzYncgy85tJR9rI8OU4GXdhUyOqYqjwpJF+dCkaUKn+9S0P/dAcpT
         jRbziFcWMzMNClTfTJhDO4k/+5jCQ2PvqBaFwLT3Sg9pXD4GaXYEfiqDIQJpPX/5PUpl
         lU3U1MV3weTRaQOtdwysXySpe5Lh3AE5N93S8/zCyZBvEVDMkQYB8aQgFoyiw5/ZffJJ
         zRBSMVqlKK0Xc8+ZsW/iCp39CZdIOcAb43awb742S3HvUr0+tEKnfFXHbWz/HCSWNLWP
         2qxgI55tGMNRQPXrH99i0U3Nzwj11+Kx+ggpxM78wcPho1uKQg5j7syOaWtZEn70/rgm
         QuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=yDxD3XRdKqaq0labhy2zx3dkWl61h1ZKwbUIxM/vgqc=;
        b=EEVnX6WuSdxAy0JhByr+b27a2Q0ti6OJbW7QasWvDxkalxZGqRaHAEMlwICIjakSPg
         0QWypdEbg6GWzSlgB1twdNLt86aK5/2bkxgM+Oww72vzPiGJJlRzshmsBnE0TzO1Pb3R
         vd+lnF5znPJvjogj6OIiNCSWpUtRMZiIpxnPeXD8xIrUCDNwh8u121dnepAAHoM6JFGi
         DFo2tecn+twRzwxomrWHLyD9VjCk6wawj6iDrCfMNXibB3w+Eub5f7464TRL3dWAukMR
         CBlo5vkKWIlRGHBsXnuMwhMk3g1+NBGCcMJFeSZWC06MJJ3EdesgLHfUw6H0+EmndFE+
         UnfQ==
X-Gm-Message-State: APjAAAVVOwkl8qUYg8XqO2qah01DH3mExPcy8kVrFwg8QND8q6IOqNaV
        MMDcCi1gko8gi5bc1+GW9/0=
X-Google-Smtp-Source: APXvYqxyeaC1lF5sgHH1LPQ+hEpVV7IQrI59cyayS38ql//j6iWLMyS+RP7cJrO97Hj1iuIp9P9Pmw==
X-Received: by 2002:adf:fdc3:: with SMTP id i3mr7604274wrs.252.1551986588932;
        Thu, 07 Mar 2019 11:23:08 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id d1sm6275685wrs.13.2019.03.07.11.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 11:23:08 -0800 (PST)
Date:   Thu, 7 Mar 2019 20:23:05 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/kdump changes for v5.1
Message-ID: <20190307192305.GA33711@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-kdump-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-kdump-for-linus

   # HEAD: f263245a0ce2c4e23b89a58fa5f7dfc048e11929 kdump: Document kernel data exported in the vmcoreinfo note

Add the AMD SME mask to the vmcoreinfo, and also document our vmcoreinfo 
fields.

 Thanks,

	Ingo

------------------>
Lianbo Jiang (2):
      x86/kdump: Export the SME mask to vmcoreinfo
      kdump: Document kernel data exported in the vmcoreinfo note


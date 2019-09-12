Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAF6C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20BF208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568277310;
	bh=CPS/sk/QHOK1iKj+qOwe1f0GydqmyAObzk/dN3l19po=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Ay+2PjoYGexDgliPQOcjxeMsUCM1H0fv95yyDEOlsXcnrau2ECveQdco56rWSZQ/S
	 x4noeZj46yOwk6YRUU7cmjKUexKoYeVi47eSiW4kUZ5FLuIpKSr1rsTcL6kFVuOHAE
	 Q/52YtZvtf25OtNGZlsMUxiwt9ds487mr7iWpMA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbfILIfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 04:35:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51367 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfILIfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 04:35:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so6435116wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 01:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wbjx38cx9pM0sFcrLnBM6olZjRYMq3cjSn3rES6QPTM=;
        b=KkEOnVJG6W4Qa0nJAcsLtTpRg6DzCln8FoVNfJU1wBC/1QixEuEX6euFSSOl9Su1QP
         80FxXu+Ea13m72qxVi+5WszrFV0Jx20AwTGVbrsgTAX3CH3QCaTo/vUf6WZgRfregN/A
         BkVVWfqEipy+GR/ZKD4rHFDUbWMzDtjSd66v9l7KNE5XTTS0LTbxPOnYvKcnCaGltPh5
         0daXKBNs5KrKQleuZQhLi0oMZ/2nTSuM2ftr4dPJF1Z7dSdoDO+p3z6RkmSWuBrfNgsv
         Ep3Rnc7hq9VFTN4ziqVXhfGNR2MDrI2UU4dKNQe1n/GXe+qcHQN9OWa41cIhDR+XHJae
         i+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=wbjx38cx9pM0sFcrLnBM6olZjRYMq3cjSn3rES6QPTM=;
        b=DhbfvXYQh55mFywmLq37KfLj+RPgAVjZqtm4ZnM9NKKANi8BSzDHQbNvVr+E9ZKfvE
         KYdwwBzlCJY1QnZ93dTwtXZW5H88UYveMmrxTyTTfU9iq/JQw0sMdP8giDnhu+u14SuF
         mLAl8VfyNlFUVeveZOAH10kmDIg4sf2r8AGOGyIkwXJX7vXRFsue0d9ib8mfL/CD8RQ5
         ZuGyZ0/LOV3jFG7E/g2R8Zxlj+QRqC9DGZ2lsrPDPRwaMC7Sl/6A5Z4vkttnG0GqA3nx
         mePZWxSeonbrqhc+9uWt6ebdicbCtZ6H067nCVVbOzufSMc3IIONSP5OaT0xhf4KBmTg
         0SIw==
X-Gm-Message-State: APjAAAUPFbNuqA25LYQCjjfMekWjGG48Hl1HOmLhX5UsbBTuEThpquo0
        GYoVETV+Ded1HJFXftga+7Q=
X-Google-Smtp-Source: APXvYqxb7l5t0Q7F2RMblVg2TwZDR8XaEoiOiwK4hzzSUlLvy6u+NrwB+nDkoGIezXdumYgLD8zBcw==
X-Received: by 2002:a1c:7c15:: with SMTP id x21mr7921798wmc.154.1568277305871;
        Thu, 12 Sep 2019 01:35:05 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r13sm759108wrn.0.2019.09.12.01.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 01:35:05 -0700 (PDT)
Date:   Thu, 12 Sep 2019 10:35:03 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] IRQ fix
Message-ID: <20190912083503.GA124477@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest irq-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

   # HEAD: eddf3e9c7c7e4d0707c68d1bb22cc6ec8aef7d4a genirq: Prevent NULL pointer dereference in resend_irqs()

Fix a race in the IRQ resend mechanism, which can result in a NULL 
dereference crash.

 Thanks,

	Ingo

------------------>
Yunfeng Ye (1):
      genirq: Prevent NULL pointer dereference in resend_irqs()


 kernel/irq/resend.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 95414ad3506a..98c04ca5fa43 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -36,6 +36,8 @@ static void resend_irqs(unsigned long arg)
 		irq = find_first_bit(irqs_resend, nr_irqs);
 		clear_bit(irq, irqs_resend);
 		desc = irq_to_desc(irq);
+		if (!desc)
+			continue;
 		local_irq_disable();
 		desc->handle_irq(desc);
 		local_irq_enable();

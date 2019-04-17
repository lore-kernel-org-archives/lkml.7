Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C04C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA6E2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXx4lmYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbfDQMVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:21:39 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:35815 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729522AbfDQMVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:21:38 -0400
Received: by mail-wr1-f54.google.com with SMTP id o12so2241208wrn.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 05:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:references;
        bh=irC0YKrZlFHQzTSprKMgg8BG6Zvb8X0gh/lcKUUr0Qc=;
        b=AXx4lmYYipWzKUE08Q3dwUnLRP6mrDqS10j8mMw/alipHvi2b0Sp5aPJGHLBCBud+X
         rOVOjqGBziUPbqIryBN+NfgXUkfQFec/2jbnz8qgxF7Xs4300Lolu4/eycoW1zUYGvhz
         vHkPUhMA6oG4lv0UrE0lLm+65LYC170m9evq6CY6N3eDL7YYDKv7LYuQ2I7gDuUo0LhD
         yayU7Kzyh3okQSLqyOhatxO18qkCPx/BhlEdUElDzxpCT1Uz5mpz9qjeI2UoKSAGPTHq
         y7Bw8Z8c+VgQfMGa4mXzuoaljnCfhgSs/JujCGcNx2s1gYdtD+DrrrNEa+HX/sKMcjmr
         akXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:references;
        bh=irC0YKrZlFHQzTSprKMgg8BG6Zvb8X0gh/lcKUUr0Qc=;
        b=MPmQgh4SBfqf9V+CAtghgMP2vYNsoC8DuCXUkjLjKDd9SoSs6jsErCtFTZs5g/XVab
         70wdJZJhvWsJW7dRc9S5wbwyEz36d1DH0K5bnNMWNmt2BVvi6mjxl+0j1doOhnMXN73p
         BfRg8gaX27VmXOm53Ue3HyNL/gkiZ9JY8EOMhAI+Vx3TPnG9oa+c3YO5vfiVynSSHxXb
         8N5dBx2x8Y4ECOO/cBkyfGeMjmJIkVA/J0QNsCRefL+GeA/RN3lbf9cbihuMaO3nF8Ny
         dbGM8vndKw5jO4N0qIebWtuQD2dBurzovXAc+wrOtvI/lsGQSCTDFXLcENO0MbjGHM+a
         oZdg==
X-Gm-Message-State: APjAAAULhtT69iF07Qftp4J2bsd+706waRAMSaMHVXHdRvnMyR7EkI7b
        Iv9W95lBAAu7lnJmzdjqOcf/BS8M2gI=
X-Google-Smtp-Source: APXvYqzh+7TsF8mllrtGWyuyQ2qeI8RSDVgTajZ0vMcD71qBgu1s5ksqba0Tv7RsKkfds2VNJeyMIg==
X-Received: by 2002:adf:edca:: with SMTP id v10mr28277701wro.157.1555503696794;
        Wed, 17 Apr 2019 05:21:36 -0700 (PDT)
Received: from ghost.lan ([94.11.212.240])
        by smtp.gmail.com with ESMTPSA id g84sm3810696wmf.25.2019.04.17.05.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 05:21:35 -0700 (PDT)
From:   Okash Khawaja <okash.khawaja@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Gregory Nowak <greg@gregn.net>, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Ben Hutchings <ben@decadent.org.uk>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        John Covici <covici@ccs.covici.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        devel@driverdev.osuosl.org, speakup@linux-speakup.org
Subject: [PATCH v2 0/2] staging: speakup: factor out selection code
Date:   Wed, 17 Apr 2019 13:21:12 +0100
Message-Id: <1555503674-8219-1-git-send-email-okash.khawaja@gmail.com>
X-Mailer: git-send-email 1.8.3.1
References: <20190404194530.1170-1-okash.khawaja@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The v2 renames set_selection() and do_set_selection() to following 
more explicit names:

set_selection_user() /* includes copying data from user space */
set_selection_kernel() /* no copying from user space */

The patches also update references to set_selection() to be 
set_selection_user().

Original intro:

Speakup's selection functionality parallels that of  
drivers/tty/vt/selection.c. This patch set replaces speakup's
implementation with calls to vt's selection code. This is one of the
remaining items in our TODO file and it's needed for moving speakup out
of staging.

Please note that in speakup selection is set inside interrupt context of
keyboard handler. Set selection code in vt happens in process context
and hence expects ability to sleep. To address this, there were two
options: farm out speakup's set selection into a work_struct thread, or
create atomic version of vt's set_selection. These patches implement
the former option.

Here's a summary:

Patch 1 re-arranges code in vt and exports some functions.
Patch 2 replaces speakup's selection code with calls to vt's functions
exported in patch 1.

Thanks,
Okash 


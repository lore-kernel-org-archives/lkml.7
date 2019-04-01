Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FAAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEEB420850
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfDAKZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:25:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35141 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfDAKY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:24:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so10721354wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 03:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L75OSJxc8ptBxGUiwFEHQQdgwhTlCON2WMpoejyEGDs=;
        b=LUKo6j8oL2MrxIynZ2nKb8eqohVdVNH2dCUQKXi8gfS9HGzpLEkaoFZbci3lxTCbwy
         g0XYCTpHJrkqcDyHg68rKkBAJBA+LhfiOrvh0TPJ4K+G94stE3m8E6ET3VA5DOrGJf72
         QChsSHtmp8uQRSENvulQ8/ZcptAUJgS39nMqPEFwSxI09VGJtawUAAX0MzlJPhxuXySD
         52cMu/rt2oaDdGKAY/vJWG7dEjwSWMvMRn6+6gsCTVvBm/7cB/tfW03mUx6+LnzevEpx
         c2nt5eIhS+H/X0xzpwVKL35fYiS/86zcr2FWbwOCGZWJRB/fisMFew8n977jAav82Vr5
         6zwQ==
X-Gm-Message-State: APjAAAWpvMfdAdrfD+3GiMpcpBX7zZpOin7dkWJQAvI9Dtmz4fKwU6av
        wq1BvyJqGjCQiRuOp/dVfH18Ww==
X-Google-Smtp-Source: APXvYqwirzMQIA9uQn7PQmigt7FHRG+LWAzOqq3oRCjLYjtj2Nr1jSx4PhBGXMeXOcohxMSLsPq7TA==
X-Received: by 2002:a1c:4d02:: with SMTP id o2mr11964610wmh.134.1554114298084;
        Mon, 01 Apr 2019 03:24:58 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-70-69-135.cust.vodafonedsl.it. [93.70.69.135])
        by smtp.gmail.com with ESMTPSA id h18sm14233602wrt.97.2019.04.01.03.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:24:57 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-sound@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/4] Introduce the aural error reporting framework
Date:   Mon,  1 Apr 2019 12:24:51 +0200
Message-Id: <20190401102456.11162-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux kernel has had verbal error reporting since the beginning.
Different error conditions trigger different error messages, with
different severity: from a simple warning to the most feared kernel panic.

While this detailed error reporting is much helpful to developers or end
users, there are some cases in which it's impossible to notice that an
error happened.
The most common case is headless devices, such as home servers without an
attached display, or routers without an exposed serial port. Needless
to say, logging into the machine via SSH is not an option after such
a severe error.
In other cases the monitor might be attached, but the system is unable to
display the error, probably because there is an X server running and
the KMS switch fails. Or simply the user is visually impaired.

These are all cases when the aural errors framework comes to help. This
framework adds to the kernel a generic library to play sounds, which can
be used to report errors or generic events.

As the sound card driver could, and most probably will, become unusable
during a kernel crash, the sounds are played via the system buzzer which
has been around since the dawn of time.
The buzzer driver is simple, requires just a few register writes to work,
the hardware is extremely cheap and is already present on most machines.

The first patch introduces the framework functions, the other three make
use of it in, respectively, kernel panic, warning and oops.
The last patch, not to be merged, creates a procfs handler useful to test
the error reporting.

Matteo Croce (4):
  aural error reporting framework
  panic: use the aural error reporting framework to report panics
  bug: use the aural error reporting framework to report warnings
  oops: use the aural error reporting framework to report oopses

 arch/x86/lib/Makefile |  1 +
 arch/x86/lib/play.c   | 75 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/play.h  | 34 ++++++++++++++++++++
 kernel/panic.c        | 61 +++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug     | 35 ++++++++++++++++++++
 5 files changed, 206 insertions(+)
 create mode 100644 arch/x86/lib/play.c
 create mode 100644 include/linux/play.h

-- 
2.20.1


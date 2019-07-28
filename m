Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC23C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995652075C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFYnKq2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfG1N63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 09:58:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37607 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfG1N63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 09:58:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id i70so16167782pgd.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=DhB7pgMefZ2zqjVgLMgP3xs2mx8GtiK0WJNu5macO/4=;
        b=PFYnKq2O8NH3HhFByJmSYxFZZxqPtnbFvXX/VzP/suRpy2FMtBHiLOY31Hmt6XzBoY
         w4O5aRXUm6YcC/NSNeWpvAFCrl3LqpPptMzK3gbH9CkmC46+DkpRnB3lDHMP64ewOuVe
         qStgSbrWU8RTblfBJTftCxkIpRhq43fJ4iN+m0ypBzbkSRr/eiAXooR2s0dXyk5QWRpl
         xoMSbRUSbroVfGUUXQJBnOC7HIYsTddLw7WBxvX/Ki2s2s4oALG9SUjQA4TjYpcm8dr9
         2EocOp9+tpbAq8rcL07Iq9YMJD622KUSARIlX86YCvLUw2qCtzil9BD2LYrvZ+ikZEyH
         CThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding
         :user-agent;
        bh=DhB7pgMefZ2zqjVgLMgP3xs2mx8GtiK0WJNu5macO/4=;
        b=gLD15KtlAN1Q8T8kb1dcqTAbb3Vh8mliQoZWQOFqd067tePtQY2eOGmOlopMSap3Vg
         TnMfhfe4qlEDkpHVqdJpe7uDA84jqGGNez8cWWv4CAelCrwnQFsrlEfh25bwmlkcyUZO
         ilAmsEqlqKX9DMAA14QFwHz2I0ECD1IqXy9nHqclFLW1/9qm7uspQamguPVu1WNG8gL9
         B4Yd6f0xBRp3wDSBiYEwjVfX2/MPT8uvhw6kKjbjeWSlNR6SYNRj94OtnIYAPbiycuPW
         dNoL9j2UQxWe/ysEmSKfckwyuzVrS+FPTT8ZgCMYQfPItNYKTrW3Zy4gSDFDNU6qVlVE
         mI3w==
X-Gm-Message-State: APjAAAU5rWzyb5mKfDyDaogKzNL44ob9DHNB+7C7aeZoJ7w78Om+ksoX
        fSgeeOB7bhKSpRaz4vwvUPw=
X-Google-Smtp-Source: APXvYqyN26/zpjxJoCTw9HpbgkVZpVNHOUCBKlrt2gEsiEvv1vwZtKW0Erch6y22+ASSw4w6tQ8IWA==
X-Received: by 2002:a17:90a:2190:: with SMTP id q16mr103876006pjc.23.1564322308340;
        Sun, 28 Jul 2019 06:58:28 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p68sm70394749pfb.80.2019.07.28.06.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 06:58:27 -0700 (PDT)
Date:   Sun, 28 Jul 2019 06:58:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Makefile: Globally enable fall-through warning
Message-ID: <20190728135826.GA10262@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 07:46:17PM -0500, Gustavo A. R. Silva wrote:
> Now that all the fall-through warnings have been addressed in the
> kernel, enable the fall-through warning globally.
> 

Not really "all".

powerpc:85xx/sbc8548_defconfig:

arch/powerpc/kernel/align.c: In function ‘emulate_spe’:
arch/powerpc/kernel/align.c:178:8: error: this statement may fall through

Plus many more similar errors in the same file.

All sh builds:

arch/sh/kernel/disassemble.c: In function 'print_sh_insn':
arch/sh/kernel/disassemble.c:478:8: error: this statement may fall through

Again, this is seen in several places.

mips:cavium_octeon_defconfig:

arch/mips/cavium-octeon/octeon-usb.c: In function 'dwc3_octeon_clocks_start':
include/linux/device.h:1499:2: error: this statement may fall through

None of those are from recent changes. And this is just from my small
subset of test builds.

Guenter

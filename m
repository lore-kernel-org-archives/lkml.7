Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CEFCA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099F6218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToZRFpOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbfJVO4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 10:56:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42394 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbfJVO4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:56:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id z12so13362339lfj.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 07:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3YSqKTmEXvv06IcTKWhjuHPCxpqgXAh/q72UPZZW4tI=;
        b=ToZRFpOBn0qIY8fB8zR8Lx8J0SvcEBPHS4Ke6VL6ZNhhL/LtWoi/+mYzcFM3AZ5F/k
         JJzm4gf1qJGWc7fZXjLx51SqFCGNVr11Fld+rCJdJPiaiv9K9+H/Awar60IklzsClPsp
         H1PSx72g1cmbVfm2POFgj6DCDSFyghyfZpSDcipX899l1cxx4E0yN/3U3/fEmCg6cnKv
         KP2GQ5YIbCBSK6mm+8PA0X4ueFZ9cFYdObU+ifCicSirGxhAEPpKYLQE4nz+qkWhZm+K
         d0edEPJEaIAQIU4BGyhDrJO/riuzWEbjkalzzjIoxMhegedxSKSgPlwzOfdyjEAXmGDO
         Dd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3YSqKTmEXvv06IcTKWhjuHPCxpqgXAh/q72UPZZW4tI=;
        b=rPe/kGLmZhENgRZNp2EjbRZC3SuOvMsUCm913hPz2o2G5KTMJsnWfc5gAxbaB3U9je
         S1ku9WAqMiuLT8VSThLr4MDeMj88LJbDN39mjM0z5BgXyhoWOmK29/DVv9uz23NQA9D8
         ThUcU/HIlMFEfKR7gbNGEZj96EbDvWfrKkhSxRsAAPtLfTeW0bSBaqw5Y8BlhgMt6tVP
         SKEqnGR7CmdEt8/gZmj6Qu0sOFpcl5Iqeyw+ZQDu+IOFJkgOvFfIVim/z80Uts0qSVl9
         n7gDtQ3625JgPoVPWIuQYJYL4Pu08xMus42xW3KJR2k0eEtZjEl/WWvLX4wD0q//MPIp
         c3+A==
X-Gm-Message-State: APjAAAVDxM2838T5BX4Wq+CapBezCk4WTWRNvdKvyyfIPoApK5/RXEMG
        9e8rdWz8ZAPtENUbsbSyJRw=
X-Google-Smtp-Source: APXvYqzT+WvhUfV1dqaHP8e3bPnI7W7wtrekNZPYhPERXxqxvTDLLjx7cLMOG0+GgVTNcByTEFv+uw==
X-Received: by 2002:ac2:47ed:: with SMTP id b13mr15065139lfp.43.1571756182359;
        Tue, 22 Oct 2019 07:56:22 -0700 (PDT)
Received: from uranus.localdomain ([5.18.199.94])
        by smtp.gmail.com with ESMTPSA id k8sm9185096ljg.9.2019.10.22.07.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 07:56:21 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id EAF9B460E3F; Tue, 22 Oct 2019 17:56:19 +0300 (MSK)
Date:   Tue, 22 Oct 2019 17:56:19 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [BUG -tip] kmemleak and stacktrace cause page faul
Message-ID: <20191022145619.GE12121@uranus.lan>
References: <20191019114421.GK9698@uranus.lan>
 <20191022142325.GD12121@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022142325.GD12121@uranus.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 05:23:25PM +0300, Cyrill Gorcunov wrote:
> 
> I presume the kmemleak tries to save stack trace too early when estack_pages are not
> yet filled.

Indeed, at this stage of boot the percpu_setup_exception_stacks has not been called
yet and estack_pages full of crap

[    0.157502] stk 0x1008 k 1 begin 0x0 end 0xd000 estack_pages 0xffffffff82014880 ep 0xffffffff82014888
[    0.159395] estack_pages[0] = 0x0
[    0.160046] estack_pages[1] = 0x5100000001000
[    0.160881] estack_pages[2] = 0x0
[    0.161530] estack_pages[3] = 0x6100000003000
[    0.162343] estack_pages[4] = 0x0
[    0.162962] estack_pages[5] = 0x0
[    0.163523] estack_pages[6] = 0x0
[    0.164065] estack_pages[7] = 0x8100000007000
[    0.164978] estack_pages[8] = 0x0
[    0.165624] estack_pages[9] = 0x9100000009000
[    0.166448] estack_pages[10] = 0x0
[    0.167064] estack_pages[11] = 0xa10000000b000
[    0.168055] estack_pages[12] = 0x0
[    0.168891] BUG: unable to handle page fault for address: 0000000000001ff0


Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AF3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896DC20882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DE9rGtF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393494AbfITPlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:41:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38652 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391672AbfITPlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:41:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so2706330wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 08:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Xv40uHTBnQKi7ek6wxrI7XSP2Xg7D4dtkThas3W0BIA=;
        b=DE9rGtF/QU58K8xulSxPWbvJ2lzUeXxbsZ2GKcFJSBKusu1CmofbZxSz2wnVQ+ywTq
         kYbdol8Qp1+cNoA0Vwi2BxL5Drqf021jPLmMdFN0vYrwDlCDQWNB15w+GMAs/+5X0HFr
         dEXLUk3YFQbUi0zoEHYujgon8JhsgFivu1lYCGmmaXuhNMFSCxPkA7RpAN+6XFulLeO6
         Bf9L8hJBUfZ/83TBpb+8UwKT9q+i0yXQRm9JV3X+P88aX3S+vlvBt49cSLOzn1GYTHsm
         m9D+vjtQZo3AE2yhxjxA4gptGaN6v5ca6JLBNb+D8fdORJeX2Vm9F0ZhXHXCg10xKcxz
         Qlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Xv40uHTBnQKi7ek6wxrI7XSP2Xg7D4dtkThas3W0BIA=;
        b=YwIZ1q94Vsw06faxqt8RfeQuecn7xPTX4c3j2YKgYsJEFsF9/2G68JrcoeS/1itKNq
         K58M2xLZQgAdCU74RWEIb8zeXlkMO7Pzg9fAu+HA9LNb+0EJuqfI0/JEXQg72ao05yuU
         OS3Lg0aNwWjDw3G/179cfOJDjMYVa/rdBzzniYY57jcjR1i5LcKOfmIr4ID252U8TQxF
         /wfjyuzZBH6xsLPSjQGaQVkH/FpNmatBtjZ7wQ0SYFPcg678g81o5+/UojA5CUyXDrZz
         lUDATKIQX0XI5k9ZcqdJS6dQNwpg+7Na9BPX9xSdi8mrZoX+L7Ny9rDpkfK+4vB95dl2
         77nQ==
X-Gm-Message-State: APjAAAViQv0OwPE7lOglU2z2AYYkgtyeePrshcmr1YAQH2J/1R+Hscyv
        yUT/tjKYKgPsq1nfs3iGdZtSyUVnnf8=
X-Google-Smtp-Source: APXvYqx0L/7KeU2Qshq4qSA1RuWSp0Tp1zwhgcXLHjMp7WemaABMruhTDWLceD9B42F/X/UOftL8Mg==
X-Received: by 2002:a05:600c:294f:: with SMTP id n15mr3929123wmd.157.1568994102404;
        Fri, 20 Sep 2019 08:41:42 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f83sm3231184wmf.43.2019.09.20.08.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 08:41:41 -0700 (PDT)
Date:   Fri, 20 Sep 2019 08:41:41 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Vincent Chen <vincent.chen@sifive.com>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Avoid interrupts being erroneously enabled in
 handle_exception()
In-Reply-To: <1568623661-16779-1-git-send-email-vincent.chen@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1909200841300.10826@viisi.sifive.com>
References: <1568623661-16779-1-git-send-email-vincent.chen@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2019, Vincent Chen wrote:

> When the handle_exception function addresses an exception, the interrupts
> will be unconditionally enabled after finishing the context save. However,
> It may erroneously enable the interrupts if the interrupts are disabled
> before entering the handle_exception.
> 
> For example, one of the WARN_ON() condition is satisfied in the scheduling
> where the interrupt is disabled and rq.lock is locked. The WARN_ON will
> trigger a break exception and the handle_exception function will enable the
> interrupts before entering do_trap_break function. During the procedure, if
> a timer interrupt is pending, it will be taken when interrupts are enabled.
> In this case, it may cause a deadlock problem if the rq.lock is locked
> again in the timer ISR.
> 
> Hence, the handle_exception() can only enable interrupts when the state of
> sstatus.SPIE is 1.
> 
> This patch is tested on HiFive Unleashed board.
> 
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Thanks very much.  Queued for v5.4-rc.


- Paul

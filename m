Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	SUBJ_ALL_CAPS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CF1C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABBA21556
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTIUzGYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbfLLVA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 16:00:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34828 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730779AbfLLVA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:00:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so4292949wro.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 13:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CHC7FV6CIEHq8S+8jI61ulqchrwWHIcBae3UB47SF/w=;
        b=jTIUzGYKVcMgBpicgM0ZJXDLpERq1iE3VTnCWgL/3zjWyHVs/h1IwePHVxhlJ9W3OB
         /Bzew4TSzuk1btfHnRJP1K3G5+7VM3/d+B5XRuhO+lUHSBZUT2GPAUKGq5eWg+x/xITE
         8/6D5i1UwnLOXCMYu2WyHGvlvAX+owd1p3rczutjAMWwo3/uew2ChVuRop7Nbo8asif/
         OqieWwOKGEXCY0qRaxrOYu6Rd9ypLW48HYeInyAhowUyeyXIJ/UBqfydqGXhEanlhTpT
         mAtpzQIuX6Px7Y3Vf98a0nBAdykFY6AMHjw/nONIIBSuLr5XC11MIT3yirXrP4OsrSSR
         Q7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CHC7FV6CIEHq8S+8jI61ulqchrwWHIcBae3UB47SF/w=;
        b=tqeUj7kth9JuSXFZzP7thRMyjjLtrV7dG9Tu3T4KhQaioYHCF1XLESFR+d5k4hlNVH
         SZu7mKwnBy76/eBoOQdYuvfVy9nTpP2L28PObuE2kbxZ5jqIpnYF+4aQvcCwZKWweFlt
         0zhAUKF7VfuWCutA5quAZAjntotrGJLN7TLVC2E5SrXGJ34GnQKMVAT0OlnYqc4/gazm
         3Eku/gzyeaIV2+F9OxNDdaUA24oGkiO0WOTcSbWzerhIiJYtW3FDnByWzT8y7bbiVlDV
         m5PlkoxfUccQqbAty9PqipP1TFnXK9XUK0hYOqOuJTlcCo8B6pSXv6ApqzzXp5T+EylD
         9LRg==
X-Gm-Message-State: APjAAAVe5ECqR26keleAm4YLAf+T4TLpvfvgNxChiNPUaIcdJXkZSprO
        GUWKZeEXTYbynd8Cd0TBduCkrOU=
X-Google-Smtp-Source: APXvYqwysq+8lJjhJmKxq5ex+G2XRwfIKg/0HWSF+kY6sGGYu1j9kuYmyEfw04aRFS3tC3wO7K7iNw==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr8304942wrm.210.1576184456181;
        Thu, 12 Dec 2019 13:00:56 -0800 (PST)
Received: from avx2 ([46.53.254.212])
        by smtp.gmail.com with ESMTPSA id m7sm7484135wma.39.2019.12.12.13.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 13:00:55 -0800 (PST)
Date:   Fri, 13 Dec 2019 00:00:52 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ 
Message-ID: <20191212210052.GA8906@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We could move the kernel to C++ and write:
> 
> 	std::remove_volatile<typeof(p)>::type __p = (p);
> 
> /me runs like hell...

Did you just said I can send "struct sched_domain::private" and
"struct wait_queue_entry::private" rename?
:^)

Doable but not until C++20. constinit and designated initializers are
pretty mandatory.

Debian GNU/Linux 8 debian88 ttyS0

debian88 login: root
Password:
Last login: Thu Sep 19 01:04:29 +03 2019 on tty1
Linux debian88 5.3.0+ #1 SMP PREEMPT Thu Sep 19 01:02:26 +03 2019 x86_64
root@debian88:~# cat /proc/$(pgrep sshd)/stack
[<0>] _ZL9do_selectiP11fd_set_bitsP10timespec64+0x5ac/0x750
[<0>] _Z15core_sys_selectiP15__kernel_fd_setS0_S0_P10timespec64+0x143/0x260
[<0>] __x64_sys_select+0xa7/0xf0
[<0>] do_syscall_64+0x3b/0xe7
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB12C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F36D22CEC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="vFz2D+ds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfHSV3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 17:29:17 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43948 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbfHSV3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 17:29:16 -0400
Received: by mail-qk1-f195.google.com with SMTP id m2so2745976qkd.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=0l0Pa0ElqK1DZWn0mgQwwfUufG1B6hMxS63646CFTfA=;
        b=vFz2D+dsGimCQxKLYPtL7kb/5ZcKWdyiABI2FKvG71x0Bt4YfuWuG8RNWUymu7+m63
         icUb3o9Hvu2mjZDqcuQyJtpfPz5WuJcFWSV08m2zKHRq/736D558UHD2+TfpavBooYE3
         byafPyfYpri+HCXimSPC/s+okyeKn7GYqvUg8KLPFFH9IGtta2DBVXasDP3o7kU+B8yB
         hK/qkWZIQdl/8ts0c2lDMC2hRpXdo/dkSgNJ1SHd5k1sRjw1okoGZcVA05Lyls1/vxUr
         mJMEMOnaJPE/nidQWBE9NTNc2+pgrZJlIQ33GP1teo9fmrNqtBtrDfFPTHrzVK1dE2PH
         /AYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=0l0Pa0ElqK1DZWn0mgQwwfUufG1B6hMxS63646CFTfA=;
        b=bpSgDNOJKwigD53unpdivshkpxq+v7Ngn/CYbGj6umDVZO3+cjlOAMJwVux3qpDeZj
         namtXNZGYyMiPFkmUGhkA0WlzIyFyu4uizcMnuwXb2Ce3K6eV+n7wpcTfks4WhtuGAJ7
         XKX607TA56lg5ID/tiDCmcqnXCXeXgHogHAgev9lu5m5s78IhlDPzU7wCuflRqKiG8MY
         i4pCFhcH3zToskrkPrGHyOREOv95EJQ5H9MXPwVmglKhSuqOdLiyM8NntHJDY4J5lPjs
         i3IWeYn78K0dNCbIptRZ+KkDj/Y0I+qLx4crsWG51AUmeCgY/3EkE9Qg1NxB5JEXWyQH
         D6dw==
X-Gm-Message-State: APjAAAUnL+rvO5om9grqgk+WcO/hNZiml9EQlWnYaa+xaFOcgzU+Gwj0
        hRgGBBnTveStO2pVq+ykrklJCg==
X-Google-Smtp-Source: APXvYqzTQy/Lr6Ti+E/hIvFy1hXuDHcWSKY1hLZDpyObSYqbHZKCD29b41aVxncBy/HWCPAzxZo3yQ==
X-Received: by 2002:a05:620a:10ae:: with SMTP id h14mr7798507qkk.40.1566250155654;
        Mon, 19 Aug 2019 14:29:15 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id h26sm8387575qta.58.2019.08.19.14.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 14:29:15 -0700 (PDT)
Date:   Mon, 19 Aug 2019 14:29:08 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     syzbot <syzbot+23d9570edec63669d890@syzkaller.appspotmail.com>
Cc:     ast@kernel.org, aviadye@mellanox.com,
        bhole_prashant_q7@lab.ntt.co.jp, borisp@mellanox.com,
        daniel@iogearbox.net, davejwatson@fb.com, davem@davemloft.net,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        shuah@kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in tls_setsockopt
Message-ID: <20190819142908.72082c69@cakuba.netronome.com>
In-Reply-To: <000000000000d917f4058dd525cf@google.com>
References: <000000000000d917f4058dd525cf@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2019 16:58:06 -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    a131c2bf Merge tag 'acpi-5.3-rc1-2' of git://git.kernel.or..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1603e9c0600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8bff73c5ba9e876
> dashboard link: https://syzkaller.appspot.com/bug?extid=23d9570edec63669d890
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13560870600000

#syz fix: net/tls: partially revert fix transition through disconnect with close

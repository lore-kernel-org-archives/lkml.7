Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E806C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E078C21479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxuD70Ue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfEIKSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 06:18:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39423 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfEIKSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 06:18:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id z26so1079609pfg.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 03:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CTf90VjXEEHOLCaxdp+kSOHPoaCpeiePTqliSxM7Esc=;
        b=TxuD70Ueav4V9V1FkiuTlBH0HoblqulrviNdWDNq20n+MOyg6aETAY8hC6FbpaRzKV
         6cmiAp8kZ49gRmNXnRK5+lZ+IPkfGBouJtULN/Qvr/UxGg9iZ1Y7/oR5Rvo/JGFD0WJ1
         5IWZ6sf8OGJNWfGbv1AscP9MRpZVHJ+j85rgWO5h74cmseWfSgV8k0MAKuC/3TZn8nAL
         20eFsmgnMBZgUcfhDXezNmoRcqKoFVQ+5Oxp7rNjD+QYQUBzBwGGwn0fDB2f0aVtkRV5
         mZPz47k3YTnUwHqryA3v7oTYovnU/wCUnieVa5c1CRRwkv+dQSyR6jrBuV9ij7Oknc9f
         6S/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CTf90VjXEEHOLCaxdp+kSOHPoaCpeiePTqliSxM7Esc=;
        b=YxsU+9yvjoQnxYfJzER6KctF94idI9KCozLvDPnbaEIgtBWlACl2Te1Ena4+CGPLMX
         rt392DpmQGrsrlJTy8DeY1rcc50tB7jE7hbngiSF1Z+2bbrwQRPz97BmpUUgV2lKQnuH
         +kCPuqKWqYcrPy1WaYxq70ky1Ji8dbxQctmTvTWBysgHfEU60iba2YsmJA8fhvN3XzYc
         OgJS5RMXmqaikStRmUyMmRj+T75rKjqhT5ejLMydTIQAsG4HKridoVPhPYmz0eZKpEVp
         ogJYyoDOp1d0MScHBehuy7KjjNoeo06vek4qVBL963uirVwaNZAr2xXqtvBy/kIyPznt
         /1Tw==
X-Gm-Message-State: APjAAAU2OOPw0vuhPnLqrjCuIMBJDxzIzkE/uVtA1fKtBSb8syQTnRKo
        8+ZnWXApSqcUk5GuPQIguKc=
X-Google-Smtp-Source: APXvYqz90vv990h5LnzY4pVlQS/SgbMqxCbU6ebVhmKqBVpkXce0eDMRNMzba9wg6AoZ7sLfTQ513w==
X-Received: by 2002:aa7:90ce:: with SMTP id k14mr3642062pfk.239.1557397114828;
        Thu, 09 May 2019 03:18:34 -0700 (PDT)
Received: from localhost ([39.7.47.21])
        by smtp.gmail.com with ESMTPSA id f20sm3506265pff.176.2019.05.09.03.18.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 03:18:33 -0700 (PDT)
Date:   Thu, 9 May 2019 19:18:30 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [syzbot? printk?] no WARN_ON() messages printed before "Kernel
 panic - not syncing: panic_on_warn set ..."
Message-ID: <20190509101830.GB23572@jagdpanzerIV>
References: <CACT4Y+bosgWpJ=s9_hQ-Jg_XJoSHR9S-zC3es-2F=FTRppEncA@mail.gmail.com>
 <CACT4Y+aM0P-G-Oza-oYbyq2firAjvb-nJ0NX21p8U9TL3-FExQ@mail.gmail.com>
 <20190318125019.GA2686@tigerII.localdomain>
 <CACT4Y+ZedhD+=-YyvphZvLCcCF3FM0YAjXX54K2kMkhNmV4axw@mail.gmail.com>
 <20190318140937.GA29374@tigerII.localdomain>
 <CACT4Y+Z_+H09iOPzSzJfs=_D=dczk22gL02FjuZ6HXO+p0kRyA@mail.gmail.com>
 <20190319123500.GA18754@tigerII.localdomain>
 <CACT4Y+ZhHvsVZh1pKzK1tn-P78rOssOz=7eWkXz7z2Sh1JscdA@mail.gmail.com>
 <127c9c3b-f878-174f-7065-66dc50fcabcf@i-love.sakura.ne.jp>
 <20190509095823.GA23572@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509095823.GA23572@jagdpanzerIV>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/09/19 18:58), Sergey Senozhatsky wrote:
> On (05/08/19 19:31), Tetsuo Handa wrote:
> [..]
> > We are again getting corrupted reports where message from WARN() is missing.
> > For example, https://syzkaller.appspot.com/text?tag=CrashLog&x=1720cac8a00000 was
> > titled as "WARNING in cgroup_exit" because the
> > "WARNING: CPU: 0 PID: 7870 at kernel/cgroup/cgroup.c:6008 cgroup_exit+0x51a/0x5d0"
> > line is there but https://syzkaller.appspot.com/text?tag=CrashLog&x=1670a602a00000
> > was titled as "corrupted report (2)" because the
> > "WARNING: CPU: 0 PID: 10223 at kernel/cgroup/cgroup.c:6008 cgroup_exit+0x51a/0x5d0"
> > line is missing. Also, it is unlikely that there was no printk() for a few minutes.
> > Thus, I suspect something is again suppressing console output.
> 
> Hmm... That's interesting...

What are these lines right before the kernel panic output?
TTY writes (user space logging)?


03:54:05 executing program 5:
syz_mount_image$xfs(&(0x7f0000000000)='xfs\x00', &(0x7f0000000040)='./file0\x00', 0x0, 0x0, 0x0, 0xe003, &(0x7f00000005c0)={[{@nolargeio='nolargeio'}]})

03:54:06 executing program 2:
syz_emit_ethernet(0x66, &(0x7f0000000080)={@local, @random="029cce98941b", [], {@ipv6={0x86dd, {0x0, 0x6, 'v`Q', 0x30, 0x3a, 0xffffffffffffffff, @remote={0xfe, 0x80, [0x29c, 0x0, 0x700, 0x5], 0xffffffffffffffff}, @mcast2={0xff, 0x2, [0x0, 0xfffffffffffff000]}, {[], @icmpv6=@dest_unreach={0xffffff86, 0x0, 0x0, 0x0, [0x7], {0x0, 0x6, "c5961e", 0x0, 0x0, 0x0, @mcast1={0xff, 0x1, [0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x3, 0x3, 0x0, 0x0, 0x8906], 0x8200}, @mcast2}}}}}}}, 0x0)

[ 2396.035331][T10223] Kernel panic - not syncing: panic_on_warn set ...
[ 2396.042217][T10223] CPU: 0 PID: 10223 Comm: syz-executor.1 Not tainted 5.1.0-next-20190507 #2


Hmm... Dunno... Don't really have any explanations yet...

Can you add

	if (oops_in_progress)
		return IRQ_HANDLED;

to you console driver's IRQ handler (xmit TX/RX path)? Just to
check if this will change anything...

	-ss

Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150FAC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D734F206A3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIXUDVIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfEIJ63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 05:58:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36900 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfEIJ62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 05:58:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id g3so1056987pfi.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 02:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GZ+wQKKiixHuEYLTGFpeth1VcqwUvyMR2q/R/eQ33+M=;
        b=aIXUDVIwNr7Sko8wPS0CDmiCvkw+csxtWMweInhT50pcvIl6vJ7OzrDDH6TUzwJQ4W
         Q35UjbDHTDVNcQGmO8yg0w8D+a+u6KUv6Y4AahBS5Af8EMEhOSUezvl/SO8reux+zkiq
         zLAq3yoXadskAqJy98LJ1BObPt2X5kLwCSzHNCqMwgcSmCY3TnMAkKbbvIfQKvzn/2uT
         ul4Vfc1cKKxAcTVE6gHFDQgWRujSXGqR781r/25gG5zFtTJxVQoigns1i7KDG5/zYIc6
         tLhaOm52dSadQlZrlA3CJLpCkMWwn2ujHj6t87MM80rtXc7fQRDjEOkewrP6LK+9A2Gd
         wHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GZ+wQKKiixHuEYLTGFpeth1VcqwUvyMR2q/R/eQ33+M=;
        b=JQOXOk6+x2uFhNBkW1venGU9CAX+Wx5ktb3vjycbW5m2822CPjF+39JHJfHgaq+odp
         ZHgiZpOh8889xE0/PgBCYadr7UFmNnB9ZdQyh8oV7A66S7AHgKZABRV9diFLCALX9G3b
         X4ibYLCGkl6wMV11f9vFrihBfLIeGCINhkGflGnArs+b0UXPkuaYaoZo6lB2paciz3OE
         B3txhncQRfFIFzFJDMapjwDcSrylOWrjSUfaezhd1Ddb897RbQeQ49CWhvqM2qcLaDyj
         bYCHkmVcSHJgJpbspf4bnv6R9Vxk1LLiscZyD/p+LClBfWJq980By5qCAhhXJngu2Lxn
         jpMw==
X-Gm-Message-State: APjAAAVPOxzMv0sFVEjC+R79TM0Vktgi/kwr9aRurmeTob4vyqsC6mfj
        0E6JtLqya4fuQ9k/Ikd6o8I=
X-Google-Smtp-Source: APXvYqwx0+HkYfUu1r8DpFuzYPzbiaGcIDvSF8LKLMhDgNS/GhYNX8N+thMp9aHIH9O5oREZZ1WyqQ==
X-Received: by 2002:a62:7995:: with SMTP id u143mr3612819pfc.61.1557395907656;
        Thu, 09 May 2019 02:58:27 -0700 (PDT)
Received: from localhost ([39.7.47.21])
        by smtp.gmail.com with ESMTPSA id n15sm4700420pfb.111.2019.05.09.02.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 02:58:26 -0700 (PDT)
Date:   Thu, 9 May 2019 18:58:23 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [syzbot? printk?] no WARN_ON() messages printed before "Kernel
 panic - not syncing: panic_on_warn set ..."
Message-ID: <20190509095823.GA23572@jagdpanzerIV>
References: <201903180527.x2I5RQVp009981@www262.sakura.ne.jp>
 <CACT4Y+bosgWpJ=s9_hQ-Jg_XJoSHR9S-zC3es-2F=FTRppEncA@mail.gmail.com>
 <CACT4Y+aM0P-G-Oza-oYbyq2firAjvb-nJ0NX21p8U9TL3-FExQ@mail.gmail.com>
 <20190318125019.GA2686@tigerII.localdomain>
 <CACT4Y+ZedhD+=-YyvphZvLCcCF3FM0YAjXX54K2kMkhNmV4axw@mail.gmail.com>
 <20190318140937.GA29374@tigerII.localdomain>
 <CACT4Y+Z_+H09iOPzSzJfs=_D=dczk22gL02FjuZ6HXO+p0kRyA@mail.gmail.com>
 <20190319123500.GA18754@tigerII.localdomain>
 <CACT4Y+ZhHvsVZh1pKzK1tn-P78rOssOz=7eWkXz7z2Sh1JscdA@mail.gmail.com>
 <127c9c3b-f878-174f-7065-66dc50fcabcf@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <127c9c3b-f878-174f-7065-66dc50fcabcf@i-love.sakura.ne.jp>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/08/19 19:31), Tetsuo Handa wrote:
[..]
> We are again getting corrupted reports where message from WARN() is missing.
> For example, https://syzkaller.appspot.com/text?tag=CrashLog&x=1720cac8a00000 was
> titled as "WARNING in cgroup_exit" because the
> "WARNING: CPU: 0 PID: 7870 at kernel/cgroup/cgroup.c:6008 cgroup_exit+0x51a/0x5d0"
> line is there but https://syzkaller.appspot.com/text?tag=CrashLog&x=1670a602a00000
> was titled as "corrupted report (2)" because the
> "WARNING: CPU: 0 PID: 10223 at kernel/cgroup/cgroup.c:6008 cgroup_exit+0x51a/0x5d0"
> line is missing. Also, it is unlikely that there was no printk() for a few minutes.
> Thus, I suspect something is again suppressing console output.

Hmm... That's interesting...

[..]
> +#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
> +static int initial_loglevel;
> +static void check_loglevel(struct timer_list *timer)
> +{
> +	if (console_loglevel < initial_loglevel)
> +		panic("Console loglevel changed (%d->%d)!", initial_loglevel,
> +		      console_loglevel);
> +	mod_timer(timer, jiffies + HZ);
> +}
> +static int __init loglevelcheck_init(void)
> +{
> +	static DEFINE_TIMER(timer, check_loglevel);
> +
> +	initial_loglevel = console_loglevel;
> +	mod_timer(&timer, jiffies + HZ);
> +	return 0;
> +}
> +late_initcall(loglevelcheck_init);
> +#endif

I suppose this patch is for internal testing at Google only. I don't
think we can consider upstreaming it.

> By the way, recently we are hitting false positives caused by "WARNING:"
> string from not WARN() messages but plain printk() messages (e.g.
> 
>   https://syzkaller.appspot.com/bug?id=31bdef63e48688854fde93e6edf390922b70f8a4
>   https://syzkaller.appspot.com/bug?id=faae4720a75cadb8cd0dbda5c4d3542228d37340
> 
> ) and we need to avoid emitting "WARNING:" string from plain printk() messages
> during fuzzing testing. I guess we want to add something like
> CONFIG_DEBUG_AID_FOR_SYZBOT to all kernels in order to mask such string...

I thought that we have MSG_FORMAT_SYSLOG exactly for things like these,
so you can look at actual message level <%d> and then decide if it's a
warning or a false alarm.

These are pr_info() level messages, but the text contains "WARNING: "

[..]
pvr2_trace(PVR2_TRACE_ERROR_LEGS,
	   "WARNING: Detected a wedged cx25840 chip; the device will not work.");
[..]

I would suggest to fix pvrusb2-i2c-core.c. I don't think we really
want to $text =~ s/WARNING//g in printk.

	-ss

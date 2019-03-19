Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0F5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF47020857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkEq/QVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfCSMfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:35:09 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:37576 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfCSMfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:35:08 -0400
Received: by mail-pf1-f181.google.com with SMTP id 8so10185553pfr.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 05:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pXGSMCvAzf0HNFwl1hqaFl2ShpygrFyoDN27PoiJjBM=;
        b=NkEq/QVUKfyuZF2yUTyx3afhfmTtMovZt7E7I40TiQ1dqDmvBC5FDan6/ooh5fw3/L
         cHGwrYtYFqKr0P8yMjpRiibiHIwfPFb+8BtSQTQ7VIeesgmm1Zg1AFOaC4hvSVev4ilT
         3gc8N52qYr5kNYjy83iPKRvaTDm62AdYQvXcorcp154m/v/HNgkEF5wKU1TrdzRueylX
         UmnPXKUJDK045AVd3kh0Q2VOQ4gnZQtzEbk8U+a1vVaHUrYooNqtZO1UNkwygwLdwAeR
         ckRzmXUH7ytBRB/IqtK+rjGH4qLDeEry+24I87xLxoY6kfuFakEFBNZBtOmdqFmnbRTD
         2D2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pXGSMCvAzf0HNFwl1hqaFl2ShpygrFyoDN27PoiJjBM=;
        b=gcsSKY9hlG27hx8alLuRGXLY4xfZaz6eKhu8ZI4IAU3BcEs15hy0/Qg2RKG+m/ibl0
         rKM3pp+v6GyqScXrukYL14Ezf4/XKl7RfSosZv8U7P/IEGAwlIQzznlI72Y0hrqTf6lb
         4iqCZ8cL28XaVa2F3nG/PBbkkut4BktqyvOvRQgocKIcUvPGI0VcAbvTeSq09fzR8Zmw
         vNXpsVcvZ4Zsi59OJTPSbxdKJorwBqG84+CsvGr4M6Sg+jvBJEaY+kIR4DT5niV4AlvJ
         yQyd7Jv1NiP6ktKuQc17hXMMyt9gzNVmhWtwbJOAyM8VuP0qFMhQbplTDeFa9QxMbRwe
         BZdw==
X-Gm-Message-State: APjAAAVYau/ApdTUEh4+Tm7kUNZonOYEwk4wgq+gr2CJOs19gZxmBbRD
        MCv+ZTqjOtDwLLC+kcPpsnE=
X-Google-Smtp-Source: APXvYqwvHnnKPfoAS9B90y2qNHbj+ZrP7RJZ8PJMuppQHy48S5+pOCRl4IW1KK1msFb97HKdsfD8vA==
X-Received: by 2002:a17:902:8bc7:: with SMTP id r7mr1940127plo.163.1552998906657;
        Tue, 19 Mar 2019 05:35:06 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id g2sm31808778pfm.144.2019.03.19.05.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 05:35:05 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 19 Mar 2019 21:35:00 +0900
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [syzbot? printk?] no WARN_ON() messages printed before "Kernel
 panic - not syncing: panic_on_warn set ..."
Message-ID: <20190319123500.GA18754@tigerII.localdomain>
References: <2a48dee7-b649-65a4-be5d-8b3374013cee@i-love.sakura.ne.jp>
 <CACT4Y+ay7nuT-7y2JARozV1s0VisuLdN6VT+w9OsEDs1PeBRoA@mail.gmail.com>
 <201903180527.x2I5RQVp009981@www262.sakura.ne.jp>
 <CACT4Y+bosgWpJ=s9_hQ-Jg_XJoSHR9S-zC3es-2F=FTRppEncA@mail.gmail.com>
 <CACT4Y+aM0P-G-Oza-oYbyq2firAjvb-nJ0NX21p8U9TL3-FExQ@mail.gmail.com>
 <20190318125019.GA2686@tigerII.localdomain>
 <CACT4Y+ZedhD+=-YyvphZvLCcCF3FM0YAjXX54K2kMkhNmV4axw@mail.gmail.com>
 <20190318140937.GA29374@tigerII.localdomain>
 <CACT4Y+Z_+H09iOPzSzJfs=_D=dczk22gL02FjuZ6HXO+p0kRyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Z_+H09iOPzSzJfs=_D=dczk22gL02FjuZ6HXO+p0kRyA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/19/19 09:10), Dmitry Vyukov wrote:

[..]

> In some setups we read out output with "dmesg -w" (should stream
> output as well) in absence of a better solution. Will this be affected
> by SYSLOG_ACTION_CLEAR?

There is a small chance that syslog/devkmsg can be affected

	syslog_clear()
	{
		clear_seq = log_next_seq;
		clear_idx = log_next_idx;
	}

	syslog_print_all()
	{
		...
		seq = clear_seq;
		idx = clear_idx;
		while (seq < log_next_seq) {
		...
			len += msg_print_text(msg, true, time, NULL, 0);
		}
		...
	}

devkmsg also may be affected

	syslog_clear()
	{
		clear_seq = log_next_seq;
		clear_idx = log_next_idx;
	}

	devkmsg_llseek()
	{
	...
		case SEEK_DATA:
			user->idx = clear_idx;
			user->seq = clear_seq;
			break;
	...
	}

user->idx/user->seq then are used in devkmsg poll()/read(). syslog is
more likely to be affected, I think.

	-ss

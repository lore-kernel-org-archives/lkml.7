Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833DEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F25B20657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQIGLQJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfCROJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:09:43 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:46288 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfCROJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:09:43 -0400
Received: by mail-pg1-f181.google.com with SMTP id a22so11440414pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 07:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c8zPsZZ+mTSL93ve/TItgqzFG9vh1I/IX1AK2W5EfHg=;
        b=rQIGLQJ0Gmehn4RJBwK+XYYhH8NVpNohTlrXRYos2cc+4AuVLv/tEIIZ9iGsP3L/mI
         O2N5V7c2zie9jQJTi0tQqMBQnF+ejmoku5GONV3ln73D+jTkkg/ohk367LABEePv3PAY
         hQ5ck40KeJHJhL85FhaKlezkX9nfl0jm9dy7thOPNbwaiIReFy/dYUUVCOK/+jzh5Zu4
         CzR1EORIXerx/v5KhMU33PwSH9FvxmZHP92Efa0jZggyO/VdtQeedpapTzPkrTFdgbFd
         iP3KLZJL+nfrze1AySq6dZ910aK9tw34SUu3rVTWMnBkXsPPuhyj6F8R3kMQPnBvCxGC
         ItLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c8zPsZZ+mTSL93ve/TItgqzFG9vh1I/IX1AK2W5EfHg=;
        b=ln1CVoOorPdTkGHWYTo0tiSauU6c6BpEQ7GAQaJY+Sk5TjSQxor9WbusvVlWsa/woY
         10Xg5Hd+W8XutjZFuG38+0UVPDsrImIhAzwB+6XmZgjDvcW9xBn6JoWKJi1dc7JEK+z3
         By/+RRIrKS2/mgNQM8oNCPha4H1iCEAECGIsDIXwEMM84hqkrXNoyOdN/gbZy/6dm3nB
         t4UUnqQ3s/uxTfpTi8MPOKxiCctwXP2jcHsQ8/xGZZsEueLIaMVYYou6llHmbu/cuw7p
         FVoXeGMpsLdnQybLiFlI7/CiM8LIimIW74TrcT7aEEtmV+Khb4APZg3sc1feaq0FXcCg
         vA1A==
X-Gm-Message-State: APjAAAXESYhdr8acRWJUZZjss8OV1xSbkwJGeagdyHUOgpBJmgcG0lsE
        MJksH/vBKGiGwy4J3/CM6lI=
X-Google-Smtp-Source: APXvYqx46bk7MvKOjs/36RKYYJoi55ABwJPp+CQ9OKHn/ND+gjH+8Siu72TJ1s+b36dt1pxg57IebQ==
X-Received: by 2002:a62:69c3:: with SMTP id e186mr18885415pfc.169.1552918181343;
        Mon, 18 Mar 2019 07:09:41 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id p7sm14472557pgs.42.2019.03.18.07.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 07:09:40 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Mon, 18 Mar 2019 23:09:37 +0900
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [syzbot? printk?] no WARN_ON() messages printed before "Kernel
 panic - not syncing: panic_on_warn set ..."
Message-ID: <20190318140937.GA29374@tigerII.localdomain>
References: <2a48dee7-b649-65a4-be5d-8b3374013cee@i-love.sakura.ne.jp>
 <CACT4Y+ay7nuT-7y2JARozV1s0VisuLdN6VT+w9OsEDs1PeBRoA@mail.gmail.com>
 <201903180527.x2I5RQVp009981@www262.sakura.ne.jp>
 <CACT4Y+bosgWpJ=s9_hQ-Jg_XJoSHR9S-zC3es-2F=FTRppEncA@mail.gmail.com>
 <CACT4Y+aM0P-G-Oza-oYbyq2firAjvb-nJ0NX21p8U9TL3-FExQ@mail.gmail.com>
 <20190318125019.GA2686@tigerII.localdomain>
 <CACT4Y+ZedhD+=-YyvphZvLCcCF3FM0YAjXX54K2kMkhNmV4axw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZedhD+=-YyvphZvLCcCF3FM0YAjXX54K2kMkhNmV4axw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/18/19 14:42), Dmitry Vyukov wrote:
> > There is also SYSLOG_ACTION_CONSOLE_OFF, which disables logging.
> 
> That one I somehow figured earlier, here is the exact check:
> https://github.com/google/syzkaller/blob/61f9c92f3a465025d2b9d91f429aaec968aeaa2a/sys/linux/init.go#L152-L155

OK, cool.
You probably would also want to add SYSLOG_ACTION_CLEAR to the list.

	-ss

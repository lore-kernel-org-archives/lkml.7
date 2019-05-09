Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A378C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE5320644
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7BtAowi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfEIKg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 06:36:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43480 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfEIKg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 06:36:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id n8so941460plp.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 03:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bHZmeHYkLEL+rg5709BsrdM/vHK9Q/g3rJek3ZFgWD0=;
        b=q7BtAowibgLk5SBQD+sjAALwhMqRAvExXByjUTtprxBc4hByjteLgSgtKSBYuFyfjN
         gAqJEeMXIUqpZwwwV+ZACaplr/xdE44xziW714X7OKam3EC3ykl3cN05OcO59vR9K73L
         U1WIeg1bjIa2x1//M1IN0iGvWSNS+5XzlMU1Ul+Z875GnYAiP9Ej/pN9JYNeDJqSdb8H
         wzt4yS/lHCFgn2AjkQC5r3koZGPosGWn8LqVaXORVfziPEpuwTtjAEzwcIV5bxtXb6AM
         sE6YLsjyMB4k+HuaQL/hKtXWC0gPGkcpdwE4nTAbihWssi5mkNdh94YF/huCr8W4vld6
         IIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bHZmeHYkLEL+rg5709BsrdM/vHK9Q/g3rJek3ZFgWD0=;
        b=Tvb+FWkfAXLt4ovhNaUSqpbEXeblbFeyFfFSYtpT/3G3bPuTw384sGaAFbRVX8bLbg
         BYWbMU6iGFUiZi1JxrE16KRNCHA0kVULqzGvtrDf9S3ybgYicdvaUXYN/J6O50cZA97H
         4rhpjJL3QnqMgqTKFe6jVPHDhAaEJM/H4i0NOCBEAEBEQ2dvoWPRRO2UH1c8MOhpoGHv
         ZC8bzxY91yqu6n3ieFBg+/qAnI9e55SnbsWOKc+oyycuQ4MArvotAHGv1hK1R8uRYFwQ
         OAeO8BJyfmtX42vyOw7SCbVlcpi/V75YdTSsDRmkTntJ5Gxh4A0Pap5EZ6ijSVyHb8f7
         x6Gw==
X-Gm-Message-State: APjAAAU6i/KpqisSBw1DzN9HAzA9xTa1AIH/yK/j+W/1D2beOmFzZgKE
        BA8GvyGUVCSTtEWmje3zLYc=
X-Google-Smtp-Source: APXvYqzgoQjjox51KD2bI0JzcBAKJmhMOmojw6RxQz0qp4nGKq9DFDAJq4wvcGExnmd//CayYmeoAQ==
X-Received: by 2002:a17:902:694c:: with SMTP id k12mr3815704plt.149.1557398186919;
        Thu, 09 May 2019 03:36:26 -0700 (PDT)
Received: from localhost ([39.7.47.21])
        by smtp.gmail.com with ESMTPSA id h189sm2727625pfc.125.2019.05.09.03.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 03:36:26 -0700 (PDT)
Date:   Thu, 9 May 2019 19:36:23 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [syzbot? printk?] no WARN_ON() messages printed before "Kernel
 panic - not syncing: panic_on_warn set ..."
Message-ID: <20190509103623.GA3369@jagdpanzerIV>
References: <CACT4Y+aM0P-G-Oza-oYbyq2firAjvb-nJ0NX21p8U9TL3-FExQ@mail.gmail.com>
 <20190318125019.GA2686@tigerII.localdomain>
 <CACT4Y+ZedhD+=-YyvphZvLCcCF3FM0YAjXX54K2kMkhNmV4axw@mail.gmail.com>
 <20190318140937.GA29374@tigerII.localdomain>
 <CACT4Y+Z_+H09iOPzSzJfs=_D=dczk22gL02FjuZ6HXO+p0kRyA@mail.gmail.com>
 <20190319123500.GA18754@tigerII.localdomain>
 <CACT4Y+ZhHvsVZh1pKzK1tn-P78rOssOz=7eWkXz7z2Sh1JscdA@mail.gmail.com>
 <127c9c3b-f878-174f-7065-66dc50fcabcf@i-love.sakura.ne.jp>
 <20190509095823.GA23572@jagdpanzerIV>
 <c7d1a923-a1cd-ca1e-e842-dd32b219c12f@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7d1a923-a1cd-ca1e-e842-dd32b219c12f@i-love.sakura.ne.jp>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/09/19 19:26), Tetsuo Handa wrote:
> >> By the way, recently we are hitting false positives caused by "WARNING:"
> >> string from not WARN() messages but plain printk() messages (e.g.
> >>
> >>   https://syzkaller.appspot.com/bug?id=31bdef63e48688854fde93e6edf390922b70f8a4
> >>   https://syzkaller.appspot.com/bug?id=faae4720a75cadb8cd0dbda5c4d3542228d37340
> >>
> >> ) and we need to avoid emitting "WARNING:" string from plain printk() messages
> >> during fuzzing testing. I guess we want to add something like
> >> CONFIG_DEBUG_AID_FOR_SYZBOT to all kernels in order to mask such string...
> > 
> > I thought that we have MSG_FORMAT_SYSLOG exactly for things like these,
> > so you can look at actual message level <%d> and then decide if it's a
> > warning or a false alarm.
> 
> Since syzbot needs to use console output, message level is not available.

Sorry, not following. MSG_FORMAT_SYSLOG should add message level
to console output. Booting the kernel with console_msg_format=syslog
will change msg_print_text() behaviour, and you'll get on your serial
console messages in

	<print_syslog>[print_time][print_caller] message text\n

format.

Does this work for you?

	-ss

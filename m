Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBE1C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 02:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC560208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 02:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="iRl0DBZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfEMCbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 22:31:55 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43237 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbfEMCby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 22:31:54 -0400
Received: by mail-pl1-f193.google.com with SMTP id n8so5643050plp.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 19:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GkmKn8xqtM5ZFNASHy3dhSS1TrKNKE1jNN1/7Rw3UKs=;
        b=iRl0DBZnB84iNuFBTLWCeRyIpe0lPSsH15HCK6R6QA+PwO8exC1hHVjRgytri52y0q
         AOdcHrBnb8unRWbDBfXAac3xtO2Pq/ni2zHg2H9doeRN/YbHX4x5lt0Z3vp3M99NadxD
         E9/XMC0G2cO9/StbBL2Yw3EU2hvkVISGiw84w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GkmKn8xqtM5ZFNASHy3dhSS1TrKNKE1jNN1/7Rw3UKs=;
        b=HMBGS8EHiJSojkx1mwhexseke8TbQyEB1ySoXjq+l1ABUcZr+myml6GTLbLDuwNWG+
         V01O1Zg3GcxWvEY8SBxz9rKnEuGlM2NJbjxaKhTeSSq7UQVxw0NJGd9w6pmvu9mdHCE7
         JouA0/8A1BB09z2iJhnvCsmsitoFwy2l/MQO6AiEQRKGJ+lSdALedwkoujw9kxxdOr4o
         1YXycelBNYKqFZvNwDgQc0zRdxKbfSjCYdBh8iQ7K89HHZyOVV4JVeTGcUV70Vt5WKFb
         rfYVbMtEYs8T2sUTneNKCgy/hXhYJiuJs12pG0FOIwC2pHlwPCUfnozFGMK8o3Z/kqBr
         aZkg==
X-Gm-Message-State: APjAAAWgwK36mzKKIBzrnvWsb0Vmtkm0fb/4BciML9My8bi8HcNS6hpC
        PmabX3dcHNhf003xczCwlqU1Rw==
X-Google-Smtp-Source: APXvYqxM3LbMIU9Q5iaT+nkjQfWHuEDGndPZntXzyCbgcmkhL7NypAv9mABJvVEnP0bGD1ZenD85DQ==
X-Received: by 2002:a17:902:7406:: with SMTP id g6mr27017388pll.328.1557714713660;
        Sun, 12 May 2019 19:31:53 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y14sm13984506pga.54.2019.05.12.19.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 May 2019 19:31:52 -0700 (PDT)
Date:   Sun, 12 May 2019 22:31:50 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        corbet@lwn.net, tglx@linutronix.de, mingo@kernel.org,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        srinivas.eeda@oracle.com
Subject: Re: [PATCH 2/2] doc: kernel-parameters.txt: fix documentation of
 nmi_watchdog parameter
Message-ID: <20190513023150.GA192545@google.com>
References: <1555211464-28652-1-git-send-email-zhenzhong.duan@oracle.com>
 <1555211464-28652-2-git-send-email-zhenzhong.duan@oracle.com>
 <20190510144749.592f4249@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510144749.592f4249@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 02:47:49PM -0400, Steven Rostedt wrote:
> 
> As nobody else commented, I will ;)
> 
> Hi Zhenzhong!
> 
> On Sun, 14 Apr 2019 11:11:04 +0800
> Zhenzhong Duan <zhenzhong.duan@oracle.com> wrote:
> 
> > As stated in "Documentation/lockup-watchdogs.txt:line 22", the default
> > behaivor after 'hardlockup' is to stay locked up rather than panic.
> 
> That actually says:
> 
>  A 'hardlockup' is defined as a bug that causes the CPU to loop in
>  kernel mode for more than 10 seconds (see "Implementation" below for 
>  details), without letting other interrupts have a chance to run.
>  Similarly to the softlockup case, the current stack trace is displayed
>  upon detection and the system will stay locked up unless the default
>  behavior is changed, which can be done through a sysctl,
>  'hardlockup_panic', a compile time knob, "BOOTPARAM_HARDLOCKUP_PANIC",
>  and a kernel parameter, "nmi_watchdog"
> 
> If your config has:
> 
>  CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
> 
> The kernel will panic on hard lockup by default unless you add nopanic.
> 
> If your config has:
> 
>  # CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
> 
> Then the default will be not to panic unless you add "panic" to the
> kernel command line.
> 
> > 
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 2b8ee90..fcc9579 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2769,7 +2769,7 @@
> >  			0 - turn hardlockup detector in nmi_watchdog off
> >  			1 - turn hardlockup detector in nmi_watchdog on
> >  			When panic is specified, panic when an NMI watchdog
> > -			timeout occurs (or 'nopanic' to override the opposite
> > +			timeout occurs (or 'nopanic' which is the opposite
> >  			default). To disable both hard and soft lockup detectors,
> 
> Honestly, I think the original text states what it does better than
> your update. Because the nopanic is added to override the "opposite
> default" which is if the config was set to do so.
> 
> That said, this all still can be explained better. What about:
> 
>         nmi_watchdog=   [KNL,BUGS=X86] Debugging features for SMP kernels
>                         Format: [panic,][nopanic,][num]
>                         Valid num: 0 or 1
>                         0 - turn hardlockup detector in nmi_watchdog off
>                         1 - turn hardlockup detector in nmi_watchdog on
>                         When panic is specified, panic when an NMI watchdog
>                         timeout occurs (or 'nopanic' to not panic on an NMI
> 			watchdog, if CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is set)
>                         To disable both hard and soft lockup detectors,
>                         please see 'nowatchdog'.
>                         This is useful when you use a panic=... timeout and
>                         need the box quickly up again.

Steven, your update makes it more clear to me. If patch is being written with
such update, here is my Reviewed-by:

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks!

 - Joel

> 
> -- Steve
> 
> 
> >  			please see 'nowatchdog'.
> >  			This is useful when you use a panic=... timeout and
> 

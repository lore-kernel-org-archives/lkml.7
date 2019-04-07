Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EA8C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 15:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A146620B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 15:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLyWkgnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfDGPq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 11:46:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36516 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfDGPq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 11:46:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so12021396wml.1;
        Sun, 07 Apr 2019 08:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UI152o0UmWyMsk7FGb97jVxM9rW1c6HS5ElaumSrp3Y=;
        b=PLyWkgnJGnAuXSOJXUSmA5bLmHqYKc2xFZCUkiuUhuVvKYpQ86Y16Fu6JZ+fGzBI5P
         OmCfrF+fMOzYxkIS85oaZZhbqzz0rVYM0J2Yt+lALfPgvF2Wy4yBjhcZcax3tFgYsgxD
         f58+uYbeG2QeFiNogogaWSbWojhqMwbg4L/RvSeSJzeOO0qc8yWZTFaF7lUO+qYecJt9
         uYWgWAjOsv14+wKrZM2jeYxotlDxU4vnP1DTgkeGtGtnVMf8/CsBevsP5iDKaJVjgFmI
         8U8PsCSdbxWbldqWZpZLV48h3B54d0NGpMG3tco/PA6+Lq/XAFORr7K1pFkwz/MzJwOs
         bJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UI152o0UmWyMsk7FGb97jVxM9rW1c6HS5ElaumSrp3Y=;
        b=NcQUDNcjMSPXSsWQZtCXOPIvjoAeKND83ZEnN6tk5t+NH7Ds107WuGww8nT7OTjfA5
         FHbzzjTMfhgVFn0bAsKEifQ+uC7HzwvGyQKYRiThIoiLzl4dYlBTQrxo46tjHM3vIq9h
         dzU1SgLoCrjrXGcVtaEm+PNziG4OE9KsS4icM2/R5aLiGuTBCU8uxmIf1X4Fpiy/508f
         owU4DncMXUzx400I5q7E4iSn7RknMx0mSYT40sUvFMqB1QfcyZj7deh3AJ7xa5hJ6ar+
         rHbWosznFvyIUC3wBe+fyeh7VC5q6K843MgLcSax7/JHEMh0sDv7EN5+dnkzXJJ5nWad
         6Pjg==
X-Gm-Message-State: APjAAAXxPu5IRFceqPgASMXasdrseAad3wk6pnfvSRXY1WUMyzHZMFhu
        tFzOUdpY97P6a0DN5bx71A==
X-Google-Smtp-Source: APXvYqz4Bi22zxBDwAf+m1lumU7h5YRxSTw/ZHW3dN9/7V29tfYl7OPXP3h6nfIBMnNVd58dK/6Hgw==
X-Received: by 2002:a1c:4602:: with SMTP id t2mr15301427wma.120.1554651985589;
        Sun, 07 Apr 2019 08:46:25 -0700 (PDT)
Received: from avx2 ([46.53.244.164])
        by smtp.gmail.com with ESMTPSA id d3sm22132550wmf.46.2019.04.07.08.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 08:46:24 -0700 (PDT)
Date:   Sun, 7 Apr 2019 18:46:22 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, ak@linux.intel.com,
        tim.c.chen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, aubrey.li@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v13 1/3] /proc/pid/status: Add support for architecture
 specific output
Message-ID: <20190407154622.GA16004@avx2>
References: <20190224044400.34975-1-aubrey.li@linux.intel.com>
 <alpine.DEB.2.21.1904052129371.1802@nanos.tec.linutronix.de>
 <20190406214143.GA21551@avx2>
 <7cd8fa2d-301a-5c96-ce3d-3dc373a5d8f5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7cd8fa2d-301a-5c96-ce3d-3dc373a5d8f5@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2019 at 09:02:38PM +0800, Li, Aubrey wrote:
> On 2019/4/7 5:41, Alexey Dobriyan wrote:
> > On Fri, Apr 05, 2019 at 09:32:35PM +0200, Thomas Gleixner wrote:
> >>> +/* Add support for architecture specific output in /proc/pid/status */
> >>> +extern void arch_proc_pid_status(struct seq_file *m, struct task_struct *task);
> >      ^^^^^^
> > 
> > Unnecessary extern.
> > 
> The linkage is default extern, but with this functions and variables
> can be treated the same way.
> 
> Is it mandatory not to use it explicitly? ./script/checkpatch.pl did
> not report this.

"extern" is only necessary for variables. For prototypes, it is more typing
and more characters on the screen.

checkpatch.pl doesn't report it because opening floodgates is not the plan.

Yours,
	Extern Police.

Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10641C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47FD21783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGmDEguL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfKKOHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:07:38 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:44498 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKOHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:07:38 -0500
Received: by mail-qv1-f67.google.com with SMTP id d3so3320302qvs.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 06:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VgMErk+E48MiYAc0J7PGMr4nIuiEkoSHhPNvRoYNCfg=;
        b=SGmDEguLV6fWs8/5nKJYMSTHck5geK/EWvdE/5M38Bf8GfqCwoscylQKOatQFl/0FU
         qosNswjGVeWlfVvEErS+w730j2wM2Nv7rMgdIFgvy6ifLbwRyC3hstjq52ARhrnif1DW
         czMBZDIlPPtSfEC+++XBFQrmfSC4X5W9aXnlc87KSPbk/kbY/v7Q1oe4UlaWNN4x+HSp
         03CRltIh8jCkDBD6g2LveQAU5hii81aikXN1QHXXA5cLEF1AY1rU4/8X9j83CZs3175z
         M5CP2OrdZiwOCqJvrdJ+a1gECc/C/Up6CgMbL/CV5pUv28h5ppBi3fpQbWvA1uAEqv6A
         E20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VgMErk+E48MiYAc0J7PGMr4nIuiEkoSHhPNvRoYNCfg=;
        b=CgrLFKP0hVVKsSboqo6z1BHxgT3Th3cCwpZhQPcy6kiYRJawh1jVfjNMlz+olV2rHU
         jYDUX46GI9Ps800EYMVEqep1OEkXoz9laCP6DF4BeYGryWYrVRr2gUsVL5tYT5o5gdi3
         i/mq9fLmowZIpaVJmFSjtdLRR5hD2fjFZQWzWkCuDF27Q0ULg+q5Qj9dS0dRvb7yI44V
         x1J/k81cHjdj4GGXNwsn/hdof1eMWmsQqF29cRZkJPEVLbK56G9GjN6wvbbdielMq48D
         lJNWE33CfTr5keGg2HH4pydN5iQyH8ihNMHVgN9/ohoshDFpTENO9YeHWo1TD3uIRgLu
         n4Hw==
X-Gm-Message-State: APjAAAU81BWpJgGbxFBpSAfiT4gt5Gkf95mk/57d5nOMzbCgLXuUj/oz
        E/9sJOIJKC8Jhm0M5r5s4lQ=
X-Google-Smtp-Source: APXvYqz6AqiA3VmSBWp9fG82m+nDASdMbhVoJfhI56V0300YEC9zsYNM8WVac5dvx3Kn1/kZ14orSg==
X-Received: by 2002:a05:6214:12ac:: with SMTP id w12mr24291476qvu.44.1573481256802;
        Mon, 11 Nov 2019 06:07:36 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id c27sm4664295qko.132.2019.11.11.06.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 06:07:36 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 00A0A411B3; Mon, 11 Nov 2019 11:07:33 -0300 (-03)
Date:   Mon, 11 Nov 2019 11:07:33 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 1/4] perf probe: Generate event name with line number
Message-ID: <20191111140733.GD9365@kernel.org>
References: <157314406866.4063.16995747442215702109.stgit@devnote2>
 <157314407850.4063.2307803945694526578.stgit@devnote2>
 <20191111140450.GB9365@kernel.org>
 <20191111140625.GC9365@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111140625.GC9365@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 11, 2019 at 11:06:25AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Nov 11, 2019 at 11:04:50AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Nov 08, 2019 at 01:27:58AM +0900, Masami Hiramatsu escreveu:
> > > Generate event name from function name with line number
> > > as <function>_L<line_number>. Note that this is only for
> > > the new event which is defined by the line number of
> > > function (except for line 0).
> > > 
> > > If there is another event on same line, you have to use
> > > "-f" option. In that case, the new event has "_1" suffix.
> > > 
> > >  e.g.
> > >   # perf probe -a kernel_read:1
> > >   Added new events:
> > >     probe:kernel_read_L1 (on kernel_read:1)
> > 
> > While testing this, using the same function (kernel_read), I found it
> > confusing that it is possible to insert probes in lines seemingly with
> > no code, for instance:
> > 
> > [root@quaco ~]# perf probe -a kernel_read:1
> > Added new event:
> >   probe:kernel_read_L1 (on kernel_read:1)
> > 
> > You can now use it in all perf tools, such as:
> > 
> > 	perf record -e probe:kernel_read_L1 -aR sleep 1
> > 
> > [root@quaco ~]# perf probe -a kernel_read:2
> > Added new event:
> >   probe:kernel_read_L2 (on kernel_read:2)
> > 
> > You can now use it in all perf tools, such as:
> > 
> > 	perf record -e probe:kernel_read_L2 -aR sleep 1
> > 
> > #
> > # perf probe --list
> >   probe:kernel_read_l1 (on kernel_read@fs/read_write.c)
> >   probe:kernel_read_l2 (on kernel_read:1@fs/read_write.c)
> 
> 
> Also look above at the listing, I would expect this instead:
> 
> # perf probe --list
>   probe:kernel_read_l1 (on kernel_read:1@fs/read_write.c)
>   probe:kernel_read_l2 (on kernel_read:2@fs/read_write.c)
> 
> Right?

And this one may be a problem with this specific patch, so I'll hold off
processing this series till you have a chance to look at these problems
and reply,

Thanks,

- Arnaldo

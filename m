Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A90C17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0432190F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bM4iKzdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfKKOGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:06:30 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45382 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKOG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:06:28 -0500
Received: by mail-qk1-f196.google.com with SMTP id q70so11200031qke.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 06:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GDQYhUU4TUL5Xua4eXjjd9fK4kpSHxqVLmnp+laawDQ=;
        b=bM4iKzdtrGCaIifa41Or/qEE45ujDBF7IZwybFakPIekq9Av89bgb/jV+JFbnP+Mkz
         jF/BbFLDGeHTvxMEVCDBkzOzS2VrEiqVgP0j8ui2HrDuO9xVPZWSws84f4mC6RvsBcbU
         TUB+6SOD0CKJSYHT55nhQhpld8lKR+sv+nr6cCdf5CKKxgdpH19AkCBS16AB7wNMNJ1c
         mWHuSg3IToaE3vBQEHFiQvfbF1Qr9oyooL+ykz/8cq3c5ay231nB10f59aDH9sqRcgAj
         TLr5hHeMGYKIcH3N3FEOqL8YOZN+lme6iEscL2Z/T+oBVAcXQKTvZySYKaRPH/MO5kQz
         kLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GDQYhUU4TUL5Xua4eXjjd9fK4kpSHxqVLmnp+laawDQ=;
        b=KgfhLU7jBa67ztaZq97W+PXsMtXKnIu3xBLV4pNwJL75jezF57RLfHmwLbmp4ys9Sk
         aLIS5Z8poLnnBQV27COETs3EzH2Y458RQJeUdGqzMQMsHJW7EuVCEYEhQv4s3j1kHjfI
         R1edM8f2vnZhLx7CqD2ATq6L3hqgZnybJ+BUi843X7r0KK4/Uy9X6UtzJeOtWESzC+Pj
         KM/iYyXQnIr7mXYSq2vUewxKJeyk3ogvYAmwv+b+rSFtyzD5S34yDUi9eSBUTJI7DqEv
         LsKdR+x3i4EtNsbaDAq9+7dNtMig134PJ10/VVfgiPvWY39FcTxZXJZ7tSeihhlgHSsL
         FWUA==
X-Gm-Message-State: APjAAAWcVthYzK9gUr//uouG66lNwfeb09G7/sPFCoJmArY/9B7SzyNL
        KEHMHPjG3j0SK2qJZ+44KA+WafRE
X-Google-Smtp-Source: APXvYqxMCADwd0KyssD80O62M5Da4r4daUNWZ+NH3B6rCgpmD2gks1LtzeXQGn8dQb+JnbUzxHIrdg==
X-Received: by 2002:ae9:e301:: with SMTP id v1mr588405qkf.197.1573481187683;
        Mon, 11 Nov 2019 06:06:27 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id o53sm9276437qtj.91.2019.11.11.06.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 06:06:27 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 25BEF411B3; Mon, 11 Nov 2019 11:06:25 -0300 (-03)
Date:   Mon, 11 Nov 2019 11:06:25 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 1/4] perf probe: Generate event name with line number
Message-ID: <20191111140625.GC9365@kernel.org>
References: <157314406866.4063.16995747442215702109.stgit@devnote2>
 <157314407850.4063.2307803945694526578.stgit@devnote2>
 <20191111140450.GB9365@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111140450.GB9365@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 11, 2019 at 11:04:50AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Nov 08, 2019 at 01:27:58AM +0900, Masami Hiramatsu escreveu:
> > Generate event name from function name with line number
> > as <function>_L<line_number>. Note that this is only for
> > the new event which is defined by the line number of
> > function (except for line 0).
> > 
> > If there is another event on same line, you have to use
> > "-f" option. In that case, the new event has "_1" suffix.
> > 
> >  e.g.
> >   # perf probe -a kernel_read:1
> >   Added new events:
> >     probe:kernel_read_L1 (on kernel_read:1)
> 
> While testing this, using the same function (kernel_read), I found it
> confusing that it is possible to insert probes in lines seemingly with
> no code, for instance:
> 
> [root@quaco ~]# perf probe -a kernel_read:1
> Added new event:
>   probe:kernel_read_L1 (on kernel_read:1)
> 
> You can now use it in all perf tools, such as:
> 
> 	perf record -e probe:kernel_read_L1 -aR sleep 1
> 
> [root@quaco ~]# perf probe -a kernel_read:2
> Added new event:
>   probe:kernel_read_L2 (on kernel_read:2)
> 
> You can now use it in all perf tools, such as:
> 
> 	perf record -e probe:kernel_read_L2 -aR sleep 1
> 
> #
> # perf probe --list
>   probe:kernel_read_l1 (on kernel_read@fs/read_write.c)
>   probe:kernel_read_l2 (on kernel_read:1@fs/read_write.c)


Also look above at the listing, I would expect this instead:

# perf probe --list
  probe:kernel_read_l1 (on kernel_read:1@fs/read_write.c)
  probe:kernel_read_l2 (on kernel_read:2@fs/read_write.c)

Right?

- Arnaldo

> [root@quaco ~]# perf probe -L kernel_read
> <kernel_read@/usr/src/debug/kernel-5.3.fc30/linux-5.3.8-200.fc30.x86_64/fs/read_write.c:0>
>       0  ssize_t kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
>       1  {
>       2         mm_segment_t old_fs;
>       3         ssize_t result;
> 
>       5         old_fs = get_fs();
>       6         set_fs(KERNEL_DS);
>                 /* The cast to a user pointer is valid due to the set_fs() */
>       8         result = vfs_read(file, (void __user *)buf, count, pos);
>       9         set_fs(old_fs);
>      10         return result;
>          }
>          EXPORT_SYMBOL(kernel_read);
> 
> 
> [root@quaco ~]#
> 
> 
> What is the point of putting a probe on line 2? I is not initializing,
> etc, 1 as well, notthing there and we already have 0 (or not specifying
> a line number) to put a probe at the start of a function, can you
> clarify?
> 
> I'll apply this patch, the problem above isn't strictly related to it.
> 
> - Arnaldo

-- 

- Arnaldo

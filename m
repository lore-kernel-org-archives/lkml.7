Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9923C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD52C21783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3ZOYeDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKKOEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:04:54 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33483 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfKKOEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:04:54 -0500
Received: by mail-qt1-f195.google.com with SMTP id y39so15808419qty.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 06:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XYVomfoUOz+2dXFVT1MrIwqA9RjQftapicqclx+MmeQ=;
        b=U3ZOYeDAezylhF8/Ittif28Vr6c8z5gRnnMr+GaYMAWii/m1ikhIodaE8tpRYm/YwN
         dwoNRmWz+ftp5JR2jkkowcsmb2+/zIS4X44+up2Vp/ldpbVUXR1rnWc6GXz8BXVgwRMe
         djGod7Fzbc5bYdWKHyLwdRag6rgkn5fe6ojMS4FsqX5+KPdj1q31y8Kl4S1PTCOdGBZQ
         Vf4pk8EKHd5UOnQrjgEQ6Gj5irOMQ0sFKUCnOZekLhIweNsjhLXn2RnCrh5GZwAWxXJd
         I6rPmdBbxZeN0/dJNlJxBIZ1Y6VOg1Xc7tEHXGpFqlBBk+iwmfCt9NBbl28TxjWxFGQi
         /6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XYVomfoUOz+2dXFVT1MrIwqA9RjQftapicqclx+MmeQ=;
        b=RD70CH2s5Pv4fmgHV2RoqlLzd07Znmjw0zscxkABtP0DLE8M8ASm9of9i0wbH7txlQ
         Ckfy+Hmv6CBs+tlEg1hC/1lfyL+9QWv6pMuDfV3bufdUw97G1J29Zz+mH7RK6rb3aT9w
         qNFyE7CwjItk4ckEK9c2Mz6FKrLgL4TIuQfDAVrRqJmJ/6pprktgFV8s1l7k4FM8wQ4a
         W+auAqOo37psBu42EtQ0po3YATWnE+/mmxXuk72Tw+oqnm6Dsz/9KDx4bbmsFc9GVmp8
         9wEvGjHECJiQH4+WtJmK2CBdT3LrBzxofdVYU3775Dr7Y/F4dYxmEq9Bp1p20lzvOwte
         ps4w==
X-Gm-Message-State: APjAAAWm7wX2VLDihgtaXT6h/XuXlyU/4SUHNwc5N32gyrsZRD/WQvNr
        UNefDhfi8Jb2QQoqdjH+AWM=
X-Google-Smtp-Source: APXvYqxfRziSPu4cYp648NXJXS9DdsYMnD+4dhFaNcmzTJKhl076ZDYGHCRtlJRn/ByjjECfhO6VaQ==
X-Received: by 2002:aed:2799:: with SMTP id a25mr26414466qtd.226.1573481093347;
        Mon, 11 Nov 2019 06:04:53 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id a18sm7971101qkc.2.2019.11.11.06.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 06:04:52 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9C5AD411B3; Mon, 11 Nov 2019 11:04:50 -0300 (-03)
Date:   Mon, 11 Nov 2019 11:04:50 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 1/4] perf probe: Generate event name with line number
Message-ID: <20191111140450.GB9365@kernel.org>
References: <157314406866.4063.16995747442215702109.stgit@devnote2>
 <157314407850.4063.2307803945694526578.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157314407850.4063.2307803945694526578.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 08, 2019 at 01:27:58AM +0900, Masami Hiramatsu escreveu:
> Generate event name from function name with line number
> as <function>_L<line_number>. Note that this is only for
> the new event which is defined by the line number of
> function (except for line 0).
> 
> If there is another event on same line, you have to use
> "-f" option. In that case, the new event has "_1" suffix.
> 
>  e.g.
>   # perf probe -a kernel_read:1
>   Added new events:
>     probe:kernel_read_L1 (on kernel_read:1)

While testing this, using the same function (kernel_read), I found it
confusing that it is possible to insert probes in lines seemingly with
no code, for instance:

[root@quaco ~]# perf probe -a kernel_read:1
Added new event:
  probe:kernel_read_L1 (on kernel_read:1)

You can now use it in all perf tools, such as:

	perf record -e probe:kernel_read_L1 -aR sleep 1

[root@quaco ~]# perf probe -a kernel_read:2
Added new event:
  probe:kernel_read_L2 (on kernel_read:2)

You can now use it in all perf tools, such as:

	perf record -e probe:kernel_read_L2 -aR sleep 1

[root@quaco ~]#
[root@quaco ~]# perf probe --list
  probe:kernel_read_L1 (on kernel_read@fs/read_write.c)
  probe:kernel_read_L2 (on kernel_read:1@fs/read_write.c)
[root@quaco ~]# perf probe -L kernel_read
<kernel_read@/usr/src/debug/kernel-5.3.fc30/linux-5.3.8-200.fc30.x86_64/fs/read_write.c:0>
      0  ssize_t kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
      1  {
      2         mm_segment_t old_fs;
      3         ssize_t result;

      5         old_fs = get_fs();
      6         set_fs(KERNEL_DS);
                /* The cast to a user pointer is valid due to the set_fs() */
      8         result = vfs_read(file, (void __user *)buf, count, pos);
      9         set_fs(old_fs);
     10         return result;
         }
         EXPORT_SYMBOL(kernel_read);


[root@quaco ~]#


What is the point of putting a probe on line 2? I is not initializing,
etc, 1 as well, notthing there and we already have 0 (or not specifying
a line number) to put a probe at the start of a function, can you
clarify?

I'll apply this patch, the problem above isn't strictly related to it.

- Arnaldo

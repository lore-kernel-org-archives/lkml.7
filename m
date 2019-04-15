Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E35C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42799206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQfUFS4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfDOMIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:08:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52879 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfDOMIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:08:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id a184so20323967wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 05:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WZ4XJ1wjaphN2Mm4zz4dKBcURerJfV7+y5PrYWGB390=;
        b=uQfUFS4VJ/MaaRuPh30JckUdukMD2vQOAUEUbsmdHR6e+9BrHKvQDH/rPgRzYKW+ga
         2UaydH9ICrJM/fMHDBA+Sk0/D1lUGMit/7+8Pj8b/7vnrZnd0tAgaJK+ZGevP0C0w+Wm
         gb6YKBpRywG2bYQCGRs5kTmaetBOhBkU+q64sbm7cY1MQXHbBd3gXBvseLnLSMYAIueO
         IxazXdclV/rdjCwXPTvsLSaRFIMxWMB2Shho9m1to5fw7JUGNUmoXx5esAjKyGlTNofW
         Ut+zwpo5J745fuZbaO4pQFQigoRXB9U7k8i4rr/ecGv3QnqG+YT4DV3EwcfhMjGojgV3
         BpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=WZ4XJ1wjaphN2Mm4zz4dKBcURerJfV7+y5PrYWGB390=;
        b=cLe3gDSgnhLB5AZhLAs21Qm+1OJfzi05MnYJ5/iKmNFzWt8M+NwFmdgWcHGzLxC9BK
         Pyu9Q1PL+rJHbWTpjah9lsEgeh1SsVjKCDiSfnUARWvznOo5LFn0Q5qXRwSPxJ02AYKZ
         NAi1ePCANn+0yzESdYgPepEM9kXLhnaOai2rmbLY+9iJGz8DKNqTlg1BfQD6NalGLggr
         LZR/8zhcTV9r/LhkgWl1CR61kBMIZTUbcbJW7nm54/sfH+wn5mHChJpxTtXfUAlfxcCh
         JffWtf2SdawKdJmOn7EDXhOV9+6ijHYbzGwSoswPxfyegISpjUB9QF1eQoU6ZEzuBF8Q
         dw5g==
X-Gm-Message-State: APjAAAXoUVqDQ6IrHw4oSHb+z/JGr2d846uYiVU9OqsGNVDoBtlDaDjh
        zsiJpiy9UPX3Y5AeWMCpdE0=
X-Google-Smtp-Source: APXvYqwvjbCnqZiBnI1vmCJam0TV7wSWFl0OX9P4ecw6uG0GWKcaQbdr8KZmW9wPdTsLISNlL12Bow==
X-Received: by 2002:a1c:c504:: with SMTP id v4mr22711830wmf.45.1555330087198;
        Mon, 15 Apr 2019 05:08:07 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id j22sm147521348wrd.91.2019.04.15.05.08.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Apr 2019 05:08:06 -0700 (PDT)
Date:   Mon, 15 Apr 2019 14:08:04 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Stephen Rostedt <rostedt@goodmis.org>
cc:     linux-kernel@vger.kernel.org, Josef Bacik <jbacik@fb.com>
Subject: Re: BUG: trace-cmd: trace-cmd record -e failure
In-Reply-To: <alpine.LFD.2.21.1904151348530.7076@planxty>
Message-ID: <alpine.LFD.2.21.1904151406560.7076@planxty>
References: <alpine.LFD.2.21.1904151348530.7076@planxty>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463804494-252759748-1555330086=:7076"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-252759748-1555330086=:7076
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT



On Mon, 15 Apr 2019, John Kacur wrote:

> This is a long standing but in trace-cmd.
> 
> [root@pq6-0 tmp]# trace-cmd record -p function -e sched:* sleep 1
>   plugin 'function'
> none
> trace-cmd: Invalid argument
>   Failed filter of 
> /sys/kernel/debug/tracing/events/sched/sched_kthread_stop/filter
> 
> trace-cmd: No such file or directory
>   can not stat 'trace.dat.cpu0'
> 
> -------------------------------------------
> 
> This only happens on large machines, I can only get it to trigger at 
> around 200 cpus. However, it's not complicated, it's simply we're writing
> to the filter file, one per recorder thread until the size of the string
> exceeds the limit.
> 
> We're writing something crazy like this.
> 
> str = 
> (common_pid!=50883)||(common_pid!=50882)||(common_pid!=50881)||(common_pid!=50880)||(common_pid!=50879)||(common_pid!=50878)||(common_pid!=50877)||(common_pid!=50876)||(common_pid!=50875)||(common_pid!=50874)||(common_pid!=50873)||(common_pid!=50872)||(common_pid!=50871)||(common_pid!=50870)||(common_pid!=50869)||(common_pid!=50868)||(common_pid!=50867)||(common_pid!=50866)||(common_pid!=50865)||(common_pid!=50864)||(common_pid!=50863)||(common_pid!=50862)||(common_pid!=50861)||(common_pid!=50860)||(common_pid!=50859)||(common_pid!=50858)||(common_pid!=50857)||(common_pid!=50856)||(common_pid!=50855)||(common_pid!=50854)||(common_pid!=50853)||(common_pid!=50852)||(common_pid!=50851)||(common_pid!=50850)||(common_pid!=50849)||(common_pid!=50848)||(common_pid!=50847)||(common_pid!=50846)||(common_pid!=50845)||(common_pid!=50844)||(common_pid!=50843)||(common_pid!=50842)||(common_pid!=50841)||(common_pid!=50840)||(common_pid!=50839)||(common_pid!=50838)||(common_pid!=50837)||(common_p
 id!=50836)||(common_pid!=50835)||(common_pid!=50834)||(common_pid!=50833)||(common_pid!=50832)||(common_pid!=50831)||(common_pid!=50830)||(common_pid!=50829)||(common_pid!=50828)||(common_pid!=50827)||(common_pid!=50826)||(common_pid!=50825)||(common_pid!=50824)||(common_pid!=50823)||(common_pid!=50822)||(common_pid!=50821)||(common_pid!=50820)||(common_pid!=50819)||(common_pid!=50818)||(common_pid!=50817)||(common_pid!=50816)||(common_pid!=50815)||(common_pid!=50814)||(common_pid!=50813)||(common_pid!=50812)||(common_pid!=50811)||(common_pid!=50810)||(common_pid!=50809)||(common_pid!=50808)||(common_pid!=50807)||(common_pid!=50806)||(common_pid!=50805)||(common_pid!=50804)||(common_pid!=50803)||(common_pid!=50802)||(common_pid!=50801)||(common_pid!=50800)||(common_pid!=50799)||(common_pid!=50798)||(common_pid!=50797)||(common_pid!=50796)||(common_pid!=50795)||(common_pid!=50794)||(common_pid!=50793)||(common_pid!=50792)||(common_pid!=50791)||(common_pid!=50790)||(common_pid!=50789)
 ||(common_pid!=50788)||(common_pid!=50787)||(common_pid!=50786)||(common_pid!=50785)||(common_pid!=50784)||(common_pid!=50783)||(common_pid!=50782)||(common_pid!=50781)||(common_pid!=50780)||(common_pid!=50779)||(common_pid!=50778)||(common_pid!=50777)||(common_pid!=50776)||(common_pid!=50775)||(common_pid!=50774)||(common_pid!=50773)||(common_pid!=50772)||(common_pid!=50771)||(common_pid!=50770)||(common_pid!=50769)||(common_pid!=50768)||(common_pid!=50767)||(common_pid!=50766)||(common_pid!=50765)||(common_pid!=50764)||(common_pid!=50763)||(common_pid!=50762)||(common_pid!=50761)||(common_pid!=50760)||(common_pid!=50759)||(common_pid!=50758)||(common_pid!=50757)||(common_pid!=50756)||(common_pid!=50755)||(common_pid!=50754)||(common_pid!=50753)||(common_pid!=50752)||(common_pid!=50751)||(common_pid!=50750)||(common_pid!=50749)||(common_pid!=50748)||(common_pid!=50747)||(common_pid!=50746)||(common_pid!=50745)||(common_pid!=50744)||(common_pid!=50743)||(common_pid!=50742)||(common_
 pid!=50741)||(common_pid!=50740)||(common_pid!=50739)||(common_pid!=50738)||(common_pid!=50737)||(common_pid!=50736)||(common_pid!=50735)||(common_pid!=50734)||(common_pid!=50733)||(common_pid!=50732)||(common_pid!=50731)||(common_pid!=50730)||(common_pid!=50729)||(common_pid!=50728)||(common_pid!=50727)||(common_pid!=50726)||(common_pid!=50725)||(common_pid!=50724)||(common_pid!=50723)||(common_pid!=50722)||(common_pid!=50721)||(common_pid!=50720)||(common_pid!=50719)||(common_pid!=50718)||(common_pid!=50717)||(common_pid!=50716)||(common_pid!=50715)||(common_pid!=50714)||(common_pid!=50713)||(common_pid!=50712)||(common_pid!=50711)||(common_pid!=50710)||(common_pid!=50709)||(common_pid!=50708)||(common_pid!=50707)||(common_pid!=50706)||(common_pid!=50705)||(common_pid!=50704)||(common_pid!=50703)||(common_pid!=50702)||(common_pid!=50701)||(common_pid!=50700)||(common_pid!=50699)||(common_pid!=50698)||(common_pid!=50697)||(common_pid!=50696)||(common_pid!=50695)||(common_pid!=50694
 )||(common_pid!=50693)||(common_pid!=50692)||(common_pid!=50691)||(common_pid!=50690)||(common_pid!=50689)||(common_pid!=50688)||(common_pid!=50687)||(common_pid!=50686)||(common_pid!=50685)||(common_pid!=50684)||(common_pid!=50683)||(common_pid!=50682)||(common_pid!=50681)||(common_pid!=50680)||(common_pid!=50679)||(common_pid!=50678)||(common_pid!=50677)||(common_pid!=50676)||(common_pid!=50675)||(common_pid!=50674)||(common_pid!=50673)||(common_pid!=50672)||(common_pid!=50671)||(common_pid!=50670)||(common_pid!=50669)||(common_pid!=50668)||(common_pid!=50667)||(common_pid!=50666)||(common_pid!=50665)||(common_pid!=50664)||(common_pid!=50663)||(common_pid!=50662)||(common_pid!=50661)||(common_pid!=50660)||(common_pid!=50659)||(common_pid!=50658)||(common_pid!=50657)||(common_pid!=50656)||(common_pid!=50655)||(common_pid!=50654)||(common_pid!=50653)||(common_pid!=50652)||(common_pid!=50651)||(common_pid!=50650)||(common_pid!=50649)||(common_pid!=50648)||(common_pid!=50647)||(common
 _pid!=50646)||(common_pid!=50645)||(common_pid!=50644)||(common_pid!=50643)||(common_pid!=50642)||(common_pid!=50641)||(common_pid!=50640)||(common_pid!=50639)||(common_pid!=50638)||(common_pid!=50637)||(common_pid!=50636)||(common_pid!=50635)||(common_pid!=50634)||(common_pid!=50633)||(common_pid!=50632)||(common_pid!=50631)||(common_pid!=50630)||(common_pid!=50629)||(common_pid!=50628)||(common_pid!=50627)||(common_pid!=50626)||(common_pid!=50625)||(common_pid!=50624)||(common_pid!=50623)||(common_pid!=50622)||(common_pid!=50621)||(common_pid!=50620)||(common_pid!=50619)||(common_pid!=50618)||(common_pid!=50617)||(common_pid!=50616)||(common_pid!=50615)||(common_pid!=50614)||(common_pid!=50613)||(common_pid!=50612)||(common_pid!=50611)||(common_pid!=50610)||(common_pid!=50609)||(common_pid!=50608)||(common_pid!=50607)||(common_pid!=50606)||(common_pid!=50605)||(common_pid!=50604)||(common_pid!=50603)||(common_pid!=50602)||(common_pid!=50601)||(common_pid!=50600)||(common_pid!=5059
 9)||(common_pid!=50598)||(common_pid!=50597)||(common_pid!=50596), 
> strlen = 6046b
> 
> on an older version of traceback (but this bug still exists in the 
> latest), I did a gdb session like this
> 
> Breakpoint 2, write_file (
>     file=0x670e40 
> "/sys/kernel/debug/tracing/events/sched/sched_kthread_stop/filter", 
>     str=0x67f8c0 
> "(common_pid!=21759)||(common_pid!=21758)||(common_pid!=21757)||(common_pid!=21756)||(common_pid!=21755)||(common_pid!=21754)||(common_pid!=21753)||(common_pid!=21752)||(common_pid!=21751)||(common_pid"..., 
>     type=0x447dc4 "filter") at /root/trace-cmd/trace-record.c:1586
> 1586			die("Failed %s of %s\n", type, file);
> (gdb) print file
> $7 = 0x670e40 
> "/sys/kernel/debug/tracing/events/sched/sched_kthread_stop/filter"
> (gdb) bt
> #0  write_file (
>     file=0x670e40 
> "/sys/kernel/debug/tracing/events/sched/sched_kthread_stop/filter", 
>     str=0x67f8c0 
> "(common_pid!=21759)||(common_pid!=21758)||(common_pid!=21757)||(common_pid!=21756)||(common_pid!=21755)||(common_pid!=21754)||(common_pid!=21753)||(common_pid!=21752)||(common_pid!=21751)||(common_pid"..., 
>     type=0x447dc4 "filter") at /root/trace-cmd/trace-record.c:1586
> #1  0x000000000040abfd in write_filter (
>     file=0x670e40 
> "/sys/kernel/debug/tracing/events/sched/sched_kthread_stop/filter", 
>     filter=0x67f8c0 
> "(common_pid!=21759)||(common_pid!=21758)||(common_pid!=21757)||(common_pid!=21756)||(common_pid!=21755)||(common_pid!=21754)||(common_pid!=21753)||(common_pid!=21752)||(common_pid!=21751)||(common_pid"...)
>     at /root/trace-cmd/trace-record.c:1652
> #2  0x000000000040af81 in update_event (event=0x670d30, 
>     filter=0x67f8c0 
> "(common_pid!=21759)||(common_pid!=21758)||(common_pid!=21757)||(common_pid!=21756)||(common_pid!=21755)||(common_pid!=21754)||(common_pid!=21753)||(common_pid!=21752)||(common_pid!=21751)||(common_pid"..., 
>     filter_only=1, update=49 '1') at /root/trace-cmd/trace-record.c:1785
> #3  0x000000000040b653 in update_event_filters (
>     instance=0x65e5e0 <top_instance>) at 
> /root/trace-cmd/trace-record.c:2016
> #4  0x000000000040b83b in update_pid_event_filters (
>     instance=0x65e5e0 <top_instance>) at 
> /root/trace-cmd/trace-record.c:2081
> #5  0x0000000000409607 in update_task_filter ()
>     at /root/trace-cmd/trace-record.c:971
> #6  0x00000000004118be in trace_record (argc=6, argv=0x7fffffffe0f8)
>     at /root/trace-cmd/trace-record.c:4818
> #7  0x0000000000407cb7 in main (argc=6, argv=0x7fffffffe0f8)
>     at /root/trace-cmd/trace-cmd.c:133
> 
> Note even if you don't invoke the filter, you still write the sting to the 
> file.
> 
> Not sure how to fix this, but conceptually it's not hard, we need to add 
> some error checking and stop writing to the filter if we exceed the limit.
> The functions that do the writes however are shared in many paths.
> 
> In addition to that, perhaps we could write something saner to the file
> so that it takes longer to hit the limit.
> 
> Rewriting "common_pid" over and over again for example, is probably 
> unnecessary with some reworking.
> 
> John Kacur

I forgot to mention that the cause of the problem is the addition of the 
filting feature.

commit a5923c5c9f812d84472f60f8c9c3e13a6702dd97
Author: Josef Bacik <jbacik@fb.com>
Date:   Fri Dec 4 12:03:38 2015 -0500

    trace-cmd: Filter out specific pids
    
    Sometimes it is a good idea to filter out events from the recording 
processes
    and even other pids, for example an external app that links against 
libtracecmd
    that watches syscalls probably doesn't want its own syscalls showing 
up in the
    events.  So add the ability to filter _out_ certain pids for the 
events that are
    enabled.  The recorder threads will add their pids to this list, but 
they are
    only filtered if the library consumer filters out a pid or if the 
trace-cmd
    record user tries to filter anything out.
    
    Link: 
http://lkml.kernel.org/r/1449248618-30556-1-git-send-email-jbacik@fb.com
    
    Signed-off-by: Josef Bacik <jbacik@fb.com>
    Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Thanks

John
---1463804494-252759748-1555330086=:7076--

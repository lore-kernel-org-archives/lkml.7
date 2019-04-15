Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3275BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E084D206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+48GaSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfDOMCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:02:32 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:55484 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfDOMCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:02:32 -0400
Received: by mail-wm1-f53.google.com with SMTP id o25so20300000wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 05:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=SYGWq1P11ey8IPCI8GxNhTXpsSVR35lzZw0JouUSIVQ=;
        b=h+48GaSdBImcaLs6Ce/qg/u0GjvosTwhhorwPBIWKd4gucOlAEsqPjzNcJSh1xIJ70
         ImVTMGVOhfGhNZFCboeWSRxAH5niasw+O4BvqM54RV13nAem86AA10mUJmhdJN9LkJia
         Kt5c7CwVRdLNy1GfoNJ+5VFkg4IJ23Ln1lw8sHd+i6qpxUTai6Jh493ceRcUzvLJvxSw
         qjNoJMhpUoTU+dCz8GlWR6yX69bQPRXB6t8hqa7hYDNTwBfQ6KvgosfoeOtQrXGUxI2U
         r2/P2nVWUlgYVZtTndraIbKVv4TbmWwEgocdtMhjIpT2fr3Xzg+a8RP5Wj+eybSfaanH
         4lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :user-agent:mime-version;
        bh=SYGWq1P11ey8IPCI8GxNhTXpsSVR35lzZw0JouUSIVQ=;
        b=NuLXgQFa0upXLLjIaZOwJJ8gESUawjBQL5M4qr8jpW7BiPEWXvjdHntPxOoq8OPkij
         PQLUWWZmnuIYZa1q+GjSzGV00EvcgDOS7gTMBG42BmwC8Nc7GZ57/Zq+N18pV0y5lmy6
         D1zM0uRPq6nhqOuhG09Fm3maVFq0gZ0BRYjJLyNgeN4lDFQWqNNwl59nj2YM/vmX6POF
         hHlE++mDLkh3Esu/bZO7uPM79lW9owWI97X9dxh50+lvgCUzgIPaO/7nn6nRf7dpLH7/
         q0HEXf0dbqYPApUDybwrWaW1uZvXdk25xVlmA4SyIoRgKP0XNLadBjDHZ5/crDiCgj51
         egfQ==
X-Gm-Message-State: APjAAAXsFaw9vMsc0L4lfLaGANIYl3J4fcpdwodMAh7lB94HJ9Wzmxnx
        3GzDLONxPMM8WrQbTU51T8oKrfXp
X-Google-Smtp-Source: APXvYqz13IrJaBeORE1Wel0smrgVAIAiZolhbwohHH+KiPQEqdoIhG1Ju3mBJWGmxsRxqNI+AZL9bA==
X-Received: by 2002:a1c:14:: with SMTP id 20mr21280429wma.66.1555329749597;
        Mon, 15 Apr 2019 05:02:29 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id a4sm36008979wmf.45.2019.04.15.05.02.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Apr 2019 05:02:28 -0700 (PDT)
Date:   Mon, 15 Apr 2019 14:02:16 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Stephen Rostedt <rostedt@goodmis.org>
cc:     linux-kernel@vger.kernel.org, Josef Bacik <jbacik@fb.com>
Subject: BUG: trace-cmd: trace-cmd record -e failure
Message-ID: <alpine.LFD.2.21.1904151348530.7076@planxty>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463804494-227336266-1555329743=:7076"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-227336266-1555329743=:7076
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT

This is a long standing but in trace-cmd.

[root@pq6-0 tmp]# trace-cmd record -p function -e sched:* sleep 1
  plugin 'function'
none
trace-cmd: Invalid argument
  Failed filter of 
/sys/kernel/debug/tracing/events/sched/sched_kthread_stop/filter

trace-cmd: No such file or directory
  can not stat 'trace.dat.cpu0'

-------------------------------------------

This only happens on large machines, I can only get it to trigger at 
around 200 cpus. However, it's not complicated, it's simply we're writing
to the filter file, one per recorder thread until the size of the string
exceeds the limit.

We're writing something crazy like this.

str = 
(common_pid!=50883)||(common_pid!=50882)||(common_pid!=50881)||(common_pid!=50880)||(common_pid!=50879)||(common_pid!=50878)||(common_pid!=50877)||(common_pid!=50876)||(common_pid!=50875)||(common_pid!=50874)||(common_pid!=50873)||(common_pid!=50872)||(common_pid!=50871)||(common_pid!=50870)||(common_pid!=50869)||(common_pid!=50868)||(common_pid!=50867)||(common_pid!=50866)||(common_pid!=50865)||(common_pid!=50864)||(common_pid!=50863)||(common_pid!=50862)||(common_pid!=50861)||(common_pid!=50860)||(common_pid!=50859)||(common_pid!=50858)||(common_pid!=50857)||(common_pid!=50856)||(common_pid!=50855)||(common_pid!=50854)||(common_pid!=50853)||(common_pid!=50852)||(common_pid!=50851)||(common_pid!=50850)||(common_pid!=50849)||(common_pid!=50848)||(common_pid!=50847)||(common_pid!=50846)||(common_pid!=50845)||(common_pid!=50844)||(common_pid!=50843)||(common_pid!=50842)||(common_pid!=50841)||(common_pid!=50840)||(common_pid!=50839)||(common_pid!=50838)||(common_pid!=50837)||(common_pid
 !=50836)||(common_pid!=50835)||(common_pid!=50834)||(common_pid!=50833)||(common_pid!=50832)||(common_pid!=50831)||(common_pid!=50830)||(common_pid!=50829)||(common_pid!=50828)||(common_pid!=50827)||(common_pid!=50826)||(common_pid!=50825)||(common_pid!=50824)||(common_pid!=50823)||(common_pid!=50822)||(common_pid!=50821)||(common_pid!=50820)||(common_pid!=50819)||(common_pid!=50818)||(common_pid!=50817)||(common_pid!=50816)||(common_pid!=50815)||(common_pid!=50814)||(common_pid!=50813)||(common_pid!=50812)||(common_pid!=50811)||(common_pid!=50810)||(common_pid!=50809)||(common_pid!=50808)||(common_pid!=50807)||(common_pid!=50806)||(common_pid!=50805)||(common_pid!=50804)||(common_pid!=50803)||(common_pid!=50802)||(common_pid!=50801)||(common_pid!=50800)||(common_pid!=50799)||(common_pid!=50798)||(common_pid!=50797)||(common_pid!=50796)||(common_pid!=50795)||(common_pid!=50794)||(common_pid!=50793)||(common_pid!=50792)||(common_pid!=50791)||(common_pid!=50790)||(common_pid!=50789)||
 (common_pid!=50788)||(common_pid!=50787)||(common_pid!=50786)||(common_pid!=50785)||(common_pid!=50784)||(common_pid!=50783)||(common_pid!=50782)||(common_pid!=50781)||(common_pid!=50780)||(common_pid!=50779)||(common_pid!=50778)||(common_pid!=50777)||(common_pid!=50776)||(common_pid!=50775)||(common_pid!=50774)||(common_pid!=50773)||(common_pid!=50772)||(common_pid!=50771)||(common_pid!=50770)||(common_pid!=50769)||(common_pid!=50768)||(common_pid!=50767)||(common_pid!=50766)||(common_pid!=50765)||(common_pid!=50764)||(common_pid!=50763)||(common_pid!=50762)||(common_pid!=50761)||(common_pid!=50760)||(common_pid!=50759)||(common_pid!=50758)||(common_pid!=50757)||(common_pid!=50756)||(common_pid!=50755)||(common_pid!=50754)||(common_pid!=50753)||(common_pid!=50752)||(common_pid!=50751)||(common_pid!=50750)||(common_pid!=50749)||(common_pid!=50748)||(common_pid!=50747)||(common_pid!=50746)||(common_pid!=50745)||(common_pid!=50744)||(common_pid!=50743)||(common_pid!=50742)||(common_pi
 d!=50741)||(common_pid!=50740)||(common_pid!=50739)||(common_pid!=50738)||(common_pid!=50737)||(common_pid!=50736)||(common_pid!=50735)||(common_pid!=50734)||(common_pid!=50733)||(common_pid!=50732)||(common_pid!=50731)||(common_pid!=50730)||(common_pid!=50729)||(common_pid!=50728)||(common_pid!=50727)||(common_pid!=50726)||(common_pid!=50725)||(common_pid!=50724)||(common_pid!=50723)||(common_pid!=50722)||(common_pid!=50721)||(common_pid!=50720)||(common_pid!=50719)||(common_pid!=50718)||(common_pid!=50717)||(common_pid!=50716)||(common_pid!=50715)||(common_pid!=50714)||(common_pid!=50713)||(common_pid!=50712)||(common_pid!=50711)||(common_pid!=50710)||(common_pid!=50709)||(common_pid!=50708)||(common_pid!=50707)||(common_pid!=50706)||(common_pid!=50705)||(common_pid!=50704)||(common_pid!=50703)||(common_pid!=50702)||(common_pid!=50701)||(common_pid!=50700)||(common_pid!=50699)||(common_pid!=50698)||(common_pid!=50697)||(common_pid!=50696)||(common_pid!=50695)||(common_pid!=50694)|
 |(common_pid!=50693)||(common_pid!=50692)||(common_pid!=50691)||(common_pid!=50690)||(common_pid!=50689)||(common_pid!=50688)||(common_pid!=50687)||(common_pid!=50686)||(common_pid!=50685)||(common_pid!=50684)||(common_pid!=50683)||(common_pid!=50682)||(common_pid!=50681)||(common_pid!=50680)||(common_pid!=50679)||(common_pid!=50678)||(common_pid!=50677)||(common_pid!=50676)||(common_pid!=50675)||(common_pid!=50674)||(common_pid!=50673)||(common_pid!=50672)||(common_pid!=50671)||(common_pid!=50670)||(common_pid!=50669)||(common_pid!=50668)||(common_pid!=50667)||(common_pid!=50666)||(common_pid!=50665)||(common_pid!=50664)||(common_pid!=50663)||(common_pid!=50662)||(common_pid!=50661)||(common_pid!=50660)||(common_pid!=50659)||(common_pid!=50658)||(common_pid!=50657)||(common_pid!=50656)||(common_pid!=50655)||(common_pid!=50654)||(common_pid!=50653)||(common_pid!=50652)||(common_pid!=50651)||(common_pid!=50650)||(common_pid!=50649)||(common_pid!=50648)||(common_pid!=50647)||(common_p
 id!=50646)||(common_pid!=50645)||(common_pid!=50644)||(common_pid!=50643)||(common_pid!=50642)||(common_pid!=50641)||(common_pid!=50640)||(common_pid!=50639)||(common_pid!=50638)||(common_pid!=50637)||(common_pid!=50636)||(common_pid!=50635)||(common_pid!=50634)||(common_pid!=50633)||(common_pid!=50632)||(common_pid!=50631)||(common_pid!=50630)||(common_pid!=50629)||(common_pid!=50628)||(common_pid!=50627)||(common_pid!=50626)||(common_pid!=50625)||(common_pid!=50624)||(common_pid!=50623)||(common_pid!=50622)||(common_pid!=50621)||(common_pid!=50620)||(common_pid!=50619)||(common_pid!=50618)||(common_pid!=50617)||(common_pid!=50616)||(common_pid!=50615)||(common_pid!=50614)||(common_pid!=50613)||(common_pid!=50612)||(common_pid!=50611)||(common_pid!=50610)||(common_pid!=50609)||(common_pid!=50608)||(common_pid!=50607)||(common_pid!=50606)||(common_pid!=50605)||(common_pid!=50604)||(common_pid!=50603)||(common_pid!=50602)||(common_pid!=50601)||(common_pid!=50600)||(common_pid!=50599)
 ||(common_pid!=50598)||(common_pid!=50597)||(common_pid!=50596), 
strlen = 6046b

on an older version of traceback (but this bug still exists in the 
latest), I did a gdb session like this

Breakpoint 2, write_file (
    file=0x670e40 
"/sys/kernel/debug/tracing/events/sched/sched_kthread_stop/filter", 
    str=0x67f8c0 
"(common_pid!=21759)||(common_pid!=21758)||(common_pid!=21757)||(common_pid!=21756)||(common_pid!=21755)||(common_pid!=21754)||(common_pid!=21753)||(common_pid!=21752)||(common_pid!=21751)||(common_pid"..., 
    type=0x447dc4 "filter") at /root/trace-cmd/trace-record.c:1586
1586			die("Failed %s of %s\n", type, file);
(gdb) print file
$7 = 0x670e40 
"/sys/kernel/debug/tracing/events/sched/sched_kthread_stop/filter"
(gdb) bt
#0  write_file (
    file=0x670e40 
"/sys/kernel/debug/tracing/events/sched/sched_kthread_stop/filter", 
    str=0x67f8c0 
"(common_pid!=21759)||(common_pid!=21758)||(common_pid!=21757)||(common_pid!=21756)||(common_pid!=21755)||(common_pid!=21754)||(common_pid!=21753)||(common_pid!=21752)||(common_pid!=21751)||(common_pid"..., 
    type=0x447dc4 "filter") at /root/trace-cmd/trace-record.c:1586
#1  0x000000000040abfd in write_filter (
    file=0x670e40 
"/sys/kernel/debug/tracing/events/sched/sched_kthread_stop/filter", 
    filter=0x67f8c0 
"(common_pid!=21759)||(common_pid!=21758)||(common_pid!=21757)||(common_pid!=21756)||(common_pid!=21755)||(common_pid!=21754)||(common_pid!=21753)||(common_pid!=21752)||(common_pid!=21751)||(common_pid"...)
    at /root/trace-cmd/trace-record.c:1652
#2  0x000000000040af81 in update_event (event=0x670d30, 
    filter=0x67f8c0 
"(common_pid!=21759)||(common_pid!=21758)||(common_pid!=21757)||(common_pid!=21756)||(common_pid!=21755)||(common_pid!=21754)||(common_pid!=21753)||(common_pid!=21752)||(common_pid!=21751)||(common_pid"..., 
    filter_only=1, update=49 '1') at /root/trace-cmd/trace-record.c:1785
#3  0x000000000040b653 in update_event_filters (
    instance=0x65e5e0 <top_instance>) at 
/root/trace-cmd/trace-record.c:2016
#4  0x000000000040b83b in update_pid_event_filters (
    instance=0x65e5e0 <top_instance>) at 
/root/trace-cmd/trace-record.c:2081
#5  0x0000000000409607 in update_task_filter ()
    at /root/trace-cmd/trace-record.c:971
#6  0x00000000004118be in trace_record (argc=6, argv=0x7fffffffe0f8)
    at /root/trace-cmd/trace-record.c:4818
#7  0x0000000000407cb7 in main (argc=6, argv=0x7fffffffe0f8)
    at /root/trace-cmd/trace-cmd.c:133

Note even if you don't invoke the filter, you still write the sting to the 
file.

Not sure how to fix this, but conceptually it's not hard, we need to add 
some error checking and stop writing to the filter if we exceed the limit.
The functions that do the writes however are shared in many paths.

In addition to that, perhaps we could write something saner to the file
so that it takes longer to hit the limit.

Rewriting "common_pid" over and over again for example, is probably 
unnecessary with some reworking.

John Kacur
---1463804494-227336266-1555329743=:7076--

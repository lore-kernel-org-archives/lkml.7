Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E78BFC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D502178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEwVAnBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfKHQMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:12:02 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:45991 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfKHQMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:12:02 -0500
Received: by mail-wr1-f52.google.com with SMTP id z10so2357774wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 08:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vfSMyonLNWSStTVXi/+0MEYGDG3O7Vuvm5dH7uvXqwo=;
        b=AEwVAnBgU2jNScqOseydoEaBBJJxBCXU6NmVBre0HQW5nxkf4unTDsavaxNM/0Ci4D
         m8RvulI0QkCcVuO3KcSk18U+XtA8zF134kNhGG8XGiu1y1PN9zInpUfT02kMTfDeGPev
         WWqBVavLqPsIXACZCyCnoYALJCB9+sL4u9yaa4gnL6ljldJqbe/QcOjJ+OBlgmkSOySR
         Xy5jGfqGi4qll2w6cpzzO6VxWc+9Ging6gM9XMCMstSbTYOhSO21a1t01yIFmoHx5pZh
         8TUjWYLpXfWXgx19ENEeTxK9lTZKE2jrq+jN4mURIjeHOruPQJbJDmzxmTOhkIf6Onx8
         ROgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vfSMyonLNWSStTVXi/+0MEYGDG3O7Vuvm5dH7uvXqwo=;
        b=dOzVkkrnIMr1FtUChS1plC+tEsk+gKQLdCwz+bUHl4M3akF87d4qP2lt4t10Mw1pH1
         IPcWkTpzNQv1a3lVxCbuS9/QMEe/mZSvSguffAFDHADJs6nINiW1UE2+DF3vcvUGKbcE
         OKG8JfBEjpceD1R3pF4XFdEzLqTHdXVhosibaAlI5ByRnGpisRTupTeTAeKcBmtGa3ha
         YiEQ1p++FcAeJwcYCgguZ7Wen00ZfijFym22FMUsa921TpKZitboP/1Yq0HFxu/RmmxF
         dSPoTgCmEce59CBguJ6DeFdZHBU3HSiNW/ltqTJR5/RPor4XfYOPzhQKQkCOFVP1P5H2
         VPZQ==
X-Gm-Message-State: APjAAAUDGvJbOlcV8TsMs6LBI1lbsScDODjw1QXJxvW6Fjce8eXWpLNl
        0g/sl+GXbVoxqY+NDhQfPkrPqcnY
X-Google-Smtp-Source: APXvYqwdr6usJ4bGyyp0FTiNoGOK4B/8DRuo7APPq8qVeKpq+g8dDL9o6RV8LWA64mmz7H//6YXfdg==
X-Received: by 2002:adf:e903:: with SMTP id f3mr9637350wrm.121.1573229520107;
        Fri, 08 Nov 2019 08:12:00 -0800 (PST)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id d13sm6226385wrq.51.2019.11.08.08.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Nov 2019 08:11:59 -0800 (PST)
Date:   Fri, 8 Nov 2019 16:11:57 +0000
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: libtraceevent installing in wrong folder
Message-ID: <20191108161157.g5aadocnfvragqb2@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

I tried to install libtraceevent. and I used the command:
"make DESTDIR=/home/sudip/test prefix=/usr install" from tool/lib/traceevent

And this is what I get:
sudip@debian:~/test$ pwd
/home/sudip/test

sudip@debian:~/test$ find .
.
./usr
./usr/local
./usr/local/lib
./usr/local/lib/x86_64-linux-gnu
./usr/local/lib/x86_64-linux-gnu/pkgconfig
./usr/local/lib/x86_64-linux-gnu/pkgconfig/libtraceevent.pc
./usr/lib64
./usr/lib64/traceevent
./usr/lib64/traceevent/plugins
./usr/lib64/traceevent/plugins/plugin_hrtimer.so
./usr/lib64/traceevent/plugins/plugin_sched_switch.so
./usr/lib64/traceevent/plugins/plugin_jbd2.so
./usr/lib64/traceevent/plugins/plugin_kvm.so
./usr/lib64/traceevent/plugins/plugin_cfg80211.so
./usr/lib64/traceevent/plugins/plugin_kmem.so
./usr/lib64/traceevent/plugins/plugin_scsi.so
./usr/lib64/traceevent/plugins/plugin_mac80211.so
./usr/lib64/traceevent/plugins/plugin_function.so
./usr/lib64/traceevent/plugins/plugin_xen.so
./usr/lib64/libtraceevent.so
./usr/lib64/libtraceevent.so.1.1.0
./usr/lib64/libtraceevent.a
./usr/lib64/libtraceevent.so.1
./home
./home/sudip
./home/sudip/test
./home/sudip/test/usr
./home/sudip/test/usr/include
./home/sudip/test/usr/include/traceevent
./home/sudip/test/usr/include/traceevent/event-parse.h
./home/sudip/test/usr/include/traceevent/trace-seq.h
./home/sudip/test/usr/include/traceevent/kbuffer.h
./home/sudip/test/usr/include/traceevent/event-utils.h

I am seeing two problems:
1) It created another home/sudip/test folder inside /home/sudip/test and
the header files are installed in /home/sudip/test/home/sudip/test/usr/include folder.
They should have been in /home/sudip/test/usr/include.

2) I used prefix=/usr but the 'pkgconfig' still went to /usr/local

Did I do something wrong?


-- 
Regards
Sudip

Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3929BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01301206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhmQzz1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKLL3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:29:17 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37430 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfKLL3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:29:14 -0500
Received: by mail-qk1-f195.google.com with SMTP id e187so14079526qkf.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 03:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R+ci91iQwSqIQQI6cqG1rpScTQGhC4P3AIBOquj9Lag=;
        b=ZhmQzz1JVF7Qpkl9X3Dl7+7UiCHy9dZGRBfY09GA8DKpHcY8ZrsIep2sjKAKUZOKJO
         LU4cWw4qWo1WTJHdenDiTv+c1nm716RnwWsWAAGbgwr2J6lSj/yNHbInXhTubRaIncZd
         T0PBjv5dMvxIzPfYfmw3cdEOsafvJdcQ8TxClqoJ/dYmrTLTqDtLlweus4Gh2Sfe8Z5/
         aDABsbceEhrgeo9ofbmPVB7SdHFdRaSSEXiPrsaeMRY3WiWFgU8/92EDWNvKd0cJ3YyQ
         18i9iLgWVEK8m6wZUAETvWEp1n90Xr1R40+1OcU7Z9I6XjaNfaPMggXy2SfliLZX+eTX
         pOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R+ci91iQwSqIQQI6cqG1rpScTQGhC4P3AIBOquj9Lag=;
        b=BtBA58TOHv6raiPeb/v/CkaXhx/Dl48VPC8TKAGsIwF4SNAULdOFtE5Ru1j5Wyq+Bu
         mccoJTrePubBa0osOXdavbLtSeE41fAWWgrnBuzQvepOFz9spFrIIOPF6KAiT7bldNUz
         yR02tkxqxspnenvFGnwltAnK4EvcC3UInkiXHLeBolZq/7/aW8YC376d1BEB+B4sbSx/
         nuvVZQjA9LHTwhZwDakG9ZvFqwyE9WcWNGh/wuZtlhnw6IQQTTWWAk08EgSypsg+fZiS
         V4y55SJJmaZ9nN3jVsb1rznJfyz3wC+pft6hLs8iAmABu4SxqeMn3LCH4SJ5XiZFONHF
         OeJw==
X-Gm-Message-State: APjAAAXVhqpakfe0zp5ElJZxzq3Hgp7i1ghu6r9fXFoNGTStz8u5nI9/
        bUk3HwZt4qDeZ3Mpg631SaqqQdB+
X-Google-Smtp-Source: APXvYqy5jVv77/YpmSPqTNQIgRNTFMphHzhXEFMde1sjj9pYlqVeNdZFF8+UbQluQ55To0YDkE26Og==
X-Received: by 2002:a37:9d0:: with SMTP id 199mr14974411qkj.356.1573558153443;
        Tue, 12 Nov 2019 03:29:13 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.182.211.47])
        by smtp.gmail.com with ESMTPSA id m25sm10930149qtc.0.2019.11.12.03.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 03:29:12 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 41011411B3; Tue, 12 Nov 2019 08:29:10 -0300 (-03)
Date:   Tue, 12 Nov 2019 08:29:10 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf tool: Provide an option to print perf_event_open
 args and return value
Message-ID: <20191112112910.GK9365@kernel.org>
References: <20191108093024.27077-1-ravi.bangoria@linux.ibm.com>
 <20191108094128.28769-1-ravi.bangoria@linux.ibm.com>
 <20191108110009.GE18723@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108110009.GE18723@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 08, 2019 at 12:00:09PM +0100, Jiri Olsa escreveu:
> On Fri, Nov 08, 2019 at 03:11:28PM +0530, Ravi Bangoria wrote:
> > Perf record with verbose=2 already prints this information along with
> > whole lot of other traces which requires lot of scrolling. Introduce
> > an option to print only perf_event_open() arguments and return value.
> > 
> > Sample o/p:
> >   $ ./perf --debug perf-event-open=1 record -- ls > /dev/null
> >   ------------------------------------------------------------
> >   perf_event_attr:
> >     size                             112
> >     { sample_period, sample_freq }   4000
> >     sample_type                      IP|TID|TIME|PERIOD
> >     read_format                      ID
> >     disabled                         1
> >     inherit                          1
> >     exclude_kernel                   1
> >     mmap                             1
> >     comm                             1
> >     freq                             1
> >     enable_on_exec                   1
> >     task                             1
> >     precise_ip                       3
> >     sample_id_all                    1
> >     exclude_guest                    1
> >     mmap2                            1
> >     comm_exec                        1
> >     ksymbol                          1
> >     bpf_event                        1
> >   ------------------------------------------------------------
> >   sys_perf_event_open: pid 4308  cpu 0  group_fd -1  flags 0x8 = 4
> >   sys_perf_event_open: pid 4308  cpu 1  group_fd -1  flags 0x8 = 5
> >   sys_perf_event_open: pid 4308  cpu 2  group_fd -1  flags 0x8 = 6
> >   sys_perf_event_open: pid 4308  cpu 3  group_fd -1  flags 0x8 = 8
> >   sys_perf_event_open: pid 4308  cpu 4  group_fd -1  flags 0x8 = 9
> >   sys_perf_event_open: pid 4308  cpu 5  group_fd -1  flags 0x8 = 10
> >   sys_perf_event_open: pid 4308  cpu 6  group_fd -1  flags 0x8 = 11
> >   sys_perf_event_open: pid 4308  cpu 7  group_fd -1  flags 0x8 = 12
> >   ------------------------------------------------------------
> >   perf_event_attr:
> >     type                             1
> >     size                             112
> >     config                           0x9
> >     watermark                        1
> >     sample_id_all                    1
> >     bpf_event                        1
> >     { wakeup_events, wakeup_watermark } 1
> >   ------------------------------------------------------------
> >   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> >   sys_perf_event_open failed, error -13
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 0.002 MB perf.data (9 samples) ]
> > 
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > ---
> > v1->v2:
> >  - man page updates.
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

[root@quaco ~]# perf test -v python
18: 'import perf' in python                               :
--- start ---
test child forked, pid 19237
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ImportError: /tmp/build/perf/python/perf.so: undefined symbol: debug_peo_args
test child finished with -1
---- end ----
'import perf' in python: FAILED!
[root@quaco ~]#

Please always test your changes using 'perf test', before and after, to
see if some regression is being added. I'm trying to fix this one.

Thanks,

- Arnaldo

Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC028C17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C05206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+4SAJKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfKKNxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:53:13 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38861 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfKKNxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:53:02 -0500
Received: by mail-qk1-f195.google.com with SMTP id e2so11186406qkn.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 05:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8efeiwGoDhyr7iDbcNRFPVeLGrc7lxxr0ZZhdTh4HRU=;
        b=G+4SAJKnCcXyCUU4uKEreU6xRIXN3lc0XZfTXr3fBu+uq8LQAeS9sUhs2YBpyRJgb6
         JP86j+xJGF46dWSklBKgJmm537Fm2jNkvh2yKdk1uVcx/QC+Nln+o8Uo+FLPdGO7tIew
         KvGucuFv29UPEZ/zgMbPmCrSI6ujdBUeKlHHjwnwJ7vy5/07gmmBi1PiRXsJfA1ZLbeB
         EVfGDYUx9T8ca88fPgHhidC8/MbECB3Y2CRsaOkVV4hpR1QAVgPge+Kkyb686JqO/8G9
         wasa8c7xgFbUOb6oFPHBtuJlTZygdnhW1arykU/X8T8VNQ6MqigI7GYnEeSftIFip265
         ErmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8efeiwGoDhyr7iDbcNRFPVeLGrc7lxxr0ZZhdTh4HRU=;
        b=rG2W+/aP3FOMH9+JtrL4WWU55onh42+jU8lj1OdfMF5jykgbXmXPafmuqAkOxkDNM1
         Uo2U9nJahzrcCS+ndUefW756gn9ZGKyQkeJmt19I6uTuWTCt2ayR5LYGGQELwxs6CncD
         TOifkoiJLKOwquZ8HWnzKhvWHnTy7aK/iZu/5vyZMHfchmL3gBwE8OtdpLkYNNrr1rEY
         MyjQCJEjdOkLJUzcki5Rngz3lZGwsAHxNRC40cdxupKkJDWnG7cYD93O3X0GzjKej4sI
         wWbAU+rVMfkfz74i+dFXz+bCIXyahPmZkGpoPSvGN+8bxQaA7+Vob3FxaRVz58ZEQOeJ
         U6hw==
X-Gm-Message-State: APjAAAW9hI2d//Zli6NRga6HdOi3EwVQfLLzh+v3pDLnidyPGWY3oSza
        EeSn+xBLYngaSsaqX/0pIr8Cj39f
X-Google-Smtp-Source: APXvYqzxH7Pi4pyPVa291gpkGMosTsctj27F1KbO3Vfwn2RDG71G/SqWql6gixGOY7nmqMQLtjO1Lg==
X-Received: by 2002:a05:620a:1404:: with SMTP id d4mr9739306qkj.404.1573480380598;
        Mon, 11 Nov 2019 05:53:00 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id h21sm6544549qkl.13.2019.11.11.05.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 05:52:59 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7FA61411B3; Mon, 11 Nov 2019 10:52:57 -0300 (-03)
Date:   Mon, 11 Nov 2019 10:52:57 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf tool: Provide an option to print perf_event_open
 args and return value
Message-ID: <20191111135257.GA9365@kernel.org>
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

Thanks, tested and applied.

- Arnaldo

Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93758C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6815B217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgtlxgWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbfJNOdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:33:01 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38339 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfJNOdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:33:00 -0400
Received: by mail-qt1-f195.google.com with SMTP id j31so25713619qta.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zOzM+hCj6PP0QQR5NcFofbxu5VpzS8dDzbWm+Rc24Hk=;
        b=XgtlxgWQR9xcOd0JIHs/nYkc1LPxsp4fKSTiUut4TMNys+F2UfeXLwFAF5ryK8vRqs
         +xrcaJt2950ElYGV1vjj3wC+WU5enT0QCEe0UF2SiHc2oZoa5JEmznOw6kCyOuJRc2tn
         DEZX7bmLYrRo+VqpDpTFVwIcsZqQM/QuvGQCBhTwifanApVY+8tkypL/Dk5pnq7r1blN
         JXwE2bjoZsDTxMTkNE2juYHTHqCtt7zl26V6PfRqZN6zAt4M+5WUQEE/LFVCQyca32iI
         2srJ2KrWqgnOcELzD9fSd1mxZKPewE/nHrsI+/OaCygZOv007JQtZRmrxJLwFqVc3oRp
         PsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zOzM+hCj6PP0QQR5NcFofbxu5VpzS8dDzbWm+Rc24Hk=;
        b=Hv2bluq52G2kiBEMD/36tykoFJB/nkFwyQk5JeSLYg7UUfV4A6V/2jn6rQtFbBoC4i
         jyPecIZOeOE8fMTcjlZJ5qTqrIzce77MR8lePcPK9FCRhi5c5g2hS5WBwiqVyzpykkMW
         ckVIj8CeoDdUErDuwGckvhlHs2NR5Ys2VwddzEjK+oClWB6NfUUU5YhRU0AsnHX+7YSf
         zvMUQVzFsib6AxscKrHCNk8huKUevYfBWJ+5sarzanZttjnvkVaQXr8OyPTre/P2vTOD
         8hvx9hevTp8CoaD5Hu9ZVGAnxbPmcUj+ryVoCuI+DEXgww35UFlAXV9TIi8buVTokG7O
         wkMA==
X-Gm-Message-State: APjAAAW+us6LQG2S95tMMHRN9/sVny4K6Q/49dietKUrwQMlZCqhRAg5
        QBIOTQwjGwCqZW3VpuxUEJP/n7hb
X-Google-Smtp-Source: APXvYqy3Ffek5QwcpeRGlTiEALPlezYFxb4mXeelLcY1GtDL5AI/3qx986U2EycyIauhpXL7OlyYFQ==
X-Received: by 2002:ac8:488b:: with SMTP id i11mr30880362qtq.95.1571063579821;
        Mon, 14 Oct 2019 07:32:59 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id d45sm9328165qtc.70.2019.10.14.07.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:32:58 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AF0A74DD66; Mon, 14 Oct 2019 11:32:56 -0300 (-03)
Date:   Mon, 14 Oct 2019 11:32:56 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf data: Fix babeltrace detection
Message-ID: <20191014143256.GL19627@kernel.org>
References: <20191007174120.12330-1-andi@firstfloor.org>
 <20191008115240.GE10009@krava>
 <20191008142143.ts5se4pzwfnfnbsh@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008142143.ts5se4pzwfnfnbsh@two.firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 08, 2019 at 07:21:44AM -0700, Andi Kleen escreveu:
> On Tue, Oct 08, 2019 at 01:52:40PM +0200, Jiri Olsa wrote:
> > On Mon, Oct 07, 2019 at 10:41:20AM -0700, Andi Kleen wrote:
> > > From: Andi Kleen <ak@linux.intel.com>
> > > 
> > > The symbol the feature file checks for is now actually in -lbabeltrace,
> > > not -lbabeltrace-ctf, at least as of libbabeltrace-1.5.6-2.fc30.x86_64
> > > 
> > > Always add both libraries to fix the feature detection.
> > 
> > well, we link with libbabeltrace-ctf.so which links with libbabeltrace.so
> > 
> > I guess we can link it as well, but where do you see it fail?
> 
> On FC30 the .so file is just a symlink, so it doesn't pull
> in the other library.
> 
> $ gcc test-libbabeltrace.c -lbabeltrace-ctf
> /usr/bin/ld:
> /usr/lib/gcc/x86_64-redhat-linux/9/../../../../lib64/libbabeltrace-ctf.so:
> undefined reference to `bt_packet_seek_get_error'
> /usr/bin/ld:
> /usr/lib/gcc/x86_64-redhat-linux/9/../../../../lib64/libbabeltrace-ctf.so:
> undefined reference to `bt_packet_seek_set_error'
> collect2: error: ld returned 1 exit status
> 
> $ ls -l /usr/lib64/libbabeltrace-ctf.so
> lrwxrwxrwx 1 root root 26 Jan 31  2019 /usr/lib64/libbabeltrace-ctf.so
> -> libbabeltrace-ctf.so.1.0.0
> 
> $ rpm -qf /usr/lib64/libbabeltrace-ctf.so
> libbabeltrace-devel-1.5.6-2.fc30.x86_64

I'm not being able to reproduce here, without your patch I get things
working:

[acme@quaco perf]$ ldd ~/bin/perf | grep babel
	libbabeltrace-ctf.so.1 => /lib64/libbabeltrace-ctf.so.1 (0x00007f2396e41000)
	libbabeltrace.so.1 => /lib64/libbabeltrace.so.1 (0x00007f2396dc1000)
[acme@quaco perf]$ ldd /lib64/libbabeltrace-ctf.so.1 | grep babel
	libbabeltrace.so.1 => /lib64/libbabeltrace.so.1 (0x00007f8bffe59000)
[acme@quaco perf]$
[acme@quaco perf]$ rpm -qa | grep babeltrace
libbabeltrace-1.5.6-2.fc30.x86_64
libbabeltrace-devel-1.5.6-2.fc30.x86_64
[acme@quaco perf]$ cat /etc/fedora-release
Fedora release 30 (Thirty)
[acme@quaco perf]$ cat /tmp/build/perf/feature/test-libbabeltrace.make.output
[acme@quaco perf]$ cat /tmp/build/perf/feature/test-libbabeltrace.
test-libbabeltrace.bin          test-libbabeltrace.d            test-libbabeltrace.make.output
[acme@quaco perf]$ ldd /tmp/build/perf/feature/test-libbabeltrace.bin
	linux-vdso.so.1 (0x00007fff5ff7c000)
	libunwind-x86_64.so.8 => /lib64/libunwind-x86_64.so.8 (0x00007f2517979000)
	libunwind.so.8 => /lib64/libunwind.so.8 (0x00007f251795f000)
	liblzma.so.5 => /lib64/liblzma.so.5 (0x00007f2517936000)
	libbabeltrace-ctf.so.1 => /lib64/libbabeltrace-ctf.so.1 (0x00007f25178e0000)
	libc.so.6 => /lib64/libc.so.6 (0x00007f251771a000)
	libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007f2517700000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f25179bc000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f25176dd000)
	libbabeltrace.so.1 => /lib64/libbabeltrace.so.1 (0x00007f25176cd000)
	libdw.so.1 => /lib64/libdw.so.1 (0x00007f2517678000)
	libelf.so.1 => /lib64/libelf.so.1 (0x00007f251765d000)
	libpopt.so.0 => /lib64/libpopt.so.0 (0x00007f251764f000)
	libuuid.so.1 => /lib64/libuuid.so.1 (0x00007f2517645000)
	libgmodule-2.0.so.0 => /lib64/libgmodule-2.0.so.0 (0x00007f251763d000)
	libglib-2.0.so.0 => /lib64/libglib-2.0.so.0 (0x00007f2517519000)
	libdl.so.2 => /lib64/libdl.so.2 (0x00007f2517513000)
	libz.so.1 => /lib64/libz.so.1 (0x00007f25174f9000)
	libbz2.so.1 => /lib64/libbz2.so.1 (0x00007f25174e5000)
	libpcre.so.1 => /lib64/libpcre.so.1 (0x00007f251746f000)
[acme@quaco perf]$

Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1507C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C93620663
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKlFSl0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfHLTnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 15:43:12 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38315 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLTnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 15:43:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id x4so6028442qts.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rB9TabLMT7EbyBpCU9BFNX0wdPGpmubLxWJ1mH2+tmU=;
        b=MKlFSl0Bvz1D79g+w2kWUYBHivFded8EPWy7EgAmddcoXQIL1d7xyQJ9WfAK1H9Bhi
         nc0FBQYYjafCAbDZZ+8xu29yMLZiBG/Witt/oB98LkLywzHMvhUupG3bOFqK8TxeXb/C
         92UdSZgWOrOK59oRBGsfhQAIb75R2BV9UPK/OS8T2yjKPK5t9X/A/fzlbiHyb5yP9765
         KbvT50Bqz2+HvFjKtDRnAcj0ECrmK6pcT6mDlxkl8IGeoknpTeo8Y34yUEcA9UkS0Hoq
         P+RbszOXmhcrpyFM0nYCDbgxI8/sG2CmEecjef4nAgoMrHt441SgCUN/TK1AzP8IoW7A
         kY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rB9TabLMT7EbyBpCU9BFNX0wdPGpmubLxWJ1mH2+tmU=;
        b=UtLfCNEPPkPBDbV9aWtKRxHpkj1jsDmThwAMAOfmvBYagnNXWDg/bmscDqC+x87Dkw
         2wN+R910IZtx7HCU5exxH4OOsRgefR10QYx3j0rnEwIeZDBTiMPHkMgupadZQD4Kv3Af
         9gaCzSMkxrPM4PRCxzcnFxmLJWpMDeLcxmGKOFGC0FARsQmpkpxJMAONtIvQPe/KL8T0
         t5Nt79RptzbAmzM4XPTnz9kj981TXpYSTWpO+efhGT64lrrheIf/UDBzD2XXCZ3Ic9EM
         QmrgTl+q5gwHSfVbSMEKvZeNUlpqCGBr3WGiYvmVHm6cly28GxyIRTs7ttD52r/BhKqN
         EQhw==
X-Gm-Message-State: APjAAAUPgp5H7u16BaaJAQvSU9z8bJ8VGSkvckurZKRNU5+lT/4bU0v/
        2N//UxW8CuMZSGB5iM7SKdU=
X-Google-Smtp-Source: APXvYqz6xxGLaDEBLk0JyrKDskYLYEs6Fi0MPTwRWCHqZ88htbkkUFWE4tcbSFhRZVbyD4pUdaCaYw==
X-Received: by 2002:ac8:225d:: with SMTP id p29mr22481863qtp.259.1565638990551;
        Mon, 12 Aug 2019 12:43:10 -0700 (PDT)
Received: from quaco.ghostprotocols.net (187-26-98-68.3g.claro.net.br. [187.26.98.68])
        by smtp.gmail.com with ESMTPSA id y25sm1469665qtf.83.2019.08.12.12.43.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 12:43:08 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 64B5340340; Mon, 12 Aug 2019 16:43:02 -0300 (-03)
Date:   Mon, 12 Aug 2019 16:43:02 -0300
To:     Igor Lubashev <ilubashe@akamai.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH v3 1/4] perf: Add capability-related utilities
Message-ID: <20190812194302.GD9280@kernel.org>
References: <cover.1565188228.git.ilubashe@akamai.com>
 <8a1e76cf5c7c9796d0d4d240fbaa85305298aafa.1565188228.git.ilubashe@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a1e76cf5c7c9796d0d4d240fbaa85305298aafa.1565188228.git.ilubashe@akamai.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 07, 2019 at 10:44:14AM -0400, Igor Lubashev escreveu:
> Add utilities to help checking capabilities of the running procss.
> Make perf link with libcap, if it is available. If no libcap-dev[el],
> assume no capabilities.

Applied and added the text at the end of this message on the commit log,
I'm also adding NO_LIBCAP=1 to the minimum build in

  make -C tools/perf build-test


I.e.:

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 5363a12a8b9b..70c48475896d 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -108,6 +108,7 @@ make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1
 make_minimal        += NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1
 make_minimal        += NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1
 make_minimal        += NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
+make_minimal        += NO_LIBCAP=1
 
 # $(run) contains all available tests
 run := make_pure

Thanks,

- Arnaldo


Committer testing:

  $ make O=/tmp/build/perf -C tools/perf install-bin
  make: Entering directory '/home/acme/git/perf/tools/perf'
    BUILD:   Doing 'make -j8' parallel build
  
  Auto-detecting system features:
  <SNIP>
  ...                        libbfd: [ on  ]
  ...                        libcap: [ OFF ]
  ...                        libelf: [ on  ]
  <SNIP>
  Makefile.config:833: No libcap found, disables capability support, please install libcap-devel/libcap-dev
  <SNIP>
  $ grep libcap /tmp/build/perf/FEATURE-DUMP 
  feature-libcap=0
  $ cat /tmp/build/perf/feature/test-libcap.make.output 
  test-libcap.c:2:10: fatal error: sys/capability.h: No such file or directory
      2 | #include <sys/capability.h>
        |          ^~~~~~~~~~~~~~~~~~
  compilation terminated.
  $

Now install libcap-devel and try again:

  $ make O=/tmp/build/perf -C tools/perf install-bin
  make: Entering directory '/home/acme/git/perf/tools/perf'
    BUILD:   Doing 'make -j8' parallel build
  Warning: Kernel ABI header at 'tools/include/linux/bits.h' differs from latest version at 'include/linux/bits.h'
  diff -u tools/include/linux/bits.h include/linux/bits.h
  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
  
  Auto-detecting system features:
  ...                         dwarf: [ on  ]
  ...            dwarf_getlocations: [ on  ]
  ...                         glibc: [ on  ]
  ...                          gtk2: [ on  ]
  ...                      libaudit: [ on  ]
  ...                        libbfd: [ on  ]
  ...                        libcap: [ on  ]
  ...                        libelf: [ on  ]
  <SNIP>>
    CC       /tmp/build/perf/jvmti/libjvmti.o
  <SNIP>>
  $ grep libcap /tmp/build/perf/FEATURE-DUMP 
  feature-libcap=1
  $ cat /tmp/build/perf/feature/test-libcap.make.output 
  $ ldd /tmp/build/perf/feature/test-libcap.make.bin
  ldd: /tmp/build/perf/feature/test-libcap.make.bin: No such file or directory
  $ ldd /tmp/build/perf/feature/test-libcap.bin 
  	linux-vdso.so.1 (0x00007ffc35bfe000)
  	libcap.so.2 => /lib64/libcap.so.2 (0x00007ff9c62ff000)
  	libc.so.6 => /lib64/libc.so.6 (0x00007ff9c6139000)
  	/lib64/ld-linux-x86-64.so.2 (0x00007ff9c6326000)
  $
  $ ldd ~/bin/perf | grep libcap
	libcap.so.2 => /lib64/libcap.so.2 (0x00007fe20ea19000)
  $

Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

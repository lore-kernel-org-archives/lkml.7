Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12A0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8986B20659
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vn7SA22k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKLScE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:32:04 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38664 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfKLScE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:32:04 -0500
Received: by mail-qk1-f194.google.com with SMTP id e2so15365269qkn.5;
        Tue, 12 Nov 2019 10:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FyJG1PDCDltsfeRsoooMZspnUJfIOZMxfJSYP9WOtWA=;
        b=Vn7SA22k0wxfbgdM/mYQ/IIbXauZnpvkEtjJTvSVJ6b2EVyLNrZ7F6wvlx/z/UgKJo
         XmenRtqMWWt7I21OW1P3PWaI0gLn/IdKWJDYIeo028ylZphbT5anjxS+HwQYHcGadM8m
         gNdU1ITeMqO4pjRIik5VXLpnr8+kMQEggXjqohlI99yqmZso/7deeWe7LailezcadytO
         40r7qmn6T4Md633VSfsKUf5HghMfJwrb/wofCR9U+v+RTFbMnJQO+YAPIHDTfWDGkZ31
         ew8VYQRgjt+o8HequG+UcSzs6jYYJd/dd1Z2TWMz3aJH9aSU3RhH/uC2JH7XQmHf1OGm
         navg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FyJG1PDCDltsfeRsoooMZspnUJfIOZMxfJSYP9WOtWA=;
        b=hMdAhiDjjeeZGIRAQnDpf8PVht2cVjneF41Vm07xGqKF9xOKEo7/NZcfIN0jKNXvXJ
         M2ztqMIbGq6qoU2L1pjTjxI7tTujTTGjVQeFNPYXPIg4R4tfiThPzhDWlgfjyrHGsc7c
         +lfHBO+xQRif/vzkat/jQWSozgzkMU0lfqOCg58Ke+KwpfSJs+7b/W+GP7RgKXvTZStP
         3pXLfOg19KG3yj4Y3x8XXtgllb0lLIwPCa/7GNqsVnzAF3Pl/6tNt7ca2zKkKo77rr9I
         JEYrJPRgCakM1m9YxCd4el1wVL2kIQYGItDrEtjVy5DB8m6+RazpvVm2Bg1nqutPDAM2
         WKfA==
X-Gm-Message-State: APjAAAVDzDhrZkPUz9hAagWYOMDaSjJl+INKlU6C9KelXKBondxWNLTx
        8oSNo5Sm8mJShBQTiq0+qCc=
X-Google-Smtp-Source: APXvYqwkxV0lO/WDXHkhetG3gYnPo+O6zFDXxlgSw5/ENX0kljN2DHu78/aCM7WfRJNub5AUhRL5oA==
X-Received: by 2002:a05:620a:237:: with SMTP id u23mr6688495qkm.484.1573583520716;
        Tue, 12 Nov 2019 10:32:00 -0800 (PST)
Received: from quaco.ghostprotocols.net ([177.195.211.83])
        by smtp.gmail.com with ESMTPSA id p145sm10008825qke.37.2019.11.12.10.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 10:31:58 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BB36D411B3; Tue, 12 Nov 2019 15:31:53 -0300 (-03)
Date:   Tue, 12 Nov 2019 15:31:53 -0300
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        nd@arm.com, John Garry <john.garry@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kevin Mooney <kevin.mooney@arm.com>
Subject: Re: [PATCH 1/3] perf vendor events arm64: Fix commas so PMU event
 files are valid JSON
Message-ID: <20191112183153.GM9365@kernel.org>
References: <20191112160342.26470-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112160342.26470-1-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 12, 2019 at 04:03:39PM +0000, James Clark escreveu:
> No functional change.
> 
> Add and remove extra commas in the arm64 JSON files so that the files
> can be parsed and validated by other utilities such as Python
> that fail to parse invalid JSON.

Thanks, no mangling now, and I passed all via json_verify, before and
after, all is good now, see:

  https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=da3ef7f6cd5222f5a0289c4eb34254c62629b603

I found it lying around in my machine, required by libvirt:

  $ rpm -qi yajl | grep Description -A5
  Description :
  Yet Another JSON Library. YAJL is a small event-driven
  (SAX-style) JSON parser written in ANSI C, and a small
  validating JSON generator.
  $
  $ rpm -q --whatrequires `rpm -q --provides yajl`
  yajl-2.1.0-12.fc30.x86_64
  raptor2-2.0.15-18.fc30.x86_64
  libvirt-libs-5.1.0-9.fc30.x86_64
  libvirt-daemon-5.1.0-9.fc30.x86_64
  libvirt-daemon-driver-interface-5.1.0-9.fc30.x86_64
 
> Signed-off-by: James Clark <james.clark@arm.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Clark <james.clark@arm.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Kevin Mooney <kevin.mooney@arm.com>
> ---
>  .../arch/arm64/ampere/emag/branch.json        |   8 +-
>  .../arch/arm64/ampere/emag/bus.json           |  14 +-
>  .../arch/arm64/ampere/emag/cache.json         |  28 ++--
>  .../arch/arm64/ampere/emag/clock.json         |   2 +-
>  .../arch/arm64/ampere/emag/exception.json     |  26 +--
>  .../arch/arm64/ampere/emag/instruction.json   |  28 ++--
>  .../arch/arm64/ampere/emag/intrinsic.json     |  10 +-
>  .../arch/arm64/ampere/emag/memory.json        |  12 +-
>  .../arch/arm64/ampere/emag/pipeline.json      |   2 +-
>  .../arch/arm64/arm/cortex-a53/branch.json     |   2 +-
>  .../arch/arm64/arm/cortex-a53/bus.json        |   4 +-
>  .../arch/arm64/arm/cortex-a53/other.json      |   4 +-
>  .../arm/cortex-a57-a72/core-imp-def.json      | 120 ++++++-------
>  .../arch/arm64/armv8-recommended.json         | 158 +++++++++---------
>  .../arm64/cavium/thunderx2/core-imp-def.json  |  74 ++++----
>  .../arm64/hisilicon/hip08/core-imp-def.json   |  60 +++----
>  .../arm64/hisilicon/hip08/uncore-ddrc.json    |  18 +-
>  .../arm64/hisilicon/hip08/uncore-hha.json     |  22 +--
>  .../arm64/hisilicon/hip08/uncore-l3c.json     |  28 ++--
>  19 files changed, 310 insertions(+), 310 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/branch.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/branch.json
> index abc98b018446..2d15b11e5383 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/emag/branch.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/branch.json
> @@ -1,12 +1,12 @@
>  [
>      {
> -        "ArchStdEvent": "BR_IMMED_SPEC",
> +        "ArchStdEvent": "BR_IMMED_SPEC"
>      },
>      {
> -        "ArchStdEvent": "BR_RETURN_SPEC",
> +        "ArchStdEvent": "BR_RETURN_SPEC"
>      },
>      {
> -        "ArchStdEvent": "BR_INDIRECT_SPEC",
> +        "ArchStdEvent": "BR_INDIRECT_SPEC"
>      },
>      {
>          "PublicDescription": "Mispredicted or not predicted branch speculatively executed",
> @@ -19,5 +19,5 @@
>          "EventCode": "0x12",
>          "EventName": "BR_PRED",
>          "BriefDescription": "Predictable branch"
> -    },
> +    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/bus.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/bus.json
> index 687b2629e1d1..5c1a9a922ca4 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/emag/bus.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/bus.json
> @@ -1,26 +1,26 @@
>  [
>      {
> -        "ArchStdEvent": "BUS_ACCESS_RD",
> +        "ArchStdEvent": "BUS_ACCESS_RD"
>      },
>      {
> -        "ArchStdEvent": "BUS_ACCESS_WR",
> +        "ArchStdEvent": "BUS_ACCESS_WR"
>      },
>      {
> -        "ArchStdEvent": "BUS_ACCESS_SHARED",
> +        "ArchStdEvent": "BUS_ACCESS_SHARED"
>      },
>      {
> -        "ArchStdEvent": "BUS_ACCESS_NOT_SHARED",
> +        "ArchStdEvent": "BUS_ACCESS_NOT_SHARED"
>      },
>      {
> -        "ArchStdEvent": "BUS_ACCESS_NORMAL",
> +        "ArchStdEvent": "BUS_ACCESS_NORMAL"
>      },
>      {
> -        "ArchStdEvent": "BUS_ACCESS_PERIPH",
> +        "ArchStdEvent": "BUS_ACCESS_PERIPH"
>      },
>      {
>          "PublicDescription": "Bus access",
>          "EventCode": "0x19",
>          "EventName": "BUS_ACCESS",
>          "BriefDescription": "Bus access"
> -    },
> +    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
> index df9201434cb6..40010a8724b3 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
> @@ -1,42 +1,42 @@
>  [
>      {
> -        "ArchStdEvent": "L1D_CACHE_RD",
> +        "ArchStdEvent": "L1D_CACHE_RD"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_WR",
> +        "ArchStdEvent": "L1D_CACHE_WR"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
> +        "ArchStdEvent": "L1D_CACHE_REFILL_RD"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_INVAL",
> +        "ArchStdEvent": "L1D_CACHE_INVAL"
>      },
>      {
> -        "ArchStdEvent": "L1D_TLB_REFILL_RD",
> +        "ArchStdEvent": "L1D_TLB_REFILL_RD"
>      },
>      {
> -        "ArchStdEvent": "L1D_TLB_REFILL_WR",
> +        "ArchStdEvent": "L1D_TLB_REFILL_WR"
>      },
>      {
> -        "ArchStdEvent": "L2D_CACHE_RD",
> +        "ArchStdEvent": "L2D_CACHE_RD"
>      },
>      {
> -        "ArchStdEvent": "L2D_CACHE_WR",
> +        "ArchStdEvent": "L2D_CACHE_WR"
>      },
>      {
> -        "ArchStdEvent": "L2D_CACHE_REFILL_RD",
> +        "ArchStdEvent": "L2D_CACHE_REFILL_RD"
>      },
>      {
> -        "ArchStdEvent": "L2D_CACHE_REFILL_WR",
> +        "ArchStdEvent": "L2D_CACHE_REFILL_WR"
>      },
>      {
> -        "ArchStdEvent": "L2D_CACHE_WB_VICTIM",
> +        "ArchStdEvent": "L2D_CACHE_WB_VICTIM"
>      },
>      {
> -        "ArchStdEvent": "L2D_CACHE_WB_CLEAN",
> +        "ArchStdEvent": "L2D_CACHE_WB_CLEAN"
>      },
>      {
> -        "ArchStdEvent": "L2D_CACHE_INVAL",
> +        "ArchStdEvent": "L2D_CACHE_INVAL"
>      },
>      {
>          "PublicDescription": "Level 1 instruction cache refill",
> @@ -187,5 +187,5 @@
>          "EventCode": "0x116",
>          "EventName": "PAGE_WALK_L2_STAGE2_HIT",
>          "BriefDescription": "Page walk, L2 stage-2 hit"
> -    },
> +    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/clock.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/clock.json
> index 38cd1f1a70dc..51d1dc1519b2 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/emag/clock.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/clock.json
> @@ -16,5 +16,5 @@
>          "EventCode": "0x110",
>          "EventName": "Wait_CYCLES",
>          "BriefDescription": "Wait state cycle"
> -    },
> +    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/exception.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/exception.json
> index 3720dc28a15f..66e51bc64b22 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/emag/exception.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/exception.json
> @@ -1,39 +1,39 @@
>  [
>      {
> -        "ArchStdEvent": "EXC_UNDEF",
> +        "ArchStdEvent": "EXC_UNDEF"
>      },
>      {
> -        "ArchStdEvent": "EXC_SVC",
> +        "ArchStdEvent": "EXC_SVC"
>      },
>      {
> -        "ArchStdEvent": "EXC_PABORT",
> +        "ArchStdEvent": "EXC_PABORT"
>      },
>      {
> -        "ArchStdEvent": "EXC_DABORT",
> +        "ArchStdEvent": "EXC_DABORT"
>      },
>      {
> -        "ArchStdEvent": "EXC_IRQ",
> +        "ArchStdEvent": "EXC_IRQ"
>      },
>      {
> -        "ArchStdEvent": "EXC_FIQ",
> +        "ArchStdEvent": "EXC_FIQ"
>      },
>      {
> -        "ArchStdEvent": "EXC_HVC",
> +        "ArchStdEvent": "EXC_HVC"
>      },
>      {
> -        "ArchStdEvent": "EXC_TRAP_PABORT",
> +        "ArchStdEvent": "EXC_TRAP_PABORT"
>      },
>      {
> -        "ArchStdEvent": "EXC_TRAP_DABORT",
> +        "ArchStdEvent": "EXC_TRAP_DABORT"
>      },
>      {
> -        "ArchStdEvent": "EXC_TRAP_OTHER",
> +        "ArchStdEvent": "EXC_TRAP_OTHER"
>      },
>      {
> -        "ArchStdEvent": "EXC_TRAP_IRQ",
> +        "ArchStdEvent": "EXC_TRAP_IRQ"
>      },
>      {
> -        "ArchStdEvent": "EXC_TRAP_FIQ",
> +        "ArchStdEvent": "EXC_TRAP_FIQ"
>      },
>      {
>          "PublicDescription": "Exception taken",
> @@ -46,5 +46,5 @@
>          "EventCode": "0x0a",
>          "EventName": "EXC_RETURN",
>          "BriefDescription": "Exception return"
> -    },
> +    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/instruction.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/instruction.json
> index 82cf753e6472..0d3e46776642 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/emag/instruction.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/instruction.json
> @@ -1,42 +1,42 @@
>  [
>      {
> -        "ArchStdEvent": "LD_SPEC",
> +        "ArchStdEvent": "LD_SPEC"
>      },
>      {
> -        "ArchStdEvent": "ST_SPEC",
> +        "ArchStdEvent": "ST_SPEC"
>      },
>      {
> -        "ArchStdEvent": "LDST_SPEC",
> +        "ArchStdEvent": "LDST_SPEC"
>      },
>      {
> -        "ArchStdEvent": "DP_SPEC",
> +        "ArchStdEvent": "DP_SPEC"
>      },
>      {
> -        "ArchStdEvent": "ASE_SPEC",
> +        "ArchStdEvent": "ASE_SPEC"
>      },
>      {
> -        "ArchStdEvent": "VFP_SPEC",
> +        "ArchStdEvent": "VFP_SPEC"
>      },
>      {
> -        "ArchStdEvent": "PC_WRITE_SPEC",
> +        "ArchStdEvent": "PC_WRITE_SPEC"
>      },
>      {
> -        "ArchStdEvent": "CRYPTO_SPEC",
> +        "ArchStdEvent": "CRYPTO_SPEC"
>      },
>      {
> -        "ArchStdEvent": "ISB_SPEC",
> +        "ArchStdEvent": "ISB_SPEC"
>      },
>      {
> -        "ArchStdEvent": "DSB_SPEC",
> +        "ArchStdEvent": "DSB_SPEC"
>      },
>      {
> -        "ArchStdEvent": "DMB_SPEC",
> +        "ArchStdEvent": "DMB_SPEC"
>      },
>      {
> -        "ArchStdEvent": "RC_LD_SPEC",
> +        "ArchStdEvent": "RC_LD_SPEC"
>      },
>      {
> -        "ArchStdEvent": "RC_ST_SPEC",
> +        "ArchStdEvent": "RC_ST_SPEC"
>      },
>      {
>          "PublicDescription": "Instruction architecturally executed, software increment",
> @@ -85,5 +85,5 @@
>          "EventCode": "0x100",
>          "EventName": "NOP_SPEC",
>          "BriefDescription": "Speculatively executed, NOP"
> -    },
> +    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/intrinsic.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/intrinsic.json
> index 2aecc5c2347d..7ecffb989ae0 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/emag/intrinsic.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/intrinsic.json
> @@ -1,14 +1,14 @@
>  [
>      {
> -        "ArchStdEvent": "LDREX_SPEC",
> +        "ArchStdEvent": "LDREX_SPEC"
>      },
>      {
> -        "ArchStdEvent": "STREX_PASS_SPEC",
> +        "ArchStdEvent": "STREX_PASS_SPEC"
>      },
>      {
> -        "ArchStdEvent": "STREX_FAIL_SPEC",
> +        "ArchStdEvent": "STREX_FAIL_SPEC"
>      },
>      {
> -        "ArchStdEvent": "STREX_SPEC",
> -    },
> +        "ArchStdEvent": "STREX_SPEC"
> +    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/memory.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/memory.json
> index 08508697b318..c2fe674df960 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/emag/memory.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/memory.json
> @@ -1,18 +1,18 @@
>  [
>      {
> -        "ArchStdEvent": "MEM_ACCESS_RD",
> +        "ArchStdEvent": "MEM_ACCESS_RD"
>      },
>      {
> -        "ArchStdEvent": "MEM_ACCESS_WR",
> +        "ArchStdEvent": "MEM_ACCESS_WR"
>      },
>      {
> -        "ArchStdEvent": "UNALIGNED_LD_SPEC",
> +        "ArchStdEvent": "UNALIGNED_LD_SPEC"
>      },
>      {
> -        "ArchStdEvent": "UNALIGNED_ST_SPEC",
> +        "ArchStdEvent": "UNALIGNED_ST_SPEC"
>      },
>      {
> -        "ArchStdEvent": "UNALIGNED_LDST_SPEC",
> +        "ArchStdEvent": "UNALIGNED_LDST_SPEC"
>      },
>      {
>          "PublicDescription": "Data memory access",
> @@ -25,5 +25,5 @@
>          "EventCode": "0x1a",
>          "EventName": "MEM_ERROR",
>          "BriefDescription": "Memory error"
> -    },
> +    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/pipeline.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/pipeline.json
> index e2087de586bf..17c71aba6612 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/emag/pipeline.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/pipeline.json
> @@ -46,5 +46,5 @@
>          "EventCode": "0x10f",
>          "EventName": "FX_STALL",
>          "BriefDescription": "FX stalled"
> -    },
> +    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/branch.json
> index 0b0e6b26605b..8f5cf88aaf38 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/branch.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/branch.json
> @@ -1,6 +1,6 @@
>  [
>    {
> -    "ArchStdEvent":  "BR_INDIRECT_SPEC",
> +    "ArchStdEvent":  "BR_INDIRECT_SPEC"
>    },
>    {
>      "EventCode": "0xC9",
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/bus.json
> index ce33b2553277..0a70b82f753f 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/bus.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/bus.json
> @@ -1,8 +1,8 @@
>  [
>    {
> -        "ArchStdEvent": "BUS_ACCESS_RD",
> +        "ArchStdEvent": "BUS_ACCESS_RD"
>    },
>    {
> -        "ArchStdEvent": "BUS_ACCESS_WR",
> +        "ArchStdEvent": "BUS_ACCESS_WR"
>    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/other.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/other.json
> index 6cc6cbd7bf0b..e9f7e4c3900d 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/other.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/other.json
> @@ -1,9 +1,9 @@
>  [
>    {
> -        "ArchStdEvent": "EXC_IRQ",
> +        "ArchStdEvent": "EXC_IRQ"
>    },
>    {
> -        "ArchStdEvent": "EXC_FIQ",
> +        "ArchStdEvent": "EXC_FIQ"
>    },
>    {
>          "EventCode": "0xC6",
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json
> index 0ac9b7927450..543c7692677a 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json
> @@ -1,179 +1,179 @@
>  [
>      {
> -        "ArchStdEvent": "L1D_CACHE_RD",
> +        "ArchStdEvent": "L1D_CACHE_RD"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_WR",
> +        "ArchStdEvent": "L1D_CACHE_WR"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
> +        "ArchStdEvent": "L1D_CACHE_REFILL_RD"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
> +        "ArchStdEvent": "L1D_CACHE_REFILL_WR"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
> +        "ArchStdEvent": "L1D_CACHE_WB_VICTIM"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_WB_CLEAN",
> +        "ArchStdEvent": "L1D_CACHE_WB_CLEAN"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_INVAL",
> +        "ArchStdEvent": "L1D_CACHE_INVAL"
>      },
>      {
> -        "ArchStdEvent": "L1D_TLB_REFILL_RD",
> +        "ArchStdEvent": "L1D_TLB_REFILL_RD"
>      },
>      {
> -        "ArchStdEvent": "L1D_TLB_REFILL_WR",
> +        "ArchStdEvent": "L1D_TLB_REFILL_WR"
>      },
>      {
> -        "ArchStdEvent": "L2D_CACHE_RD",
> +        "ArchStdEvent": "L2D_CACHE_RD"
>      },
>      {
> -        "ArchStdEvent": "L2D_CACHE_WR",
> +        "ArchStdEvent": "L2D_CACHE_WR"
>      },
>      {
> -        "ArchStdEvent": "L2D_CACHE_REFILL_RD",
> +        "ArchStdEvent": "L2D_CACHE_REFILL_RD"
>      },
>      {
> -        "ArchStdEvent": "L2D_CACHE_REFILL_WR",
> +        "ArchStdEvent": "L2D_CACHE_REFILL_WR"
>      },
>      {
> -        "ArchStdEvent": "L2D_CACHE_WB_VICTIM",
> +        "ArchStdEvent": "L2D_CACHE_WB_VICTIM"
>      },
>      {
> -        "ArchStdEvent": "L2D_CACHE_WB_CLEAN",
> +        "ArchStdEvent": "L2D_CACHE_WB_CLEAN"
>      },
>      {
> -        "ArchStdEvent": "L2D_CACHE_INVAL",
> +        "ArchStdEvent": "L2D_CACHE_INVAL"
>      },
>      {
> -        "ArchStdEvent": "BUS_ACCESS_RD",
> +        "ArchStdEvent": "BUS_ACCESS_RD"
>      },
>      {
> -        "ArchStdEvent": "BUS_ACCESS_WR",
> +        "ArchStdEvent": "BUS_ACCESS_WR"
>      },
>      {
> -        "ArchStdEvent": "BUS_ACCESS_SHARED",
> +        "ArchStdEvent": "BUS_ACCESS_SHARED"
>      },
>      {
> -        "ArchStdEvent": "BUS_ACCESS_NOT_SHARED",
> +        "ArchStdEvent": "BUS_ACCESS_NOT_SHARED"
>      },
>      {
> -        "ArchStdEvent": "BUS_ACCESS_NORMAL",
> +        "ArchStdEvent": "BUS_ACCESS_NORMAL"
>      },
>      {
> -        "ArchStdEvent": "BUS_ACCESS_PERIPH",
> +        "ArchStdEvent": "BUS_ACCESS_PERIPH"
>      },
>      {
> -        "ArchStdEvent": "MEM_ACCESS_RD",
> +        "ArchStdEvent": "MEM_ACCESS_RD"
>      },
>      {
> -        "ArchStdEvent": "MEM_ACCESS_WR",
> +        "ArchStdEvent": "MEM_ACCESS_WR"
>      },
>      {
> -        "ArchStdEvent": "UNALIGNED_LD_SPEC",
> +        "ArchStdEvent": "UNALIGNED_LD_SPEC"
>      },
>      {
> -        "ArchStdEvent": "UNALIGNED_ST_SPEC",
> +        "ArchStdEvent": "UNALIGNED_ST_SPEC"
>      },
>      {
> -        "ArchStdEvent": "UNALIGNED_LDST_SPEC",
> +        "ArchStdEvent": "UNALIGNED_LDST_SPEC"
>      },
>      {
> -        "ArchStdEvent": "LDREX_SPEC",
> +        "ArchStdEvent": "LDREX_SPEC"
>      },
>      {
> -        "ArchStdEvent": "STREX_PASS_SPEC",
> +        "ArchStdEvent": "STREX_PASS_SPEC"
>      },
>      {
> -        "ArchStdEvent": "STREX_FAIL_SPEC",
> +        "ArchStdEvent": "STREX_FAIL_SPEC"
>      },
>      {
> -        "ArchStdEvent": "LD_SPEC",
> +        "ArchStdEvent": "LD_SPEC"
>      },
>      {
> -        "ArchStdEvent": "ST_SPEC",
> +        "ArchStdEvent": "ST_SPEC"
>      },
>      {
> -        "ArchStdEvent": "LDST_SPEC",
> +        "ArchStdEvent": "LDST_SPEC"
>      },
>      {
> -        "ArchStdEvent": "DP_SPEC",
> +        "ArchStdEvent": "DP_SPEC"
>      },
>      {
> -        "ArchStdEvent": "ASE_SPEC",
> +        "ArchStdEvent": "ASE_SPEC"
>      },
>      {
> -        "ArchStdEvent": "VFP_SPEC",
> +        "ArchStdEvent": "VFP_SPEC"
>      },
>      {
> -        "ArchStdEvent": "PC_WRITE_SPEC",
> +        "ArchStdEvent": "PC_WRITE_SPEC"
>      },
>      {
> -        "ArchStdEvent": "CRYPTO_SPEC",
> +        "ArchStdEvent": "CRYPTO_SPEC"
>      },
>      {
> -        "ArchStdEvent": "BR_IMMED_SPEC",
> +        "ArchStdEvent": "BR_IMMED_SPEC"
>      },
>      {
> -        "ArchStdEvent": "BR_RETURN_SPEC",
> +        "ArchStdEvent": "BR_RETURN_SPEC"
>      },
>      {
> -        "ArchStdEvent": "BR_INDIRECT_SPEC",
> +        "ArchStdEvent": "BR_INDIRECT_SPEC"
>      },
>      {
> -        "ArchStdEvent": "ISB_SPEC",
> +        "ArchStdEvent": "ISB_SPEC"
>      },
>      {
> -        "ArchStdEvent": "DSB_SPEC",
> +        "ArchStdEvent": "DSB_SPEC"
>      },
>      {
> -        "ArchStdEvent": "DMB_SPEC",
> +        "ArchStdEvent": "DMB_SPEC"
>      },
>      {
> -        "ArchStdEvent": "EXC_UNDEF",
> +        "ArchStdEvent": "EXC_UNDEF"
>      },
>      {
> -        "ArchStdEvent": "EXC_SVC",
> +        "ArchStdEvent": "EXC_SVC"
>      },
>      {
> -        "ArchStdEvent": "EXC_PABORT",
> +        "ArchStdEvent": "EXC_PABORT"
>      },
>      {
> -        "ArchStdEvent": "EXC_DABORT",
> +        "ArchStdEvent": "EXC_DABORT"
>      },
>      {
> -        "ArchStdEvent": "EXC_IRQ",
> +        "ArchStdEvent": "EXC_IRQ"
>      },
>      {
> -        "ArchStdEvent": "EXC_FIQ",
> +        "ArchStdEvent": "EXC_FIQ"
>      },
>      {
> -        "ArchStdEvent": "EXC_SMC",
> +        "ArchStdEvent": "EXC_SMC"
>      },
>      {
> -        "ArchStdEvent": "EXC_HVC",
> +        "ArchStdEvent": "EXC_HVC"
>      },
>      {
> -        "ArchStdEvent": "EXC_TRAP_PABORT",
> +        "ArchStdEvent": "EXC_TRAP_PABORT"
>      },
>      {
> -        "ArchStdEvent": "EXC_TRAP_DABORT",
> +        "ArchStdEvent": "EXC_TRAP_DABORT"
>      },
>      {
> -        "ArchStdEvent": "EXC_TRAP_OTHER",
> +        "ArchStdEvent": "EXC_TRAP_OTHER"
>      },
>      {
> -        "ArchStdEvent": "EXC_TRAP_IRQ",
> +        "ArchStdEvent": "EXC_TRAP_IRQ"
>      },
>      {
> -        "ArchStdEvent": "EXC_TRAP_FIQ",
> +        "ArchStdEvent": "EXC_TRAP_FIQ"
>      },
>      {
> -        "ArchStdEvent": "RC_LD_SPEC",
> +        "ArchStdEvent": "RC_LD_SPEC"
>      },
>      {
> -        "ArchStdEvent": "RC_ST_SPEC",
> -    },
> +        "ArchStdEvent": "RC_ST_SPEC"
> +    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/arm64/armv8-recommended.json b/tools/perf/pmu-events/arch/arm64/armv8-recommended.json
> index 6328828c018c..d0a19866563d 100644
> --- a/tools/perf/pmu-events/arch/arm64/armv8-recommended.json
> +++ b/tools/perf/pmu-events/arch/arm64/armv8-recommended.json
> @@ -154,297 +154,297 @@
>          "EventCode": "0x61",
>          "EventName": "BUS_ACCESS_WR",
>          "BriefDescription": "Bus access write"
> -   }
> +   },
>     {
>          "PublicDescription": "Bus access, Normal, Cacheable, Shareable",
>          "EventCode": "0x62",
>          "EventName": "BUS_ACCESS_SHARED",
>          "BriefDescription": "Bus access, Normal, Cacheable, Shareable"
> -   }
> +   },
>     {
>          "PublicDescription": "Bus access, not Normal, Cacheable, Shareable",
>          "EventCode": "0x63",
>          "EventName": "BUS_ACCESS_NOT_SHARED",
>          "BriefDescription": "Bus access, not Normal, Cacheable, Shareable"
> -   }
> +   },
>     {
>          "PublicDescription": "Bus access, Normal",
>          "EventCode": "0x64",
>          "EventName": "BUS_ACCESS_NORMAL",
>          "BriefDescription": "Bus access, Normal"
> -   }
> +   },
>     {
>          "PublicDescription": "Bus access, peripheral",
>          "EventCode": "0x65",
>          "EventName": "BUS_ACCESS_PERIPH",
>          "BriefDescription": "Bus access, peripheral"
> -   }
> +   },
>     {
>          "PublicDescription": "Data memory access, read",
>          "EventCode": "0x66",
>          "EventName": "MEM_ACCESS_RD",
>          "BriefDescription": "Data memory access, read"
> -   }
> +   },
>     {
>          "PublicDescription": "Data memory access, write",
>          "EventCode": "0x67",
>          "EventName": "MEM_ACCESS_WR",
>          "BriefDescription": "Data memory access, write"
> -   }
> +   },
>     {
>          "PublicDescription": "Unaligned access, read",
>          "EventCode": "0x68",
>          "EventName": "UNALIGNED_LD_SPEC",
>          "BriefDescription": "Unaligned access, read"
> -   }
> +   },
>     {
>          "PublicDescription": "Unaligned access, write",
>          "EventCode": "0x69",
>          "EventName": "UNALIGNED_ST_SPEC",
>          "BriefDescription": "Unaligned access, write"
> -   }
> +   },
>     {
>          "PublicDescription": "Unaligned access",
>          "EventCode": "0x6a",
>          "EventName": "UNALIGNED_LDST_SPEC",
>          "BriefDescription": "Unaligned access"
> -   }
> +   },
>     {
>          "PublicDescription": "Exclusive operation speculatively executed, LDREX or LDX",
>          "EventCode": "0x6c",
>          "EventName": "LDREX_SPEC",
>          "BriefDescription": "Exclusive operation speculatively executed, LDREX or LDX"
> -   }
> +   },
>     {
>          "PublicDescription": "Exclusive operation speculatively executed, STREX or STX pass",
>          "EventCode": "0x6d",
>          "EventName": "STREX_PASS_SPEC",
>          "BriefDescription": "Exclusive operation speculatively executed, STREX or STX pass"
> -   }
> +   },
>     {
>          "PublicDescription": "Exclusive operation speculatively executed, STREX or STX fail",
>          "EventCode": "0x6e",
>          "EventName": "STREX_FAIL_SPEC",
>          "BriefDescription": "Exclusive operation speculatively executed, STREX or STX fail"
> -   }
> +   },
>     {
>          "PublicDescription": "Exclusive operation speculatively executed, STREX or STX",
>          "EventCode": "0x6f",
>          "EventName": "STREX_SPEC",
>          "BriefDescription": "Exclusive operation speculatively executed, STREX or STX"
> -   }
> +   },
>     {
>          "PublicDescription": "Operation speculatively executed, load",
>          "EventCode": "0x70",
>          "EventName": "LD_SPEC",
>          "BriefDescription": "Operation speculatively executed, load"
> -   }
> +   },
>     {
> -        "PublicDescription": "Operation speculatively executed, store"
> +        "PublicDescription": "Operation speculatively executed, store",
>          "EventCode": "0x71",
>          "EventName": "ST_SPEC",
>          "BriefDescription": "Operation speculatively executed, store"
> -   }
> +   },
>     {
>          "PublicDescription": "Operation speculatively executed, load or store",
>          "EventCode": "0x72",
>          "EventName": "LDST_SPEC",
>          "BriefDescription": "Operation speculatively executed, load or store"
> -   }
> +   },
>     {
>          "PublicDescription": "Operation speculatively executed, integer data processing",
>          "EventCode": "0x73",
>          "EventName": "DP_SPEC",
>          "BriefDescription": "Operation speculatively executed, integer data processing"
> -   }
> +   },
>     {
>          "PublicDescription": "Operation speculatively executed, Advanced SIMD instruction",
>          "EventCode": "0x74",
>          "EventName": "ASE_SPEC",
> -        "BriefDescription": "Operation speculatively executed, Advanced SIMD instruction",
> -   }
> +        "BriefDescription": "Operation speculatively executed, Advanced SIMD instruction"
> +   },
>     {
>          "PublicDescription": "Operation speculatively executed, floating-point instruction",
>          "EventCode": "0x75",
>          "EventName": "VFP_SPEC",
>          "BriefDescription": "Operation speculatively executed, floating-point instruction"
> -   }
> +   },
>     {
>          "PublicDescription": "Operation speculatively executed, software change of the PC",
>          "EventCode": "0x76",
>          "EventName": "PC_WRITE_SPEC",
>          "BriefDescription": "Operation speculatively executed, software change of the PC"
> -   }
> +   },
>     {
>          "PublicDescription": "Operation speculatively executed, Cryptographic instruction",
>          "EventCode": "0x77",
>          "EventName": "CRYPTO_SPEC",
>          "BriefDescription": "Operation speculatively executed, Cryptographic instruction"
> -   }
> +   },
>     {
> -        "PublicDescription": "Branch speculatively executed, immediate branch"
> +        "PublicDescription": "Branch speculatively executed, immediate branch",
>          "EventCode": "0x78",
>          "EventName": "BR_IMMED_SPEC",
>          "BriefDescription": "Branch speculatively executed, immediate branch"
> -   }
> +   },
>     {
> -        "PublicDescription": "Branch speculatively executed, procedure return"
> +        "PublicDescription": "Branch speculatively executed, procedure return",
>          "EventCode": "0x79",
>          "EventName": "BR_RETURN_SPEC",
>          "BriefDescription": "Branch speculatively executed, procedure return"
> -   }
> +   },
>     {
> -        "PublicDescription": "Branch speculatively executed, indirect branch"
> +        "PublicDescription": "Branch speculatively executed, indirect branch",
>          "EventCode": "0x7a",
>          "EventName": "BR_INDIRECT_SPEC",
>          "BriefDescription": "Branch speculatively executed, indirect branch"
> -   }
> +   },
>     {
> -        "PublicDescription": "Barrier speculatively executed, ISB"
> +        "PublicDescription": "Barrier speculatively executed, ISB",
>          "EventCode": "0x7c",
>          "EventName": "ISB_SPEC",
>          "BriefDescription": "Barrier speculatively executed, ISB"
> -   }
> +   },
>     {
> -        "PublicDescription": "Barrier speculatively executed, DSB"
> +        "PublicDescription": "Barrier speculatively executed, DSB",
>          "EventCode": "0x7d",
>          "EventName": "DSB_SPEC",
>          "BriefDescription": "Barrier speculatively executed, DSB"
> -   }
> +   },
>     {
> -        "PublicDescription": "Barrier speculatively executed, DMB"
> +        "PublicDescription": "Barrier speculatively executed, DMB",
>          "EventCode": "0x7e",
>          "EventName": "DMB_SPEC",
>          "BriefDescription": "Barrier speculatively executed, DMB"
> -   }
> +   },
>     {
> -        "PublicDescription": "Exception taken, Other synchronous"
> +        "PublicDescription": "Exception taken, Other synchronous",
>          "EventCode": "0x81",
>          "EventName": "EXC_UNDEF",
>          "BriefDescription": "Exception taken, Other synchronous"
> -   }
> +   },
>     {
> -        "PublicDescription": "Exception taken, Supervisor Call"
> +        "PublicDescription": "Exception taken, Supervisor Call",
>          "EventCode": "0x82",
>          "EventName": "EXC_SVC",
>          "BriefDescription": "Exception taken, Supervisor Call"
> -   }
> +   },
>     {
> -        "PublicDescription": "Exception taken, Instruction Abort"
> +        "PublicDescription": "Exception taken, Instruction Abort",
>          "EventCode": "0x83",
>          "EventName": "EXC_PABORT",
>          "BriefDescription": "Exception taken, Instruction Abort"
> -   }
> +   },
>     {
> -        "PublicDescription": "Exception taken, Data Abort and SError"
> +        "PublicDescription": "Exception taken, Data Abort and SError",
>          "EventCode": "0x84",
>          "EventName": "EXC_DABORT",
>          "BriefDescription": "Exception taken, Data Abort and SError"
> -   }
> +   },
>     {
> -        "PublicDescription": "Exception taken, IRQ"
> +        "PublicDescription": "Exception taken, IRQ",
>          "EventCode": "0x86",
>          "EventName": "EXC_IRQ",
>          "BriefDescription": "Exception taken, IRQ"
> -   }
> +   },
>     {
> -        "PublicDescription": "Exception taken, FIQ"
> +        "PublicDescription": "Exception taken, FIQ",
>          "EventCode": "0x87",
>          "EventName": "EXC_FIQ",
>          "BriefDescription": "Exception taken, FIQ"
> -   }
> +   },
>     {
> -        "PublicDescription": "Exception taken, Secure Monitor Call"
> +        "PublicDescription": "Exception taken, Secure Monitor Call",
>          "EventCode": "0x88",
>          "EventName": "EXC_SMC",
>          "BriefDescription": "Exception taken, Secure Monitor Call"
> -   }
> +   },
>     {
> -        "PublicDescription": "Exception taken, Hypervisor Call"
> +        "PublicDescription": "Exception taken, Hypervisor Call",
>          "EventCode": "0x8a",
>          "EventName": "EXC_HVC",
>          "BriefDescription": "Exception taken, Hypervisor Call"
> -   }
> +   },
>     {
> -        "PublicDescription": "Exception taken, Instruction Abort not taken locally"
> +        "PublicDescription": "Exception taken, Instruction Abort not taken locally",
>          "EventCode": "0x8b",
>          "EventName": "EXC_TRAP_PABORT",
>          "BriefDescription": "Exception taken, Instruction Abort not taken locally"
> -   }
> +   },
>     {
> -        "PublicDescription": "Exception taken, Data Abort or SError not taken locally"
> +        "PublicDescription": "Exception taken, Data Abort or SError not taken locally",
>          "EventCode": "0x8c",
>          "EventName": "EXC_TRAP_DABORT",
>          "BriefDescription": "Exception taken, Data Abort or SError not taken locally"
> -   }
> +   },
>     {
> -        "PublicDescription": "Exception taken, Other traps not taken locally"
> +        "PublicDescription": "Exception taken, Other traps not taken locally",
>          "EventCode": "0x8d",
>          "EventName": "EXC_TRAP_OTHER",
>          "BriefDescription": "Exception taken, Other traps not taken locally"
> -   }
> +   },
>     {
> -        "PublicDescription": "Exception taken, IRQ not taken locally"
> +        "PublicDescription": "Exception taken, IRQ not taken locally",
>          "EventCode": "0x8e",
>          "EventName": "EXC_TRAP_IRQ",
>          "BriefDescription": "Exception taken, IRQ not taken locally"
> -   }
> +   },
>     {
> -        "PublicDescription": "Exception taken, FIQ not taken locally"
> +        "PublicDescription": "Exception taken, FIQ not taken locally",
>          "EventCode": "0x8f",
>          "EventName": "EXC_TRAP_FIQ",
>          "BriefDescription": "Exception taken, FIQ not taken locally"
> -   }
> +   },
>     {
> -        "PublicDescription": "Release consistency operation speculatively executed, Load-Acquire"
> +        "PublicDescription": "Release consistency operation speculatively executed, Load-Acquire",
>          "EventCode": "0x90",
>          "EventName": "RC_LD_SPEC",
>          "BriefDescription": "Release consistency operation speculatively executed, Load-Acquire"
> -   }
> +   },
>     {
> -        "PublicDescription": "Release consistency operation speculatively executed, Store-Release"
> +        "PublicDescription": "Release consistency operation speculatively executed, Store-Release",
>          "EventCode": "0x91",
>          "EventName": "RC_ST_SPEC",
>          "BriefDescription": "Release consistency operation speculatively executed, Store-Release"
> -   }
> +   },
>     {
> -        "PublicDescription": "Attributable Level 3 data or unified cache access, read"
> +        "PublicDescription": "Attributable Level 3 data or unified cache access, read",
>          "EventCode": "0xa0",
>          "EventName": "L3D_CACHE_RD",
>          "BriefDescription": "Attributable Level 3 data or unified cache access, read"
> -   }
> +   },
>     {
> -        "PublicDescription": "Attributable Level 3 data or unified cache access, write"
> +        "PublicDescription": "Attributable Level 3 data or unified cache access, write",
>          "EventCode": "0xa1",
>          "EventName": "L3D_CACHE_WR",
>          "BriefDescription": "Attributable Level 3 data or unified cache access, write"
> -   }
> +   },
>     {
> -        "PublicDescription": "Attributable Level 3 data or unified cache refill, read"
> +        "PublicDescription": "Attributable Level 3 data or unified cache refill, read",
>          "EventCode": "0xa2",
>          "EventName": "L3D_CACHE_REFILL_RD",
>          "BriefDescription": "Attributable Level 3 data or unified cache refill, read"
> -   }
> +   },
>     {
> -        "PublicDescription": "Attributable Level 3 data or unified cache refill, write"
> +        "PublicDescription": "Attributable Level 3 data or unified cache refill, write",
>          "EventCode": "0xa3",
>          "EventName": "L3D_CACHE_REFILL_WR",
>          "BriefDescription": "Attributable Level 3 data or unified cache refill, write"
> -   }
> +   },
>     {
> -        "PublicDescription": "Attributable Level 3 data or unified cache Write-Back, victim"
> +        "PublicDescription": "Attributable Level 3 data or unified cache Write-Back, victim",
>          "EventCode": "0xa6",
>          "EventName": "L3D_CACHE_WB_VICTIM",
>          "BriefDescription": "Attributable Level 3 data or unified cache Write-Back, victim"
> -   }
> +   },
>     {
> -        "PublicDescription": "Attributable Level 3 data or unified cache Write-Back, cache clean"
> +        "PublicDescription": "Attributable Level 3 data or unified cache Write-Back, cache clean",
>          "EventCode": "0xa7",
>          "EventName": "L3D_CACHE_WB_CLEAN",
>          "BriefDescription": "Attributable Level 3 data or unified cache Write-Back, cache clean"
> -   }
> +   },
>     {
> -        "PublicDescription": "Attributable Level 3 data or unified cache access, invalidate"
> +        "PublicDescription": "Attributable Level 3 data or unified cache access, invalidate",
>          "EventCode": "0xa8",
>          "EventName": "L3D_CACHE_INVAL",
>          "BriefDescription": "Attributable Level 3 data or unified cache access, invalidate"
> diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
> index 752e47eb6977..3a87d351cc39 100644
> --- a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
> +++ b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
> @@ -1,113 +1,113 @@
>  [
>      {
> -        "ArchStdEvent": "L1D_CACHE_RD",
> +        "ArchStdEvent": "L1D_CACHE_RD"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_WR",
> +        "ArchStdEvent": "L1D_CACHE_WR"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
> +        "ArchStdEvent": "L1D_CACHE_REFILL_RD"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
> +        "ArchStdEvent": "L1D_CACHE_REFILL_WR"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_REFILL_INNER",
> +        "ArchStdEvent": "L1D_CACHE_REFILL_INNER"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER",
> +        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
> +        "ArchStdEvent": "L1D_CACHE_WB_VICTIM"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_WB_CLEAN",
> +        "ArchStdEvent": "L1D_CACHE_WB_CLEAN"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_INVAL",
> +        "ArchStdEvent": "L1D_CACHE_INVAL"
>      },
>      {
> -        "ArchStdEvent": "L1D_TLB_REFILL_RD",
> +        "ArchStdEvent": "L1D_TLB_REFILL_RD"
>      },
>      {
> -        "ArchStdEvent": "L1D_TLB_REFILL_WR",
> +        "ArchStdEvent": "L1D_TLB_REFILL_WR"
>      },
>      {
> -        "ArchStdEvent": "L1D_TLB_RD",
> +        "ArchStdEvent": "L1D_TLB_RD"
>      },
>      {
> -        "ArchStdEvent": "L1D_TLB_WR",
> +        "ArchStdEvent": "L1D_TLB_WR"
>      },
>      {
> -        "ArchStdEvent": "L2D_TLB_REFILL_RD",
> +        "ArchStdEvent": "L2D_TLB_REFILL_RD"
>      },
>      {
> -        "ArchStdEvent": "L2D_TLB_REFILL_WR",
> +        "ArchStdEvent": "L2D_TLB_REFILL_WR"
>      },
>      {
> -        "ArchStdEvent": "L2D_TLB_RD",
> +        "ArchStdEvent": "L2D_TLB_RD"
>      },
>      {
> -        "ArchStdEvent": "L2D_TLB_WR",
> +        "ArchStdEvent": "L2D_TLB_WR"
>      },
>      {
> -        "ArchStdEvent": "BUS_ACCESS_RD",
> +        "ArchStdEvent": "BUS_ACCESS_RD"
>      },
>      {
> -        "ArchStdEvent": "BUS_ACCESS_WR",
> +        "ArchStdEvent": "BUS_ACCESS_WR"
>      },
>      {
> -        "ArchStdEvent": "MEM_ACCESS_RD",
> +        "ArchStdEvent": "MEM_ACCESS_RD"
>      },
>      {
> -        "ArchStdEvent": "MEM_ACCESS_WR",
> +        "ArchStdEvent": "MEM_ACCESS_WR"
>      },
>      {
> -        "ArchStdEvent": "UNALIGNED_LD_SPEC",
> +        "ArchStdEvent": "UNALIGNED_LD_SPEC"
>      },
>      {
> -        "ArchStdEvent": "UNALIGNED_ST_SPEC",
> +        "ArchStdEvent": "UNALIGNED_ST_SPEC"
>      },
>      {
> -        "ArchStdEvent": "UNALIGNED_LDST_SPEC",
> +        "ArchStdEvent": "UNALIGNED_LDST_SPEC"
>      },
>      {
> -        "ArchStdEvent": "EXC_UNDEF",
> +        "ArchStdEvent": "EXC_UNDEF"
>      },
>      {
> -        "ArchStdEvent": "EXC_SVC",
> +        "ArchStdEvent": "EXC_SVC"
>      },
>      {
> -        "ArchStdEvent": "EXC_PABORT",
> +        "ArchStdEvent": "EXC_PABORT"
>      },
>      {
> -        "ArchStdEvent": "EXC_DABORT",
> +        "ArchStdEvent": "EXC_DABORT"
>      },
>      {
> -        "ArchStdEvent": "EXC_IRQ",
> +        "ArchStdEvent": "EXC_IRQ"
>      },
>      {
> -        "ArchStdEvent": "EXC_FIQ",
> +        "ArchStdEvent": "EXC_FIQ"
>      },
>      {
> -        "ArchStdEvent": "EXC_SMC",
> +        "ArchStdEvent": "EXC_SMC"
>      },
>      {
> -        "ArchStdEvent": "EXC_HVC",
> +        "ArchStdEvent": "EXC_HVC"
>      },
>      {
> -        "ArchStdEvent": "EXC_TRAP_PABORT",
> +        "ArchStdEvent": "EXC_TRAP_PABORT"
>      },
>      {
> -        "ArchStdEvent": "EXC_TRAP_DABORT",
> +        "ArchStdEvent": "EXC_TRAP_DABORT"
>      },
>      {
> -        "ArchStdEvent": "EXC_TRAP_OTHER",
> +        "ArchStdEvent": "EXC_TRAP_OTHER"
>      },
>      {
> -        "ArchStdEvent": "EXC_TRAP_IRQ",
> +        "ArchStdEvent": "EXC_TRAP_IRQ"
>      },
>      {
> -        "ArchStdEvent": "EXC_TRAP_FIQ",
> +        "ArchStdEvent": "EXC_TRAP_FIQ"
>      }
>  ]
> diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
> index 9f0f15d15f75..a4a6408639b4 100644
> --- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
> +++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
> @@ -1,122 +1,122 @@
>  [
>      {
> -        "ArchStdEvent": "L1D_CACHE_RD",
> +        "ArchStdEvent": "L1D_CACHE_RD"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_WR",
> +        "ArchStdEvent": "L1D_CACHE_WR"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
> +        "ArchStdEvent": "L1D_CACHE_REFILL_RD"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
> +        "ArchStdEvent": "L1D_CACHE_REFILL_WR"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
> +        "ArchStdEvent": "L1D_CACHE_WB_VICTIM"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_WB_CLEAN",
> +        "ArchStdEvent": "L1D_CACHE_WB_CLEAN"
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_INVAL",
> +        "ArchStdEvent": "L1D_CACHE_INVAL"
>      },
>      {
> -        "ArchStdEvent": "L1D_TLB_REFILL_RD",
> +        "ArchStdEvent": "L1D_TLB_REFILL_RD"
>      },
>      {
> -        "ArchStdEvent": "L1D_TLB_REFILL_WR",
> +        "ArchStdEvent": "L1D_TLB_REFILL_WR"
>      },
>      {
> -        "ArchStdEvent": "L1D_TLB_RD",
> +        "ArchStdEvent": "L1D_TLB_RD"
>      },
>      {
> -        "ArchStdEvent": "L1D_TLB_WR",
> +        "ArchStdEvent": "L1D_TLB_WR"
>      },
>      {
> -        "ArchStdEvent": "L2D_CACHE_RD",
> +        "ArchStdEvent": "L2D_CACHE_RD"
>      },
>      {
> -        "ArchStdEvent": "L2D_CACHE_WR",
> +        "ArchStdEvent": "L2D_CACHE_WR"
>      },
>      {
> -        "ArchStdEvent": "L2D_CACHE_REFILL_RD",
> +        "ArchStdEvent": "L2D_CACHE_REFILL_RD"
>      },
>      {
> -        "ArchStdEvent": "L2D_CACHE_REFILL_WR",
> +        "ArchStdEvent": "L2D_CACHE_REFILL_WR"
>      },
>      {
> -        "ArchStdEvent": "L2D_CACHE_WB_VICTIM",
> +        "ArchStdEvent": "L2D_CACHE_WB_VICTIM"
>      },
>      {
> -        "ArchStdEvent": "L2D_CACHE_WB_CLEAN",
> +        "ArchStdEvent": "L2D_CACHE_WB_CLEAN"
>      },
>      {
> -        "ArchStdEvent": "L2D_CACHE_INVAL",
> +        "ArchStdEvent": "L2D_CACHE_INVAL"
>      },
>      {
>          "PublicDescription": "Level 1 instruction cache prefetch access count",
>          "EventCode": "0x102e",
>          "EventName": "L1I_CACHE_PRF",
> -        "BriefDescription": "L1I cache prefetch access count",
> +        "BriefDescription": "L1I cache prefetch access count"
>      },
>      {
>          "PublicDescription": "Level 1 instruction cache miss due to prefetch access count",
>          "EventCode": "0x102f",
>          "EventName": "L1I_CACHE_PRF_REFILL",
> -        "BriefDescription": "L1I cache miss due to prefetch access count",
> +        "BriefDescription": "L1I cache miss due to prefetch access count"
>      },
>      {
>          "PublicDescription": "Instruction queue is empty",
>          "EventCode": "0x1043",
>          "EventName": "IQ_IS_EMPTY",
> -        "BriefDescription": "Instruction queue is empty",
> +        "BriefDescription": "Instruction queue is empty"
>      },
>      {
>          "PublicDescription": "Instruction fetch stall cycles",
>          "EventCode": "0x1044",
>          "EventName": "IF_IS_STALL",
> -        "BriefDescription": "Instruction fetch stall cycles",
> +        "BriefDescription": "Instruction fetch stall cycles"
>      },
>      {
>          "PublicDescription": "Instructions can receive, but not send",
>          "EventCode": "0x2014",
>          "EventName": "FETCH_BUBBLE",
> -        "BriefDescription": "Instructions can receive, but not send",
> +        "BriefDescription": "Instructions can receive, but not send"
>      },
>      {
>          "PublicDescription": "Prefetch request from LSU",
>          "EventCode": "0x6013",
>          "EventName": "PRF_REQ",
> -        "BriefDescription": "Prefetch request from LSU",
> +        "BriefDescription": "Prefetch request from LSU"
>      },
>      {
>          "PublicDescription": "Hit on prefetched data",
>          "EventCode": "0x6014",
>          "EventName": "HIT_ON_PRF",
> -        "BriefDescription": "Hit on prefetched data",
> +        "BriefDescription": "Hit on prefetched data"
>      },
>      {
>          "PublicDescription": "Cycles of that the number of issuing micro operations are less than 4",
>          "EventCode": "0x7001",
>          "EventName": "EXE_STALL_CYCLE",
> -        "BriefDescription": "Cycles of that the number of issue ups are less than 4",
> +        "BriefDescription": "Cycles of that the number of issue ups are less than 4"
>      },
>      {
>          "PublicDescription": "No any micro operation is issued and meanwhile any load operation is not resolved",
>          "EventCode": "0x7004",
>          "EventName": "MEM_STALL_ANYLOAD",
> -        "BriefDescription": "No any micro operation is issued and meanwhile any load operation is not resolved",
> +        "BriefDescription": "No any micro operation is issued and meanwhile any load operation is not resolved"
>      },
>      {
>          "PublicDescription": "No any micro operation is issued and meanwhile there is any load operation missing L1 cache and pending data refill",
>          "EventCode": "0x7006",
>          "EventName": "MEM_STALL_L1MISS",
> -        "BriefDescription": "No any micro operation is issued and meanwhile there is any load operation missing L1 cache and pending data refill",
> +        "BriefDescription": "No any micro operation is issued and meanwhile there is any load operation missing L1 cache and pending data refill"
>      },
>      {
>          "PublicDescription": "No any micro operation is issued and meanwhile there is any load operation missing both L1 and L2 cache and pending data refill from L3 cache",
>          "EventCode": "0x7007",
>          "EventName": "MEM_STALL_L2MISS",
> -        "BriefDescription": "No any micro operation is issued and meanwhile there is any load operation missing both L1 and L2 cache and pending data refill from L3 cache",
> -    },
> +        "BriefDescription": "No any micro operation is issued and meanwhile there is any load operation missing both L1 and L2 cache and pending data refill from L3 cache"
> +    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
> index 7da86942dae2..61514d38601b 100644
> --- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
> +++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
> @@ -4,55 +4,55 @@
>  	    "EventName": "uncore_hisi_ddrc.flux_wr",
>  	    "BriefDescription": "DDRC total write operations",
>  	    "PublicDescription": "DDRC total write operations",
> -	    "Unit": "hisi_sccl,ddrc",
> +	    "Unit": "hisi_sccl,ddrc"
>     },
>     {
>  	    "EventCode": "0x01",
>  	    "EventName": "uncore_hisi_ddrc.flux_rd",
>  	    "BriefDescription": "DDRC total read operations",
>  	    "PublicDescription": "DDRC total read operations",
> -	    "Unit": "hisi_sccl,ddrc",
> +	    "Unit": "hisi_sccl,ddrc"
>     },
>     {
>  	    "EventCode": "0x02",
>  	    "EventName": "uncore_hisi_ddrc.flux_wcmd",
>  	    "BriefDescription": "DDRC write commands",
>  	    "PublicDescription": "DDRC write commands",
> -	    "Unit": "hisi_sccl,ddrc",
> +	    "Unit": "hisi_sccl,ddrc"
>     },
>     {
>  	    "EventCode": "0x03",
>  	    "EventName": "uncore_hisi_ddrc.flux_rcmd",
>  	    "BriefDescription": "DDRC read commands",
>  	    "PublicDescription": "DDRC read commands",
> -	    "Unit": "hisi_sccl,ddrc",
> +	    "Unit": "hisi_sccl,ddrc"
>     },
>     {
>  	    "EventCode": "0x04",
>  	    "EventName": "uncore_hisi_ddrc.pre_cmd",
>  	    "BriefDescription": "DDRC precharge commands",
>  	    "PublicDescription": "DDRC precharge commands",
> -	    "Unit": "hisi_sccl,ddrc",
> +	    "Unit": "hisi_sccl,ddrc"
>     },
>     {
>  	    "EventCode": "0x05",
>  	    "EventName": "uncore_hisi_ddrc.act_cmd",
>  	    "BriefDescription": "DDRC active commands",
>  	    "PublicDescription": "DDRC active commands",
> -	    "Unit": "hisi_sccl,ddrc",
> +	    "Unit": "hisi_sccl,ddrc"
>     },
>     {
>  	    "EventCode": "0x06",
>  	    "EventName": "uncore_hisi_ddrc.rnk_chg",
>  	    "BriefDescription": "DDRC rank commands",
>  	    "PublicDescription": "DDRC rank commands",
> -	    "Unit": "hisi_sccl,ddrc",
> +	    "Unit": "hisi_sccl,ddrc"
>     },
>     {
>  	    "EventCode": "0x07",
>  	    "EventName": "uncore_hisi_ddrc.rw_chg",
>  	    "BriefDescription": "DDRC read and write changes",
>  	    "PublicDescription": "DDRC read and write changes",
> -	    "Unit": "hisi_sccl,ddrc",
> -   },
> +	    "Unit": "hisi_sccl,ddrc"
> +   }
>  ]
> diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
> index 3be418a248ea..ada86782933f 100644
> --- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
> +++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
> @@ -4,69 +4,69 @@
>  	    "EventName": "uncore_hisi_hha.rx_ops_num",
>  	    "BriefDescription": "The number of all operations received by the HHA",
>  	    "PublicDescription": "The number of all operations received by the HHA",
> -	    "Unit": "hisi_sccl,hha",
> +	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "EventCode": "0x01",
>  	    "EventName": "uncore_hisi_hha.rx_outer",
>  	    "BriefDescription": "The number of all operations received by the HHA from another socket",
>  	    "PublicDescription": "The number of all operations received by the HHA from another socket",
> -	    "Unit": "hisi_sccl,hha",
> +	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "EventCode": "0x02",
>  	    "EventName": "uncore_hisi_hha.rx_sccl",
>  	    "BriefDescription": "The number of all operations received by the HHA from another SCCL in this socket",
>  	    "PublicDescription": "The number of all operations received by the HHA from another SCCL in this socket",
> -	    "Unit": "hisi_sccl,hha",
> +	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "EventCode": "0x03",
>  	    "EventName": "uncore_hisi_hha.rx_ccix",
>  	    "BriefDescription": "Count of the number of operations that HHA has received from CCIX",
>  	    "PublicDescription": "Count of the number of operations that HHA has received from CCIX",
> -	    "Unit": "hisi_sccl,hha",
> +	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "EventCode": "0x1c",
>  	    "EventName": "uncore_hisi_hha.rd_ddr_64b",
>  	    "BriefDescription": "The number of read operations sent by HHA to DDRC which size is 64 bytes",
>  	    "PublicDescription": "The number of read operations sent by HHA to DDRC which size is 64bytes",
> -	    "Unit": "hisi_sccl,hha",
> +	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "EventCode": "0x1d",
>  	    "EventName": "uncore_hisi_hha.wr_ddr_64b",
>  	    "BriefDescription": "The number of write operations sent by HHA to DDRC which size is 64 bytes",
>  	    "PublicDescription": "The number of write operations sent by HHA to DDRC which size is 64 bytes",
> -	    "Unit": "hisi_sccl,hha",
> +	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "EventCode": "0x1e",
>  	    "EventName": "uncore_hisi_hha.rd_ddr_128b",
>  	    "BriefDescription": "The number of read operations sent by HHA to DDRC which size is 128 bytes",
>  	    "PublicDescription": "The number of read operations sent by HHA to DDRC which size is 128 bytes",
> -	    "Unit": "hisi_sccl,hha",
> +	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "EventCode": "0x1f",
>  	    "EventName": "uncore_hisi_hha.wr_ddr_128b",
>  	    "BriefDescription": "The number of write operations sent by HHA to DDRC which size is 128 bytes",
>  	    "PublicDescription": "The number of write operations sent by HHA to DDRC which size is 128 bytes",
> -	    "Unit": "hisi_sccl,hha",
> +	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "EventCode": "0x20",
>  	    "EventName": "uncore_hisi_hha.spill_num",
>  	    "BriefDescription": "Count of the number of spill operations that the HHA has sent",
>  	    "PublicDescription": "Count of the number of spill operations that the HHA has sent",
> -	    "Unit": "hisi_sccl,hha",
> +	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "EventCode": "0x21",
>  	    "EventName": "uncore_hisi_hha.spill_success",
>  	    "BriefDescription": "Count of the number of successful spill operations that the HHA has sent",
>  	    "PublicDescription": "Count of the number of successful spill operations that the HHA has sent",
> -	    "Unit": "hisi_sccl,hha",
> -   },
> +	    "Unit": "hisi_sccl,hha"
> +   }
>  ]
> diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
> index f463d0acfaef..67ab19e8cf3a 100644
> --- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
> +++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
> @@ -4,90 +4,90 @@
>  	    "EventName": "uncore_hisi_l3c.rd_cpipe",
>  	    "BriefDescription": "Total read accesses",
>  	    "PublicDescription": "Total read accesses",
> -	    "Unit": "hisi_sccl,l3c",
> +	    "Unit": "hisi_sccl,l3c"
>     },
>     {
>  	    "EventCode": "0x01",
>  	    "EventName": "uncore_hisi_l3c.wr_cpipe",
>  	    "BriefDescription": "Total write accesses",
>  	    "PublicDescription": "Total write accesses",
> -	    "Unit": "hisi_sccl,l3c",
> +	    "Unit": "hisi_sccl,l3c"
>     },
>     {
>  	    "EventCode": "0x02",
>  	    "EventName": "uncore_hisi_l3c.rd_hit_cpipe",
>  	    "BriefDescription": "Total read hits",
>  	    "PublicDescription": "Total read hits",
> -	    "Unit": "hisi_sccl,l3c",
> +	    "Unit": "hisi_sccl,l3c"
>     },
>     {
>  	    "EventCode": "0x03",
>  	    "EventName": "uncore_hisi_l3c.wr_hit_cpipe",
>  	    "BriefDescription": "Total write hits",
>  	    "PublicDescription": "Total write hits",
> -	    "Unit": "hisi_sccl,l3c",
> +	    "Unit": "hisi_sccl,l3c"
>     },
>     {
>  	    "EventCode": "0x04",
>  	    "EventName": "uncore_hisi_l3c.victim_num",
>  	    "BriefDescription": "l3c precharge commands",
>  	    "PublicDescription": "l3c precharge commands",
> -	    "Unit": "hisi_sccl,l3c",
> +	    "Unit": "hisi_sccl,l3c"
>     },
>     {
>  	    "EventCode": "0x20",
>  	    "EventName": "uncore_hisi_l3c.rd_spipe",
>  	    "BriefDescription": "Count of the number of read lines that come from this cluster of CPU core in spipe",
>  	    "PublicDescription": "Count of the number of read lines that come from this cluster of CPU core in spipe",
> -	    "Unit": "hisi_sccl,l3c",
> +	    "Unit": "hisi_sccl,l3c"
>     },
>     {
>  	    "EventCode": "0x21",
>  	    "EventName": "uncore_hisi_l3c.wr_spipe",
>  	    "BriefDescription": "Count of the number of write lines that come from this cluster of CPU core in spipe",
>  	    "PublicDescription": "Count of the number of write lines that come from this cluster of CPU core in spipe",
> -	    "Unit": "hisi_sccl,l3c",
> +	    "Unit": "hisi_sccl,l3c"
>     },
>     {
>  	    "EventCode": "0x22",
>  	    "EventName": "uncore_hisi_l3c.rd_hit_spipe",
>  	    "BriefDescription": "Count of the number of read lines that hits in spipe of this L3C",
>  	    "PublicDescription": "Count of the number of read lines that hits in spipe of this L3C",
> -	    "Unit": "hisi_sccl,l3c",
> +	    "Unit": "hisi_sccl,l3c"
>     },
>     {
>  	    "EventCode": "0x23",
>  	    "EventName": "uncore_hisi_l3c.wr_hit_spipe",
>  	    "BriefDescription": "Count of the number of write lines that hits in spipe of this L3C",
>  	    "PublicDescription": "Count of the number of write lines that hits in spipe of this L3C",
> -	    "Unit": "hisi_sccl,l3c",
> +	    "Unit": "hisi_sccl,l3c"
>     },
>     {
>  	    "EventCode": "0x29",
>  	    "EventName": "uncore_hisi_l3c.back_invalid",
>  	    "BriefDescription": "Count of the number of L3C back invalid operations",
>  	    "PublicDescription": "Count of the number of L3C back invalid operations",
> -	    "Unit": "hisi_sccl,l3c",
> +	    "Unit": "hisi_sccl,l3c"
>     },
>     {
>  	    "EventCode": "0x40",
>  	    "EventName": "uncore_hisi_l3c.retry_cpu",
>  	    "BriefDescription": "Count of the number of retry that L3C suppresses the CPU operations",
>  	    "PublicDescription": "Count of the number of retry that L3C suppresses the CPU operations",
> -	    "Unit": "hisi_sccl,l3c",
> +	    "Unit": "hisi_sccl,l3c"
>     },
>     {
>  	    "EventCode": "0x41",
>  	    "EventName": "uncore_hisi_l3c.retry_ring",
>  	    "BriefDescription": "Count of the number of retry that L3C suppresses the ring operations",
>  	    "PublicDescription": "Count of the number of retry that L3C suppresses the ring operations",
> -	    "Unit": "hisi_sccl,l3c",
> +	    "Unit": "hisi_sccl,l3c"
>     },
>     {
>  	    "EventCode": "0x42",
>  	    "EventName": "uncore_hisi_l3c.prefetch_drop",
>  	    "BriefDescription": "Count of the number of prefetch drops from this L3C",
>  	    "PublicDescription": "Count of the number of prefetch drops from this L3C",
> -	    "Unit": "hisi_sccl,l3c",
> -   },
> +	    "Unit": "hisi_sccl,l3c"
> +   }
>  ]
> -- 
> 2.23.0

-- 

- Arnaldo

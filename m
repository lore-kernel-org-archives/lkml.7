Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2A5C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 04:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFDE2075D
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 04:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eLk428HU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfI1EjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 00:39:12 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40542 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfI1EjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 00:39:12 -0400
Received: by mail-io1-f67.google.com with SMTP id h144so22357406iof.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 21:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rbRLrePd745uUQO1OgkG0ITX19watITISzXEVZhuFt8=;
        b=eLk428HUQguzTDWuEcR2L6hhWjHRnE/KExpbaeJApRbwRZbJIPmxZWzrryqJQKHG84
         7Qdb0tfQjL9FaatcilD0lugv6okoRmxS61gxI8yGsfbWClIHOEpaA5pIXNlcxCp2wgrq
         puXae/C8jJaZPkd5u7rOgp24XiGBimZQcty0jmldYAa2w9uoE1dKljro3L4+1IwmiiKp
         /Vkb06lGVCg5kSwO8dIMVAxT3beko1nGJSgR6fRQu83MgvHs27ntSe0urR+5UENGObbB
         SlyDO1VMglOCvgfXCfKtG9UkFlfoskxzT9GIqQKaaE7gp8dkOKRIxNhswtw5nlBI7kUy
         7S+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbRLrePd745uUQO1OgkG0ITX19watITISzXEVZhuFt8=;
        b=HZDMpVY2HN4mrjbz5IJ6IkqvwQn6cahTq7jJmRV5pg1gb9ytyYUILb1kcagNjXX9uN
         TLo6MgYUUlOXYEwZ4oB+P+Yj4tXtFW7Le2sI0Q+3JjO5LQjQnf+VUD9hSiCMfxAglf0Z
         qKlnx6PSRVybf/ucsBW5AqWZ/s68Bh+7ps3zOCxicBoYTiNyHcsuNsafL/CZjur8v2e6
         EQdcwkVT6xcOfG5PcUK4zGEiDsjaKwcr0LHf++xke8zAjSYpExA0jw/MY0P3TVZxAZdn
         Iim6Jwpr3gfhfKZ3rINXzO0aIRbe1c7RFOjRULcBW9h4tYuzoOHPjO1TPfU8x1y5AUa1
         ED9A==
X-Gm-Message-State: APjAAAXy35e37vFrKlQcUyu5um9DlvyRnzmruWSjNkFo34U2lZwd8M2y
        4p9hbUYW35Yr03fG0V8hg99eILGa9DbGHAicZtYPng==
X-Google-Smtp-Source: APXvYqzbrAG9hIPK98l8ElB0KEkf8J940FbGfS8ObLqdofDIxiJbNHDPAxTiFXKzsbRacRUkDbOWAeT7R6MLUpFKszI=
X-Received: by 2002:a05:6602:2241:: with SMTP id o1mr11249291ioo.129.1569645551405;
 Fri, 27 Sep 2019 21:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <BN8PR21MB1362F63CDE7AC69736FC7F9EF7800@BN8PR21MB1362.namprd21.prod.outlook.com>
In-Reply-To: <BN8PR21MB1362F63CDE7AC69736FC7F9EF7800@BN8PR21MB1362.namprd21.prod.outlook.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 27 Sep 2019 21:39:00 -0700
Message-ID: <CABPqkBTVso=2bo1EkYETXBOk_g1ykiZdHcQmt9uew5JECQzEBw@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf docs: Correct and clarify jitdump spec
To:     Steve MacLean <Steve.MacLean@microsoft.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        John Keeping <john@metanate.com>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Leo Yan <leo.yan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Robbins <brianrob@microsoft.com>,
        Tom McDonald <Thomas.McDonald@microsoft.com>,
        John Salem <josalem@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 6:53 PM Steve MacLean
<Steve.MacLean@microsoft.com> wrote:
>
> Specification claims latest version of jitdump file format is 2. Current
> jit dump reading code treats 1 as the latest version.
>
> Correct spec to match code.
>
> The original language made it unclear the value to be written in the magic
> field.
>
> Revise language that the writer always writes the same value. Specify that
> the reader uses the value to detect endian mismatches.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Steve MacLean <Steve.MacLean@Microsoft.com>

Corrections are valid.

Acked-by: Stephane Eranian <eranian@google.com>

> ---
>  tools/perf/Documentation/jitdump-specification.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/Documentation/jitdump-specification.txt b/tools/perf/Documentation/jitdump-specification.txt
> index 4c62b07..52152d1 100644
> --- a/tools/perf/Documentation/jitdump-specification.txt
> +++ b/tools/perf/Documentation/jitdump-specification.txt
> @@ -36,8 +36,8 @@ III/ Jitdump file header format
>  Each jitdump file starts with a fixed size header containing the following fields in order:
>
>
> -* uint32_t magic     : a magic number tagging the file type. The value is 4-byte long and represents the string "JiTD" in ASCII form. It is 0x4A695444 or 0x4454694a depending on the endianness. The field can be used to detect the endianness of the file
> -* uint32_t version   : a 4-byte value representing the format version. It is currently set to 2
> +* uint32_t magic     : a magic number tagging the file type. The value is 4-byte long and represents the string "JiTD" in ASCII form. It written is as 0x4A695444. The reader will detect an endian mismatch when it reads 0x4454694a.
> +* uint32_t version   : a 4-byte value representing the format version. It is currently set to 1
>  * uint32_t total_size: size in bytes of file header
>  * uint32_t elf_mach  : ELF architecture encoding (ELF e_machine value as specified in /usr/include/elf.h)
>  * uint32_t pad1      : padding. Reserved for future use
> --
> 2.7.4
>

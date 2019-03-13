Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70074C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C2F2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552487407;
	bh=WxCoh3/Zwj0u1M4rzUiIbIW6lK0BNxsjKCOZBUJggrQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=r1DTW0WpcRGqJ9w8w6aZhjDbqbq6SnGDgftEIpRGrWrLCCD/f2CxYCkRkJFbRBCtH
	 mFFaXOfYdz8wA+7D/ke9kfqvdJDdYYkXm01G7ovphIVuqH7WbAuqirC8JV115R7FAw
	 mdZAFPBheopdHjSu7kX3vGrFMFsdKFTlk7pGvUaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfCMOaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:30:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34999 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMOaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:30:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id t18so2257743wrx.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 07:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pj/5Ah2gba8heXTnd4O6BtfFDTc51WqCFu9jCZywzTk=;
        b=IsI3ZHDEDtoWElQkEyxQ/gTWoBbE1+HsHl4UeLdA3/fEEpiM+/u6zyBr6+RpKraU0H
         m6VspCuOBZppBjDorKj7T41wNmhkpFbL9lUAAIh2TKpmve91aWIScYWFq9fNus3Po5Tj
         7PRxfma+TqcJ2vXoyb4YyKh1DoMV+IDBppX/B3Av3E7oSt88flb+LKRdIdf7xIqLvkvQ
         obAzP6rf1rNf5RutZlcT/ixU9uArSgezNbQmYU2YUhRPfrX77BTPGH140O8ZPdKtEE32
         4uIAUQP5c85fPpwExJreTcdkq4FW7zQ95FS3eRirPXUPVhRYtnHEzO0eROqqkGV/dn5C
         Tz1w==
X-Gm-Message-State: APjAAAWTeFxsKsjAa1oLaYRufdrYhXMft2AB9pPVixz6mMXgPE96FlS4
        hPrHL4rr3cDMWHewG11/Nd+HG+oMpti1/hwOlalo3w==
X-Google-Smtp-Source: APXvYqzkS9hInl5Dyebh1QIwN8wDUPFzAdKsKHw0xjULBKHw63UntOgIoV5XfLQtafRBH5HI7Am+G5qfBFhBk2XVMWw=
X-Received: by 2002:a5d:4887:: with SMTP id g7mr21341667wrq.51.1552487402561;
 Wed, 13 Mar 2019 07:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190310153026.8661-1-jolsa@kernel.org>
In-Reply-To: <20190310153026.8661-1-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 13 Mar 2019 23:29:51 +0900
Message-ID: <CAM9d7chND4RwmsS3Bf24KKp320myqZ6B6ZfaCGRZ1LM0dAp+9A@mail.gmail.com>
Subject: Re: [PATCHv6 0/5] perf record: Add support to store data in directory
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 12:30 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> this patchset adds the --dir option to record command (and all
> the other record command that overload cmd_record) that allows
> the data to be stored in directory with multiple data files.
>
> It's next step for multiple threads implementation in record.
> It's now possible to make directory data via --dir option, like:
>
>   $ perf record --dir perf bench sched messaging
>   $ ls -l perf.data
>   total 344
>   -rw-------. 1 jolsa jolsa 43864 Jan 20 22:26 data.0
>   -rw-------. 1 jolsa jolsa 30464 Jan 20 22:26 data.1
>   -rw-------. 1 jolsa jolsa 53816 Jan 20 22:26 data.2
>   -rw-------. 1 jolsa jolsa 30368 Jan 20 22:26 data.3
>   -rw-------. 1 jolsa jolsa 40088 Jan 20 22:26 data.4
>   -rw-------. 1 jolsa jolsa 42592 Jan 20 22:26 data.5
>   -rw-------. 1 jolsa jolsa 56136 Jan 20 22:26 data.6
>   -rw-------. 1 jolsa jolsa 25992 Jan 20 22:26 data.7
>   -rw-------. 1 jolsa jolsa  8832 Jan 20 22:26 header
>
> There's a data file created for every cpu and it's storing
> data for those cpu maps. The report command will read it
> transparently, sort it and display as single file data.
>
> There's new DIR_FORMAT feature to describe directory data
> layout/format. In future we can describe different data files
> layout according to special needs.
>
> It's possible to transform directory data into standard
> perf.data file via simple inject command:
>
>   $ perf inject -o perf.data.file -i perf.data
>
> The old perf fails over the directory data with following message:
>   $ perf report
>   incompatible file format (rerun with -v to learn more)
>
> I'm now testing the record threads support, so I'd like to
> have some agreement on the directory data support before.
>
> v6 changes:
>   - rebased to latest Arnaldo's perf/core
>   - some of the patches already taken
>   - adding comments to __perf_session__process_dir_events
>
> v5 changes:
>   - rebased to latest Arnaldo's perf/core
>
> v4 changes:
>   - some of the patches already taken
>   - removing up perf.data directory on perf_data__open
>     error path
>
> v3 changes:
>   - add rm_rf_perf_data to safely remove file/directory perf data
>   - allocation fix in perf_data__create_dir
>
> v2 changes:
>   - rm_rf changes are already accepted with requested changes
>   - updated doc/man plus adding perf.data-directory-format.txt
>     to describe directory format/layout
>   - the --switch-output options now works over directory data
>   - data rollback is not part of this patchset, updated my TODO though ;-)
>   - added --output-dir option to combine -o and --dir
>   - added DIR_FORMAT feature to describe directory data
>   - disabling directory output for aio for now
>
> It's also available in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/dir
>

It seems I'm too late, but anyway for the series

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks for the work!
Namhyung



> Jiri Olsa (5):
>       perf session: Add __perf_session__process_dir_events function
>       perf session: Add path to reader object
>       perf record: Add --dir option to store data in directory
>       perf record: Add --output-dir option to store data in directory
>       perf record: Describe perf.data directory format
>
>  tools/lib/subcmd/parse-options.h                        |   4 ++++
>  tools/perf/Documentation/perf-record.txt                |   6 ++++++
>  tools/perf/Documentation/perf.data-directory-format.txt |  54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/builtin-record.c                             |  93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
>  tools/perf/util/mmap.h                                  |  23 ++++++++++++-----------
>  tools/perf/util/session.c                               | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  6 files changed, 272 insertions(+), 22 deletions(-)
>  create mode 100644 tools/perf/Documentation/perf.data-directory-format.txt

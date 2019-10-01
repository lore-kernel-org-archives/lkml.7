Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1040FECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADAB21D79
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uPm0zeEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfJASp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:45:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40352 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfJASp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:45:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so8681982pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 11:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AANP1N4bUBK1vRju7io+6B8tIATeh783y4OIZvIm+Y4=;
        b=uPm0zeEg0jebg8iIPrYc7aUikU2B95vbJqR5ieJCagztLzAANuY/dFzEKiIkgWAXiD
         vSM9vmFn2kE0yI5DZ7P+6Zq2wYszUFIPDeq4ciEOrqEpDhaLIUnsqir6z75zxa+MIlTg
         mvCvZkOk/4zTUwvanzQiCWPqgkSms5yN0CPZCvIwVWyMvgtfgfW6ypTX9pBrwPw3knna
         lLAMmg2+I8X25NSdT1gXHGjZWFBiZ/3DutrxPSm/yMij3S/mgI84mH++C+vGYkVnsewu
         x3NgH3CyZlJDObzhL9VFhLsUs52eXNthWWWJbNYXDqN2bsl8SujvwQNLQtcjDiLP5hlx
         595A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=AANP1N4bUBK1vRju7io+6B8tIATeh783y4OIZvIm+Y4=;
        b=EnJTWXBmrjoo26fDXVFJJs9T2/M3PY+thkeSYUR6DrLMz/cyL6ALY/rT/1F3U6tl0w
         xzFZ+PJapLqYmwC9TKHRga5+MWPz9lO48W9s97fzhaDv7Fwz/u8mw2p5HXvIA9bCTiXO
         nxDYhcTVdAUyMiNybpewnYDW4b0f+Z7Pr8gmTCoqubIIm7wKYZGKYLJmCPGWtpVDMk5K
         E9U+cVC3z4hlalb21RytSDj+CnnWqsqeoFLV1KBqcQEfQtR3FM/P237oeV7evlT42lLO
         9lFoxqROTxUKrNf3SBfS9Z1rnZGXg08futj3DOh9xdFlVRpTlZFi2yZhxDCrcLRATkCw
         8Fkg==
X-Gm-Message-State: APjAAAU384UW1J/1Zyr/2BKh0PJW9u/QhnbLnZE76iVoVHJQwGP30KxT
        2SFB8mF6GnPUqpBBRwDJ2ECctQ==
X-Google-Smtp-Source: APXvYqzbM4D6bCcL02KSG5aQv7AP4WvuqIoxT0J92FGC3zucprRUqiQOLm7bEti8jpAOXxfZtWer6Q==
X-Received: by 2002:a17:90a:25a9:: with SMTP id k38mr7478006pje.12.1569955526920;
        Tue, 01 Oct 2019 11:45:26 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:765b:31cb:30c4:166])
        by smtp.gmail.com with ESMTPSA id i16sm19193189pfa.184.2019.10.01.11.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 11:45:25 -0700 (PDT)
Date:   Tue, 1 Oct 2019 11:45:21 -0700
From:   Eric Biggers <ebiggers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 07/24] tools headers uapi: Sync linux/fs.h with the
 kernel sources
Message-ID: <20191001184521.GA15756@google.com>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20191001111216.7208-1-acme@kernel.org>
 <20191001111216.7208-8-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001111216.7208-8-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 08:11:59AM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> To pick the changes from:
> 
>   78a1b96bcf7a ("fscrypt: add FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS ioctl")
>   23c688b54016 ("fscrypt: allow unprivileged users to add/remove keys for v2 policies")
>   5dae460c2292 ("fscrypt: v2 encryption policy support")
>   5a7e29924dac ("fscrypt: add FS_IOC_GET_ENCRYPTION_KEY_STATUS ioctl")
>   b1c0ec3599f4 ("fscrypt: add FS_IOC_REMOVE_ENCRYPTION_KEY ioctl")
>   22d94f493bfb ("fscrypt: add FS_IOC_ADD_ENCRYPTION_KEY ioctl")
>   3b6df59bc4d2 ("fscrypt: use FSCRYPT_* definitions, not FS_*")
>   2336d0deb2d4 ("fscrypt: use FSCRYPT_ prefix for uapi constants")
>   7af0ab0d3aab ("fs, fscrypt: move uapi definitions to new header <linux/fscrypt.h>")
> 
> That don't trigger any changes in tooling, as it so far is used only
> for:
> 
>   $ grep -l 'fs\.h' tools/perf/trace/beauty/*.sh | xargs grep regex=
>   tools/perf/trace/beauty/rename_flags.sh:regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+RENAME_([[:alnum:]_]+)[[:space:]]+\(1[[:space:]]*<<[[:space:]]*([[:xdigit:]]+)[[:space:]]*\)[[:space:]]*.*'
>   tools/perf/trace/beauty/sync_file_range.sh:regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+SYNC_FILE_RANGE_([[:alnum:]_]+)[[:space:]]+([[:xdigit:]]+)[[:space:]]*.*'
>   tools/perf/trace/beauty/usbdevfs_ioctl.sh:regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)(\(\w+\))?[[:space:]]+_IO[CWR]{0,2}\([[:space:]]*(_IOC_\w+,[[:space:]]*)?'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
>   tools/perf/trace/beauty/usbdevfs_ioctl.sh:regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)[[:space:]]+_IO[WR]{0,2}\([[:space:]]*'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
>   $
> 
> This silences this perf build warning:
> 
>   Warning: Kernel ABI header at 'tools/include/uapi/linux/fs.h' differs from latest version at 'include/uapi/linux/fs.h'
>   diff -u tools/include/uapi/linux/fs.h include/uapi/linux/fs.h
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Eric Biggers <ebiggers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lkml.kernel.org/n/tip-44g48exl9br9ba0t64chqb4i@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

What's the reason why you don't just use the include/uapi/ headers directly?

- Eric

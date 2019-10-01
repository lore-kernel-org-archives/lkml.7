Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7CFC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBF82190F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohbZDLnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfJAS5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:57:51 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37176 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfJAS5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:57:51 -0400
Received: by mail-qt1-f193.google.com with SMTP id l3so23008045qtr.4;
        Tue, 01 Oct 2019 11:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C0CqVlj1moGxN14sdD84N2iUwftu1KTuF6RkzEs7mEA=;
        b=ohbZDLnhGAaE4PepoC2SCPmETAfQNU7dtFJRcr4GnU4kvBYFzPbKcsmkgZwNxkMlkE
         qdZS2H6uqE1n3l9GectESztY2xm6U/x8H3g7jihAZxie4UQz9/jE7MilYu7a7AWwakMs
         3CuX8j1/crlg/8sVQv9h+1q2nDWcx7MBFdIIJSQ/iFn8K2vdYaaB+WmNubyoYB244Ltm
         zP5LfCPw5nZXGn36qC2eXh/xM+l4b7UsKcN5fuZh0o+vSVJztNCfT39Wc3UiD2qkZEBX
         dErfm3TGVsguF8B7n7lGNkbWiUp3tMZKXB2eNgQKmTLmVa2FhSH5FWOJdfTJzd0RJdSM
         RnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C0CqVlj1moGxN14sdD84N2iUwftu1KTuF6RkzEs7mEA=;
        b=UcgWWOnVqFGn5bGeBa9TK+C2iQH/oOpvz0MbJA8Fg4vfrLw71wjT7L53HcdOG9iBzm
         4G0BVm7h+x9r+2ZDCfuyHrN2SVNMWbGGAF1p3ObpFQD+ZcCe03n5Lo0YgQQnxZ+QesB4
         FZzuvztJd+3qpYCsR4cJsk4P8zfOj76zvaPmMb0tGl+8tWDMz/qR5PFITi5mCSrwhsP5
         zybcRD3w+UbOLFRfjanm6rvMFeF0BDb6dM0+ZFi4I0NwXT2uHUw4AYAaj7b7JjyxalKD
         BImIB/yKr6x/QMm5DjbyyNlbowA64bqOmLse/EODm6Ax3YnJNMbd9Pxs8RXMzKOgDZVz
         rZww==
X-Gm-Message-State: APjAAAUuIL2eLqqMRK9S77BcAlvpgTkXhYHK3uZkCf8HOSaUvOfjkSzp
        fAF6JT6s9syMmvpoWYWIGoI=
X-Google-Smtp-Source: APXvYqwIS2icBZtYJocvs58tna7l7EPUt9hjWWfLAE3/CcvgwSctz1yfo703HgfSL3Wiy5WJJJWaEQ==
X-Received: by 2002:ac8:342a:: with SMTP id u39mr32044971qtb.7.1569956268754;
        Tue, 01 Oct 2019 11:57:48 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-185-49.3g.claro.net.br. [179.240.185.49])
        by smtp.gmail.com with ESMTPSA id 63sm8248631qkh.82.2019.10.01.11.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 11:57:46 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 67F4A40DA4; Tue,  1 Oct 2019 15:57:41 -0300 (-03)
Date:   Tue, 1 Oct 2019 15:57:41 -0300
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 07/24] tools headers uapi: Sync linux/fs.h with the
 kernel sources
Message-ID: <20191001185741.GD13904@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
 <20191001111216.7208-8-acme@kernel.org>
 <20191001184521.GA15756@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001184521.GA15756@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 01, 2019 at 11:45:21AM -0700, Eric Biggers escreveu:
> On Tue, Oct 01, 2019 at 08:11:59AM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > To pick the changes from:
> > 
> >   78a1b96bcf7a ("fscrypt: add FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS ioctl")
> >   23c688b54016 ("fscrypt: allow unprivileged users to add/remove keys for v2 policies")
> >   5dae460c2292 ("fscrypt: v2 encryption policy support")
> >   5a7e29924dac ("fscrypt: add FS_IOC_GET_ENCRYPTION_KEY_STATUS ioctl")
> >   b1c0ec3599f4 ("fscrypt: add FS_IOC_REMOVE_ENCRYPTION_KEY ioctl")
> >   22d94f493bfb ("fscrypt: add FS_IOC_ADD_ENCRYPTION_KEY ioctl")
> >   3b6df59bc4d2 ("fscrypt: use FSCRYPT_* definitions, not FS_*")
> >   2336d0deb2d4 ("fscrypt: use FSCRYPT_ prefix for uapi constants")
> >   7af0ab0d3aab ("fs, fscrypt: move uapi definitions to new header <linux/fscrypt.h>")
> > 
> > That don't trigger any changes in tooling, as it so far is used only
> > for:
> > 
> >   $ grep -l 'fs\.h' tools/perf/trace/beauty/*.sh | xargs grep regex=
> >   tools/perf/trace/beauty/rename_flags.sh:regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+RENAME_([[:alnum:]_]+)[[:space:]]+\(1[[:space:]]*<<[[:space:]]*([[:xdigit:]]+)[[:space:]]*\)[[:space:]]*.*'
> >   tools/perf/trace/beauty/sync_file_range.sh:regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+SYNC_FILE_RANGE_([[:alnum:]_]+)[[:space:]]+([[:xdigit:]]+)[[:space:]]*.*'
> >   tools/perf/trace/beauty/usbdevfs_ioctl.sh:regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)(\(\w+\))?[[:space:]]+_IO[CWR]{0,2}\([[:space:]]*(_IOC_\w+,[[:space:]]*)?'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
> >   tools/perf/trace/beauty/usbdevfs_ioctl.sh:regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)[[:space:]]+_IO[WR]{0,2}\([[:space:]]*'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
> >   $
> > 
> > This silences this perf build warning:
> > 
> >   Warning: Kernel ABI header at 'tools/include/uapi/linux/fs.h' differs from latest version at 'include/uapi/linux/fs.h'
> >   diff -u tools/include/uapi/linux/fs.h include/uapi/linux/fs.h
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Eric Biggers <ebiggers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Link: https://lkml.kernel.org/n/tip-44g48exl9br9ba0t64chqb4i@git.kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> What's the reason why you don't just use the include/uapi/ headers directly?

We can't use anything from outside tools/perf/ to build it, sometimes
things get changed by kernel developers and tooling breaks.

Another reason is that we want to be able to do:

[acme@quaco perf]$ make help | grep perf
  perf-tar-src-pkg    - Build perf-5.3.0.tar source tarball
  perf-targz-src-pkg  - Build perf-5.3.0.tar.gz source tarball
  perf-tarbz2-src-pkg - Build perf-5.3.0.tar.bz2 source tarball
  perf-tarxz-src-pkg  - Build perf-5.3.0.tar.xz source tarball
[acme@quaco perf]$

Take that tarball, transfer it to an older system and still have it
building and working.

We also use the build warnings as hints that something needs to be
changed in tooling to pick up new kernel features, such as new ioctls,
syscall arguments to handle in 'perf trace', etc.

- Arnaldo

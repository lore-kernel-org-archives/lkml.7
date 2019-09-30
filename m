Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E488C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B702075D
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIvFk7Fy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbfI3Mv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 08:51:26 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40376 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbfI3Mv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 08:51:26 -0400
Received: by mail-qk1-f194.google.com with SMTP id y144so7589378qkb.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 05:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IZUTeqVl1Ba37YloeUuJ8+2p36NnetB9mk6B84ZbxMM=;
        b=UIvFk7FyVSSg2g5MFw5JdpywzIazD7hiWstxzhbaioipm148ZQLaKk4G5GJEC6dWqq
         uKQniWHQ2cZHH560T5ervxVccMx40gOQC27UFCzoNldfJhhvHi0KH3wA9CnoQkN2/Q2J
         7PAT9R+M+SBRlwapjybJqO945R7Wbkrv15alj4Py8gv/7r70WlSce/Tbw9NDoVvTGoxD
         8zTVaIRD+Gt5l6pnS6xzQ/zFZBJUSMw+CSQQxTpfe/3tDrMlXyN8EP/0eb9yz+e0duF3
         WyTFOz42xe1gKucLTSKh8w6RIQh3qR5w1RhwZhL+lhiuHRafrdu4EzPMmhdARzCOgE8c
         R9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IZUTeqVl1Ba37YloeUuJ8+2p36NnetB9mk6B84ZbxMM=;
        b=R8u5KAi9sJowKNu3fmbtfpGWdH2B0Wt5V9ae4iAWBZxqOyCuu0jcc0kJDU+Loia1bV
         +DpC/GO/0YKua/SFmemBiMqwUPS4jjzzsyEYHenig3ZoGo/v8KjgQxhvqiIDCGC4EhfT
         GCGZT+rWT5dcnyvakQF8Bzp3nPMd1+XCRoWdiTOdawUYJaPx7uCqtkqqBk2AMJIL0nP1
         EuX7MnSF2mxWXbho6BqQBMfxejlUwl5vm3FjFOdV42Tu6PcZJnrGa4tm5YaPaeSnM1RC
         Nu6eEZ3VvJBuN+CWGMTpGPC4LxHFgweI4QDXT8ozDIhmxeGyedXRTlwAa0wq/Hr70SRm
         fgNw==
X-Gm-Message-State: APjAAAVBiAvQgQenLzaPdvqX7cRzjAPLIzb/h1SR+vc1mjgmA6whVLWO
        tVnb/DZyL1S0FdfAUVyRePffeM9i
X-Google-Smtp-Source: APXvYqzrxZxScG08TJky9+cFcQP1OPhBniF1NJ75Ats3WRsbQq0BgUOxe6p1hPBNsy6FcozaroBOOA==
X-Received: by 2002:ae9:d807:: with SMTP id u7mr18307243qkf.492.1569847884727;
        Mon, 30 Sep 2019 05:51:24 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id b130sm5443702qkc.100.2019.09.30.05.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 05:51:24 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C969040DA4; Mon, 30 Sep 2019 09:51:21 -0300 (-03)
Date:   Mon, 30 Sep 2019 09:51:21 -0300
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf annotate fails with "Invalid -1 error code"
Message-ID: <20190930125121.GG9622@kernel.org>
References: <20190930121537.GG25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930121537.GG25745@shell.armlinux.org.uk>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 30, 2019 at 01:15:37PM +0100, Russell King - ARM Linux admin escreveu:
> Hi,
> 
> While using perf report on aarch64, I try to annotate
> __arch_copy_to_user, and it fails with:
> 
> Error: Couldn't annotate __arch_copy_to_user: Internal error: Invalid -1 error code
> 
> which is not very helpful.  Looking at the code, the error message
> appended to the "Couldn't annotate ...:" comes from
> symbol__strerror_disassemble(), which expects either an errno or
> one of the special SYMBOL_ANNOTATE_ERRNO_* constants in its 3rd
> argument.
> 
> symbol__tui_annotate() passes the 3rd argument as the return value
> from symbol__annotate2().  symbol__annotate2() returns either zero or
> -1.  This calls symbol__annotate(), which returns -1 (which would
> generally conflict with -EPERM), -errno, the return value of
> arch->init, or the return value of symbol__disassemble().
> 
> This seems to be something of a mess - different places seem to use
> different approaches to handling errors, and some don't bother
> propagating the error code up.
> 
> The upshot is, the error message reported when trying to annotate
> gives the user no clue why perf is unable to annotate, and you have
> to resort to stracing perf in an attempt to find out - which also
> isn't useful:
> 
> 3431  pselect6(1, [0], NULL, NULL, NULL, NULL) = 1 (in [0])
> 3431  pselect6(5, [4], NULL, NULL, {tv_sec=10, tv_nsec=0}, NULL) = 1 (in [4], left {tv_sec=9, tv_nsec=999995480})
> 3431  read(4, "\r", 1)                  = 1
> 3431  uname({sysname="Linux", nodename="cex7", ...}) = 0
> 3431  openat(AT_FDCWD, "/usr/lib/aarch64-linux-gnu/gconv/gconv-modules.cache", O_RDONLY) = 26
> 3431  fstat(26, {st_mode=S_IFREG|0644, st_size=26404, ...}) = 0
> 3431  mmap(NULL, 26404, PROT_READ, MAP_SHARED, 26, 0) = 0x7fa1fd9000
> 3431  close(26)                         = 0
> 3431  futex(0x7fa172b830, FUTEX_WAKE_PRIVATE, 2147483647) = 0
> 3431  write(1, "\33[10;21H\33[37m\33[40m\342\224\214\342\224\200Error:\342\224"..., 522) = 522
> 3431  pselect6(1, [0], NULL, NULL, NULL, NULL <detached ...>
> 
> Which makes it rather difficult to know what is actually failing...
> so the only way is to resort to gdb.
> 
> It seems that dso__disassemble_filename() is returning -10000, which
> seems to be SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX and as described above,
> this is lost due to the lack of error code propagation.
> 
> Specifically, the failing statement is:
> 
>         if (dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
>             !dso__is_kcore(dso))
>                 return SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX;
> 
> Looking at "dso" shows:
> 
> 	kernel = DSO_TYPE_KERNEL,
> 	symtab_type = DSO_BINARY_TYPE__KALLSYMS,
> 	binary_type = DSO_BINARY_TYPE__KALLSYMS,
> 	load_errno = DSO_LOAD_ERRNO__MISMATCHING_BUILDID,
> 	name = 0x555588781c "/boot/vmlinux",
> 
> and we finally get to the reason - it's using the wrong vmlinux.
> So, obvious solution (once the failure reason is known), give it
> the correct vmlinux.
> 
> Should it really be necessary to resort to gdb to discover why perf
> is failing?
> 
> It looks like this was introduced by ecda45bd6cfe ("perf annotate:
> Introduce symbol__annotate2 method") which did this:
> 
> -       err = symbol__annotate(sym, map, evsel, 0, &browser.arch);
> +       err = symbol__annotate2(sym, map, evsel, &annotate_browser__opts, &browser.arch);
> 
> +int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *evsel,
> +                     struct annotation_options *options, struct arch **parch)
> +{
> ...
> +       err = symbol__annotate(sym, map, evsel, 0, parch);
> +       if (err)
> +               goto out_free_offsets;
> ...
> +out_free_offsets:
> +       zfree(&notes->offsets);
> +       return -1;
> +}
> 
> introducing this problem by the "return -1" disease.
> 
> So, given that this function's return value is used as an error code
> in the way I've described above, should this function also be fixed
> to return ENOMEM when the zalloc fails, as well as propagating the
> return value from symbol__annotate() ?
> 
> I haven't yet checked to see if there's other places that call this
> function but now rely on it returning -1... but I'd like to lodge a
> plea that perf gets some consistency wrt how errors are passed and
> propagated from one function to another.

Note taken, will address the points raised here.

- Arnaldo

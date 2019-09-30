Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450A8C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D99921855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="okYil+Xj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbfI3MPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 08:15:48 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49646 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfI3MPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 08:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZfDBsutnn0AhJnthNc5JfCT41CTdG+3OkNf+gtjI+DM=; b=okYil+Xj4Cw2pUPSKUvdGwBZ7
        hSDbdzyD2965WO9s5CH4L8jCLwkNmopw2NZk/JKAy6+Tvli3NFDgW/wyH3f6MCsEfIZ08/G0/fK96
        CjGzXaR687//2XeUiyuLnMgfcEDYOJwtZNO2Qv8IXD6nobO3928NTVAsC7kyStiW6r+6L/jWqHThN
        knIrUUWFge4t4rxpIbVatI801QTetd9W6JweWFLMHToP+D0fxMhrGnk89hH1r37ONkvB6GC6UfP0+
        nH3EVQ9tFnpaCjeZfJgRPM25m/M/Z7e9XNOP/PrqebsEuXCLESCTZ+6j3t95mjpsQgLCL0do5JZ8r
        mRaAI6JlA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:45870)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iEuaZ-0004Sw-Ey; Mon, 30 Sep 2019 13:15:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iEuaX-0007Ek-MU; Mon, 30 Sep 2019 13:15:37 +0100
Date:   Mon, 30 Sep 2019 13:15:37 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: perf annotate fails with "Invalid -1 error code"
Message-ID: <20190930121537.GG25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While using perf report on aarch64, I try to annotate
__arch_copy_to_user, and it fails with:

Error: Couldn't annotate __arch_copy_to_user: Internal error: Invalid -1 error code

which is not very helpful.  Looking at the code, the error message
appended to the "Couldn't annotate ...:" comes from
symbol__strerror_disassemble(), which expects either an errno or
one of the special SYMBOL_ANNOTATE_ERRNO_* constants in its 3rd
argument.

symbol__tui_annotate() passes the 3rd argument as the return value
from symbol__annotate2().  symbol__annotate2() returns either zero or
-1.  This calls symbol__annotate(), which returns -1 (which would
generally conflict with -EPERM), -errno, the return value of
arch->init, or the return value of symbol__disassemble().

This seems to be something of a mess - different places seem to use
different approaches to handling errors, and some don't bother
propagating the error code up.

The upshot is, the error message reported when trying to annotate
gives the user no clue why perf is unable to annotate, and you have
to resort to stracing perf in an attempt to find out - which also
isn't useful:

3431  pselect6(1, [0], NULL, NULL, NULL, NULL) = 1 (in [0])
3431  pselect6(5, [4], NULL, NULL, {tv_sec=10, tv_nsec=0}, NULL) = 1 (in [4], left {tv_sec=9, tv_nsec=999995480})
3431  read(4, "\r", 1)                  = 1
3431  uname({sysname="Linux", nodename="cex7", ...}) = 0
3431  openat(AT_FDCWD, "/usr/lib/aarch64-linux-gnu/gconv/gconv-modules.cache", O_RDONLY) = 26
3431  fstat(26, {st_mode=S_IFREG|0644, st_size=26404, ...}) = 0
3431  mmap(NULL, 26404, PROT_READ, MAP_SHARED, 26, 0) = 0x7fa1fd9000
3431  close(26)                         = 0
3431  futex(0x7fa172b830, FUTEX_WAKE_PRIVATE, 2147483647) = 0
3431  write(1, "\33[10;21H\33[37m\33[40m\342\224\214\342\224\200Error:\342\224"..., 522) = 522
3431  pselect6(1, [0], NULL, NULL, NULL, NULL <detached ...>

Which makes it rather difficult to know what is actually failing...
so the only way is to resort to gdb.

It seems that dso__disassemble_filename() is returning -10000, which
seems to be SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX and as described above,
this is lost due to the lack of error code propagation.

Specifically, the failing statement is:

        if (dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
            !dso__is_kcore(dso))
                return SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX;

Looking at "dso" shows:

	kernel = DSO_TYPE_KERNEL,
	symtab_type = DSO_BINARY_TYPE__KALLSYMS,
	binary_type = DSO_BINARY_TYPE__KALLSYMS,
	load_errno = DSO_LOAD_ERRNO__MISMATCHING_BUILDID,
	name = 0x555588781c "/boot/vmlinux",

and we finally get to the reason - it's using the wrong vmlinux.
So, obvious solution (once the failure reason is known), give it
the correct vmlinux.

Should it really be necessary to resort to gdb to discover why perf
is failing?

It looks like this was introduced by ecda45bd6cfe ("perf annotate:
Introduce symbol__annotate2 method") which did this:

-       err = symbol__annotate(sym, map, evsel, 0, &browser.arch);
+       err = symbol__annotate2(sym, map, evsel, &annotate_browser__opts, &browser.arch);

+int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *evsel,
+                     struct annotation_options *options, struct arch **parch)
+{
...
+       err = symbol__annotate(sym, map, evsel, 0, parch);
+       if (err)
+               goto out_free_offsets;
...
+out_free_offsets:
+       zfree(&notes->offsets);
+       return -1;
+}

introducing this problem by the "return -1" disease.

So, given that this function's return value is used as an error code
in the way I've described above, should this function also be fixed
to return ENOMEM when the zalloc fails, as well as propagating the
return value from symbol__annotate() ?

I haven't yet checked to see if there's other places that call this
function but now rely on it returning -1... but I'd like to lodge a
plea that perf gets some consistency wrt how errors are passed and
propagated from one function to another.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

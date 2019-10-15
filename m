Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D644BC4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 00:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F0C20663
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 00:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m82ItVoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfJOAgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 20:36:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51654 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfJOAgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 20:36:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so18910731wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 17:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cSDyetkp9LF+HPNPXXqByeV3PmiahLNlHpt22HU4NqA=;
        b=m82ItVoByCPK/bGQ7w05jl34Ya9OYybQkITCWbFBfWefmJug6lmmu1ZTHeeULTSQzk
         JFBpeopFF18JEfSVGYaygJRcO/CGuSKBI+yFWPlqCT8jVM0YZ5/X0a8eAaNfgpo5jtJv
         aTyiRD1ybAam5Z2IcQLjLsjX93YcPfPD+0t47lumJQTNZOm7c2qQw/G7YHUx3KKoadZy
         xZcV0MTwpYrfaBFzSwJBl/I+kV7ZvOscfwOPetiWquBCXmr6TmGqQp/cJohjaBtKM+T/
         ku1TPqn4Km0PgHJ2sa1lNN7O2mAdC9BB6CebKHStM4BLJ0uN7dA6x3sG7UzGHdmI19eg
         AXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cSDyetkp9LF+HPNPXXqByeV3PmiahLNlHpt22HU4NqA=;
        b=EHOmISzOgMYw+UzZ8+F8L78D3JTTJzfsmnxY+kLA+Fn25wo2Xk+fDlJW48xuLdroFU
         OagEp5uOL0EKuQwQyukiiHZfJJo0xvFoJjg0n+/LZw3MgZmOLouNFE6xjgimnRaXqzPC
         mptVBj25S94zr2pRlxAYraawOkDY+f+QltPZTo1iMx3tuqMhSMDhXFRODvcoOmH4g9uY
         T+yp4vGQ4cHyh/VMpjfdtbNmFifNIgyTpc44Azh5gNyr4zdQg4ry+5gxucxXywTtpR9h
         5/875DrVPGdvkVyHqd7+sAr7j7Th13arEoPjKUKTUl3DayVPzerofDJ3pT9twBb8NBtz
         pZqg==
X-Gm-Message-State: APjAAAUTWizP9nTdI/uIw2PiPVpPYaTsZaMLe1g4Z3jaW2guLXPzAXFf
        qeUZRMxkfDu78geDqCRrPuzxauckOdBEUTgJOfuDDA==
X-Google-Smtp-Source: APXvYqyPLcH/frCpPM+6cU4wdBc6s1qznhJ3cSGVnKw07sjqGZHWrKY3ta00ObaNMJpdj3Sj7lsE6KVcJhCjh8a+8t0=
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr16928637wmk.30.1571099760603;
 Mon, 14 Oct 2019 17:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191010183649.23768-1-irogers@google.com> <20191010183649.23768-3-irogers@google.com>
 <20191014141828.GG19627@kernel.org>
In-Reply-To: <20191014141828.GG19627@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Oct 2019 17:35:49 -0700
Message-ID: <CAP-5=fUSNZWga5TDPk1aG6-VKKMHU8x0hF_t60sLJL5tvn4c2w@mail.gmail.com>
Subject: Re: [PATCH 2/5] perf annotate: use run-command.h to fork objdump
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for applying! Apologies, there was a missing null termination.
Sent in a follow-up patch.

Ian

On Mon, Oct 14, 2019 at 7:18 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Oct 10, 2019 at 11:36:46AM -0700, Ian Rogers escreveu:
> > Reduce duplicated logic by using the subcmd library. Ensure when errors
> > occur they are reported to the caller. Before this patch, if no lines are
> > read the error status is 0.
>
> Thanks, applied and tested.
>
> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/annotate.c | 71 +++++++++++++++++++-------------------
> >  1 file changed, 36 insertions(+), 35 deletions(-)
> >
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index 1487849a191a..fc12c5cfe112 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -43,6 +43,7 @@
> >  #include <linux/string.h>
> >  #include <bpf/libbpf.h>
> >  #include <subcmd/parse-options.h>
> > +#include <subcmd/run-command.h>
> >
> >  /* FIXME: For the HE_COLORSET */
> >  #include "ui/browser.h"
> > @@ -1843,12 +1844,18 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
> >       struct kcore_extract kce;
> >       bool delete_extract = false;
> >       bool decomp = false;
> > -     int stdout_fd[2];
> >       int lineno = 0;
> >       int nline;
> > -     pid_t pid;
> >       char *line;
> >       size_t line_len;
> > +     const char *objdump_argv[] = {
> > +             "/bin/sh",
> > +             "-c",
> > +             NULL, /* Will be the objdump command to run. */
> > +             "--",
> > +             NULL, /* Will be the symfs path. */
> > +     };
> > +     struct child_process objdump_process;
> >       int err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename));
> >
> >       if (err)
> > @@ -1878,7 +1885,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
> >
> >               if (dso__decompress_kmodule_path(dso, symfs_filename,
> >                                                tmp, sizeof(tmp)) < 0)
> > -                     goto out;
> > +                     return -1;
> >
> >               decomp = true;
> >               strcpy(symfs_filename, tmp);
> > @@ -1903,38 +1910,28 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
> >
> >       pr_debug("Executing: %s\n", command);
> >
> > -     err = -1;
> > -     if (pipe(stdout_fd) < 0) {
> > -             pr_err("Failure creating the pipe to run %s\n", command);
> > -             goto out_free_command;
> > -     }
> > -
> > -     pid = fork();
> > -     if (pid < 0) {
> > -             pr_err("Failure forking to run %s\n", command);
> > -             goto out_close_stdout;
> > -     }
> > +     objdump_argv[2] = command;
> > +     objdump_argv[4] = symfs_filename;
> >
> > -     if (pid == 0) {
> > -             close(stdout_fd[0]);
> > -             dup2(stdout_fd[1], 1);
> > -             close(stdout_fd[1]);
> > -             execl("/bin/sh", "sh", "-c", command, "--", symfs_filename,
> > -                   NULL);
> > -             perror(command);
> > -             exit(-1);
> > +     /* Create a pipe to read from for stdout */
> > +     memset(&objdump_process, 0, sizeof(objdump_process));
> > +     objdump_process.argv = objdump_argv;
> > +     objdump_process.out = -1;
> > +     if (start_command(&objdump_process)) {
> > +             pr_err("Failure starting to run %s\n", command);
> > +             err = -1;
> > +             goto out_free_command;
> >       }
> >
> > -     close(stdout_fd[1]);
> > -
> > -     file = fdopen(stdout_fd[0], "r");
> > +     file = fdopen(objdump_process.out, "r");
> >       if (!file) {
> >               pr_err("Failure creating FILE stream for %s\n", command);
> >               /*
> >                * If we were using debug info should retry with
> >                * original binary.
> >                */
> > -             goto out_free_command;
> > +             err = -1;
> > +             goto out_close_stdout;
> >       }
> >
> >       /* Storage for getline. */
> > @@ -1958,8 +1955,14 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
> >       }
> >       free(line);
> >
> > -     if (nline == 0)
> > +     err = finish_command(&objdump_process);
> > +     if (err)
> > +             pr_err("Error running %s\n", command);
> > +
> > +     if (nline == 0) {
> > +             err = -1;
> >               pr_err("No output from %s\n", command);
> > +     }
> >
> >       /*
> >        * kallsyms does not have symbol sizes so there may a nop at the end.
> > @@ -1969,23 +1972,21 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
> >               delete_last_nop(sym);
> >
> >       fclose(file);
> > -     err = 0;
> > +
> > +out_close_stdout:
> > +     close(objdump_process.out);
> > +
> >  out_free_command:
> >       free(command);
> > -out_remove_tmp:
> > -     close(stdout_fd[0]);
> >
> > +out_remove_tmp:
> >       if (decomp)
> >               unlink(symfs_filename);
> >
> >       if (delete_extract)
> >               kcore_extract__delete(&kce);
> > -out:
> > -     return err;
> >
> > -out_close_stdout:
> > -     close(stdout_fd[1]);
> > -     goto out_free_command;
> > +     return err;
> >  }
> >
> >  static void calc_percent(struct sym_hist *sym_hist,
> > --
> > 2.23.0.581.g78d2f28ef7-goog
>
> --
>
> - Arnaldo

Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144CAC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 04:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A3D208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 04:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oPMATDOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfFYEwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 00:52:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37662 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbfFYEwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 00:52:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id y8so483712pgl.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 21:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x++iS19w63sxgFVfWWLm5YJQFUHEat//0dXequQHgss=;
        b=oPMATDOVDtVdhlOcqT7LD8rym0j7XNpvTqF81EmRDXevW5UrlQq+FYBUI8F5pOH+FV
         vOoyEXA3YXGXBeBlycdLp9fk9MazJEIc9K+NxmzsuRCpDdG9h7TuhXujrTj6DMCN8h7T
         Y6i84uBKUBG5O4vYCrqQ7eXupJwjwqHWx/1kMbOsHbWMGfZ3csvfmUoLMbgSOqMptbGf
         KoVs3A8EU6eR5YM3Pxu8PVnJ2VOU/KlDIxEk6zJdxdxyl6DY0AMbUkIrpnJ78EvrnBFB
         TlCzMdE1KIJzqUwkvzH5kvGPEsftIY/nqvyBzHUlz1SabNYgQiXNDdXCyqcmY9m38/Ky
         tNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x++iS19w63sxgFVfWWLm5YJQFUHEat//0dXequQHgss=;
        b=Ic6tC6B4clU80zfBbXJxzmAFc5aVMGHsJCR07AzPMx+OhjwXjw5waCdoXFZTNwaehv
         oPtRPmLb262uGkNY6DKjaS1zEBr2guOaqt2DIsdKm1/e+W+q5tbSogRbvLiYhGwF/pES
         sX2bIxbmrGqf6L/ykHjjdwYxuytyIb42iJSER8UJnF4PEwFe87mtvx5rVrL7L0Qq27y1
         KxSqkRLUISWUVE+7tFw/dTQ9VLh/EgAP59eN1UJQg3RXePjiVviWZ/U2PmEwlSswwnIt
         DVgcARILICnhZKZYfql9LQIV/UJL8OFuQdxZuzXIrz3l9hGXAzeRFQN6/dqQVnWReI3I
         K8cQ==
X-Gm-Message-State: APjAAAW8TiU1Vzh43owPafEagbuzalhnPHmDCj/3w6uabIyvQZcfaSsK
        lR41j4rFPsRl96LKtLBWBu4pcA==
X-Google-Smtp-Source: APXvYqwq+x8bjy217eJe6SW1wvSRPjFujvsZCYifDyTnFtr9gkiZuKb/hbegQMTzT8JlFrq6Jsu5Gg==
X-Received: by 2002:a63:a046:: with SMTP id u6mr20953163pgn.122.1561438320211;
        Mon, 24 Jun 2019 21:52:00 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([240e:e0:f087:f467:b43a:6fd7:87a2:c789])
        by smtp.gmail.com with ESMTPSA id 22sm18808541pfu.179.2019.06.24.21.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 21:51:59 -0700 (PDT)
Date:   Tue, 25 Jun 2019 12:51:40 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH] perf cs-etm: Improve completeness for kernel address
 space
Message-ID: <20190625045140.GA7637@leoy-ThinkPad-X240s>
References: <20190617150024.11787-1-leo.yan@linaro.org>
 <CANLsYkyMW=WG+=yWTLSyMT3JXqd_2kvsrx9c-EwCoKEnRZvErA@mail.gmail.com>
 <20190620005829.GH24549@leoy-ThinkPad-X240s>
 <20190624190009.GE4181@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624190009.GE4181@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Mon, Jun 24, 2019 at 04:00:09PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > > > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > > > index 0c7776b51045..ae831f836c70 100644
> > > > --- a/tools/perf/util/cs-etm.c
> > > > +++ b/tools/perf/util/cs-etm.c
> > > > @@ -613,10 +613,34 @@ static void cs_etm__free(struct perf_session *session)
> > > >  static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address)
> > > >  {
> > > >         struct machine *machine;
> > > > +       u64 fixup_kernel_start = 0;
> > > > +       const char *arch;
> > > >
> > > >         machine = etmq->etm->machine;
> > > > +       arch = perf_env__arch(machine->env);
> > > >
> > > > -       if (address >= etmq->etm->kernel_start) {
> > > > +       /*
> > > > +        * Since arm and arm64 specify some memory regions prior to
> > > > +        * 'kernel_start', kernel addresses can be less than 'kernel_start'.
> > > > +        *
> > > > +        * For arm architecture, the 16MB virtual memory space prior to
> > > > +        * 'kernel_start' is allocated to device modules, a PMD table if
> > > > +        * CONFIG_HIGHMEM is enabled and a PGD table.
> > > > +        *
> > > > +        * For arm64 architecture, the root PGD table, device module memory
> > > > +        * region and BPF jit region are prior to 'kernel_start'.
> > > > +        *
> > > > +        * To reflect the complete kernel address space, compensate these
> > > > +        * pre-defined regions for kernel start address.
> > > > +        */
> > > > +       if (!strcmp(arch, "arm64"))
> > > > +               fixup_kernel_start = etmq->etm->kernel_start -
> > > > +                                    ARM64_PRE_START_SIZE;
> > > > +       else if (!strcmp(arch, "arm"))
> > > > +               fixup_kernel_start = etmq->etm->kernel_start -
> > > > +                                    ARM_PRE_START_SIZE;
> > > 
> > > I will test your work but from a quick look wouldn't it be better to
> > > have a single define name here?  From looking at the modifications you
> > > did to Makefile.config there doesn't seem to be a reason to have two.
> > 
> > Thanks for suggestion.  I changed to use single define
> > ARM_PRE_START_SIZE and sent patch v2 [1].
> > 
> > If possible, please test patch v2.
> > 
> > Thanks,
> > Leo Yan
> 
> So just for the record, I'm waiting for Mathieu on this one, i.e. for
> him to test/ack v3.

Yes, this makes sense.  I'd like to get Mathieu's green light as well,
it needs to take much time to build llvm/clang on SBC, so it's no rush.

Thanks,
Leo Yan

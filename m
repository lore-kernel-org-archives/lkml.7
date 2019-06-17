Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DB3C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F95F208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zqp5qnd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfFQSL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:11:27 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38177 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfFQSLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:11:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id n11so11881459qtl.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 11:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0vsERB58U1V/zFHTvBLaEeu4RqZKbmUfIGsVAvkpJGI=;
        b=Zqp5qnd+FPNBYdtsa89EQzmhKEGoyvyO7O9xPThibitiM2sVCEIEVjVoc52gK60W3e
         uUMCcFWJP7DVeXSiEeFwxSeHXS8JTJ0UPQbG9M10Xl6tx0hCnub01eUcZ4dk1kIYlgyE
         +Cveq+QSrfusZhAIEbnE8MolTWO/mWHpgHVhbl5VdWVK1aF8TZfIlJbomEFGm1iWsnoo
         HagEH0Q9sCF6gkhITkHsVLBFMUrc94PpIQRVYVIRFK40AseixhYfn6Tn4p/+Ab9giNWl
         9i2I6BdA73F6sk8oCa/bmjhpm34TWHx/nn1r44rwMNBdod/EJMTZiGlpnZgyZuByAfip
         3UcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0vsERB58U1V/zFHTvBLaEeu4RqZKbmUfIGsVAvkpJGI=;
        b=E1HYNMtf8NuCbmIKKW/rIVwy3rdzhZQ6oIRZKcbpKj5cPr7duTjyJOJUN//y7B+YOt
         ipdp70z+t6hUSDzSCFpRS05vDWqiQkfCBIASogFRUdOqlALrTFJGaJ6l8D3EYyc5c/z8
         mvgJGJ2/6sUi76JQQey99fOYephGI6u2rdL0UzY017jRyCRsLQc844KChh8iOfNv8hEY
         Q+hJZJ8Z6b8zzAIjMlX7Aldh9AqhQEyYL+T4f294t+KUqlIvnn/CdgIqd53Y5juifBiJ
         yCnZVjuh8J7t2XxX2+Sq3mTlLB7gqpWtKjfgzBHsLrzSjHxLSn3HTz2PGtkulYFajhlL
         DN2g==
X-Gm-Message-State: APjAAAWahoQNL1AylEb1N3umxvq3oemYbWYgqe27eXyXdrm0o4js+L4g
        qCicRjrOaFsiAF32DhSt7kTClBtZ
X-Google-Smtp-Source: APXvYqzzVoDh7W3O1j+OecqYg0IqeMk+s1zpjkh4TTMPWeq6V3aZldtssgn9ZgNtk9XXi/ICbWXeuA==
X-Received: by 2002:a0c:d013:: with SMTP id u19mr22535817qvg.136.1560795079586;
        Mon, 17 Jun 2019 11:11:19 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-145-61.3g.claro.net.br. [179.240.145.61])
        by smtp.gmail.com with ESMTPSA id u7sm8620272qta.82.2019.06.17.11.11.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 11:11:18 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AF04941149; Mon, 17 Jun 2019 15:11:15 -0300 (-03)
Date:   Mon, 17 Jun 2019 15:11:15 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Stanislav Fomichev <sdf@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH] perf: Don't hardcode host include path for libslang
Message-ID: <20190617181115.GC3927@kernel.org>
References: <20190614183949.5588-1-f.fainelli@gmail.com>
 <20190616094605.GB2500@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190616094605.GB2500@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jun 16, 2019 at 11:46:05AM +0200, Jiri Olsa escreveu:
> On Fri, Jun 14, 2019 at 11:39:47AM -0700, Florian Fainelli wrote:
> > Hardcoding /usr/include/slang is fundamentally incompatible with cross
> > compilation and will lead to the inability for a cross-compiled
> > environment to properly detect whether slang is available or not.
> > 
> > If /usr/include/slang is necessary that is a distribution specific
> > knowledge that could be solved with either a standard pkg-config .pc
> > file (which slang has) or simply overriding CFLAGS accordingly, but the
> > default perf Makefile should be clean of all of that.
> 
> fedora 30 is ok with this, I guess acme's distro test will
> tell us about the rest ;-)

Seems to be just needless old cruft:

[perfbuilder@7143ebde35eb /]$ cat /etc/redhat-release
Fedora release 20 (Heisenbug)
[perfbuilder@7143ebde35eb /]$
[perfbuilder@7143ebde35eb /]$ ls -la /usr/include/slang.h 
-rw-r--r--. 1 root root 87562 Apr 11  2011 /usr/include/slang.h
[perfbuilder@7143ebde35eb /]$ ls -la /usr/include/slang/slang.h 
lrwxrwxrwx. 1 root root 10 Jun 17 16:41 /usr/include/slang/slang.h -> ../slang.h
[perfbuilder@7143ebde35eb /]$ 

So I'm removing that comment:

> >      # Fedora has /usr/include/slang/slang.h, but ubuntu /usr/include/slang.h

And adding a:

Fixes: ef7b93a11904 ("perf report: Librarize the annotation code and use it in the newt browser")

Will do a build with all the containers and check that the output for
all the ones with the slang devel package installed have slang
successfully detected.

Thanks,

- Arnaldo
 
> jirka
> 
> > 
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >  tools/build/feature/Makefile | 2 +-
> >  tools/perf/Makefile.config   | 1 -
2> >  2 files changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > index 4b8244ee65ce..f9432d21eff9 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -181,7 +181,7 @@ $(OUTPUT)test-libaudit.bin:
> >  	$(BUILD) -laudit
> >  
> >  $(OUTPUT)test-libslang.bin:
> > -	$(BUILD) -I/usr/include/slang -lslang
> > +	$(BUILD) -lslang
> >  
> >  $(OUTPUT)test-libcrypto.bin:
> >  	$(BUILD) -lcrypto
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 85fbcd265351..b11134fdf59f 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -641,7 +641,6 @@ ifndef NO_SLANG
> >      NO_SLANG := 1
> >    else
> >      # Fedora has /usr/include/slang/slang.h, but ubuntu /usr/include/slang.h
> > -    CFLAGS += -I/usr/include/slang
> >      CFLAGS += -DHAVE_SLANG_SUPPORT
> >      EXTLIBS += -lslang
> >      $(call detected,CONFIG_SLANG)
> > -- 
> > 2.17.1
> > 

-- 

- Arnaldo

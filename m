Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BB2C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 15:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2525C216F4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 15:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dd8tlyCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfK2PN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 10:13:29 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:37331 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfK2PN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 10:13:28 -0500
Received: by mail-qk1-f178.google.com with SMTP id e187so25829161qkf.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 07:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=W6egdRMGiTO6yhu5AX3v9UKGMgKCZYWtWcMTq1xiguc=;
        b=dd8tlyCbL0MV/jdCFG+gVtyZoNki0wz9bCiO9PYILiolX0HJwMUTpCILRsKT0VfFMD
         9a7a4+hepOHL6TfYW7wDA8PGRZfI07VJ4LjKudFEh614ssIIbOcLRDKDGZWoQlmwiOPo
         VN5BIOORVVd+U8CtOCgqNLLQZ9i5HGslnPIu+wEG0XjqAOItC9hacvr61Vmwuxgj1as8
         dw7+x2rd6cPCFKY2i9OzTGZJat0KuNWayEVxE31PCG3iQAg+tOm4Mt2z7Drz2gfqC0Yr
         uHrJuLlbkepCWFqztmEjKCF1Ud7kKzyfQAPbzWYQ4Rl/JDfIJw5Si4EeXGVJcDMwRb4f
         ne8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=W6egdRMGiTO6yhu5AX3v9UKGMgKCZYWtWcMTq1xiguc=;
        b=iAqsF7vFl2bLbIxNJ5pbW3g+aT+x28G3qMlZHFLe3DfBhfVnKxc9iIDRH/LImZlGqQ
         2HYH9LQ2nyZIG2CNjlEGvhDtm8vTejFxjuI25x8NcBDwcnmkkOeU4rSPV3Yb4U5EvNK9
         YJfvUEcDydIfgMibXN7pzDFW0wzVrysanCVL13KCW9a5kNGe3RofMHmBYQjJ7Aj5iweo
         2JBTUrofncsZGoBTaoAZ2w6GQymRmF+oBZXNtSTVga8AAK0/2xrrU6Us43oMnBebljn6
         pI8WIfdMwazOIinAOzO38jp3P5sIdcgAgVzUheToj6HmoHQxKH3QMDecnJH2D10Lks+m
         fEkQ==
X-Gm-Message-State: APjAAAVMFrnNUtjSl0yt10zo3RxAmvZT7DqafO+C3f4kyXWXRGF33Soz
        OfLg/9TI9+7xAEWXxx0BaL8=
X-Google-Smtp-Source: APXvYqwOBURrykCZNgLFpWJqdA6UhD0rgc/KnvgW09ESJk9X2ZsmBeCEKUSqTwF/+wM2U/cnRAczmg==
X-Received: by 2002:a37:bdc4:: with SMTP id n187mr16934395qkf.376.1575040407639;
        Fri, 29 Nov 2019 07:13:27 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id y91sm11760529qtd.28.2019.11.29.07.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 07:13:26 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 234A4405B6; Fri, 29 Nov 2019 12:13:24 -0300 (-03)
Date:   Fri, 29 Nov 2019 12:13:24 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: perf probe -d failing to delete probes
Message-ID: <20191129151324.GA26963@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Masami,

   Can you please take a look at this?

[root@quaco perf]# perf probe -l
  probe_perf:map__map_ip (on ui__warn_map_erange+222@perf/tools/perf/builtin-top.c in /home/acme/bin/perf)
  probe_perf:map__map_ip (on ui__warn_map_erange+222@perf/tools/perf/builtin-top.c in /home/acme/bin/perf)
  probe_perf:map__map_ip (on perf_evlist__set_paused+222@util/evlist.c in /home/acme/bin/perf)
  probe_perf:map__map_ip (on perf_evlist__resume+222@util/evlist.c in /home/acme/bin/perf)
  probe_perf:map__map_ip (on perf_evsel__group_desc+222@util/evsel.c in /home/acme/bin/perf)
  probe_perf:map__map_ip (on svg_partial_wakeline+222@util/svghelper.c in /home/acme/bin/perf)
[root@quaco perf]# perf probe -d probe_perf:map_*
"probe_perf:map_*" does not hit any event.
  Error: Failed to delete events.
[root@quaco perf]# perf probe -d probe_perf:*
"probe_perf:*" does not hit any event.
  Error: Failed to delete events.
[root@quaco perf]# perf probe -d probe*:*
"probe*:*" does not hit any event.
  Error: Failed to delete events.
[root@quaco perf]# perf probe -d '*:*'
"*:*" does not hit any event.
  Error: Failed to delete events.
[root@quaco perf]#

- Arnaldo

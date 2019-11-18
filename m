Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEFEC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310D5208CE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrOn5CCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfKRVz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:55:27 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44125 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfKRVz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:55:26 -0500
Received: by mail-qt1-f196.google.com with SMTP id o11so22048108qtr.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 13:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=viT7ea/bkcve/+EF9qqPdJj7A/7OREWbNRKfKg4q68I=;
        b=VrOn5CCkPTNLBAAQ5chP/GDXIktLZLemDmNHFkgx+m6bbdPH0CO2lrOFYyA/nBR1BM
         uGmEHaUOs8/oPaO5YgERkTOMn3wr0BFN9Lpynm8cF9D9MOC24195sReaqVe3EXR3hjJa
         ftC5Alta3O3e6xjlQRaOucC5zmXWG6wWz5BAflXDBHZmgxEKdTPERVSsZvlvmNwUpGUM
         e8xRUkUbnIX+ALLZr1xUQEUlkSExO28fCYCnnx6YVKJC4OUHuG0CnSlVsCJEygdqdyEr
         nGPdhICP2bew/fbhsgGaqU9NiwKp+CR/TarlJ2iNLAbCLCVZkrWM7zC9wLpbkUMp6crT
         GcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=viT7ea/bkcve/+EF9qqPdJj7A/7OREWbNRKfKg4q68I=;
        b=pNbmDrCZD+8ut0WDUjh7zB13x8bw7JuVEuE44RChr4d9hagxgJgErzuHOejl1kZsaj
         /k8qbyTBoiPJfm3gfzki8Dn7I1AF5ApM+vemscEuTk6x9SpwgKjNoIM71zPrS2EzVk//
         nEQD4ojq9Pan4OPCz3Snu0qZozOqUb4MzIB8i90cg4R8kssEvJSuR33ddxv/1FpNcZlz
         ojbDHi3LBWSiC6GVFNvwhXr121STO2pjewRXVU4cxfZZuZVG8Alc7bkaG9FuJzgT0qIi
         LkYIdxfcQn2xvQsCe2jeItP4MseJypZUVNpghaRhEMZ1Y394wIkIKX47xaxFKxgsZqSb
         pCYQ==
X-Gm-Message-State: APjAAAV+Q7EkLdtKNZ0w1EmFNBk3MXesPDgcdFHzlzryohDHi85b/PGc
        JIVUIIlqZ9SGXt+Od7cv7HXSUOOT41g=
X-Google-Smtp-Source: APXvYqzXU0xcSLgza42RvMsAoG0ko3FJ9tp8HoSbpq3FmRObVQx+BHTZBkgfqVQx8mXOmrOGb+kCng==
X-Received: by 2002:aed:3145:: with SMTP id 63mr30303009qtg.165.1574114125821;
        Mon, 18 Nov 2019 13:55:25 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id d126sm9261375qkc.93.2019.11.18.13.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 13:55:24 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DABA840D3E; Mon, 18 Nov 2019 18:55:22 -0300 (-03)
Date:   Mon, 18 Nov 2019 18:55:22 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, x86@kernel.org,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] x86/insn: Add some Intel instructions to the opcode
 map
Message-ID: <20191118215522.GA20465@kernel.org>
References: <20191115135447.6519-1-adrian.hunter@intel.com>
 <20191115135447.6519-3-adrian.hunter@intel.com>
 <20191118204045.35ef5aaa02650c47fbb51950@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118204045.35ef5aaa02650c47fbb51950@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 18, 2019 at 08:40:45PM +0900, Masami Hiramatsu escreveu:
> Hi Adrian,
> 
> On Fri, 15 Nov 2019 15:54:47 +0200
> Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
> 
> Thanks for updating it!
> This looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > Reviewed-by: Andi Kleen <ak@linux.intel.com>

Thanks, applied both patches,

- Arnaldo

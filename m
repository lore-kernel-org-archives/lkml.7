Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416ADC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B36A207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPnTCL2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407399AbfIXTVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 15:21:20 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:37719 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730858AbfIXTVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:21:19 -0400
Received: by mail-qt1-f179.google.com with SMTP id d2so3562716qtr.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 12:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A5eS5NXht/vOaGonLfgI9sz4CtBniYeY84hPs1tCF1U=;
        b=pPnTCL2s+MDwOixyKhQt4so/dr7NxfSvZtoG6zTBeUbJnurN4L/Wt2417aeCaYQeHQ
         0ARnrk4Edbj7XgxvCivBp6CAPlrUDiyRFNpAziInufexp8LXUrlMUxDy/r53xEe+ish6
         2EglZW6obyuM4pHb1Jyl1V5MZi4w6+W85npiFwsZudv3lAU0TKEtFP+g4S9MQ2FqhG94
         DsL0NRtFji9G7YdfRMK3bmvP/CyyyjCiwtOjy2vk1zF+c5apbh3WaxOPFR2MpKSX8LjD
         8pWXrPOf1xIqcyjqE/MLQXC1IIUNqYEOpLo7FkQlC+dSFGxFGEEeHoj1pPW+cZRPYaHM
         /W3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A5eS5NXht/vOaGonLfgI9sz4CtBniYeY84hPs1tCF1U=;
        b=PsIhQmv72lkj317evvdQBTjesBLqFdIJUT6SCk7OJhimAI+UlEOJ0kQwiOuG3gLMIq
         vw/Q/oS1GkS+GqsoHfCNlHafoD1C9AmMDQ+QYY9aJFnMXxPDyC/ejwd5/re1HvvTTBnH
         SzP3Wp1N0jUPHCDaVCO789mffjhyIjP+PO5ZizHcomAs9Hpkj/SigQJbHNxT0/4MUcTf
         LBbL6d2CJ2owv6AHxJ7niN2oRL3nVDgBLm61wWOMGrKRfM/Ta8DjAaLmj+co18WGwwI4
         ChpRabNFLTgA5dzMStMr20P/wo6DZVKLw+i+dpE18HQZFChYMTDzW9ae//eZCKLRpGiI
         9/cA==
X-Gm-Message-State: APjAAAVsUJypfxLvzkG4FHCGk97Jrd8e/W/QmDJjOjgM46pF9CqlQ3c2
        dJszV/o11/xsyxLotEWdfZY=
X-Google-Smtp-Source: APXvYqymWFT56IJ+vjDefojeO4qqFdA/Csb37ZGdXCQtDhRQsc94r/Go0f1QQr63x8U2PmmWZhdEhA==
X-Received: by 2002:ac8:7b2e:: with SMTP id l14mr4574224qtu.11.1569352878906;
        Tue, 24 Sep 2019 12:21:18 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.210.60])
        by smtp.gmail.com with ESMTPSA id j137sm1571001qke.64.2019.09.24.12.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 12:21:18 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A9DA041105; Tue, 24 Sep 2019 16:20:46 -0300 (-03)
Date:   Tue, 24 Sep 2019 16:20:46 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Andi Kleen <andi@firstfloor.org>,
        jolsa@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] perf, stat: Fix free memory access / memory leaks in
 metrics
Message-ID: <20190924192046.GA20773@kernel.org>
References: <20190923233339.25326-1-andi@firstfloor.org>
 <20190923233339.25326-3-andi@firstfloor.org>
 <20190924075040.GC26797@krava>
 <20190924140856.GQ8537@tassilo.jf.intel.com>
 <20190924144418.GC21815@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924144418.GC21815@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 24, 2019 at 04:44:18PM +0200, Jiri Olsa escreveu:
> On Tue, Sep 24, 2019 at 07:08:56AM -0700, Andi Kleen wrote:
> > > >  	expr__ctx_init(&pctx);
> > > > +	/* Must be first id entry */
> > > > +	expr__add_id(&pctx, name, avg);
> > > 
> > > hum, shouldn't u instead use strdup(name) instead of name?
> > 
> > The cleanup loop later skips freeing the first entry.
> 
> aaah, nice ;-)
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, reproduced and applied, before the patch:

      # perf stat -M IpB,IpCall,IpTB,IPC,Retiring_SMT,Frontend_Bound_SMT,Kernel_Utilization,CPU_Utilization --metric-only -a -I 1000 sleep 2
      #           time      CPU_Utilization
           1.000470810                      free(): double free detected in tcache 2
      Aborted (core dumped)
      #

- Arnaldo

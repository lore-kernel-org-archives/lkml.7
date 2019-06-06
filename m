Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05008C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB00020872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oD872j0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfFFTTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:19:45 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:37071 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbfFFTTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:19:44 -0400
Received: by mail-qt1-f182.google.com with SMTP id y57so4058420qtk.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 12:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2oS5QNLHGlJv3yS1XyyZhPfR0aQYy6cC8m3Y2LuoN4U=;
        b=oD872j0ckEfzVVFQVCmfBjtoZOeaNs++his5eoMg5PjTNF7yLnceoZjgdQDCTYkDDi
         U5ZE0+oiQ2AHoN/3VL0ixAYoRiMQR5nBzBwjjEWq7ekox4Vrpc0K7ZrixZ0jjjdUATE2
         D1a0bVBctCVysjRltlusKJr79C8odIw3wgv8LSTEFwOi9Z5/pI351qHbSoEEco8tg8rz
         OLdwc/FPbs2I8le2RfETGtWSODwSgcxWb4EBBaO2p9T9MNcQ7YQs79GpX8EVhIXt9U1Q
         266wGP/xSRioMC0GtY5w0mnFJLKMQCx/hOlubYe2fGyvTHwHVqa+AeGqXLtTBqIFAGjM
         9hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2oS5QNLHGlJv3yS1XyyZhPfR0aQYy6cC8m3Y2LuoN4U=;
        b=ruLmw5LpYDoEDHGApzo15NCZiFEstUS151FR2Pj1nqSWhw7VbrCIaH8UW122eiME83
         lBuvQxvRWMHplM2v8gK7X25reEYWCiW3ys8CLFuP7pTErH6fngHHHpVxovyLcIaQ+mOs
         CbAljDwHTcbbmv6k8HSeK7YblkustBu7K9RnS/sGqmAxaDy4CZdDj0JVtdUn8aMIsuld
         mV8hfpSwbj2WFc2a6zMGJtIWaNQeykGdTEw3b7gyn8qx+qHJon82iIf+6w8TmSdjG+xq
         H3mbcpj9DJEhdMD+h6JL7vYmVBR1yNdiyVlfCC/7OEEqXpcyc/CQapEeRbi4wD0jwH7W
         zlZQ==
X-Gm-Message-State: APjAAAWFt3izwtWRIxTJgC0EJ+aD/15lgrjYTmINaZOwvTu92GUo539j
        /gATWEzzV3xBkGpL9cJsnV0=
X-Google-Smtp-Source: APXvYqx7Imnl8WlP7WPtMnHGaDETa1iIdLlD5ktDlqTrh1dejzjRzship7BRay7fzSIyLa8+RiNElw==
X-Received: by 2002:aed:3535:: with SMTP id a50mr43101741qte.237.1559848783662;
        Thu, 06 Jun 2019 12:19:43 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.209.167])
        by smtp.gmail.com with ESMTPSA id t6sm1543517qti.30.2019.06.06.12.19.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 12:19:43 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7727A41149; Thu,  6 Jun 2019 16:19:30 -0300 (-03)
Date:   Thu, 6 Jun 2019 16:19:30 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     kan.liang@linux.intel.com, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        ak@linux.intel.com
Subject: Re: [PATCH V3 1/5] perf cpumap: Retrieve die id information
Message-ID: <20190606191930.GH21245@kernel.org>
References: <1559688644-106558-1-git-send-email-kan.liang@linux.intel.com>
 <20190605090907.GC23116@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605090907.GC23116@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 05, 2019 at 11:09:07AM +0200, Jiri Olsa escreveu:
> On Tue, Jun 04, 2019 at 03:50:40PM -0700, kan.liang@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > 
> > There is no function to retrieve die id information of a given CPU.
> > 
> > Add cpu_map__get_die_id() to retrieve die id information.
> > 
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > ---
> > 
> > No changes since V2.
> 
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>
> 
> for the whole patchset

Thanks, applied.

- Arnaldo

Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CA6C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3628C206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSPM8eue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbfI3Ksr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:48:47 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:43631 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729870AbfI3Ksr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 06:48:47 -0400
Received: by mail-qt1-f181.google.com with SMTP id c3so16339887qtv.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 03:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SO892WAVgocnbXqqMJG3LZJ1u8N49nNayKbSCOkyt/Y=;
        b=pSPM8eue8Pt+JuI99tgHoPBekOi6xG/jeBGX2N6BM8n9VHgbNJLAglrhW+vjHX6Jhs
         KYybKQ9xC/BdG+9tHzc77DKbjZ0QGmif7t2Xn88xmVHg6lLhCx2aHPGwcB23IGCzygFK
         3DfjCwXxWH8ZOvlj5BSrfNuFMnaRcfvXfVrCN7KILPtS2FYWmYtC9QixjKYfvAGSoPgB
         QkDpL1v2y9DITlYwGnISYE7BPrxRS6ejTo+XYKdtdS3gpXFM/Wrk6PjKfkfPfNZUxCWS
         mvGaSzqN3GKxlIy3cqk+XnKvuxWT0cAqArqX5yo7AiYaguqmHJXmaNfLuq761wpVxSEE
         mUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SO892WAVgocnbXqqMJG3LZJ1u8N49nNayKbSCOkyt/Y=;
        b=PdMStLf0zmyxjQpbKIcSEDWYSLyDZCon6pilGJI+LbYhHHLOxMK+JVI3PdXDm944xc
         TtD6GIdVtEsMN6MexoEBZ7SmZY29C8rLJ/ZlZI54BQx/DJFhLiCzerGpRgndm1ovMvaw
         x5kHj0ESNXqyRtO75p2tDu/dFY6LCIJZ2OzR13oHdkZwKdQVX4paQ+liVBzkSM43HAPk
         vVlD+8dnSx3Jh7R6gRwIhlTaLQpqQnTyv6rJuTbl7BkT+0cDUTE59LOUjVDbLSRBRgdY
         OOKi1WeFVgCMjeL0uGT2iqM2Kjms1EAJBXwLnSLSUGNVSfz7x9uV0Oah4zA8WmJPfSjI
         cDNw==
X-Gm-Message-State: APjAAAXnDsCXBx9G/DdkFXZNsoJ8Q79ZECIyHtdgK/rPNAs5ec7ZYhlI
        /EBZ/cgxaGZvYD0KS6qhN74=
X-Google-Smtp-Source: APXvYqwKZ7sJYOgpP02aZtVW+zEDSNO1VwJvSmPdXjB9HVjhvw5CgU9MakPOZ5qCu5eCIKeFf9ipXw==
X-Received: by 2002:ac8:160d:: with SMTP id p13mr24156259qtj.189.1569840526287;
        Mon, 30 Sep 2019 03:48:46 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id i30sm7661217qte.27.2019.09.30.03.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 03:48:45 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B7DBA40396; Mon, 30 Sep 2019 07:48:43 -0300 (-03)
Date:   Mon, 30 Sep 2019 07:48:43 -0300
To:     Stephane Eranian <eranian@google.com>
Cc:     Steve MacLean <Steve.MacLean@microsoft.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        John Keeping <john@metanate.com>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Leo Yan <leo.yan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Robbins <brianrob@microsoft.com>,
        Tom McDonald <Thomas.McDonald@microsoft.com>,
        John Salem <josalem@microsoft.com>
Subject: Re: [PATCH 4/4] perf docs: Correct and clarify jitdump spec
Message-ID: <20190930104843.GC9622@kernel.org>
References: <BN8PR21MB1362F63CDE7AC69736FC7F9EF7800@BN8PR21MB1362.namprd21.prod.outlook.com>
 <CABPqkBTVso=2bo1EkYETXBOk_g1ykiZdHcQmt9uew5JECQzEBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBTVso=2bo1EkYETXBOk_g1ykiZdHcQmt9uew5JECQzEBw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 27, 2019 at 09:39:00PM -0700, Stephane Eranian escreveu:
> On Fri, Sep 27, 2019 at 6:53 PM Steve MacLean
> <Steve.MacLean@microsoft.com> wrote:
> >
> > Specification claims latest version of jitdump file format is 2. Current
> > jit dump reading code treats 1 as the latest version.
> >
> > Correct spec to match code.

<SNIP>
 
> Corrections are valid.
> 
> Acked-by: Stephane Eranian <eranian@google.com>

Thanks, applied.

- Arnaldo

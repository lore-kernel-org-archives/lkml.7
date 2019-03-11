Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36FCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DEE20828
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXd424oP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfCKRFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:05:09 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37550 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbfCKRFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:05:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id z17so5889522qtn.4;
        Mon, 11 Mar 2019 10:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kg5/8Cp0fzBEwa3lnBHbpJ9hSN5foWZQ3REej7M1LZo=;
        b=qXd424oPqePKlAGTT17heg67fjbvf3lPt2udU/QGcJNsOb2zZD2G5l+jYuQaBOw1eO
         Q1rWtB8GTx1OV0tWQEEvLhE/kTLOBvH0e1Aa2Y//12AwBE6ZqPAJUsOTafwnK8dXqSlC
         +0CZY2dVSxVFbrLINjdUhn0g4rZSZSN6/5HWacHZAxoeDVspixeaYr6EmGk2cJ0XtRsg
         /kRQJTw4gtFXOCdkkHJcUcPK1vfzrY6kGbI3NozlOgge5kWhlG0J9CMGWK71t4vCRI7k
         8itwAJf/3CaGY5LvNUZhCwE5Q3aZNK0LJ8h/k66QZUM5aGrKeoDZojc2B278RQboUmWe
         4p6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kg5/8Cp0fzBEwa3lnBHbpJ9hSN5foWZQ3REej7M1LZo=;
        b=jYwICQlW9j3Scwg/R2kcAJnO1yKb+FkR6EXM3hGvjauQ37bS7HdwHFRsbqy7iJCKNi
         vR0fZMTPN/DbxMe7iwBcYv7cb2hFM7kIesvz6NKkL0sqr1eB3woAhuyGb+Xt37nj4/EX
         OBg6sEQ8a4uI8MfoCOcjsZmN6uZW9W4r0OgsdzBHXHI2ffLyOARs2MtGzrr8yeTb6Go6
         pVPO0qwBlNAABOAkoAZQXhhvyhNCa3+3uIqNw0EprsRngar4Oh0uLSukIveuOtR0khvE
         0S6hmjCIGR5ZCz9eELhFLX5mTVQ0VJ3ZZ/8u4ZMQhzR0Dt4O0nM140A5csaaNVDJ/G5g
         67HA==
X-Gm-Message-State: APjAAAWF8um6v+E6UEWyG2rvHsNcOrN9gSIUrmi7eTOP+6Ho11EJmPkN
        nqeFWBRhTobsjmfaZIxlA4M=
X-Google-Smtp-Source: APXvYqxhDg/DvoMZv7LDGJTTuB8woBNMftV1wE/z9XdTI8i3qXCTg+oS3kSMYA7Id7n0kA6ASZbFDA==
X-Received: by 2002:a0c:afef:: with SMTP id t44mr13988703qvc.59.1552323908520;
        Mon, 11 Mar 2019 10:05:08 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.162.132.204])
        by smtp.gmail.com with ESMTPSA id h52sm4153956qte.78.2019.03.11.10.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 10:05:07 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 83C7C4039C; Mon, 11 Mar 2019 14:05:04 -0300 (-03)
Date:   Mon, 11 Mar 2019 14:05:04 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v6 04/11] perf tools report: Use less for scripts output
Message-ID: <20190311170504.GQ10690@kernel.org>
References: <20190311144502.15423-1-andi@firstfloor.org>
 <20190311144502.15423-5-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311144502.15423-5-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 07:44:55AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The UI viewer for scripts output has a lot of limitations: limited size,
> no search or save function, slow, and various other issues.
> 
> Just use 'less' to display directly on the terminal instead.
> 
> This won't work in gtk mode, but gtk doesn't support these
> context menus anyways. If that is ever done could use an terminal
> for the output.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Thanks. applied.

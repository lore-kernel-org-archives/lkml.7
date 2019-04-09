Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE98C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE01214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgKQFcsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfDIRA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:00:58 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:46075 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDIRA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:00:57 -0400
Received: by mail-lf1-f44.google.com with SMTP id t15so9025817lfl.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 10:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EVEEcAd9WHhYjPxPs9+RgAT+g9az+iC7s/1ataG+iSY=;
        b=SgKQFcskFAzwd49wNA4VbDlzcCwa5tkIkxDn5LKGrzx/JWQHhpH2M45WVG7errFM5h
         9FVfWPfMfh16Mivgy51er/QukcyhGkaSZxWeGWmdEETIp8V4g8m2oWgLU2IipnU0sj2N
         ASezx+WmRXxQrJnvuzIvBW33SbDbvYgHLbDjCdOpeBxPeStMruskMJ++fQQNA5nffbF7
         9Nd5JGdXK0L+uI9ioGnDNK/4miD68Y6Paoq7BMZIbULFdbtpki/bUc4XPYT6fgenK/JK
         w6q6RRVTcpqCVWFZdQr3NmdGj3UZEGFQA1NDeSsxHBRi7ekLWh6lcIzwVSTOifFLUldZ
         22/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EVEEcAd9WHhYjPxPs9+RgAT+g9az+iC7s/1ataG+iSY=;
        b=Za0LHXbmwDbtBTu4Vwl8xCmQTWxG30om2grEvqRNdYvCFrVZMFCBxBDnI0lwAvQbiw
         k2wRuwujokmCwt8a7Hd9jhK0atTSKUNvNnQedl5Vdpemw8zeW8kHkR4obPiNvzXgu20I
         513jET9oTxs5qW6gxBaqeQiAD6SQAYTgQXshCLdyiDBN5Kauf7wDZ0jVvBkW8eGEdqFY
         tfNrabE2Jhtu7MBvRaNxHvfAYaw6+lIJomUKQv2ARBe75G/6Kw2eLu/SOXVRdPjwswJA
         fm7fF021YJpD8X5+sdauPYyt39Wwc6IRqZSMLRtgMGtXimRVpaTHanY1M0+KMjCqzIeS
         iy7g==
X-Gm-Message-State: APjAAAWng+Ez36FR5Sh+XqDVSmgzX1H4aBGlNNTZ8t0/BukXW0UjDaoC
        OEu7Hgk/a7MDnsF9WErzr4FZ08pC
X-Google-Smtp-Source: APXvYqy3/1b4a2EVEqb9i7SZH+MXGJ1pfq8WYe3ZCpunokseVop/O6Zxw3h+8AaFqErA4jo6e0HIoA==
X-Received: by 2002:a19:761a:: with SMTP id c26mr3126814lff.8.1554829255789;
        Tue, 09 Apr 2019 10:00:55 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id q5sm5273294lff.30.2019.04.09.10.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 10:00:54 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 737B44606E7; Tue,  9 Apr 2019 20:00:54 +0300 (MSK)
Date:   Tue, 9 Apr 2019 20:00:54 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: perf: perf_fuzzer crashes on Pentium 4 systems
Message-ID: <20190409170054.GF1421@uranus.lan>
References: <20190403191944.GH1421@uranus.lan>
 <20190403203144.GI1421@uranus.lan>
 <alpine.DEB.2.21.1904040922350.3758@macbook-air>
 <20190404133327.GP1421@uranus.lan>
 <alpine.DEB.2.21.1904041234340.5098@macbook-air>
 <20190404164700.GR1421@uranus.lan>
 <alpine.DEB.2.21.1904041454290.5597@macbook-air>
 <20190404202038.GT1421@uranus.lan>
 <20190407202055.GX1421@uranus.lan>
 <alpine.DEB.2.21.1904091237090.15486@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904091237090.15486@macbook-air>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 12:38:25PM -0400, Vince Weaver wrote:
> 
> It still crashes at the same place with this patch and my reproducible 
> test case.

Thank for testing, Vince! At least now we know it is unrelated to
alias events. Will ping you once I get more ideas.

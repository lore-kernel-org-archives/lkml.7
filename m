Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59F9C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9377C205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNzieVOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfDSS6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:58:32 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:35520 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfDSS6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:58:32 -0400
Received: by mail-pl1-f171.google.com with SMTP id w24so2982451plp.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/smgrwNL9Ro4smy+pIRIb1DughZuGs785pN/B2Zi9BQ=;
        b=jNzieVOpsTV/9e0hZwK9DaR8wPUHEAhheEjR8bvSNIV1mBeCWXLK0sx6WOPCvq8DWP
         7sj0IGesfW/sksf7f/GLHpr1J+wxGYumpEmMSEwUMQ1LyMUL2myckX/Obb18iUqX4tyP
         nnlNvp1owxRFMGQ1tepIGYli2ITfGe1ZMBBmsCulDUlfMA0FZ75KUoYZWVJjrTDJlc9u
         WuHcEPNXvWjjJAV74KkUdSfEJDLI8YjXrFtYejL5P2aofCB/hFaGPpyINL21YJk9zymJ
         Vnt+OojkY3BZKcdXWRcUdG6yrXZ3srjeWHJXCewgDo8KfcA9pTHSd4oWw3sic+PwFUus
         lgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/smgrwNL9Ro4smy+pIRIb1DughZuGs785pN/B2Zi9BQ=;
        b=Azs9jmcKbyqxygggPwhMhboElu65kCULEZy3j01hu6zMwJOezhemgyh7+izdgEugGB
         Bx2F1V8utaBAVvLuBvggb6Yk/C4FCpSRizulyvulu3vS8NaNmUnPh++YIyjhBtTT6YKY
         EWaBRdFUZ3VP0LNbUDRg+BllvXa2YVOfD1Q1NIDrXM8Jdl3DfjER+reT0744Cso7FfnD
         H0OMAOr79FlVPPyHiKBgfM4JpxCy1dWT4BcJQ2deMVK2WP/JUb+AAsilR5el2xJHkWe5
         J5A0b09tQO6fqycYTXJ7yuBRhlKphmUX9AArvm/cmr5PiCIrNeaWQZ9/wxRKLRCgoOYc
         9SGA==
X-Gm-Message-State: APjAAAVDKpevo0gs49H1Lih5cI900/SWcO/rlvCeC6MnfK/mfX3xyB9H
        6hQRINEPaEM5RShqlwgiRPJPPn+t
X-Google-Smtp-Source: APXvYqxu0AYyKOqFHsRy6w/hRtcq1zY7cUnWr526D4YGfCmPxmglbud6ng9MVob2RfA2Kskvi/X4+Q==
X-Received: by 2002:a17:902:8a8b:: with SMTP id p11mr3236687plo.227.1555673723814;
        Fri, 19 Apr 2019 04:35:23 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id k9sm5553457pga.22.2019.04.19.04.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 04:35:22 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 19 Apr 2019 21:33:26 +0900
To:     yamada.masahiro@socionext.com
Cc:     sergey.senozhatsky.work@gmail.com, linux-kernel@vger.kernel.org,
        sergey.senozhatsky@gmail.com
Subject: Re: [next] kbuild: use $(srctree) instead of KBUILD_SRC to check
 out-of-tree build
Message-ID: <20190419123326.GA476@tigerII.localdomain>
References: <20190419083339.GA8504@jagdpanzerIV>
 <43c5127830dd44e0817c2aa1906fe515@SOC-EX01V.e01.socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43c5127830dd44e0817c2aa1906fe515@SOC-EX01V.e01.socionext.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/19/19 08:59), yamada.masahiro@socionext.com wrote:
> > It seems that commit a9a49c2ad9b9b8 (linux-next) breaks ./scripts/tags.sh
> > on my system. It scans, basically, my entire drive now (including the
> > root partition):
> > 
> > $ ./scripts/tags.sh tags
> 
> I did not know this script is run directly
> because I expected people were using 'make tags'.

:) I always run it directly, didn't even know there was 'make tags'

> It is easy to fix, though.

Works fine.

Tested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss

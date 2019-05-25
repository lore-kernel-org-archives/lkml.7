Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BECC04AB0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 09:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B692133D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 09:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="O2xcEAc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfEYJYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 05:24:09 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36472 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfEYJYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 05:24:09 -0400
Received: by mail-lf1-f68.google.com with SMTP id y10so8810450lfl.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 02:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zLPXe8YfAMWrMxZxyor/59W4BIdpO5GJjp5HzwcajBk=;
        b=O2xcEAc62rrzl5ZEYLoz6T0zW68KCQMp9xLEnRtfDTBVONdXteRWJBL3z1vwwO5nb3
         g3I8gtYILSeK6gkJKljYdYKdMSG+Q5Izz6Whe0179wVLBIPGuYYL0BM6hZ2VWj8W2xCd
         cGLEdSDVus4RM60IYAQbIesFBt70sYFHnJgSeQSgkVPNpUa0txrEzBsmeQNsre+KGwpG
         yJRrhr3SDWmzL8GduHA0Ck3AzUJo6q6xS1LWKcpFJ9nLhdYds5rY9tmJ5sWHvJlOn6Rq
         9dSpI5V4ug6pjb/yh9xUEtMPnx8nfS1km03uRPB7B0roBf0Vl/tACBRZnLUIN19WuPzg
         vsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zLPXe8YfAMWrMxZxyor/59W4BIdpO5GJjp5HzwcajBk=;
        b=f313L+RoPDtXFU/3J39RpQsPzE1QV70X9Im0BfColU3MIPRuedfc18IBm3jIzydJZr
         Bi1qijdCY1aSV9QQb33ChMnU335SbUMa5jfKS8Fxc32kU9g0wWX6y7/BRyknRs4kihh/
         k2iZP3qKyi/GgHvKQRxYEH/QSZPD3jvs9AsVnrevdhH3JGW5OXCwFLCYCt12aPBRxu7r
         2jm/l2DDVwQ37aVTI6iq65vR5RonMeNM7brwaeP26wvD0oEWhMrANZA4plAK7fUvf1uu
         MyDuN6co+ATjZ3rtMiFG2lWrp7XbTPSoP2g2h4Voiesn4meJgvLqCHfl80O5MhzX74lK
         NpIA==
X-Gm-Message-State: APjAAAUC54mzeFpa0mFfYuY6MXlYLU52Lea1aYeLG3/XNeHXCQIgMiHP
        akVJ1PepfT0SsxsIBl6S9Poprx+nqsUnIw==
X-Google-Smtp-Source: APXvYqybSZykR0c6vHf89ir+w3lQi90PZd4QnIShqRFeafVjYcq59+X5gjxiJ/oXmhEnHMIAM6oduw==
X-Received: by 2002:ac2:51a3:: with SMTP id f3mr807910lfk.125.1558776247159;
        Sat, 25 May 2019 02:24:07 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id h14sm979318ljj.11.2019.05.25.02.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 02:24:06 -0700 (PDT)
Date:   Sat, 25 May 2019 11:24:04 +0200
From:   Simon =?utf-8?Q?Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: kpc2000: add missing dependencies for
 kpc2000
Message-ID: <20190525092404.go3qlfknra6g3fot@dev.nikanor.nu>
References: <20190524203058.30022-1-simon@nikanor.nu>
 <20190524203058.30022-3-simon@nikanor.nu>
 <20190525050017.GA18684@kroah.com>
 <20190525083918.dxa5qtomlu5yyqw5@dev.nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190525083918.dxa5qtomlu5yyqw5@dev.nikanor.nu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 10:39:18AM +0200, Simon Sandström wrote:
> On Sat, May 25, 2019 at 07:00:17AM +0200, Greg KH wrote:
> > 
> > This is already in linux-next (in a different form), are you sure you
> > are working against the latest kernel tree?
> > 
> > thanks,
> > 
> > greg k-h
> 
> It's based on your staging tree. I think that I have to go back and read
> about next trees again, because I thought it took longer time for things
> to get from staging-next to linux-next.
> 
> Anyway, neither the MFD_CORE nor the typo fix is in linux-next so I
> guess that I could just rebase this on linux-next and re-send as v2.
> I'm not sure if MFD_CORE should be "depends on" or "select" though...
> 
> 
> - Simon

Oh, it must be "select MFD_CORE" because there is no prompt for
MFD_CORE? Should I just rebase it on linux-next and re-send as v2 then?


- Simon

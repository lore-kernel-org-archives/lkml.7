Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56CFC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F2D20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555340615;
	bh=LbMuZJXS3OuHCA50YYwRd7qhH0F0uusSi5Tdf1BeWYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=19jjNMiLXf8rYbwlneETlkl1QfKE8/21B6rl4tuOEAYaia4ZUAXLyvHS676/VOi85
	 ktwgD8pq8vT0XvN8NIbG12zPNGJtXaaBsNaMPsveuJP+Hd0I1UBzFlfSIsWbHLlIDZ
	 2AgmzHJFkSIo9U8410nfTxZlpWcCWdENJg9Cl3Wg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfDOPDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:03:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43320 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbfDOPDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:03:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id i68so2442697lfi.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 08:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z5LOiqCT2DO1rtZ6X70ffSdt0K6mgD3RtIkDbDwnU5M=;
        b=czC6JhfMudxVT4xD8skQpmlKC8ZCDSFLCJBcxne/pOw/e+emu/gVm3qs+7ZO905B0X
         hZKree3K58yMhGjSm1In+tEDS6YeLDwTNf2+QIA3PamwB6CyOWSs2XI81r4bTrwj0Pgo
         eAquPKo71NI2HvS8HuZxMBJegjImbdFdImSodKtSvxET0cMHMaM97DWxRO8xEX05HSWh
         O2PTn0oFke6mTOk+LhII1QPufnLHGgrPCW2k9AyWj20F+mEiy4J6PhJ+RJgXBHWJW4dO
         dZsE/2e8wMoQcxuYNwMmsBm3+LZwnnW6UKeaQ33cDGXiieXwI+mtUuCAfAzT5YfxxS+P
         eYQA==
X-Gm-Message-State: APjAAAWI2/GzEzv/vTrbOr4eq7O9BYcVuez5yhMuL+N8VYCpxABYxCje
        wrwRp/niOOOM13ZiTfPrkhg=
X-Google-Smtp-Source: APXvYqw1mfwkaNel6rJ2q9bmkeboo8NXLX6+majtiahj1daPzxxdr/z1sb3S/+CdrQX1mjvq0jdhtw==
X-Received: by 2002:a19:6911:: with SMTP id e17mr11462421lfc.5.1555340608776;
        Mon, 15 Apr 2019 08:03:28 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id o7sm9956476ljj.23.2019.04.15.08.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 08:03:27 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hG38v-0003QZ-CJ; Mon, 15 Apr 2019 17:03:33 +0200
Date:   Mon, 15 Apr 2019 17:03:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Johan Hovold <johan@kernel.org>, devel@driverdev.osuosl.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        greybus-dev@lists.linaro.org
Subject: Re: [PATCH] Staging: greybus: Cleanup in header file control.h
Message-ID: <20190415150333.GE775@localhost>
References: <20190405201437.3689-1-madhumithabiw@gmail.com>
 <20190415131002.GC775@localhost>
 <20190415133357.GP6095@kadam>
 <20190415141201.GD775@localhost>
 <20190415144015.GB22423@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415144015.GB22423@kadam>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:40:16PM +0300, Dan Carpenter wrote:
> What I'm saying is that if we just apply it then we avoid the long
> discussion forever.  The macro is OK, sure, but it's not like anyone is
> going to come back later and argue that macros are better or preferred.

That may be a valid argument, at least with respect to staging
currently (even if checkpatch isn't entirely too blame for this
particular "cleanup").

But then all eight or so instances should be replaced in one go, to
maintain consistency.

Johan

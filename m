Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33D7C2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B677206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mjst4cLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfL3SIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:08:52 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35587 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfL3SIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 13:08:52 -0500
Received: by mail-yb1-f195.google.com with SMTP id a124so14400797ybg.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 10:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ygcEd+mjaSKrmBq/UwIfmJMGRSUP47afmC7rxQ+g8j4=;
        b=mjst4cLscGZODIE7UbwbgrzDoRxVSdO3I/bbcHFxXAQac+bF/lkEoQTB3tX8Oom7TA
         JvlghNn4OJZ6CS4bqaRb2yoH9ZIxNCdTPe5zlV9VaavRHmE25TZjvOKJ8zT96huqj1tV
         GP8/bMBQ2uEgIgjCdqaL7UUWo58SiYdJ8UaL+lwtTFiKXwf/aUa/uWgOUxyKQFDQIRYY
         GTPZLY9DurdLifuqeQ2rg/sD6ct7NUrKSM75KJJPaY/+m0lntc7dDtYSwt/jBs4a9Iz9
         PGRF8qucfm5hBbZ+TCHvmzu6gq0v50VonvotPCrYJCnX3qgYZYMGnB6GGGfEhOC+mmDN
         E/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=ygcEd+mjaSKrmBq/UwIfmJMGRSUP47afmC7rxQ+g8j4=;
        b=iIDLAIJaQiGpKxz6K6cCYoaduyNplpoFa45FS5FTX0UJMcURbFlaaB7vtV0UV43gsq
         eGdnPpEe6yk6KvHGyeLQufk9fdkPl4SaDElg3dFfF0FmAT3k+gOZOeMFyl5AAlSvsBwt
         JSJTwH4n4q9VdL4Ic/Z27ryY/9SuCz0KI6tlMT6vMADSv6n4V4wvKkWgJeP2eaCo0rce
         TNlO0ddBP1WJaUFoldhqtrZqcyd3Pq5Wi+3A8D/zGvXCu8p927ZtGS2agyatseVQFer0
         TGqaVP7EBxZLqTJET2kpbwbPR40F9eeiGtID4AnUBVcKEJtcETtQ5ZkYyRMjOSnx01nG
         CaNA==
X-Gm-Message-State: APjAAAW16tKAYvgI2pD4w3qoCBY+fXb7uBev51NnDVQv8kjB1AMBXyL2
        5hTi7dZWt50ONR6j10orD043Aw==
X-Google-Smtp-Source: APXvYqwxwYcMJXoYHEy/yMGknkS1/KFBVaRMibslurcfAySvGWHO2v2vgFSggO48BTEnfUYHoz3osw==
X-Received: by 2002:a25:774a:: with SMTP id s71mr32294631ybc.189.1577729331013;
        Mon, 30 Dec 2019 10:08:51 -0800 (PST)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id d143sm18132446ywb.51.2019.12.30.10.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 10:08:50 -0800 (PST)
Date:   Mon, 30 Dec 2019 12:08:49 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.4 000/434] 5.4.7-stable review
Message-ID: <20191230180849.222x3hg2tnpwz7dn@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20191229172702.393141737@linuxfoundation.org>
 <20191230163437.sz4mb5gh7ed2htfa@xps.therub.org>
 <20191230174522.GA1499079@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191230174522.GA1499079@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 06:45:22PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Dec 30, 2019 at 10:34:37AM -0600, Dan Rue wrote:
> > On Sun, Dec 29, 2019 at 06:20:53PM +0100, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.4.7 release.
> > > There are 434 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > 
> > Results from Linaro’s test farm.
> > No regressions on arm64, arm, x86_64, and i386.
> 
> Thanks for testing all of these and letting me know.
> 
> But didn't you add perf build testing to your builds?  That should have
> broken things, so I am guessing not :(

We do build (and run) perf, and it worked for us. Which patch was the
problem? I can go look at why our config didn't hit the offending
code/build path.

Dan

-- 
Linaro LKFT
https://lkft.linaro.org

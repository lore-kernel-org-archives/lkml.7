Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A470C606B3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE35D2064B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eng.ucsd.edu header.i=@eng.ucsd.edu header.b="LELtTuNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbfGHNFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:05:47 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41047 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbfGHNFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:05:47 -0400
Received: by mail-lf1-f65.google.com with SMTP id 62so10879269lfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 06:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eng.ucsd.edu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3G1xWiLRveQufUy4czQFKlLV6/S0Oxxp00Zgaxp779A=;
        b=LELtTuNFVhVuc34C/jKXlj11scoGzAUkn7yJ5qGtaqRsSEzVvlsbLSg37OZ4KKACA/
         cje50xyprIexkvMb7RWGLTvj7sw3OSymSOZ5e6YNjKNk9hMZYo/tvi839BSvbOhV5uIS
         eFXwARDMSRQHrARp7Bzvfzo5ck1/jC1CBzpLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3G1xWiLRveQufUy4czQFKlLV6/S0Oxxp00Zgaxp779A=;
        b=SCMfZd2t8hzMIqMEuFvKetwkFHVGk75W++3UipWeMtgJJ1HlC9iULgXiPGkbKjNPLJ
         qBagAGtQRPAlIYKc5qqwCmHWw6tRyH3lfG4PNbGNwwc7gyyFIkLufkgY/CRyNQuZRrN4
         ta3TaSJrrWPR88i0w3Rue3reHtA/N/DOfENSbeNMc5U3l1vYqw4dN0ou3KkVOGBTJzdx
         BsFJbJaV94OTA+srvohhJZb/yzfvUS1q3Imt5//ZDUDkKLIBlE/vYTG1byj2et8/q8qo
         hT6AmhQ2QYTp3if8LLqvp1af86kOsMbnaA8AvpOH/C9dASz6gRBEEnkp4wlTl/nCDRp7
         N6Rw==
X-Gm-Message-State: APjAAAWBltryj4fB3dpVQkTYnoyfi2R1bpH/exqvtAP7J9YBdm4KnpB1
        OvsNPuPF3OLqilMs8W32Kj48OA==
X-Google-Smtp-Source: APXvYqyu8KLlGXUs6ikA3V7LKlY+SPgLgJtLTRKkw/ZVGH2g7/mS/5KQzQQxFWnpBLpeyOYJifVEhg==
X-Received: by 2002:a19:7f17:: with SMTP id a23mr9285124lfd.49.1562591145343;
        Mon, 08 Jul 2019 06:05:45 -0700 (PDT)
Received: from luke-XPS-13 (77-255-206-190.adsl.inetia.pl. [77.255.206.190])
        by smtp.gmail.com with ESMTPSA id l25sm3640321lja.76.2019.07.08.06.05.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 06:05:44 -0700 (PDT)
Date:   Mon, 8 Jul 2019 06:05:42 -0700
From:   Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
        akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>
Subject: Re: [PATCH 3.16 000/129] 3.16.70-rc1 review
Message-ID: <20190708130511.GA4626@luke-XPS-13>
References: <lsq.1562518456.876074874@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lsq.1562518456.876074874@decadent.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I got 1 error when applying this patch series to the latest linux-3.16.y
stable branch

fs/fuse/file.c:218:3: error: implicit declaration of function ‘stream_open’

Thanks, 
- Luke

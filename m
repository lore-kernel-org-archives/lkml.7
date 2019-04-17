Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570A4C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2901F20821
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1FGwfP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732745AbfDQQky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:40:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46446 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDQQkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:40:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id 9so12331944pfj.13;
        Wed, 17 Apr 2019 09:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sLMDtVhWt66fD2AMBpn2dT2W59pJlixF8xQq6LmHHtk=;
        b=n1FGwfP5ril/tgqZztDC4lOF07I1303o2wJzOzyIx/RsKczPrY+6s+tVb1jouYKfxm
         ikmhSDoPOOV7twGLHLdksPiP47iyK3L1x8lW08SJEuPPyXdphFmzdnDDmSpKXhhtpnKo
         oHTsDC+QfClqFfsrXDY6dbb7SZWdk587i3z/zpR6fZ3smlHg9CtMvrZQXqAPoU6HicNL
         VjkeKofMcm6IhhxMSXH4366C66aV2bS5T8K0aGhsC9JBweJJiR8DTxxExh3NAA26HhMh
         Rd6ryCqnpu9sN23J3PLtES5pJ2gQRLtj17eziJplBoFF0GvzahKJMxaqhc0kEvKDCtJf
         9FLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sLMDtVhWt66fD2AMBpn2dT2W59pJlixF8xQq6LmHHtk=;
        b=QV55MGIitMs+iTR7MRDJMLVrHggBysZYq12OwmWmK/kXo1aJ0dDP322gDCYFLv/xZ0
         7skMnnSoLA5HZPE0aDljxgvS7kYahKSXZ9E4ly1TRw/J5NyVUh53vjd41WQXtEAfQmod
         z4fZ1WICIeGxYT2WXAw1QFzgE6BuR2a9TO8JPGZWFdq4jXJImOCeF7CTLP9FlT5Tnw3x
         LZa6ld2OhwHm7JXXGzuINDTbv6NA/+h0b0Y/kKUJBIXHgqMbZzAzHGmxooagtywWScHl
         98bI8dfqgfQP+eeyGfnp5GsQmq5Pi4zU3ekOO/OF1jMBKpl3jNrtNjIxWyNaf0a5gRd7
         KK1g==
X-Gm-Message-State: APjAAAWiLKW763MwJJ22D0b4QinnDoRMzMJctvplUYITkxsAN/tRMoLg
        hOj2L5oZ2xMf00yEynYR/1UzBdbI
X-Google-Smtp-Source: APXvYqyG2QLH/u+H1+C6LuxFoNmbjD/ccrKxvyuisFozui4GrMKizi1LS+Otd3sYBZOXGxfwXLuRhw==
X-Received: by 2002:a62:7648:: with SMTP id r69mr70448521pfc.114.1555519252795;
        Wed, 17 Apr 2019 09:40:52 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.31])
        by smtp.gmail.com with ESMTPSA id t13sm73771596pgo.14.2019.04.17.09.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 09:40:52 -0700 (PDT)
Date:   Wed, 17 Apr 2019 22:10:45 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/101] 4.19.35-stable review
Message-ID: <20190417164045.GA6217@bharath12345-Inspiron-5559>
References: <20190415183740.341577907@linuxfoundation.org>
 <20190416221609.GB3502@bharath12345-Inspiron-5559>
 <20190417061556.GD18320@kroah.com>
 <20190417061615.GE18320@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417061615.GE18320@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 08:16:15AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 17, 2019 at 08:15:56AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 17, 2019 at 03:46:09AM +0530, Bharath Vedartham wrote:
> > > Compiled and Booted(defconfig) on my x86 machine. No dmesg regressions.
> > 
> > Thanks for testing 2 of these and letting me know.
> 
> Oops, you tested 3, thanks for that :)
eager to do more!

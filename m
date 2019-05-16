Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95557C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 22:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2882070D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 22:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nh/TXYLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfEPWr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 18:47:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41528 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfEPWr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 18:47:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id z3so2259818pgp.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 15:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ClyRR3xF+6k+e4O73jcWzYdi+cDXlpCTB+70QdFxP5E=;
        b=nh/TXYLZxXR8swyGizL/Ubk9TntErZ/LuRKKRmi3y9Xlf5f9WyYiRPn7DNX82aXjPi
         dNLBdZJcHhZkCTol2lPAa2O41Vsu+ODryei4G+WmxolBrJAq3YZnGvuXlb9oLvQ8Xbsl
         dl4YhD+Kb1oX/kZVi0UZloj7wJR50qv+uQLOyZN8K4JATr2TJsqvy2LHP4qae3eFM+3L
         GhcMsanqX/Pqq1LMduxRz5buN0smq5NoQBmtpYCS9Moo8ZPCBFb/pXmxKBO5IgEWQjWT
         ZobaPC7J5BbDl+uR+jPEbVbXy/Ijq/gU3aOe7exQUIW7HZSg4ZkZ5mDa5oAwtjuS8KsE
         trjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ClyRR3xF+6k+e4O73jcWzYdi+cDXlpCTB+70QdFxP5E=;
        b=t4zqlieZhHt8h7ZIRt3kMRzF630A4qqoLOYKdRiY5rwbPp1MenGEFHUKSNN/Goqccn
         cU1041wFBoKBKqTHEpkDpyb1+S0pEDRWH0aOzkdRjJ+4W0yAN9TjX0RFbSrg+Kipnn9q
         nBwl2kBlaQbABK3b9Jvnlu391IiHtTZf2f/4vgr95fZspXOcWojKEpcLeA5pXXTQ3EE7
         ZyakL/N0dokq5WgymLQUH93AzRgGoarp4HoCKM2MXknIUY2lN7yatrfnvEPrWKVqv6S/
         ift0xjLCaC8coBUCcWWkUEJ9I8SAUb5hbtdrouBNGy631ghy0zhaHyoPMrkZwuv1BGqA
         Xe1g==
X-Gm-Message-State: APjAAAVIsunKdBCUtDv9cEyJmf21BN5DKTwIFjLbLyHPM+A+8w3LvSHl
        qDUPnLCjIjCF7Yoys6J70tl3zw==
X-Google-Smtp-Source: APXvYqwsB54b3xfi7QnhOhG/Zxm3b28yU+b7dCUTMJNmc6Tx+8DkJ6jZn/TKl+2/5FxbAZrXcF8IXQ==
X-Received: by 2002:a63:903:: with SMTP id 3mr40813537pgj.400.1558046847139;
        Thu, 16 May 2019 15:47:27 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:20fc:89b:acbc:4e17])
        by smtp.googlemail.com with ESMTPSA id h26sm5863566pgh.26.2019.05.16.15.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 15:47:26 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "kernelci.org bot" <bot@kernelci.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/266] 4.4.180-stable review
In-Reply-To: <20190515151307.GA23599@kroah.com>
References: <20190515090722.696531131@linuxfoundation.org> <5cdc2691.1c69fb81.bd8d8.7247@mx.google.com> <20190515151307.GA23599@kroah.com>
Date:   Thu, 16 May 2019 15:47:25 -0700
Message-ID: <7h1s0y9fuq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Wed, May 15, 2019 at 07:47:45AM -0700, kernelci.org bot wrote:
>> stable-rc/linux-4.4.y boot: 98 boots: 1 failed, 92 passed with 3 offline, 1 untried/unknown, 1 conflict (v4.4.179-267-gbe756dada5b7)
>> 
>> Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-4.4.y/kernel/v4.4.179-267-gbe756dada5b7/
>> Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y/kernel/v4.4.179-267-gbe756dada5b7/
>> 
>> Tree: stable-rc
>> Branch: linux-4.4.y
>> Git Describe: v4.4.179-267-gbe756dada5b7
>> Git Commit: be756dada5b771fe51be37a77ad0bdfba543fdae
>> Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>> Tested: 44 unique boards, 21 SoC families, 14 builds out of 190
>> 
>> Boot Regressions Detected:
>> 
>> arm:
>> 
>>     omap2plus_defconfig:
>>         gcc-8:
>>           omap4-panda:
>>               lab-baylibre: new failure (last pass: v4.4.179-254-gce69be0d452a)
>
> Odd, is this specific to this release?

No, looks like a lab-specific hiccup.

A little bit further down in the original report (I know, not a useful
place for it) was this:

> Conflicting Boot Failure Detected: (These likely are not failures as other labs are reporting PASS. Needs review.)
>  
> arm:
>     omap2plus_defconfig:
> 	omap4-panda:
> 	    lab-baylibre: FAIL (gcc-8)
>	    lab-baylibre-seattle: PASS (gcc-8)

which means the same board passed in one lab, but not the other,
suggesting something.

This is a bug in our email reports.  Regressions should not be reported
whene there are conflicting results from labs.

Kevin

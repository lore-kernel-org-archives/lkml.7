Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE09AC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8F0206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="Xwkkm7fo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732781AbfHOThi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 15:37:38 -0400
Received: from mx1.riseup.net ([198.252.153.129]:34750 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbfHOThi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:37:38 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 78EB41B9312;
        Thu, 15 Aug 2019 12:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1565897857; bh=ix+hs2so30zL6vmT5t1SLjzk0RSE7jwWwW/ibMO7iZ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
        b=Xwkkm7fo5P8FEBVd0yjTHeD6Lfy9+phlIFlPVoJC3FA78No2Q7/BGAEwVsYJZd5Pb
         hS9tXg569yJdZrfLjI2GVGleuzhL8A6MbRjySWUlJ7CWFPXRDw485O6I0qOIyaEhuY
         gnG2vZJt0K4/5f0vqKHqIMapYKrSn6WtOVtKTJXg=
X-Riseup-User-ID: C51BCAA73C62FCDD08C039934EB35B621F4A49E71B8A99B773F0C6F3EE5A848A
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 156471209CC;
        Thu, 15 Aug 2019 12:37:35 -0700 (PDT)
Date:   Thu, 15 Aug 2019 22:37:30 +0300
From:   Kernel User <linux-kernel@riseup.net>
To:     linux-kernel@vger.kernel.org
Cc:     mhocko@suse.com, x86@kernel.org
Subject: Re: /sys/devices/system/cpu/vulnerabilities/ doesn't show all known
 CPU vulnerabilities
Message-ID: <20190815223730.0b5c6c13@localhost>
In-Reply-To: <alpine.DEB.2.21.1908151054090.2241@nanos.tec.linutronix.de>
References: <20190813232829.3a1962cc@localhost>
        <20190813212115.GO16770@zn.tnic>
        <20190814010041.098fe4be@localhost>
        <20190814070457.GA26456@zn.tnic>
        <20190814121154.12f488f7@localhost>
        <alpine.DEB.2.21.1908151054090.2241@nanos.tec.linutronix.de>
Reply-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2019 11:03:35 +0200 (CEST) Thomas Gleixner wrote:

> It's used to denote vulnerability classes and their mitigations:
> 
>   - Spectre v1
>   - Spectre v2
>   - Meltdown
>   - SSB
>   - L1TF
>   - MDS

In the Wikipedia article there are:

+ Bounds Check Bypass (Spectre, Variant 1)
+ Branch Target Injection (Spectre, Variant 2)
+ Rogue Data Cache Load (Meltdown, Variant 3)
- Rogue System Register Read (Spectre-NG, Variant 3a)
+ Speculative Store Bypass (Spectre-NG, Variant 4)
- Lazy FP state restore (Spectre-NG)
- Bounds Check Bypass Store (Spectre-NG)
+ Foreshadow
- Spoiler
+ Microarchitectural Data Sampling

I have marked with '+' those which I recognize in the list you provided
and with '-' those which are not.

> We are not tracking subclasses and their individual CVEs.

Why do you say that? In your list only L1TF and MDS are not subclasses,
i.e. subclasses are in the list. So why not have the others? Also
Spoiler seems to be a separate class.

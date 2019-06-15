Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C5AC31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 10:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC4721841
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 10:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="XR6mtp8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfFOKX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 06:23:57 -0400
Received: from mout.web.de ([212.227.15.3]:51119 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfFOKX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 06:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1560594217;
        bh=R68BVvuA51j6Q5XIITBOMYDRwOLJYxCvxbVa8IAAhV8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XR6mtp8WWt7Xht66qCkOFRFAboj0K09wJOtUMeYD3Lp/0JpxKmS/TEZ0Y4eR/sM3h
         sjukBrw4LxEYCl4ezEvHC1RBL8zaCwuPgWZnVs3wJTIjPNLJAeQEell9jcBZ8zNoOO
         BQLQxiDZ6H3DFeYD0Ka6adY0pVNesTz86zdji1jQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.156.60]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M5sDZ-1iZaFs12K1-00xwXD; Sat, 15
 Jun 2019 12:23:37 +0200
Subject: Re: drivers: Provide devm_platform_ioremap_resource_byname()
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Ping CHNG <jack.ping.chng@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Enrico Weigelt <lkml@metux.net>,
        Linus Walleij <linus.walleij@linaro.org>
References: <39e46643-d799-94b7-4aa5-d6d99d738f99@web.de>
 <20190614133840.GN9224@smile.fi.intel.com> <20190614141004.GC7234@kroah.com>
 <20190614144706.GO9224@smile.fi.intel.com>
 <48877575-90b9-3db5-7a25-53cf3817b2ee@web.de>
 <alpine.DEB.2.21.1906151044160.2614@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0c036dc6-61e6-1974-539e-c212802d239b@web.de>
Date:   Sat, 15 Jun 2019 12:23:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906151044160.2614@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:W0d0bJYY/9kHOWd/optuyyUMc9n2NMO9G9BOShg1uAMbL5w1M+m
 WkkWKGkgRsg4pjs06FGdcu/ZIe7XfdLhadDCc73Xg7xm9hKOrOu8h/6PYYHYa4C6VHx9Px8
 NJqnyWxd99CVrhHvgHkzTnH7VHHuD7BE/XT1wt8FgZ8LVBatxr9JorX8grko9ZHdI7QGOEN
 GvIl6lu3A2VEB3p8k2RiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ePxCuqJgQrE=:08jjwXy2+9TYROyLSiyTqD
 oESOfX7C+roti8YBRfU9EF2k2BLEP/wTBB2i7OTolrTqAs45JdL/c9VTMrosqhzS6OZWqf+9/
 lKghpmz/EHfdTLkZv+oisy1bEwvcGc8Du9rS75I4j2k1xAXjz5aZoaJ1VHi4+8FsATxX/qgzZ
 D4oBRA9xSmW0I3Tq7bvrW4RZ243+lgkIfTMCqDF/XXz9hTJZsjqQd034sUDR4NDJ1L83+9DBt
 JDEtnxE3v2F1BLOY70lgRzIIx59DDZ/syKYrEacl4idPRFCv0I0ar5BZelKpTEKvNSdHZopWJ
 gPUo3SRUsOn0H7SNyHqU5NqERFkYt6Stesh2ib8VPRoIrvDRWMzXmYozXFwoI8N991IuP1GMf
 65DEUAkjzWv2YqEr5ICtQSGFfK3txTGaZvZs8bhBK+EEcCanLTgccxOGMpbDfP5j4qX0DqCMp
 T9lNcLd16NSSBPnLCUgnDF1vMA5DesRb/3XKnuSrXx+PqLh0BhtV0hnVbeiaswWHPcmV8aYY2
 oShfTiOXyyd0+OVQvoRfxPxRaTECu5WA6Iwwgef7gRqdkoRhqGqBh9UoZMRNW/1Q2y+I55Zvy
 LkjpR7fO3ImJGj27T1+o+SNLsU1DHqyxsmb0G6Pkh622MbmsVIIq9No3Bv+aiSnOFefk6WQ52
 WU9VtDi5tKb4K8YL9r1zXUkXPWea6aaIsJCG78IMTZyREbE+AyITayrVD70Bea0JrZHGoodK/
 S0ydPFyn0orEmpsiG2KjCXd4LNPWXsrdhCEMUWB/our2XZaWMPeo4wyW3vEUlcHWYP/7clH13
 AVlW33o8HYIBeT5miO9RM9htUher0QrJuYwGsIRhle6b9yZpUVvRhqO8rqWZSVWHF4kHXjxAw
 V7TB1/3uOSPL5CUbE6043QAGHUipZ/qFGJqTnIzrZGbzydQ0ylL1BmTOipY3ScPkfWK+9P1j6
 l9sAxijgUE8K8vm0GTNi85JcfBXTVfPBEizdX0hbirlb5prFPVZLE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why don't you just do what is asked for?

It seems that a previous update suggestion was easier to integrate
(on the first glance), wasn't it?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/base/platform.c?id=7945f929f1a77a1c8887a97ca07f87626858ff42

Regards,
Markus

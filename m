Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0462DC4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 05:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D593521855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 05:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbfI3Fgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 01:36:36 -0400
Received: from avon.wwwdotorg.org ([104.237.132.123]:33984 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfI3Fgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 01:36:36 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Sep 2019 01:36:35 EDT
Received: from [192.168.63.111] (c-98-245-153-70.hsd1.co.comcast.net [98.245.153.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id 4CFEF1C13B3;
        Sun, 29 Sep 2019 23:28:44 -0600 (MDT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.3 at avon.wwwdotorg.org
Subject: Re: [PATCH] arm64: tegra: only map accessible sysram
To:     Mian Yousaf Kaukab <ykaukab@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org
References: <20190929200851.14228-1-ykaukab@suse.de>
From:   Stephen Warren <swarren@wwwdotorg.org>
Openpgp: preference=signencrypt
Autocrypt: addr=swarren@wwwdotorg.org; prefer-encrypt=mutual; keydata=
 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 3LeU
Message-ID: <5d2e47ec-8304-d648-9c4a-80c7c02050a9@wwwdotorg.org>
Date:   Sun, 29 Sep 2019 23:28:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190929200851.14228-1-ykaukab@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/19 2:08 PM, Mian Yousaf Kaukab wrote:
> Most of the SysRAM is secure and only accessible by TF-A.
> Don't map this inaccessible memory in kernel. Only map pages
> used by bpmp driver.

I don't believe this change is correct. The actual patch doesn't
implement mapping a subset of the RAM (a software issue), but rather it
changes the DT representation of the SYSRAM hardware. The SYSRAM
hardware always does start at 0x30000000, even if a subset of the
address range is dedicated to a specific purpose. If the kernel must map
only part of the RAM, then some additional property should indicate
this. Also, I believe it's incorrect to hard-code into the kernel's DT
the range of addresses used by the secure monitor/OS, since this can
vary depending on what the user actually chooses to install as the
secure monitor/OS. Any indication of such regions should be filled in at
runtime by some boot firmware or the secure monitor/OS itself, or
retrieved using some runtime API rather than DT.

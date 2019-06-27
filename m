Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0A4C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 05:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1225C20989
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 05:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qX8ruqVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfF0F7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 01:59:05 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39364 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0F7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 01:59:05 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5R5wiw6071608;
        Thu, 27 Jun 2019 00:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561615124;
        bh=JpTyLfC5naSgajqi/FjcBNEx9ClOWA9kiWZADHuBcq4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qX8ruqVMYvwC4JFrEM1Gl5E6VxjVfOh1gsLjBjqm0fnn+8saHLS9sJ1rngUu4tSoy
         aVyMRpk+cLuNkPBeN1ELkxif3n53RQUW87BxI+p9quYraObrYEBA2oUsPF6By62XVb
         2A0XbZNGyCY6VttsMp3LI9AbH5GZwcPP8pV375Po=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5R5wi6D013628
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jun 2019 00:58:44 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 27
 Jun 2019 00:58:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 27 Jun 2019 00:58:44 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5R5wfEa086784;
        Thu, 27 Jun 2019 00:58:42 -0500
Subject: Re: linux-next: build warning after merge of the mfd tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Lee Jones <lee.jones@linaro.org>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <gustavo@embeddedor.com>, <keescook@chromium.org>
References: <20190627151140.232a87e2@canb.auug.org.au>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <1b5aa183-6e33-ee15-4c65-5b4cdf7655af@ti.com>
Date:   Thu, 27 Jun 2019 11:29:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190627151140.232a87e2@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/06/19 10:41 AM, Stephen Rothwell wrote:
> Hi Lee,
> 
> After merging the mfd tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
> 
> drivers/regulator/lp87565-regulator.c: In function 'lp87565_regulator_probe':
> drivers/regulator/lp87565-regulator.c:182:11: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     max_idx = LP87565_BUCK_3210;

Missed adding a break here. Can i send a patch on top of linux-next?

>     ~~~~~~~~^~~~~~~~~~~~~~~~~~~
> drivers/regulator/lp87565-regulator.c:183:2: note: here
>    default:
>    ^~~~~~~
> 
> Introduced by commit
> 
>    7ee63bd74750 ("regulator: lp87565: Add 4-phase lp87561 regulator support")
> 
> I get these warnings because I am building with -Wimplicit-fallthrough
> in attempt to catch new additions early.  The gcc warning can be turned
> off by adding a /* fall through */ comment at the point the fall through
> happens (assuming that the fall through is intentional).
> 

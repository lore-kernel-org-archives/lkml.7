Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A86C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371AB2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="AcworK71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfJJNvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:51:16 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:60773 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfJJNvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds201810; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Z9kT8deS5roy+K52zZTsn6tV5HXJkoAJ1yAla/8rmZU=; b=AcworK715AEXg5eIsIVd5jDN9O
        9PJ+TZmcl1xkVfpSlXl+071b3lkDENK0W6/fevePDKMd2zFClxy1B+AAuBIK2/yDAEoNvqGm7XTg2
        zvi768iIkqezp/ohhS9tyfEfrhI6dBtG+o4afnxOUH8ZnYyR2qeuv17yISXpu64CkYd/Hf8poQrb5
        VZuZvyRiEaTtProqjGunHzXDrS8cSuscJAOlRazRz7IvTTwGhdFGDrOwBlaAKw+Ca+vbbv6eZJgRM
        F+mhx8shxX/zzaMGDu5uPExZbH9YSYzJsd/YFWJgxCXtJ/x4kwz0MrNNB7d0nkZXaxhfcpJQndrxB
        DG1+b2vA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:58426 helo=[192.168.10.177])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1iIYqT-00083M-Tc; Thu, 10 Oct 2019 15:51:09 +0200
Subject: Re: [PATCH] drm/tiny: Kconfig: Remove always-y THERMAL dep. from
 TINYDRM_REPAPER
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
To:     Ulf Magnusson <ulfalizer@gmail.com>, linux-kbuild@vger.kernel.org,
        yamada.masahiro@socionext.com
Cc:     david@lechnology.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hdegoede@redhat.com, tglx@linutronix.de, sam@ravnborg.org,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20190927174218.GA32085@huvuddator>
 <c3b41a7b-ef3b-7960-13a1-d4b8dd6f15b6@tronnes.org>
Message-ID: <10f6225f-89c0-268e-8ef9-7a6b7c22e911@tronnes.org>
Date:   Thu, 10 Oct 2019 15:51:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c3b41a7b-ef3b-7960-13a1-d4b8dd6f15b6@tronnes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 01.10.2019 12.58, skrev Noralf Trønnes:
> 
> 
> Den 27.09.2019 19.42, skrev Ulf Magnusson:
>> Commit 554b3529fe01 ("thermal/drivers/core: Remove the module Kconfig's
>> option") changed the type of THERMAL from tristate to bool, so
>> THERMAL || !THERMAL is now always y. Remove the redundant dependency.
>>
>> Discovered through Kconfiglib detecting a dependency loop. The C tools
>> simplify the expression to y before running dependency loop detection,
>> and so don't see it. Changing the type of THERMAL back to tristate makes
>> the C tools detect the same loop.
>>
>> Not sure if running dep. loop detection after simplification can be
>> called a bug. Fixing this nit unbreaks Kconfiglib on the kernel at
>> least.
>>
>> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
>> ---
> 
> Thanks, applied to drm-misc-next.
> 

This has now been queued for the next -rc pull.

Discussion: https://patchwork.freedesktop.org/patch/319826/

Noralf.

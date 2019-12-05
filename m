Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A461C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BF32464E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AmlfDNrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbfLEU7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:59:42 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36690 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731085AbfLEU7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:59:41 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB5KxUNi054523;
        Thu, 5 Dec 2019 14:59:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575579570;
        bh=GbqjKH8YsKnW/N3x6Qpx0YEAwoifburiSHjzAMeEXSg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AmlfDNrL7P3G3IBt/RgKKVFZKcVF06+vhDiDD85phTg95uGuFNezljJg2xa6IIP6S
         CAeRmH68TY+7T/0OGjQyCb9E/LgHPHSgimnZ8q0xj1HiFp4G+gDF5fbyflN+0rhoRG
         joDxO1KmAjsiFftZWCYChc5MSLaaspmNzWxFa0Ac=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB5KxUl0040632;
        Thu, 5 Dec 2019 14:59:30 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 5 Dec
 2019 14:59:30 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 5 Dec 2019 14:59:30 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB5KxUVW129738;
        Thu, 5 Dec 2019 14:59:30 -0600
Subject: Re: [PATCH 0/2] can: m_can_platform: Bug fix of kernel panic for
To:     Pankaj Sharma <pankj.sharma@samsung.com>,
        <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <rcsekar@samsung.com>, <pankaj.dubey@samsung.com>
References: <CGME20191119102134epcas5p4d3c1b18203e2001c189b9fa7a0e3aab5@epcas5p4.samsung.com>
 <1574158838-4616-1-git-send-email-pankj.sharma@samsung.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <f0550b0b-6681-75a3-c58a-28f5b7ca0821@ti.com>
Date:   Thu, 5 Dec 2019 14:57:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1574158838-4616-1-git-send-email-pankj.sharma@samsung.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pankaj

On 11/19/19 4:20 AM, Pankaj Sharma wrote:
> The current code is failing while clock prepare enable because of not
> getting proper clock from platform device.
> A device driver for CAN controller hardware registers itself with the
> Linux network layer as a network device. So, the driver data for m_can
> should ideally be of type net_device.
>
> Further even when passing the proper net device in probe function the
> code was hanging because of the function m_can_runtime_resume() getting
> recursively called from m_can_class_resume().
>
> Pankaj Sharma (2):
>    can: m_can_platform: set net_device structure as driver data
>    can: m_can_platform: remove unnecessary m_can_class_resume() call

Did you CC: linux-stable for these?  We are probably going to have 
customers picking up 5.4 LTS and would need these bug fixes.

Or at the very least see if the stable automation will pick these up.

Dan



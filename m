Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDE3C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 15:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2FC217F4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 15:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LIDKrcAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgACPwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 10:52:05 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39592 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbgACPwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 10:52:04 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 003Fq1Ci031568;
        Fri, 3 Jan 2020 09:52:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578066721;
        bh=SfsqMeXpaHIQy5T0+ikFgHjVBWCZNjzMtW2w57vNK/Y=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=LIDKrcAJs0/Qxa7IgPBiXyXxCl0iEPuqp1RWvfwRPFamMF5WCenLf8ZLDTxJlIJyq
         21DcNgC2wx8/44kE8qQ0XtceIGwQCtQa7hnJUCBu1db8b+R1BBzgQF1xZRG0yXxf3b
         mw2uucl7+3moYW8aztWLkKhJmFwh3iqok+8DvDyU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 003Fq1tt040611
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Jan 2020 09:52:01 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 3 Jan
 2020 09:52:01 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 3 Jan 2020 09:52:01 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 003Fq14T010470;
        Fri, 3 Jan 2020 09:52:01 -0600
Subject: Re: leds: lm3642: remove warnings for bad strtol, cleanup gotos
To:     Pavel Machek <pavel@ucw.cz>, <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200102214547.GA3616@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <384b876c-2043-1a48-28fc-ac7d2a1facb0@ti.com>
Date:   Fri, 3 Jan 2020 09:49:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200102214547.GA3616@amd>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 1/2/20 3:45 PM, Pavel Machek wrote:
> Hi!
>
> I've applied this to for-next tree. If you see something very wrong,
> let me know.

Nothing wrong with this patch but in reviewing I did notice in the 
lm3642_control in the switch case that we set the opmode regardless of 
regmap_update_bits passing or failing.

FWIW

Reviewed-by: Dan Murphy <dmurphy@ti.com>

Dan


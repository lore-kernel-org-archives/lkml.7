Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EDDC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC78021738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="JxGHEvwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfDWJEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:04:47 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:30524 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbfDWJEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:04:47 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3N8uJ8d000872;
        Tue, 23 Apr 2019 11:04:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=+mz0hyF9dXaVAe6HPjWWWf84hZD6RAwKtqdYMYWN3mg=;
 b=JxGHEvwvavNtLsWyXwrASgAEB2UbM7f0JcsgZroqFfNf+5z1gTxXRU4fQ42PQD4reuXg
 HNQJrLor6xI+AUxI/jvZdYcjezfhPTzKXXO8663hlSrYe1mZ50EFDtWKy9bE39iEGZKq
 AHFRXDmdszWj6b0NBv2bsUVl9YSNICC7XUzO1OHYf6iIBhriAgUvnmtHSKiK0ZV+PNjA
 8yVBPTxaCjbar8B9M/Sq7dpjXtn78pJ+E+a80Dqh0+qagCRo8F6Y9KR+u0JP1edpNOla
 YxX7NWhhMYnDkYWSn9HAprJUdflq99gxiEFC4WCsOzfDPRdTGZ9/ehNY8hlt4kAjMVw1 JQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ryrvx6g0u-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 23 Apr 2019 11:04:22 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B5F7042;
        Tue, 23 Apr 2019 09:04:17 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 89D4B1582;
        Tue, 23 Apr 2019 09:04:17 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 23 Apr
 2019 11:04:17 +0200
Subject: Re: [PATCH 0/5] Add pin package management on STM32P157
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1554895824-25709-1-git-send-email-alexandre.torgue@st.com>
 <CACRpkdbRgyfVAZ8taoDAZo+QHYYvzOo3mZC4fosxyz0-X37y0Q@mail.gmail.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <096da7b7-4483-84e8-69fb-a6ececfa2296@st.com>
Date:   Tue, 23 Apr 2019 11:02:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdbRgyfVAZ8taoDAZo+QHYYvzOo3mZC4fosxyz0-X37y0Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-22_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/23/19 10:47 AM, Linus Walleij wrote:
> On Wed, Apr 10, 2019 at 1:31 PM Alexandre Torgue
> <alexandre.torgue@st.com> wrote:
> 
>> The series adds support of chip packages for STM32MP157 SOC.
> 
> Patches 1-4 applied to the pin control tree.
> Sorry for slowness :(

No pb, thanks Linus. I'll take DT patch in my stm32 tree with your ack.

regards
Alex

> 
> Yours,
> Linus Walleij
> 

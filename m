Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF75C2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0A22146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Ay25ac56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfLRNZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:25:01 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:58831 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726987AbfLRNY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:24:58 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIDMRtc020911;
        Wed, 18 Dec 2019 14:24:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=ngcc1/bjwwXgqJYi6eIEjBZEPUTc8ZlQ1tttC11Dls0=;
 b=Ay25ac56hEhnGQYXRHZjVXs+U+zDeke0bC/YGW216LwsE2uFGPbfNYScpnUpr6nEOYEn
 K51pUxyw1hgVeSkgQVkESRkKBiJlGdS8bHUvEJutK8/p2s0OTQPRaGSN/uiiKaCkHng5
 S6ikYzL/e7EXHMrxt9UoQjL1q5hdgvD2JfjkAb7v1VwRyDu9E/77YOfLQhjBtrvCG0EE
 s5FtlTnlg8xZbLGSx7N5dBji7AVy7aO6FZ6AWzWw/dQaTn6kH7y4FJ/sl1WNytNKYp1N
 VX6VwJVmZ6LPBZYyi/2cqhuceT5uMgYzynmlJ8VQzy/2aRc2ZaB62scTZYSefQqar78y 5Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wvpd1mgy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 14:24:05 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A1595100034;
        Wed, 18 Dec 2019 14:24:04 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5D2A52BB389;
        Wed, 18 Dec 2019 14:24:04 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.51) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Dec
 2019 14:24:03 +0100
Subject: Re: [BUG] ALSA: soc: sti: a possible sleep-in-atomic-context bug in
 uni_player_ctl_iec958_put()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <739176c9-d889-0093-129c-25ff9c57b63b@gmail.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <86228f2a-f75c-2b17-1e47-ea2a6abec704@st.com>
Date:   Wed, 18 Dec 2019 14:24:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <739176c9-d889-0093-129c-25ff9c57b63b@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_03:2019-12-17,2019-12-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jia-Ju

On 12/18/19 1:51 PM, Jia-Ju Bai wrote:
> The driver may sleep while holding a spinlock.
> The function call path (from bottom to top) in Linux 4.19 is:
> 
> sound/soc/sti/uniperif_player.c, 229:
>      mutex_lock in uni_player_set_channel_status
> sound/soc/sti/uniperif_player.c, 608:
>      uni_player_set_channel_status in uni_player_ctl_iec958_put
> sound/soc/sti/uniperif_player.c, 603:
>      _raw_spin_lock_irqsave in uni_player_ctl_iec958_put
> 
> mutex_lock() can sleep at runtime.
> 
> I am not sure how to properly fix this possible bug, so I only report it.
> 
> This bug is found by a static analysis tool STCheck written by myself.
Thank you for pointing out the bug, I will test and send a fix.

Regards
Arnaud
> 
> 
> Best wishes,
> Jia-Ju Bai
> 

Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0E8C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2372021E6B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="1BUzi8rY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfFQHyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 03:54:45 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22984 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725862AbfFQHyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 03:54:45 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5H7rvFm026612;
        Mon, 17 Jun 2019 09:54:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=t1pIXwC6qKMp7Evdyj53O8stjYaD2xF5xcWOfJEKCQM=;
 b=1BUzi8rYjfd3WsBgAkJxfn5BE6hVwyPAZLfVhsAK98Q1s+kQeiwYRwQWznB/j/mprjDM
 pAD0yIVXV8rz9gw17zwLiqv/+7KNwOG6Fi50uAWk0N+2wgD5IimxLb3GsdpIVM3gaN9I
 T1/m146BnSTl0/4E42WwI9qRJti4n8VL3WtrWtx1zbySpH0FapzYbUnj7Vg3VRNaazFQ
 klmbJZ2a+lh2hEqLZFd27GljA2dsmsntpUU0IKIKgWaM2f25bVGTFNluB4BAp362E2/H
 Ra6KIPoZ+OIfUg3/e7fCV9Hb4mxeIUQN31seC9Y4hvwr+P6TwqnBh8RTcYEZb04oI3NY PA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t4nt81hc3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 17 Jun 2019 09:54:33 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 51CF031;
        Mon, 17 Jun 2019 07:54:33 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CDCD9166A;
        Mon, 17 Jun 2019 07:54:32 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.50) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 09:54:32 +0200
Subject: Re: [PATCH v2] i2c: i2c-stm32f7: fix the get_irq error cases
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     <pierre-yves.mordret@st.com>, <marc.w.gonzalez@free.fr>,
        <fabien.dessenne@st.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-i2c@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1558020594-1498-1-git-send-email-fabrice.gasnier@st.com>
 <20190614205322.GA17899@ninjato>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <b1fb50c0-b5ee-dd73-0b8e-f025dd843cbe@st.com>
Date:   Mon, 17 Jun 2019 09:54:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614205322.GA17899@ninjato>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/19 10:53 PM, Wolfram Sang wrote:
> Hi Fabrice,
> 
>> +		return irq_event ? irq_event : -ENODEV;
> 
> Maybe -ENOENT instead of -ENODEV? I mean you have a dev_err there, so
> the driver core should probably also complain?
> 
> You could also shorten the ternary operator to:
> 
> 	return irq_event ? : -E<whatyouprefer>;
> 
> However, both are minor nits. If you prefer to keep the patch as is,
> fine with me.

Hi Wolfram,

Thanks for reviewing,
I've sent a v3 with your suggestions.

Regards,
Fabrice
> 
> Regards,
> 
>    Wolfram
> 

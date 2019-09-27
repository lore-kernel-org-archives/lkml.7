Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CE2C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25F1217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfI0SUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:20:01 -0400
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:45036 "EHLO
        9.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbfI0SUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:20:00 -0400
X-Greylist: delayed 11117 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Sep 2019 14:20:00 EDT
Received: from player691.ha.ovh.net (unknown [10.108.54.97])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id 280C51423FD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 20:00:29 +0200 (CEST)
Received: from RCM-web9.webmail.mail.ovh.net (unknown [109.190.253.11])
        (Authenticated sender: steve@sk2.org)
        by player691.ha.ovh.net (Postfix) with ESMTPSA id 9F609A6A320C;
        Fri, 27 Sep 2019 18:00:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 27 Sep 2019 20:00:21 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk/ti/adpll: allocate room for terminating null
In-Reply-To: <20190927152315.GE5610@atomide.com>
References: <20190927145737.7832-1-steve@sk2.org>
 <20190927152315.GE5610@atomide.com>
Message-ID: <cec235b3e2e4e3b206fa9444b643fa56@sk2.org>
X-Sender: steve@sk2.org
User-Agent: Roundcube Webmail/1.3.10
X-Originating-IP: 109.190.253.11
X-Webmail-UserID: steve@sk2.org
X-Ovh-Tracer-Id: 5637380835038678298
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeigdduudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 27/09/2019 17:23, Tony Lindgren a écrit :
> * Stephen Kitt <steve@sk2.org> [190927 15:13]:
>> The buffer allocated in ti_adpll_clk_get_name doesn't account for the
>> terminating null. This patch adds the extra byte, and switches to
>> snprintf to avoid overflowing.
>> 
>> Signed-off-by: Stephen Kitt <steve@sk2.org>
>> ---
>>  drivers/clk/ti/adpll.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
>> index fdfb90058504..27933c4e8a27 100644
>> --- a/drivers/clk/ti/adpll.c
>> +++ b/drivers/clk/ti/adpll.c
>> @@ -196,12 +196,13 @@ static const char *ti_adpll_clk_get_name(struct 
>> ti_adpll_data *d,
>>  	} else {
>>  		const char *base_name = "adpll";
>>  		char *buf;
>> +		size_t size = 8 + 1 + strlen(base_name) + 1 +
>> +			      strlen(postfix) + 1;
>> 
>> -		buf = devm_kzalloc(d->dev, 8 + 1 + strlen(base_name) + 1 +
>> -				    strlen(postfix), GFP_KERNEL);
>> +		buf = devm_kzalloc(d->dev, size, GFP_KERNEL);
>>  		if (!buf)
>>  			return NULL;
>> -		sprintf(buf, "%08lx.%s.%s", d->pa, base_name, postfix);
>> +		snprintf(buf, size, "%08lx.%s.%s", d->pa, base_name, postfix);
>>  		name = buf;
>>  	}
>> 
> 
> Thanks for catching this. Maybe just use devm_kasprintf() here?

Ah yes, that would be much better! V2 coming up, thanks for the 
suggestion.

Regards,

Stephen

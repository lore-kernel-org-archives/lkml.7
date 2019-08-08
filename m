Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36D7C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22D22171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="zYTVhAOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732810AbfHHM7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:59:11 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:48572 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbfHHM7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:59:10 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 2B57E5C271D;
        Thu,  8 Aug 2019 14:59:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1565269149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R9R4pNwt9uuq1VgKEb/EAbsgASwWpej+aa/aWzuZJ3s=;
        b=zYTVhAOHHOdlKw03JbSXgVmZZGNvZo0ZUGizuplW55WOTHiFI16uqlf4tVjhorgZYHRBsz
        V87DiYhzjsL78YYluM0SdNgSQV2XzN7zRnJuOYj7tgNZ+d7+ehKtTVsIGjVPfIG5A7LOnc
        mM/bFy7IahZXsCVDTyM56nlWJYfDCcc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 08 Aug 2019 14:59:09 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Mark Brown <broonie@kernel.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan.agner@toradex.com>
Subject: Re: [PATCH] ASoC: soc-core: remove error due to probe deferral
In-Reply-To: <20190808124437.GD3795@sirena.co.uk>
References: <20190808123655.31520-1-stefan@agner.ch>
 <20190808124437.GD3795@sirena.co.uk>
Message-ID: <83988e57c768513425ed79eac6744ed8@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-08 14:44, Mark Brown wrote:
> On Thu, Aug 08, 2019 at 02:36:55PM +0200, Stefan Agner wrote:
>> From: Stefan Agner <stefan.agner@toradex.com>
>>
>> Deferred probes shouldn't cause error messages in the boot log. Avoid
>> printing with dev_err() in case EPROBE_DEFER is the return value.
> 
> No, they absolutely should tell the user why they are deferring so the
> user has some information to go on when they're trying to figure out why
> their device isn't instantiating.

Hm, I see, if the driver defers and does not manage in the end, then the
messages are indeed helpful.

But can we lower severity, e.g. to dev_info? In my case it succeeds in
the end, just defers about 6 times. I have 3 links which then leads to
18 error messages which confuse users... From what I can see
soc_init_dai_link() would print dev_err in case there is an actual
error.

--
Stefan

Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D74AC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FE922DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566312966;
	bh=Qqfrzt5dcyq5vRFymiw4VbTMoZDLKcixhsTKSLZ9lFg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=RfR41kN6QWveWw1wQ2p/lneGlrr+BjZ9lLnej/LeZKl1sq8/L3vstzo74pLKMvVb3
	 OjxsAQdbJfTW3dfRgtP4ABPCrqaEq8nEzACOoYFAA1c55vdQ9iqX/9rXJVyeZIaGdP
	 YdYSRGq+sKKGsmXVhD+BZ2tHLlvxM9k6S70t7S2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbfHTO4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:56:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729980AbfHTO4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:56:04 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D333122DA7;
        Tue, 20 Aug 2019 14:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566312963;
        bh=Qqfrzt5dcyq5vRFymiw4VbTMoZDLKcixhsTKSLZ9lFg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=aRUT4QX4tuTBSZx5dLNdCPB0uHXAJ0OS5y+lgKGJwudGZ9OSMNaOEd2IsjspHHINy
         T1EvrPRM27y/E7W1VaLWcAlsyPhBLybGvayMTNDO7wWJ4nEQpy/antfQ6u/9Ihk0c/
         9vufxk/OUdIVzUUC2jeVxXCrXvVJViMo4qoKWeig=
Date:   Tue, 20 Aug 2019 16:55:53 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
cc:     linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] HID: fix error message in hid_open_report()
In-Reply-To: <1230b0c19fd21fdc4d0eb30f3e32e67fff86fef9.1563818405.git.mirq-linux@rere.qmqm.pl>
Message-ID: <nycvar.YFH.7.76.1908201655030.27147@cbobk.fhfr.pm>
References: <1230b0c19fd21fdc4d0eb30f3e32e67fff86fef9.1563818405.git.mirq-linux@rere.qmqm.pl>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Michał Mirosław wrote:

> On HID report descriptor parsing error the code displays bogus
> pointer instead of error offset (subtracts start=NULL from end).
> Make the message more useful by displaying correct error offset
> and include total buffer size for reference.
> 
> This was carried over from ancient times - "Fixed" commit just
> promoted the message from DEBUG to ERROR.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8c3d52fc393b ("HID: make parser more verbose about parsing errors by default")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
[ ... snip ... ]
> @@ -1230,7 +1232,8 @@ int hid_open_report(struct hid_device *device)
>  		}
>  	}
>  
> -	hid_err(device, "item fetching failed at offset %d\n", (int)(end - start));
> +	hid_err(device, "item fetching failed at offset %zu/%zu\n",
> +		size - (end - start), size);

Hi Michal,

thanks for the fix.

This causes:

drivers/hid/hid-core.c: In function ‘hid_open_report’:
drivers/hid/hid-core.c:1235:2: warning: format ‘%zu’ expects argument of type ‘size_t’, but argument 4 has type ‘unsigned int’ [-Wformat=]
  hid_err(device, "item fetching failed at offset %zu/%zu\n",
  ^

could you please fix that up and resubmit?

Thanks,

-- 
Jiri Kosina
SUSE Labs


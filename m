Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA069C47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B252C20673
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbfJNGzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 02:55:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:58724 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726618AbfJNGzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 02:55:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 637DBAC2E;
        Mon, 14 Oct 2019 06:55:16 +0000 (UTC)
Subject: Re: [PATCH] 8250-men-mcb: fix error checking when get_num_ports
 returns -ENODEV
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191013220016.9369-1-colin.king@canonical.com>
From:   Michael Moese <mmoese@suse.de>
Message-ID: <022c9a2b-0929-3a76-7976-dca717a5bc73@suse.de>
Date:   Mon, 14 Oct 2019 08:55:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191013220016.9369-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.10.19 00:00, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The current checking for failure on the number of ports fails when
> -ENODEV is returned from the call to get_num_ports. Fix this by making
> num_ports and loop counter i signed rather than unsigned ints. Also
> add check for num_ports being less than zero to check for -ve error
> returns.
> 
> Addresses-Coverity: ("Unsigned compared against 0")
> Fixes: e2fea54e4592 ("8250-men-mcb: add support for 16z025 and 16z057")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

This looks more than reasonable to me, thanks.

Reviewed-by: Michael Moese <mmoese@suse.de>

> ---
>   drivers/tty/serial/8250/8250_men_mcb.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/8250/8250_men_mcb.c
> index 02c5aff58a74..8df89e9cd254 100644
> --- a/drivers/tty/serial/8250/8250_men_mcb.c
> +++ b/drivers/tty/serial/8250/8250_men_mcb.c
> @@ -72,8 +72,8 @@ static int serial_8250_men_mcb_probe(struct mcb_device *mdev,
>   {
>   	struct serial_8250_men_mcb_data *data;
>   	struct resource *mem;
> -	unsigned int num_ports;
> -	unsigned int i;
> +	int num_ports;
> +	int i;
>   	void __iomem *membase;
>   
>   	mem = mcb_get_resource(mdev, IORESOURCE_MEM);
> @@ -88,7 +88,7 @@ static int serial_8250_men_mcb_probe(struct mcb_device *mdev,
>   	dev_dbg(&mdev->dev, "found a 16z%03u with %u ports\n",
>   		mdev->id, num_ports);
>   
> -	if (num_ports == 0 || num_ports > 4) {
> +	if (num_ports <= 0 || num_ports > 4) {
>   		dev_err(&mdev->dev, "unexpected number of ports: %u\n",
>   			num_ports);
>   		return -ENODEV;
> @@ -133,7 +133,7 @@ static int serial_8250_men_mcb_probe(struct mcb_device *mdev,
>   
>   static void serial_8250_men_mcb_remove(struct mcb_device *mdev)
>   {
> -	unsigned int num_ports, i;
> +	int num_ports, i;
>   	struct serial_8250_men_mcb_data *data = mcb_get_drvdata(mdev);
>   
>   	if (!data)
> 

-- 
Michael Moese <mmoese@suse.de>
QA Engineer
PGP Fingerprint: 4CCE 3896 F873 2CA5 2382  3C6F 6021 375C 8635 7E74

SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 Nürnberg
Germany

(HRB 247165, AG München)
Geschäftsführer: Felix Imendörffer




Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633A7C10F0A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3421F204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FpvK0kZt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IRwKTNdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbfDEQGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:06:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55922 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfDEQGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:06:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 54A5D61157; Fri,  5 Apr 2019 16:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554480371;
        bh=CkcPhcFBFh7/48bli0XnotAJ4M6miOnul4y2lI16nPc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FpvK0kZt39Xwyc8WimYoxB7nVLEhBMUF2XgXMMThChB2th2YNlZzj16u7gPwwpQbb
         GeCqjxVlU8ifaJoRib6mdpl4DMcaIT7GBU5X8eT4geZt5+N69sL87BU04yU6LkzVdi
         terrrzp5iPPwPgNZH4bdGrevloDueliwF7zSrNdc=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C916560F3E;
        Fri,  5 Apr 2019 16:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554480369;
        bh=CkcPhcFBFh7/48bli0XnotAJ4M6miOnul4y2lI16nPc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IRwKTNdR50/wFPzRwih1V+m9kJwvkYOGvxHTFeG5B7Ce4HgElvpQ5Y6mXm++531A7
         p+gZGhP+FfhbeAAqwg1+lDO5+8nwRqP0K2wPoEFBNAddSGLgjchQ41f0prZLIwo//w
         alLygpFTfLQTD6R5lzUUBjmz73UsNqoUqA8Cga+4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C916560F3E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH][next] acpi/hmat: fix uninitialized pointer dereference on
 pointer 'target'
To:     Colin King <colin.king@canonical.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keith Busch <keith.busch@intel.com>, linux-acpi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190405141215.2079-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <3cfa8f02-7fef-72ec-03c3-1acdcc8f0f89@codeaurora.org>
Date:   Fri, 5 Apr 2019 21:36:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405141215.2079-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/5/2019 7:42 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The pointer 'target' is not initialized and is only assigned when the
> ACPI_HMAT_MEMORY_PD_VALID bit in p->flags is set.  There is a later null
> check on target that leads to an uninitialized pointer read and
> dereference when assigning target->processor_pxm when target contains a
> non-null garbage value.  Fix this by initializing targer to null.
>
> Fixes: 665ac7e92757 ("acpi/hmat: Register processor domain to its memory")
> Addresses-Coverity: ("Uninitialized pointer read")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/acpi/hmat/hmat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index b7824a0309f7..b275016ff648 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -366,7 +366,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
>   					      const unsigned long end)
>   {
>   	struct acpi_hmat_proximity_domain *p = (void *)header;
> -	struct memory_target *target;
> +	struct memory_target *target = NULL;
>   
>   	if (p->header.length != sizeof(*p)) {
>   		pr_notice("HMAT: Unexpected address range header length: %d\n",

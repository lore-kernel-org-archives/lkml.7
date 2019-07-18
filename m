Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7DBC76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B182173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389449AbfGRIhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:37:00 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45902 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfGRIhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:37:00 -0400
Received: from 79.184.255.39.ipv4.supernova.orange.pl (79.184.255.39) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 15f044a4fc8d1e2f; Thu, 18 Jul 2019 10:36:57 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn@helgaas.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] thermal: intel: int340x_thermal: Remove unnecessary acpi_has_method() uses
Date:   Thu, 18 Jul 2019 10:36:57 +0200
Message-ID: <1780280.CEgozTfreW@kreacher>
In-Reply-To: <20190717192639.90092-1-skunberg.kelsey@gmail.com>
References: <20190717192639.90092-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 17, 2019 9:26:39 PM CEST Kelsey Skunberg wrote:
> acpi_evaluate_object() will already return in error if the method does not
> exist. Checking if the method is absent before the acpi_evaluate_object()
> call is not needed. Remove acpi_has_method() calls to avoid additional
> work.
> 
> Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>

LGTM:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
> index 9716bc3abaf9..7130e90773ed 100644
> --- a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
> +++ b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
> @@ -77,9 +77,6 @@ int acpi_parse_trt(acpi_handle handle, int *trt_count, struct trt **trtp,
>  	struct acpi_buffer element = { 0, NULL };
>  	struct acpi_buffer trt_format = { sizeof("RRNNNNNN"), "RRNNNNNN" };
>  
> -	if (!acpi_has_method(handle, "_TRT"))
> -		return -ENODEV;
> -
>  	status = acpi_evaluate_object(handle, "_TRT", NULL, &buffer);
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
> @@ -158,9 +155,6 @@ int acpi_parse_art(acpi_handle handle, int *art_count, struct art **artp,
>  	struct acpi_buffer art_format =	{
>  		sizeof("RRNNNNNNNNNNN"), "RRNNNNNNNNNNN" };
>  
> -	if (!acpi_has_method(handle, "_ART"))
> -		return -ENODEV;
> -
>  	status = acpi_evaluate_object(handle, "_ART", NULL, &buffer);
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
> 





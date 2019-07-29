Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1856FC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2A6206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387723AbfG2L3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:29:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54950 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387676AbfG2L3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:29:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 4B9A027DFAF
Subject: Re: [PATCH] platform/chrome: fix crash during suspend
To:     Hyungwoo Yang <hyungwoo.yang@intel.com>
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        jettrink@chromium.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <1559189034-11268-1-git-send-email-hyungwoo.yang@intel.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <ec98fd7e-5a2b-6f0e-8a23-3fde2161d4e7@collabora.com>
Date:   Mon, 29 Jul 2019 13:29:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1559189034-11268-1-git-send-email-hyungwoo.yang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

cc'ing: Benson and Guenter

Please don't forget to add all the chrome-platform maintainers in the cc list.

On 30/5/19 6:03, Hyungwoo Yang wrote:
> Kernel crashes during suspend due to wrong conversion in
> suspend and resume functions.
> 
> Use the proper helper to get ishtp_cl_device instance.
> 
> Signed-off-by: Hyungwoo Yang <hyungwoo.yang@intel.com>

I added the cros_ec_ishtp prefix in the subject and cc'ied stable to apply this
for 5.2+ (the patch depends on "b12bbdc5: HID: intel-ish-hid: fix wrong
driver_data usage")

The patch will be pushed to the chrome-platform-5.3-fixes branch for the
autobuilders to play with, if all goes well we will do a fixes PR during this cycle.

Thanks,
~ Enric

> ---
>  drivers/platform/chrome/cros_ec_ishtp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
> index e504d25..430731c 100644
> --- a/drivers/platform/chrome/cros_ec_ishtp.c
> +++ b/drivers/platform/chrome/cros_ec_ishtp.c
> @@ -707,7 +707,7 @@ static int cros_ec_ishtp_reset(struct ishtp_cl_device *cl_device)
>   */
>  static int __maybe_unused cros_ec_ishtp_suspend(struct device *device)
>  {
> -	struct ishtp_cl_device *cl_device = dev_get_drvdata(device);
> +	struct ishtp_cl_device *cl_device = ishtp_dev_to_cl_device(device);
>  	struct ishtp_cl	*cros_ish_cl = ishtp_get_drvdata(cl_device);
>  	struct ishtp_cl_data *client_data = ishtp_get_client_data(cros_ish_cl);
>  
> @@ -722,7 +722,7 @@ static int __maybe_unused cros_ec_ishtp_suspend(struct device *device)
>   */
>  static int __maybe_unused cros_ec_ishtp_resume(struct device *device)
>  {
> -	struct ishtp_cl_device *cl_device = dev_get_drvdata(device);
> +	struct ishtp_cl_device *cl_device = ishtp_dev_to_cl_device(device);
>  	struct ishtp_cl	*cros_ish_cl = ishtp_get_drvdata(cl_device);
>  	struct ishtp_cl_data *client_data = ishtp_get_client_data(cros_ish_cl);
>  
> 

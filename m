Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11246C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F7926474
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfEaKVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 06:21:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38948 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaKVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 06:21:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2B06B26CB2F
Subject: Re: [PATCH] platform/chrome: fix crash during suspend
To:     Hyungwoo Yang <hyungwoo.yang@intel.com>
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        jettrink@chromium.org
References: <1559189034-11268-1-git-send-email-hyungwoo.yang@intel.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <8b7a8d63-d9e4-6a9e-1b13-423441416c8a@collabora.com>
Date:   Fri, 31 May 2019 12:21:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
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

Many thanks for this patch

On 30/5/19 6:03, Hyungwoo Yang wrote:
> Kernel crashes during suspend due to wrong conversion in
> suspend and resume functions.
> 
> Use the proper helper to get ishtp_cl_device instance.
> 
> Signed-off-by: Hyungwoo Yang <hyungwoo.yang@intel.com>
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

As this patch is a fix for '26a14267aff2 platform/chrome: Add ChromeOS EC ISHTP
driver' which is still for-next material, do you mind if I squash both patches?

If you don't mind I'll add your Signed-off and a small comment saying that you
fixed this.

Thanks,
 Enric



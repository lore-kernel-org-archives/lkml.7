Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94E2C10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830772075B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfCCQRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 11:17:33 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:54980 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfCCQRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 11:17:33 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 8FDE39E77B1;
        Sun,  3 Mar 2019 16:17:30 +0000 (GMT)
Date:   Sun, 3 Mar 2019 16:17:28 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     "He, Bo" <bo.he@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "ic23@kernel.org" <ic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "Chen, Hu1" <hu1.chen@intel.com>
Subject: Re: [PATCH] io: accel: kxcjk1013: restore the range after resume.
Message-ID: <20190303161728.3571869e@archlinux>
In-Reply-To: <CD6925E8781EFD4D8E11882D20FC406D52A4C63F@SHSMSX104.ccr.corp.intel.com>
References: <CD6925E8781EFD4D8E11882D20FC406D52A4C63F@SHSMSX104.ccr.corp.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 03:13:44 +0000
"He, Bo" <bo.he@intel.com> wrote:

> restore the range register in case kxcjk1013 power is off after suspend
> 
> we see the issue on some laptops, after system suspend and resume,
> the CTRL_REG1 register changed from 0xc8 to 0x80, so acceleration range
> is changed, the patch is to restore the acceleration range after resume.
> 
> Signed-off-by: he, bo <bo.he@intel.com>
> Signed-off-by: Chen, Hu <hu1.chen@intel.com>
Please don't do the ret += trick, it obscures the return value
which we may want to know if anything goes wrong.
Handle each error independently.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/kxcjk-1013.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 7506bd9..c6bb3be 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1340,6 +1340,7 @@ static int kxcjk1013_resume(struct device *dev)
>  
>  	mutex_lock(&data->mutex);
>  	ret = kxcjk1013_set_mode(data, OPERATION);
> +	ret += kxcjk1013_set_range(data, data->range);
>  	mutex_unlock(&data->mutex);
>  
>  	return ret;


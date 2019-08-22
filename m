Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CF0C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8FB21743
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389611AbfHVPfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 11:35:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:52588 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733244AbfHVPfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:35:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 08:35:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,417,1559545200"; 
   d="scan'208";a="196272111"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 22 Aug 2019 08:35:40 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 22 Aug 2019 18:35:39 +0300
Date:   Thu, 22 Aug 2019 18:35:39 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Badhri Jagan Sridharan <badhri@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] typec: tcpm: fix a typo in the comparison of
 pdo_max_voltage
Message-ID: <20190822153539.GD5356@kuha.fi.intel.com>
References: <20190822135212.10195-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822135212.10195-1-colin.king@canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 02:52:12PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There appears to be a typo in the comparison of pdo_max_voltage[i]
> with the previous value, currently it is checking against the
> array pdo_min_voltage rather than pdo_max_voltage. I believe this
> is a typo. Fix this.
> 
> Addresses-Coverity: ("Copy-paste error")
> Fixes: 5007e1b5db73 ("typec: tcpm: Validate source and sink caps")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 166b28562395..96562744101c 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1439,7 +1439,7 @@ static enum pdo_err tcpm_caps_err(struct tcpm_port *port, const u32 *pdo,
>  				else if ((pdo_min_voltage(pdo[i]) ==
>  					  pdo_min_voltage(pdo[i - 1])) &&
>  					 (pdo_max_voltage(pdo[i]) ==
> -					  pdo_min_voltage(pdo[i - 1])))
> +					  pdo_max_voltage(pdo[i - 1])))
>  					return PDO_ERR_DUPE_PDO;
>  				break;
>  			/*
> -- 
> 2.20.1

thanks,

-- 
heikki

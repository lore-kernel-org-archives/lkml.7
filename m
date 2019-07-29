Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FD3C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DF020578
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfG2OFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:05:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:45046 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbfG2OFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:05:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 07:05:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,322,1559545200"; 
   d="diff'?scan'208";a="190577036"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 29 Jul 2019 07:04:57 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 29 Jul 2019 17:04:57 +0300
Date:   Mon, 29 Jul 2019 17:04:57 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Douglas Gilbert <dgilbert@interlog.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] usb: typec: tcpm: Ignore unsupported/unknown
 alternate mode requests
Message-ID: <20190729140457.GC28600@kuha.fi.intel.com>
References: <1564029037-22929-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <1564029037-22929-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Jul 24, 2019 at 09:30:37PM -0700, Guenter Roeck wrote:
> TCPM may receive PD messages associated with unknown or unsupported
> alternate modes. If that happens, calls to typec_match_altmode()
> will return NULL. The tcpm code does not currently take this into
> account. This results in crashes.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 000001f0
> pgd = 41dad9a1
> [000001f0] *pgd=00000000
> Internal error: Oops: 5 [#1] THUMB2
> Modules linked in: tcpci tcpm
> CPU: 0 PID: 2338 Comm: kworker/u2:0 Not tainted 5.1.18-sama5-armv7-r2 #6
> Hardware name: Atmel SAMA5
> Workqueue: 2-0050 tcpm_pd_rx_handler [tcpm]
> PC is at typec_altmode_attention+0x0/0x14
> LR is at tcpm_pd_rx_handler+0xa3b/0xda0 [tcpm]
> ...
> [<c03fbee8>] (typec_altmode_attention) from [<bf8030fb>]
> 				(tcpm_pd_rx_handler+0xa3b/0xda0 [tcpm])
> [<bf8030fb>] (tcpm_pd_rx_handler [tcpm]) from [<c012082b>]
> 				(process_one_work+0x123/0x2a8)
> [<c012082b>] (process_one_work) from [<c0120a6d>]
> 				(worker_thread+0xbd/0x3b0)
> [<c0120a6d>] (worker_thread) from [<c012431f>] (kthread+0xcf/0xf4)
> [<c012431f>] (kthread) from [<c01010f9>] (ret_from_fork+0x11/0x38)
> 
> Ignore PD messages if the asociated alternate mode is not supported.
> 
> Reported-by: Douglas Gilbert <dgilbert@interlog.com>
> Cc: Douglas Gilbert <dgilbert@interlog.com>
> Fixes: e9576fe8e605c ("usb: typec: tcpm: Support for Alternate Modes")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Taking a stab at the problem. I don't really know if this is the correct
> fix, or even if my understanding of the problem is correct, thus marking
> the patch as RFC.

My guess is that typec_match_altmode() is the real culprit. We can't
rely on the partner mode index number when identifying the port alt
mode.

Douglas, can you test the attached hack instead of this patch?


thanks,

-- 
heikki

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tcpm_hack.diff"

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index ec525811a9eb..033dc097ba83 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1067,12 +1067,11 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 
 	modep = &port->mode_data;
 
-	adev = typec_match_altmode(port->port_altmode, ALTMODE_DISCOVERY_MAX,
-				   PD_VDO_VID(p[0]), PD_VDO_OPOS(p[0]));
-
 	pdev = typec_match_altmode(port->partner_altmode, ALTMODE_DISCOVERY_MAX,
 				   PD_VDO_VID(p[0]), PD_VDO_OPOS(p[0]));
 
+	adev = (void *)typec_altmode_get_partner(pdev);
+
 	switch (cmd_type) {
 	case CMDT_INIT:
 		switch (cmd) {

--82I3+IH0IqGh5yIs--

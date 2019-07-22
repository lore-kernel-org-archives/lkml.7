Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E12C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F7D21BF6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732636AbfGVVbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:31:00 -0400
Received: from smtprelay0154.hostedemail.com ([216.40.44.154]:57761 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728016AbfGVVbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:31:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id E622EC1DCA0;
        Mon, 22 Jul 2019 21:30:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: berry89_86aa08292963
X-Filterd-Recvd-Size: 2129
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon, 22 Jul 2019 21:30:57 +0000 (UTC)
Message-ID: <f686e93180d2f91c78801be124e8aac36145d9b0.camel@perches.com>
Subject: Re: [PATCH v2 3/3] HID: core: only warn once of oversize hid report
From:   Joe Perches <joe@perches.com>
To:     stillcompiling@gmail.com, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 22 Jul 2019 14:30:55 -0700
In-Reply-To: <20190722212613.24906-3-stillcompiling@gmail.com>
References: <20190722163642.10417-2-stillcompiling@gmail.com>
         <20190722212613.24906-1-stillcompiling@gmail.com>
         <20190722212613.24906-3-stillcompiling@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-22 at 15:26 -0600, stillcompiling@gmail.com wrote:
> From: Joshua Clayton <stillcompiling@gmail.com>

Thanks Joshua

> On HP spectre x360 convertible the message:
> hid-sensor-hub 001F:8087:0AC2.0002: hid_field_extract() called with n (192) > 32! (kworker/1:2)
> is continually printed many times per second, crowding out all else
> Protect dmesg by printing the warning only one time.
[]
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
[]
> @@ -1311,8 +1311,8 @@ u32 hid_field_extract(const struct hid_device *hid, u8 *report,
>  			unsigned offset, unsigned n)
>  {
>  	if (n > 32) {
> -		hid_warn(hid, "hid_field_extract() called with n (%d) > 32! (%s)\n",
> -			 n, current->comm);
> +		hid_warn_once(hid, "%s() called with n (%d) > 32! (%s)\n",
> +			      __func__ ,n , current->comm);

All the other bits are fine, but this line is oddly written
with unusual spacing around 'n'.

Normally it'd be something like:

		hid_warn_once(hid, "%s: called with n (%d) > 32! (%s)\n",
			      __func__, n, current->comm);


